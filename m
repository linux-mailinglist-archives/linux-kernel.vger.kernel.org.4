Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9916B5179
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjCJULI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjCJULG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:11:06 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BCA12B95F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 12:11:01 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id g17so8187599lfv.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 12:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678479060;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IhX79qKfM1/zb92acVDZmk/CzOUzPXH+OPf8q0XXzdI=;
        b=GKzphay129/lwuMv3wRValWEA+e3DEzmVtIhMP3r5rVNh0Nvtq9mYypRmdNpKbG3cj
         LDt+zRUErFcUkEXUPCzyW9KFn11g7t3Be0JkCjLRwxdlBQVB8cS71IQ9E3xCxo4NFpSp
         Fz2AyyxFyA1GOOdkriCQY6Thvm7WhosKAya2u3eLlXc9t29PvOX/5zT6UGUCisR7ffQG
         Sh69fnmvmnpLmm3gxdNzapfNeB7co2yGOPjxnk1sRb32ScSLylUKx4zylwfeZVLqUtKP
         HILxwHsGDE5UQlUZgA11zNJ0TWeDp+wlOlUIaM1NQLYWZROV2PL6GkneGPqm05TTZWXC
         ZsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678479060;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IhX79qKfM1/zb92acVDZmk/CzOUzPXH+OPf8q0XXzdI=;
        b=yBj4ujldRHaBlp0udcBtV1nKIvg1nPVPRRmjGtK301saz4e0nBi8UM/iiw/MobUAHx
         kkuN9hnbHWWTMmJiqkxoXFKONIK1VJ8WE3lTJikyuOhStCmro3Z4HQO+D805aP/maAve
         +zHos3xvXDj7vvncm1Sp+b9RsUTxtYGxlfH60q11+11v5jCFUvDUN6M4gJniDyT7UVPD
         IUK4eEVIHSyIgeSzJxwhE5GHhqrrdx2rgbzPUp7DRBCyJ6TaRWVSwZnQBl5BM4ASkaZU
         GqBsFbI59dPpnS8f6WXF5JlJeP4IMgGKcKWc3flsDuSlDUJ8qs6yOt2PwtAGETGuSbdo
         5sDw==
X-Gm-Message-State: AO0yUKXrRiqoDoWLug8siEsuU8d4ZtTuFmm8ZPfrIqT5hIT5qKrAS8Bn
        dU74oIrRYS2XtYJmXp1KdUEp9A==
X-Google-Smtp-Source: AK7set8IQ9GF2cDVHGw9B0cHBy/daNgrAOlvOJtUdvGgVGESyJBRaqRO9YiKz3S5IS6taomOlqQ7rQ==
X-Received: by 2002:ac2:5457:0:b0:4dd:ce0b:7692 with SMTP id d23-20020ac25457000000b004ddce0b7692mr7377693lfn.46.1678479059716;
        Fri, 10 Mar 2023 12:10:59 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id w16-20020a19c510000000b004dc4b00a1f3sm81235lfe.253.2023.03.10.12.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 12:10:59 -0800 (PST)
Message-ID: <c6e4db71-d5ab-9e82-6cde-5bbe4f7408bc@linaro.org>
Date:   Fri, 10 Mar 2023 21:10:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] power: reset: qcom-pon: drop of_match_ptr for ID table
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230310200652.19926-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230310200652.19926-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.03.2023 21:06, Krzysztof Kozlowski wrote:
> The Qualcomm SoC power-on driver is specific to ARCH_QCOM which depends
> on OF thus the driver is OF-only.  It's of_device_id table is built
> unconditionally, thus of_match_ptr() for ID table does not make sense.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/power/reset/qcom-pon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
> index 16bc01738be9..ebdcfb28c4a0 100644
> --- a/drivers/power/reset/qcom-pon.c
> +++ b/drivers/power/reset/qcom-pon.c
> @@ -91,7 +91,7 @@ static struct platform_driver pm8916_pon_driver = {
>  	.probe = pm8916_pon_probe,
>  	.driver = {
>  		.name = "pm8916-pon",
> -		.of_match_table = of_match_ptr(pm8916_pon_id_table),
> +		.of_match_table = pm8916_pon_id_table,
>  	},
>  };
>  module_platform_driver(pm8916_pon_driver);
