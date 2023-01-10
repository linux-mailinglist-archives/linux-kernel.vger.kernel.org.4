Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99A96641CB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238250AbjAJN3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238616AbjAJN2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:28:43 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3D53B3;
        Tue, 10 Jan 2023 05:28:02 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o7-20020a17090a0a0700b00226c9b82c3aso13423153pjo.3;
        Tue, 10 Jan 2023 05:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xw/+Ec6F2sXXn/Oy+GPA4z1yygz+zcW6yQ34bFJPVCM=;
        b=QbaX0ANqWEwGShl5/o1FedSd5lmpoVZbDK91tpPlukRt8oiRTcW9UJN3xSakqz9mKD
         m7q1ef6878Yjrui3KuqOJMIFWjkau8Yxyx2BiBdGCDfw6piVTK749skcZPFXBSOopE8l
         ZbwaR5sEKaDE+J+JERUh5ndtl1c/9CoQRAZYJGaEzeH7xyhYCuCh0RydmaZ7FnpYXLP/
         kqOzIxknol0LeWnySe5PXqiMUccvdYPx8T7ww7IdOIbF5UIlieAa5DHKyELF2bXGYZPJ
         3ARgWRPCyrLyMdakZWSgYfmjaOf8gN43awQU71rYoRC4A5pJ+GOmNH25QkuyvhoPEG4r
         94Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xw/+Ec6F2sXXn/Oy+GPA4z1yygz+zcW6yQ34bFJPVCM=;
        b=TVWRIa36m5VSR0LqlQdRnWcHbeb0JaTh09TLuZzl5YF8U3X/cDDHstHYH/miqq/QBs
         k9AB+AY8Z6Ht5clmkBiZhIyNJYhc08oYK/7vSQ4bLtZOkWDotjzcghjEXRWSRPB2KNGe
         Q9nn7n4aZT8RCLGHXIUkExAvw+4NuiWyXBKHpmgKuartS4YsIi5opMsGlf0ICfOl5dH2
         Sq1yLvIPSIKGiT2V1vc4WIssrw5v1aGN8DM79dqd1GjACp8pavwcIgLPF7+xLpwr2wTb
         Zi+RTDmYUX65whM0SEpYneTCcDRcV6To9IbSlfIlZtZylVXYWiW0w+AblKEacSjpHAB+
         OIbA==
X-Gm-Message-State: AFqh2kp4H2hLc4MufPjQVzoUP/gOEN8beguGoU2EuxgsGHHSwTcxLNxy
        3S9GxeXP6M3/lgxhcszngZc=
X-Google-Smtp-Source: AMrXdXuQrIZ5p/fOOAXrvQsEbH9ipOhrcmi9W6yWA45/BYFb9VORZHIuIaaUq8CJqWCLxoZemWGP/w==
X-Received: by 2002:a05:6a20:d69a:b0:af:9538:ec5c with SMTP id it26-20020a056a20d69a00b000af9538ec5cmr104676466pzb.51.1673357281946;
        Tue, 10 Jan 2023 05:28:01 -0800 (PST)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id k13-20020aa7972d000000b00561d79f1064sm8084686pfg.57.2023.01.10.05.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 05:28:01 -0800 (PST)
Message-ID: <8207ec8a-9001-e1a6-6f00-a5691bcddb91@gmail.com>
Date:   Tue, 10 Jan 2023 22:27:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 2/2 RESEND] extcon: qcom-spmi: Switch to
 platform_get_irq_byname_optional
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        agross@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
References: <20221228133058.213886-1-bryan.odonoghue@linaro.org>
 <20221228133058.213886-3-bryan.odonoghue@linaro.org>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20221228133058.213886-3-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 12. 28. 22:30, Bryan O'Donoghue wrote:
> Valid configurations for the extcon interrupt declarations are
> 
> - usb_id
> - usb_vbus
> - (usb_id | usb_vbus)
> 
> In the case of a standalone usb_id or usb_vbus failure to find one of the
> interrupts shouldn't generate a warning message. A warning is already in
> place if both IRQs are missing.
> 
> Switch to using platform_get_irq_byname_optional() in order to facilitate
> this behaviour.
> 
> Suggested-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/extcon/extcon-qcom-spmi-misc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-qcom-spmi-misc.c b/drivers/extcon/extcon-qcom-spmi-misc.c
> index eb02cb962b5e1..f72e90ceca53d 100644
> --- a/drivers/extcon/extcon-qcom-spmi-misc.c
> +++ b/drivers/extcon/extcon-qcom-spmi-misc.c
> @@ -123,7 +123,7 @@ static int qcom_usb_extcon_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	info->id_irq = platform_get_irq_byname(pdev, "usb_id");
> +	info->id_irq = platform_get_irq_byname_optional(pdev, "usb_id");
>  	if (info->id_irq > 0) {
>  		ret = devm_request_threaded_irq(dev, info->id_irq, NULL,
>  					qcom_usb_irq_handler,
> @@ -136,7 +136,7 @@ static int qcom_usb_extcon_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	info->vbus_irq = platform_get_irq_byname(pdev, "usb_vbus");
> +	info->vbus_irq = platform_get_irq_byname_optional(pdev, "usb_vbus");
>  	if (info->vbus_irq > 0) {
>  		ret = devm_request_threaded_irq(dev, info->vbus_irq, NULL,
>  					qcom_usb_irq_handler,

Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

