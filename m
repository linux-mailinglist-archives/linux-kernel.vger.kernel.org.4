Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB085B4618
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 13:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiIJLiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 07:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiIJLh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 07:37:58 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EB95A833
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 04:37:57 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id e18so6180126edj.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 04:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=XIhZJRpaDiWRqGkaa59SLZM7EwbgJv60seJarMlU01U=;
        b=5ECLG7WvarDZrsxJyzb5tYX7EDh55BwNFsi047j2Vo3SWZYL8lJ1bkL46OM0qvqS90
         XkviLwf+y67TaoOX14MY1nRXxq8FeJihYanxwJh1Odyu2sqnH7r5985bm84MKV74cW/o
         HeaK0BO/+EGLOZKO9OH9+1czODP6eF7oST3RNMfwHCb4MBdb+sQbNk3x7nKSUtDaNzcK
         K+r42a2sRCGdmwVnXdzg56P3eLMly/i+HtMv8661mDb2vYgD+Z2tCZc6+prEXTYLVobF
         nYpEMd5PsHxpsTqFcXKEJgIJygm07V6b08y9j6KcO0oS6k/mkANirz/1pecPTLRKK4TR
         js9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=XIhZJRpaDiWRqGkaa59SLZM7EwbgJv60seJarMlU01U=;
        b=C5ujyM81YEWJU5erm9VX0ntgEJZ2aC6M3VvuqvJYiZaZjDcA/tyNGODcNiU+DxTg1d
         BxV6z97E7pkggTEIGOPigU2mWglxD0oOlrHGo3fo0/0a9iF51+TqZxcT6UpCYe1zFkKw
         FCr/E4+ebE85x8Q9K8I+cN1rxFJQiiZmic3hDYxz6eIeJKb4UAJPw73DZUQE/IGqWj8P
         IPds2IFKvjwEQqh6zvQZM1kkic09FV7Q/DovYFL39kuVwtb+5AeCx2EULnNxO/NOu3vz
         YDGSLTGc7NEsNd985zmCKIkA9QgCQ/7qShdoqsTm8rTPkiIHy1P3pZAKtm4oQia5XQk9
         mhgA==
X-Gm-Message-State: ACgBeo2J1I4uudFv74vnLzS+bV+Pzpp92Hm/z6Ck57WbXQNsk1L/ZYCa
        NTNy/x4kPmAxdDpODssxsDLmnw==
X-Google-Smtp-Source: AA6agR6P7QAItu0k5MAI8tvJZnZ8lxTeeC4sY0lxahvz9q9So5AuUySCJ3RTn7kuOGHk0sxWRsFj2A==
X-Received: by 2002:a05:6402:1e8f:b0:440:eb20:7a05 with SMTP id f15-20020a0564021e8f00b00440eb207a05mr14654077edf.169.1662809875770;
        Sat, 10 Sep 2022 04:37:55 -0700 (PDT)
Received: from [10.41.110.194] ([77.241.232.19])
        by smtp.gmail.com with ESMTPSA id u2-20020a056402110200b0045147b9dd43sm1206563edv.89.2022.09.10.04.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 04:37:54 -0700 (PDT)
Message-ID: <b59409e0-0983-90da-488c-8dc5f8eef61f@kernel.dk>
Date:   Sat, 10 Sep 2022 05:37:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] writeback: remove unused macro DIRTY_FULL_SCOPE
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     dhowells@redhat.com, vbabka@suse.cz, willy@infradead.org,
        akpm@linux-foundation.org, zhanglianjie@uniontech.com,
        neilb@suse.de, jack@suse.cz, bvanassche@acm.org,
        linux-kernel@vger.kernel.org
References: <20220909025711.32012-1-linmiaohe@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220909025711.32012-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/22 8:57 PM, Miaohe Lin wrote:
> It's introduced but never used. Remove it.

Acked-by: Jens Axboe <axboe@kernel.dk>

Andrew, would you mind queueing this one up?

-- 
Jens Axboe


