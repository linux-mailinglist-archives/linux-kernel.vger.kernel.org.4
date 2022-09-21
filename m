Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0785B5BFF75
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 16:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiIUOCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 10:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiIUOCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 10:02:33 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465F78993C;
        Wed, 21 Sep 2022 07:02:32 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so5940895pjh.3;
        Wed, 21 Sep 2022 07:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=TjMGlzRi9/9H0RzSJ0Wk0DHEdZrEgqy/4cen7DiALFs=;
        b=Yrru6+VrnZ/wP8pnwqrXKsJKkW6kdD/tpUGsMJEl96p9dMyaRXP5KneH8C095U3VFp
         xgWHy4+SOlte1Mu7JWRAqPPiqo8fm9TULHP3/KDiHj0zXpYCw19NjNJjP0c6oJDErGUD
         P8MPQwoslH2qQPE+TOIiDCquWmQhsCvH+I3gfdpTjPHb5AQYB9K/EmBIUmpo/1RH/FwW
         MnPwHn8uTQ7nRmC+wQgVoPVw/LMMHASUvfQWnHJZu6K1EdH9lz4Ai3iujY7zfOiqHAF/
         kOx9Vfms1TLec8cGdwSSfjM+6hnMAp2FoksgUp/0iaXT25e2gll+JfFecBiVR4DVmlLo
         Mr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=TjMGlzRi9/9H0RzSJ0Wk0DHEdZrEgqy/4cen7DiALFs=;
        b=NCkw+KdAcjRaeOQDOoezzoFetxyYg5B6JCv606agrJaCgUxKE4M+c7OvucOagdmoWw
         Qvg8Zo/Veiegr0SXHZTBbK5rjQss+C4D2ppTlopB8IDYwcDKFOOGxbLTikShNik/9sNe
         5zqbIDfn8RwV1mzWtb2sELNrhwmbm86pBxAPTO4tIZoWYE5B2Zwz9Mh2I6ynOFNWngsB
         SxYv3hWaWUh9aAGrCeIQ4kPD04+Gm/ke3MobjxVKfFrXcebQrOTFkx+WnMVLWPRqIFW4
         ITPUXU01Fc5Y90AreHIj5ZfNU6kHZfe3AnxwlxnRn1XKCyVk2fjFixOayKgy+Uie3UHm
         GKBA==
X-Gm-Message-State: ACrzQf11Ap6RVTKQ2VeurYu6WNyNg4saToaxeZIRR2gx579m1wjwNmAi
        YQYMNAyPOAhzuIvsunjKo4Fy/DMMGci0OQ==
X-Google-Smtp-Source: AMsMyM73J4VT9C2uxUqDTrHQMocE0+BLNyq35dD0FtisGQcq02O3lz0Kgb7f/2XCtQ/1d7sQkREpjQ==
X-Received: by 2002:a17:902:ceca:b0:177:fa1f:4abc with SMTP id d10-20020a170902ceca00b00177fa1f4abcmr4948576plg.99.1663768951780;
        Wed, 21 Sep 2022 07:02:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c85-20020a621c58000000b0053653c6b9f9sm2114779pfc.204.2022.09.21.07.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 07:02:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <57f5b28d-3a21-3d1e-422d-d79eebefb8e5@roeck-us.net>
Date:   Wed, 21 Sep 2022 07:02:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] hwmon: (mr75203) fix undefined reference to `__divdi3'
Content-Language: en-US
To:     Eliav Farber <farbere@amazon.com>, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, sudipm.mukherjee@gmail.com
Cc:     hhhawa@amazon.com, jonnyc@amazon.com,
        kernel test robot <lkp@intel.com>
References: <20220921121723.6726-1-farbere@amazon.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220921121723.6726-1-farbere@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/22 05:17, Eliav Farber wrote:
> Fix build error on 32-bit machines.
> 
> Fixes: 381a86c545f1 ("hwmon: (mr75203) modify the temperature equation according to series 5 datasheet")
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> Reported-by: kernel test robot <lkp@intel.com>

Applied.

> ---
> I will also rework it into the original series (since it's not just a
> trivial squash into one previous commit) and you can decide what to use
> according to your preference.
> 

I rather keep this patch separate.

Thanks,
Guenter

>   drivers/hwmon/mr75203.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
> index 0fea443dc3e1..9c400cf790b5 100644
> --- a/drivers/hwmon/mr75203.c
> +++ b/drivers/hwmon/mr75203.c
> @@ -266,9 +266,9 @@ static long pvt_calc_temp(struct pvt_device *pvt, u32 nbs)
>   	struct temp_coeff *ts_coeff = &pvt->ts_coeff;
>   
>   	s64 tmp = ts_coeff->g +
> -		ts_coeff->h * (s64)nbs / ts_coeff->cal5 -
> +		div_s64(ts_coeff->h * (s64)nbs, ts_coeff->cal5) -
>   		ts_coeff->h / 2 +
> -		ts_coeff->j * (s64)pvt->ip_freq / HZ_PER_MHZ;
> +		div_s64(ts_coeff->j * (s64)pvt->ip_freq, HZ_PER_MHZ);
>   
>   	return clamp_val(tmp, PVT_TEMP_MIN_mC, PVT_TEMP_MAX_mC);
>   }

