Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF476B5622
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjCKAE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjCKAEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:04:55 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912F412EAEE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:04:53 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id by8so7041593ljb.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678493092;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0nQUEM3Mo/qwKczoK7AnFt/+sDF/eJanC0q6vkKReng=;
        b=k0cyTmcp+EpinxlK4oohVCqw4aFXJ5Ze7JLEd0oJ6gyeL4zdyQeycf9eknHIeAywHO
         nVLnGKm1Etkg/uG+vKmqFxsWQOy4Im/xo4pnU4lI0xxzh40etCR16CMVbiSHurs4oRTs
         ZfSm47DBhNvz0szizRcsaPTy9pN13DYuMe352zNHkAsoIog+qGH3zVqJ0G0rbAsUzErz
         KoybY2SDPVj4hM4Fiha/VchNK/zTVTNsoF+fhoEQ058zXV7DiHQ8rtpb9dKXB2UOVLjF
         FxEoAauygxMW1GOYFUT12+VQ+wjukB7EUISOgtCAXpEsIba+rBM6wmqSLWOetnsxDaS3
         Gtvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678493092;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0nQUEM3Mo/qwKczoK7AnFt/+sDF/eJanC0q6vkKReng=;
        b=JTSe2wFzK2t27s4Svp5bz0GEBMbmF38grLx1RrayorlRnKpTgjZgO8yojtlqq2cIIm
         M0uVRaEu/1MCq9HnxhSRMZXYjaymaNbOdoj+ZT7YWdoOYUoHHqNoKPgfq89y5ez5UXZA
         e1lwQNRhtDycrD/Syk8VHHGTd096l1IuVpQDIQH1tAC8HwpdRatB/+kg9iDh/iDZ/CBE
         7YJqfZkoP+WBKsxM08pGCr/MGK0DpuKkKiC2JhSiNa7j5z5eWUc5edt0K1EZbyiCxyMj
         8YB5Q8O2xxR/LwZR/bEMHYe8jwADkgqIsIzRnfEwQbsN0K+crRlfmdFlBmjLSZRQYAPB
         pfbw==
X-Gm-Message-State: AO0yUKUbJEtpn3zmR+6SelddLfIAFOhqZeeDXQXd056KRfeXU1VQHpg+
        uwxiCbPIHCPXGSUcQlphI3MEhA==
X-Google-Smtp-Source: AK7set8Rub8g/i5L5oS7Y6g5pT7fTegGL1L8CLe7ACsepZQzepmtJ1r7KlOUmUJqyAeZPP0KOwtXVw==
X-Received: by 2002:a2e:8750:0:b0:295:c399:68b with SMTP id q16-20020a2e8750000000b00295c399068bmr8483830ljj.23.1678493091819;
        Fri, 10 Mar 2023 16:04:51 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id g13-20020a2ea4ad000000b0029839faa74fsm154680ljm.134.2023.03.10.16.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 16:04:51 -0800 (PST)
Message-ID: <a5f943d0-1653-3269-32c1-d879bc333ded@linaro.org>
Date:   Sat, 11 Mar 2023 01:04:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] soc: qcom: gsbi: mark OF related data as maybe unused
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230310214413.275054-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230310214413.275054-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.03.2023 22:44, Krzysztof Kozlowski wrote:
> The driver can be compile tested with !CONFIG_OF making certain data
> unused:
> 
>   drivers/soc/qcom/qcom_gsbi.c:117:34: error: ‘tcsr_dt_match’ defined but not used [-Werror=unused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Shouldn't this driver depend on OF?

Konrad
>  drivers/soc/qcom/qcom_gsbi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/qcom_gsbi.c b/drivers/soc/qcom/qcom_gsbi.c
> index 290bdefbf28a..f1742e5bddb9 100644
> --- a/drivers/soc/qcom/qcom_gsbi.c
> +++ b/drivers/soc/qcom/qcom_gsbi.c
> @@ -114,7 +114,7 @@ struct gsbi_info {
>  	struct regmap *tcsr;
>  };
>  
> -static const struct of_device_id tcsr_dt_match[] = {
> +static const struct of_device_id tcsr_dt_match[] __maybe_unused = {
>  	{ .compatible = "qcom,tcsr-ipq8064", .data = &config_ipq8064},
>  	{ .compatible = "qcom,tcsr-apq8064", .data = &config_apq8064},
>  	{ .compatible = "qcom,tcsr-msm8960", .data = &config_msm8960},
