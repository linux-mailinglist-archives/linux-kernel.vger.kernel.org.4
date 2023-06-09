Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CCE72A172
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 19:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjFIRmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 13:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjFIRmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:42:01 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F7F35B1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 10:41:54 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-77a1a5c98e1so17692939f.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 10:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686332513; x=1688924513;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HD7qCdweYLWjitkAEiYwA46mYE4MAjAgs96SiabO/FU=;
        b=k8dFVYwghGyJytgKurDgsVSCE2Gqze9LJYmSHf1Y70Y4NzhkmaYPrs5Vbtuoy11rO9
         AqGfYETNqwaVv9LnImyNqYfDCA7RHLMxNcFsRvyV7Z5N0JegsCJMHCTph9UGMGjXC0RS
         U7wR0EOEVpFkasStCYbeNNbBVfbxOD8rnOGM9OALED3dlIVs50HYw9TO5TXh4M5/a2+z
         qRhisH0yVseNn6c329EI5BKk89WaDw8psIli2A7/d72f1GYbjQHtAenGg8lO4p+e5FX5
         BoS3KvKOkuK2o71fP9k1T+ULAg0FSAY18sU68OqGAVxR68KhuNPkK7uf4zvaM4nwLJ2u
         kVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686332513; x=1688924513;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HD7qCdweYLWjitkAEiYwA46mYE4MAjAgs96SiabO/FU=;
        b=OuboQPM7GpaSgs3Sb/F791q7/Ri3R2Jr7pISOoV0YBl7P04LppCOjuzOabz9+Bfgqd
         G0r2kAxfe579feUJeJWSWQb5ew6PTBrZXkhTYi/Yx6q1huyGpfv3WAVLwxbS8/r+ulSM
         9eBHeqTFjYrLgg7ofbvaOXxfVLiFO8ffr0/7ImW9aaEJ119dJdNbfdWHk/Abth7Wm8YB
         RrR92gdEcNdhzPixV6mTUFeePp2lBxnn3jarro7sqNlLQqSTnM0aSLbfJ9ku4jTGB7gh
         wgueDpVoMAFEUODnyqOlKF2qMTB7is60jGFI46P1Pj10/cjbwRJRYs2hPJ+nIHFkuw5Y
         tN1w==
X-Gm-Message-State: AC+VfDyqgkJaEgwjI/+4h33Ib03Z/ZcwikvaFO0nYTSxzQXCFp0NAJ5H
        03rhgRXXYwqM8VyxWsPJ2LlPkJxM2im2OP/sRJo=
X-Google-Smtp-Source: ACHHUZ7lkpeIOA42m3Eo/e1AXa/j+p3+TsO1meQYIBY+Rf12at2dmj1zGxsCROy+qYeUXSM35hQDNQ==
X-Received: by 2002:a05:6e02:1a2c:b0:338:4b36:5097 with SMTP id g12-20020a056e021a2c00b003384b365097mr1716022ile.1.1686332513446;
        Fri, 09 Jun 2023 10:41:53 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id h15-20020a02c72f000000b003c4f35c21absm1035270jao.137.2023.06.09.10.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 10:41:52 -0700 (PDT)
Message-ID: <6b2fc148-3bf9-83d5-fd5e-242ff51c9c96@kernel.dk>
Date:   Fri, 9 Jun 2023 11:41:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH -next] blk-mq: fix potential io hang by wrong 'wake_batch'
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz,
        andriy.shevchenko@linux.intel.com, qiulaibin@huawei.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
References: <20230609085130.2320859-1-yukuai1@huaweicloud.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230609085130.2320859-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/23 2:51?AM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> In __blk_mq_tag_busy/idle(), updating 'active_queues' and calculating
> 'wake_batch' is not atomic:
> 
> t1:			t2:
> _blk_mq_tag_busy	blk_mq_tag_busy
> inc active_queues
> // assume 1->2
> 			inc active_queues
> 			// 2 -> 3
> 			blk_mq_update_wake_batch
> 			// calculate based on 3
> blk_mq_update_wake_batch
> /* calculate based on 2, while active_queues is actually 3. */
> 
> Fix this problem by protecting them wih 'tags->lock', this is not a hot
> path, so performance should not be concerned.
> 
> Fixes: 180dccb0dba4 ("blk-mq: fix tag_get wait task can't be awakened")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-mq-tag.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index dfd81cab5788..43fe523f39c7 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -55,9 +55,10 @@ void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
>  			return;
>  	}
>  
> +	spin_lock_irq(&hctx->tags->lock);
>  	users = atomic_inc_return(&hctx->tags->active_queues);
> -
>  	blk_mq_update_wake_batch(hctx->tags, users);
> +	spin_unlock_irq(&hctx->tags->lock);
>  }
>  
>  /*
> @@ -90,9 +91,10 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
>  			return;
>  	}
>  
> +	spin_lock_irq(&tags->lock);
>  	users = atomic_dec_return(&tags->active_queues);
> -
>  	blk_mq_update_wake_batch(tags, users);
> +	spin_unlock_irq(&tags->lock);
>  
>  	blk_mq_tag_wakeup_all(tags, false);
>  }

From a quick look, these are the only manipulators of active_queues.
If we're under the tags lock, why do they still need to be atomics?

-- 
Jens Axboe

