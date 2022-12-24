Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8B5655B69
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 23:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiLXWCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 17:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLXWB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 17:01:59 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674E2655C
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 14:01:58 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id g13so11478077lfv.7
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 14:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2Wdg2w70NZ3btt5KhGF10ut/ZEVWqlfNtQcOg6cBTA=;
        b=T2V2ee1L8pTp81pYKXnG+LGVAP/nuyeju2gXg+ggWGlZ0KQbVV5M/guSwNo30N2RkQ
         VPFlOPJJoEK7+mEuF/O6yywL5I3mk7/DZzxqZ/q+KwDmvxc/M9N/0Fp13IZpJSvoOlY9
         QqWmbRkpvTM9rKDWTy1/1xwOOAPNBj7hIBwLe+voU9MRXzG88WgfPEV3hUkcdMmbbFFE
         EWCa9E0aPKz5QPtJLGuUgHU5slZOdKslS2eEdmSUJCk9Rglf6/AJwZqBaTo9A/L/zL85
         RKzZviEGdJjXbsoGFnD68MCD+cS3DGY/tt6OJ7sG1t+8+z8hXNON0XoEVphV4Upealxo
         cUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c2Wdg2w70NZ3btt5KhGF10ut/ZEVWqlfNtQcOg6cBTA=;
        b=MGkSwd6AdTkqiZSkbDCzIl1ixbWktrBjdmlcZeumUIvm7QYQjc9FogfLf8vE+uG1uB
         9V36COu4FxQllX1pkpqCjpWOUQ9RrGYZ46PM8V5Nu3DKrjUECpyjvm50qUnbfqXrc+tz
         zfrJTsmgi2KGuU5fyHINEi0PQnPhMxElhrumLW8328bz/wJIIlNOMUaFcx53L7Hr+pYP
         x6I7v6dDvoPQfj6WyVzNLFoucJye2DNzyCQXaDvL3trPNDJ4r0Cuymyzn3wp6l/wTNzW
         xcJglUQKqYWAXIw5sr5B+SFycvTu6Xw02jaUJOgCkrThe+i5CX39RQ7OYLYFdzkN+Aj7
         ze4Q==
X-Gm-Message-State: AFqh2krtAxizm2Oc/U016UEJl/D78Wn6i+euP/4FEtG3QpeoMJViq2zM
        8J7UiEEy6tc2jC3n71ByERc=
X-Google-Smtp-Source: AMrXdXs4tJQwnAKp32P/PRxoMaQVUKIGMJpB9UtCVF4KRKekYvmvJjE8kOD4oRBCVbvQTO9PuyeRGQ==
X-Received: by 2002:a05:6512:c24:b0:4b5:964d:499b with SMTP id z36-20020a0565120c2400b004b5964d499bmr4688117lfu.34.1671919316624;
        Sat, 24 Dec 2022 14:01:56 -0800 (PST)
Received: from [10.0.0.100] (host-185-69-38-8.kaisa-laajakaista.fi. [185.69.38.8])
        by smtp.gmail.com with ESMTPSA id y1-20020a0565123f0100b00492e3a8366esm1116625lfa.9.2022.12.24.14.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Dec 2022 14:01:56 -0800 (PST)
Message-ID: <66ef2f70-9405-fe09-7927-143084286d1b@gmail.com>
Date:   Sun, 25 Dec 2022 00:03:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
To:     Nicolas Frayer <nfrayer@baylibre.com>, nm@ti.com,
        ssantosh@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        grygorii.strashko@ti.com, khilman@baylibre.com,
        mkorpershoek@baylibre.com
References: <20221221200513.676744-1-nfrayer@baylibre.com>
Content-Language: en-US
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH] soc: ti: k3-ringacc: Add try_module_get() to
 k3_dmaring_request_dual_ring()
In-Reply-To: <20221221200513.676744-1-nfrayer@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On 21/12/2022 22:05, Nicolas Frayer wrote:
> When the k3 ring accelerator driver has been modified to add module build
> support, try_module_get() and module_put() have been added to update the
> module refcnt. One code path has not been updated and it has introduced
> an issue where the refcnt is decremented by module_put() in
> k3_ringacc_ring_free() without being incremented previously.
> Adding try_module_get() to k3_dmaring_request_dual_ring() ensures the
> refcnt is kept up to date.

Good catch!
I had never had my hands on a device with DMSS (BCDMA/PKDMA) and the
original module support was developed and tested on devices with UDMA.

can you add the fixes tag along with my reviewed by tag?

Fixes: c07f216a8b72 ("soc: ti: k3-ringacc: Allow the driver to be built as module")
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> 
> Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
> ---
>   drivers/soc/ti/k3-ringacc.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
> index e01e4d815230a..8f131368a7586 100644
> --- a/drivers/soc/ti/k3-ringacc.c
> +++ b/drivers/soc/ti/k3-ringacc.c
> @@ -406,6 +406,11 @@ static int k3_dmaring_request_dual_ring(struct k3_ringacc *ringacc, int fwd_id,
>   
>   	mutex_lock(&ringacc->req_lock);
>   
> +	if (!try_module_get(ringacc->dev->driver->owner)) {
> +		ret = -EINVAL;
> +		goto err_module_get;
> +	}
> +
>   	if (test_bit(fwd_id, ringacc->rings_inuse)) {
>   		ret = -EBUSY;
>   		goto error;
> @@ -421,6 +426,8 @@ static int k3_dmaring_request_dual_ring(struct k3_ringacc *ringacc, int fwd_id,
>   	return 0;
>   
>   error:
> +	module_put(ringacc->dev->driver->owner);
> +err_module_get:
>   	mutex_unlock(&ringacc->req_lock);
>   	return ret;
>   }

-- 
Péter
