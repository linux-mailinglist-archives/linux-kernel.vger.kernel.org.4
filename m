Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D9F61578B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 03:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiKBCZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 22:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiKBCZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 22:25:33 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFCB64DD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 19:25:29 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id b11so14934630pjp.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 19:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NVMLoWhBO3smWYjRe8JlG4e5abrqqdBoJZY3LBsOWok=;
        b=kG99P25HjBgpLUF5bSCezusrFavecyfkWN1KtJIfVpYe9wEQpJIPP6v/vbx50FkYmF
         dZ2LXiC7+jEJR692C7ZVwuFNVlhpZntx9rNaniONrXYVz0t3wRg6mN+LdNEYxyYoQWUI
         aeU5OzPhITdHStP/h/G1t6HmHzJ6miul3TYIQWZyN0kTxqEfBVdY4gK4dsUE9xnHnkQW
         13E06uBz1NtOuL1YNOVp1XvI1lZ9VOT661qtzgPkU1C9LwkdHiGttukdtiA5dxpPw+9j
         raLt9Nxp2MJB3ek5TtDlIv4PHped/KXzHQBQXLxzeBzlU8vo1xv1q91/jrAtza/B1iAX
         o1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NVMLoWhBO3smWYjRe8JlG4e5abrqqdBoJZY3LBsOWok=;
        b=f3hAhE/GW91x5uIK2h0voVLZFT5NmJTezYHGDXVEL5Icrn1/hmd3Gz+kT8Awy2uCkP
         Mqe3txeCCdNgxrwh2z0B/1X/kJ//C30xJvBWpiHCO7r2jnL0GRv4sqryOZye9C9J6HfI
         Uh77Mh4d5beOh4ALow2EDZZbcLdxuUhtYad1o1yzVLNjEkmKzOI/ADI4xHwlc/ysgXbu
         Z+CzSrIMZmEC695zBn5brp0CcT43EovMm9xtEGFRTBjkxJqHUH2iUhLqHW1gw+36ggaZ
         pJSyNLK6b8lPnw9H7GKsZuRGo0Kd/JBCDCiWgHa4lA9HUKKW5/cClkGYBs1u9Y5LpFXD
         fEJQ==
X-Gm-Message-State: ACrzQf1WtcqsIPzfiSor9+3a7Lx7ccg+cm+O5/lyuzVuVOrxsuTacGd1
        e1KeYocsajwTkIj8T9KQQL0YLw==
X-Google-Smtp-Source: AMsMyM43thENVfIBk2batYPleifjpAa4i8DNg6r23LeH0bKunT6q58WuTqC68bwwJf0yQZ9XWAuVcw==
X-Received: by 2002:a17:903:110f:b0:178:a07e:e643 with SMTP id n15-20020a170903110f00b00178a07ee643mr21757437plh.41.1667355929362;
        Tue, 01 Nov 2022 19:25:29 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id g18-20020a170902869200b0017f592a7eccsm1189675plo.298.2022.11.01.19.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 19:25:28 -0700 (PDT)
Message-ID: <79c5d83f-27b2-dbe0-826b-bcb671e0766f@kernel.dk>
Date:   Tue, 1 Nov 2022 20:25:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 4/4] blk-mq: improve readability of blk_mq_alloc_request()
Content-Language: en-US
To:     Jinlong Chen <nickyc975@zju.edu.cn>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1667314759.git.nickyc975@zju.edu.cn>
 <81fcbc046c9ea96cdfd8e20d1edc8e64c4d08153.1667314759.git.nickyc975@zju.edu.cn>
 <20221101173727.GC20690@lst.de>
 <3caa5abc.16387a.1843622d8cf.Coremail.nickyc975@zju.edu.cn>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <3caa5abc.16387a.1843622d8cf.Coremail.nickyc975@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/22 8:19 PM, Jinlong Chen wrote:
>> On Tue, Nov 01, 2022 at 11:11:37PM +0800, Jinlong Chen wrote:
>>> Add a helper blk_mq_alloc_request_nocache() to alloc request without
>>> cache. This makes blk_mq_alloc_request() more readable.
>>>
>>> Signed-off-by: Jinlong Chen <nickyc975@zju.edu.cn>
>>> ---
>>>  block/blk-mq.c | 47 +++++++++++++++++++++++++++++------------------
>>>  1 file changed, 29 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index 87a6348a0d0a..2fae111a42c8 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -572,36 +572,47 @@ static struct request *blk_mq_alloc_cached_request(struct request_queue *q,
>>>  	return rq;
>>>  }
>>>  
>>> +static struct request *blk_mq_alloc_request_nocache(struct request_queue *q,
>>> +		blk_opf_t opf, blk_mq_req_flags_t flags)
>>
>> The name is a bit odd, but I can't think off a better one.
>>
>>> +	struct blk_mq_alloc_data data = {
>>>  			.q		= q,
>>>  			.flags		= flags,
>>>  			.cmd_flags	= opf,
>>>  			.nr_tags	= 1,
>>>  		};
>>
>> And this now has superflous indenation.  Overall, while the separate
>> helper looks marginally nicer, I'm not really sure it is worth the
>> churn.
> 
> I'll drop the patch if you think it is not worth the churn. But I
> started doing this because of the following goto statement:

Please just drop it, I don't think it's an improvement.

-- 
Jens Axboe


