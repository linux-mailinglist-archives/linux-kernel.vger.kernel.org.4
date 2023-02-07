Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB2168DB9A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 15:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjBGOdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 09:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbjBGOc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:32:58 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A5E3E639
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 06:30:09 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id n2so7963815pgb.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 06:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TCoGFFPpMbOza9FdCyyz4Zw1S0IHVLItXuTN6BD2F0E=;
        b=NAFAFkZzNFYY6iP/bIFblEQaqKIpHmf1oMNAOirUnWbLeHBw4ZbvCX0Ob9vkQJ2QNU
         cPOua6c5tx0QrTPSHJX9ZrhRhu4HuB/8yyJLly5cplgSprl6x5sadjHFQJaODAZ2xT3D
         +1R/LCFwziNu/mUP+FNT/jdyhGqKcnYh6NPtXYb/kw9Wawxm1wfK9orvb29YpZpfL9Gd
         PJFHwpoDvx+t4DkxijicPQ0MQRVDaaUz7Ytku0ECDo8ZkHYub0UMUTkZbJ2Bp2ruiwx0
         PlIPdl2kWBh6YHsjm2PCNvLvBf7UHFSkl+r9lI86/uWTKx4IgxUkXXl7EdFzNs6Emejq
         pafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TCoGFFPpMbOza9FdCyyz4Zw1S0IHVLItXuTN6BD2F0E=;
        b=OKeE18H7gUA/uL5UUKbn5vQJs099ZFB+Fqdfzjukq5Hn4mCqNfaB96eeWVCevlkrjB
         5NwKKkn67780StRnQzMpX1G4b8vMClZx5ulK0EkFHpZAmUhXoTY7hGv3gfYFvehToX9n
         6BNLfn9nAMCwikqNytkoWOTdCO1xTv0qmz8f2YIYmtsHGThA6cY20bSsT5IK/A/ABq2D
         mCKy+DapPu3OyjwaTdzXzqP7EYInSNTgaj2UwSWms1PcvErDs3XIXqzZlVxW19nWUC0E
         DTkP7c1quWBJt8dfWB1ZmsbRFkUpHkR5xC4MtvjLZVBGlOlRsMxzaDy9PHTX46lzhtKq
         1RSw==
X-Gm-Message-State: AO0yUKUQZO81Q7w1zZgOQV8m1/2owZE6OcB7gKutUcykGd9z4+dWVdrM
        TVn4sN6P9TLtSOTYXCO00uQCsA==
X-Google-Smtp-Source: AK7set8Ar8Nl3tSE07P4Yp6yz07hhOu687ZD4iO2wfG9LIbz068ml6BrS7sKxkHLG4MyszWAW+79Qw==
X-Received: by 2002:a62:cd84:0:b0:593:dc7c:98b1 with SMTP id o126-20020a62cd84000000b00593dc7c98b1mr3180405pfg.3.1675780209081;
        Tue, 07 Feb 2023 06:30:09 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id m20-20020aa78a14000000b005a77b030b5csm1700377pfa.88.2023.02.07.06.30.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 06:30:08 -0800 (PST)
Message-ID: <d9247209-bca2-4650-b1c7-72e77990411d@kernel.dk>
Date:   Tue, 7 Feb 2023 07:30:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/2] iomap, splice: Fix DIO/splice_read race memory
 corruptor and kill off ITER_PIPE
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230207133916.3109147-1-dhowells@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230207133916.3109147-1-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/23 6:39?AM, David Howells wrote:
> [!] Jens: Note that there's a window in the linux-block/for-next branch
>     with a memory corruptor bug that someone bisecting might hit.  These
>     two patches would be better pushed to the front of my iov-extract
>     branch to eliminate the window.  Would it be possible for you to
>     replace my branch in your for-next branch at this point?

I'll check in on these two patches later today, but just wanted to say
that we can definitely just toss the existing branch, and setup a new
one based on -rc7 that adds these two first, then pulls in the other
branch on top to avoid this. Not a big deal, and warranted in this case.

-- 
Jens Axboe

