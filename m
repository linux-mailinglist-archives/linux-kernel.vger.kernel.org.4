Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB9568EC41
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjBHKCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjBHKCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:02:06 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90ED321945
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 02:02:05 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id gr7so49861549ejb.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 02:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6iRFBlMEYvn5uCQ8+IbFT1rdcbrh/NWARIU6RnFdQ5s=;
        b=BSlroPySQeG7GYEfe3SCe0SLI7y48GoYASx9xINHtFhxUDhnZl+IT+5JlvLjCG+mnZ
         YxJbj1t/Mpher2GxrNuFFIqE+Kksnp8UYbUbMxkbG1Dcw1Bgp4Edwq9Ix7RgTuCXUpOv
         esetcY7aaExA3NI8CLZVaAiK8sYNtuJlVQ4WwaHPeas6N0RHWbwi+6qbr8YtnHsGDd/H
         QTrAq5kBBTQl+TwDbR38gHmmT5qZ1hSwVD8SvcPdfgIWCfBoeFd8EIdvnVGUM+a7dXgf
         wYR723k/97z0+CG9TD6sZRzxuXAhZh1PT4HLGEPlRbPrhHhD0lAlBeIQqoAasx0k3sHI
         sEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6iRFBlMEYvn5uCQ8+IbFT1rdcbrh/NWARIU6RnFdQ5s=;
        b=SMRDigUraESzPY/+Gq9LNgpvg+HpBKE2ZTpTd/9RoZc4kKMtfm+OQhgokcoEvPcgEW
         bplGL5Kfu+XMMiJoXSGl4AFcTaObmeE9UhSdLVRAndlbZgHf4hmrWjS9cp+OX8+fPT66
         NTFheh9qlceJJLGd8hIrjopcG/dqGn/QXXJXSiX3M8D76ZMVOiBBO/wK2se4oXwwbWEu
         9n9fv7RLzpYJbaPpnVRS79pEWLaSeGQcD2oNhrKHGuAvqsrW1sdqUay0ZtWeyaC7Kcpd
         XoH/jE6MZ7v4dsodPXd/nlr2jMF7Ocl2hEb3sUnA1dQXtRkiY3dZTFBCRGYozv1axJnt
         GXlA==
X-Gm-Message-State: AO0yUKV4mSuHlS6nxQ0tlDLm8PJds1yIB5IOb5wlP07XQX/QPy1CIgHL
        rXb1Xtuv/+WvdoO18XEbIXUShQ==
X-Google-Smtp-Source: AK7set8U8P6nxSEV42tswzNmkWxQyomyKQu0bmz1W7EOI0sNg/vcwnW8tQ+WE4j70GLHCfm4Rc8oAg==
X-Received: by 2002:a17:906:ca0f:b0:8a6:93a4:c897 with SMTP id jt15-20020a170906ca0f00b008a693a4c897mr7376883ejb.33.1675850524242;
        Wed, 08 Feb 2023 02:02:04 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id j21-20020a17090686d500b008a9e37ca37fsm1924423ejy.166.2023.02.08.02.02.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 02:02:03 -0800 (PST)
Message-ID: <5d6c0f50-da59-8f4f-a04f-d24e3c0c2992@linaro.org>
Date:   Wed, 8 Feb 2023 11:02:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] mfd: qcom_rpm: use
 devm_platform_get_and_ioremap_resource()
Content-Language: en-US
To:     ye.xingchen@zte.com.cn, lee@kernel.org
Cc:     agross@kernel.org, andersson@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <202302081734511884545@zte.com.cn>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <202302081734511884545@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8.02.2023 10:34, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/mfd/qcom_rpm.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/mfd/qcom_rpm.c b/drivers/mfd/qcom_rpm.c
> index 8fea0e511550..086611322874 100644
> --- a/drivers/mfd/qcom_rpm.c
> +++ b/drivers/mfd/qcom_rpm.c
> @@ -530,7 +530,6 @@ static int qcom_rpm_probe(struct platform_device *pdev)
>  {
>  	const struct of_device_id *match;
>  	struct device_node *syscon_np;
> -	struct resource *res;
>  	struct qcom_rpm *rpm;
>  	u32 fw_version[3];
>  	int irq_wakeup;
> @@ -576,8 +575,7 @@ static int qcom_rpm_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	rpm->data = match->data;
> 
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	rpm->status_regs = devm_ioremap_resource(&pdev->dev, res);
> +	rpm->status_regs = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
>  	if (IS_ERR(rpm->status_regs))
>  		return PTR_ERR(rpm->status_regs);
>  	rpm->ctrl_regs = rpm->status_regs + 0x400;
