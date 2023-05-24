Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F8970F8EF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 16:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbjEXOne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 10:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjEXOnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 10:43:31 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27051C1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 07:43:30 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-760dff4b701so7943439f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 07:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684939409; x=1687531409;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IPXLDCSKwXBraRh8qU8X4kYe3FTw3OcmD0b0rwLV1YI=;
        b=m48EBfWC4KuAg/PFZ/0kUI+QHNwJaQfIB+xzHweX9tEcZiaLYmKkAFrvooTQeD72mR
         5nuIqn52bQsXOH+sDbEf2iilTBjDmzf5Vaug6zt+7NwPNUHqnF2YhFjnhAbi5jkuUDzR
         7m+SmGTwfmjIdUhZdJqzT/9rqQlD2XBG3iLW1ma53pIxqASTEaEmzR8GeDn3e+oY0/Tb
         EQY4e3uJbmu7K6DpzOYT+dvlXrh2ciUolwngPkZGHTcBmPtucatUj0435Ih4Cd11IoqE
         AvcBuVbI3PnrGjxUZeHGtGMnQeL6zlgUeSkdNoMPcGy8RAUjK35BSKtBzNQwVhfkUwn5
         Pydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684939409; x=1687531409;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IPXLDCSKwXBraRh8qU8X4kYe3FTw3OcmD0b0rwLV1YI=;
        b=A3Hh4AS0qT5NA0452BDUdwJkNPZCGO/z4VHyY9D78coovtCwO6wxj2pCg/cKwVt5Re
         xH73FAP+6OzKrzLP5iGXJQHRKBLsM4YImMsCJmxUbOtFHxvBNnKGFDXI9AWURK6Pvg80
         dAO34lMlTlRfo/GkSAQ08ahsh0R4KPRjU7+01+79OG6HAklFwMtgDBGmlqfj1+oEy8LA
         JJbeLRs0pj63JMDyl/zU3dbtBHcAcQuvXiGP9iV/xKnOCi/Ak3RJelQ6U5Ov4fGRTf0G
         FsAMatkcp1+r22UCfC/21SQkHJI/jaWedBy2XiJrOS83a9+qWApe3Run3yqH+pamt3mF
         HvYA==
X-Gm-Message-State: AC+VfDwf+8oC0Y2d7SOJC9BBP71TMm/Pe/x72tK4LVmiZ1GOY43QKwjl
        pLmlWq/IcPCe6VYCF0VuOMKPtw==
X-Google-Smtp-Source: ACHHUZ4ttTueGCVRrRMUAUl7Mb54HKL0lLyB7DUkcn/PC4TPkkAQ6M3t/qFZ/WO5l9qruO96ONfCvg==
X-Received: by 2002:a05:6e02:1608:b0:338:1467:208f with SMTP id t8-20020a056e02160800b003381467208fmr9620690ilu.2.1684939409547;
        Wed, 24 May 2023 07:43:29 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id w34-20020a05663837a200b004168295d33esm3311241jal.47.2023.05.24.07.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 07:43:28 -0700 (PDT)
Message-ID: <90c73358-7c16-8918-50b3-b1e9101f7b21@kernel.dk>
Date:   Wed, 24 May 2023 08:43:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v21 0/6] block: Use page pinning
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20230522205744.2825689-1-dhowells@redhat.com>
 <168487791137.449781.3170440352656135902.b4-ty@kernel.dk>
 <ZG2mKMus29qquHia@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZG2mKMus29qquHia@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/23 11:52 PM, Christoph Hellwig wrote:
> On Tue, May 23, 2023 at 03:38:31PM -0600, Jens Axboe wrote:
>> Applied, thanks!
> 
> This ended up on the for-6.5/block branch, but I think it needs to be
> on the splice one, as that is pre-requisite unless I'm missing
> something.

Oops yes, that's my bad. I've reshuffled things now so that they should
make more sense.

-- 
Jens Axboe


