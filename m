Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6369D6EDB2A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 07:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjDYF0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 01:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjDYF0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 01:26:35 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18DA4C0F;
        Mon, 24 Apr 2023 22:26:29 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4eed6ddcae1so22852927e87.0;
        Mon, 24 Apr 2023 22:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682400388; x=1684992388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ITYzwxnIjWJqarLAZkVNHGuPcqhLd7rHFU45HBz2awM=;
        b=nS4fRFGd/XQcYH8kR9S7t5AQ+wQLnBjGI22NnMJJnCmelObAJSY37FPnxaMBMsDc9Y
         zXq2jhZZ1y+SKBpscD76eaVJII/K1D8YLy1UonnHueEs7xHFroHHq6nDiK6gvHx30J4H
         WgHSR+zFAcjQ47h7YNCRfOcS1S3Gei9w1BTzBwysQFtdbWn3bjrQwya/FpZO4OPDHpkQ
         ansumiRt8QlDrhQ9SdVrpLwCmkluN+KStQKr/oQ52O1HoJwgXlgQzbjJ8oXTiAwuJ9Zu
         AsHjzhxST5aScxrfW7KEx/jd8R4PByMBkRuj696dOodEGWW/AmKW4Shfijd8Xk4+3401
         RVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682400388; x=1684992388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ITYzwxnIjWJqarLAZkVNHGuPcqhLd7rHFU45HBz2awM=;
        b=e9bmqftpGUTgUW+tmPgTe8kT3X/42U/mP3KPFpkD0UXP+oakRHkKNcDCNXXXaUPv4H
         u3eoUfcLkLW3kpoQ4Y/WuUaE+MVw1ovKpzLO77yVzHC9+5ccAU8vR25JT7sT6RFx3kdI
         lV9GizD2LI75fg4g2iacg/R44Nm1bUeZWkrhjRQbswwySkSpsAM7NAMV0yyb51t7Afi4
         IcGwn4AfOloqsC7vWhG+Gjhx8y2tPL2Ffm5z5iFubAYq/Poi2l57EJDFnCV/P2A7wqag
         ag18grCvR4hG4JlGKrd72C10YwciyPERIuuJ4GH3VMnIUKcglojeGvWzyaq12uFunaX0
         cpZw==
X-Gm-Message-State: AAQBX9dMg6HIA25MMPVYWMqs55G4Z3mFN7IQWGyRra9vs/c88wbYb7KJ
        dSZN0XGyb7GEpyHqAj2uaQY=
X-Google-Smtp-Source: AKy350aeWVwF+R2nqkdARpZPlaVdvOAQlZLjfGKa6gMhlmyRavk9FD6OVpIJBUK2Q+YamnKqlstweg==
X-Received: by 2002:a05:651c:124c:b0:2a8:3a07:d6c3 with SMTP id h12-20020a05651c124c00b002a83a07d6c3mr3222951ljh.9.1682400387642;
        Mon, 24 Apr 2023 22:26:27 -0700 (PDT)
Received: from [192.168.1.111] (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id d22-20020a2e9296000000b002a8a5afb87csm1947428ljh.20.2023.04.24.22.26.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 22:26:27 -0700 (PDT)
Message-ID: <03fb7564-6cd3-bcef-2993-b3b69c9dbdbc@gmail.com>
Date:   Tue, 25 Apr 2023 08:26:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/7] iio: accel: kionix-kx022a: Remove blank lines
Content-Language: en-US, en-GB
To:     Mehdi Djait <mehdi.djait.k@gmail.com>, jic23@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1682373451.git.mehdi.djait.k@gmail.com>
 <40c033bc4c139fe450d8785c327f500f6f3ca965.1682373451.git.mehdi.djait.k@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <40c033bc4c139fe450d8785c327f500f6f3ca965.1682373451.git.mehdi.djait.k@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/23 01:22, Mehdi Djait wrote:
> Remove blank lines pointed out by the checkpatch script
> 
> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
> v3:
> - no changes, this patch is introduced in the v2
> 
>   drivers/iio/accel/kionix-kx022a.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> index f98393d74666..ff8aa7b9568e 100644
> --- a/drivers/iio/accel/kionix-kx022a.c
> +++ b/drivers/iio/accel/kionix-kx022a.c
> @@ -341,7 +341,6 @@ static int kx022a_turn_on_off_unlocked(struct kx022a_data *data, bool on)
>   		dev_err(data->dev, "Turn %s fail %d\n", str_on_off(on), ret);
>   
>   	return ret;
> -
>   }
>   
>   static int kx022a_turn_off_lock(struct kx022a_data *data)
> @@ -1121,7 +1120,6 @@ int kx022a_probe_internal(struct device *dev)
>   	if (ret)
>   		return dev_err_probe(data->dev, ret, "Could not request IRQ\n");
>   
> -
>   	ret = devm_iio_trigger_register(dev, indio_trig);
>   	if (ret)
>   		return dev_err_probe(data->dev, ret,

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

