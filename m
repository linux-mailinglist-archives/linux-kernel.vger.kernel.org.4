Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8CA669CC7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjAMPrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjAMPqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:46:36 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A13101DE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:37:36 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id bf43so33663861lfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CQmmN4UZp6vm/MPn+6xJoyMuv2Cth9kwSKB3piNKqlw=;
        b=TZsx4xAO4pLUFT00cBgy9ker7fkPoPKWBWCLMezh7j12QY3zv9CR8qaK/cTYdjn38e
         nWiumjkNGMsOC3Ji0kEo/YgbCV2tnHrLjdsHF/7ZLGH30cusvXPg4wEswLK2MK2MIge4
         uvmfkZWddFuXobMXVf/5N3SCBYugtpzLieccG07cjsu46bKOJn+QJy8OLXCBohg3gewT
         aBJJvwJ+8V396LCDDnHy2/M3yOPLMXG8vmw4RGd2CHhlyBtkpUp64EY4W+rfWA/6UHVy
         03ofI/AeGm72arXzEJZyupuC3n2Tl1TtjS72NMJ0idzE8kfk+8kjNWyN05SIP16zayEy
         AkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CQmmN4UZp6vm/MPn+6xJoyMuv2Cth9kwSKB3piNKqlw=;
        b=YXwSIM2Qcc6uYKP3FEuz6p5DChpyTjFR0GSCAyMKn6/9PLly08U6155QvAn2n7K6QE
         50QJPggbBoqfli8mZsxsqo/eaVbwbNAbXSCh/3eSC8m+CMsBp4vAaYqaHrmpimwZPgZk
         970/x6l6c+ZgHCUX98rWfrwGl+jeQrxUF9dsoj0ko3/KcnAng7T6ErOeUCE5Lv0IV7vV
         AXf9cylAXdI5F9EGu+HQDYklWAS5sco6GF4Yj8nvD0OmaRRTovMYs/akhYeXh0KRxrso
         SxVjvZaDbWM8n1aFckdMaJOzWN7Wf1ZrswRZTsmeut0NlBjrA5HmsNSmrtl8I6wltU7j
         IoNQ==
X-Gm-Message-State: AFqh2koBh+e6RsACQ88Ffu4Xmkf22PDc+5BnCkQw0vYRygk0GzKDJQtS
        HtkpQ/AupDkm0QwhwznsWeY4cA==
X-Google-Smtp-Source: AMrXdXsw6l1NUq5GD0ouPv+r+GXQDAqG/gmNYndecwpSh8o9NX0xu9PT3TBmT7p8ywz7QI7gq5AH4A==
X-Received: by 2002:ac2:551c:0:b0:4a4:68b8:c2b8 with SMTP id j28-20020ac2551c000000b004a468b8c2b8mr77993lfk.15.1673624254592;
        Fri, 13 Jan 2023 07:37:34 -0800 (PST)
Received: from [192.168.1.101] (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id d22-20020a196b16000000b004d093d60f50sm379848lfa.215.2023.01.13.07.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 07:37:33 -0800 (PST)
Message-ID: <77d84408-166e-8a02-227a-67654a4d31f2@linaro.org>
Date:   Fri, 13 Jan 2023 16:37:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 6/6] regulator: qcom_smd: Add support to define the bootup
 voltage
Content-Language: en-US
To:     devi priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
References: <20230113150310.29709-1-quic_devipriy@quicinc.com>
 <20230113150310.29709-7-quic_devipriy@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230113150310.29709-7-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.01.2023 16:03, devi priya wrote:
> Kernel does not know the initial voltage set by the bootloaders.
> During regulator registration, the voltage variable is just declared
> and it is zero. Based on that, the regulator framework considers current
> the voltage as zero and tries to bring up each regulator to minimum
> the supported voltage.
> 
> This introduces a dip in the voltage during kernel boot and gets
> stabilized once the voltage scaling comes into picture.
> 
> To avoid the voltage dip, adding support to define the
> bootup voltage set by the boodloaders and based on it, regulator
> framework understands that proper voltage is already set
> 
> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
> ---
Or maybe hook it up to the spmi_regulator_common_get_voltage()
from the SPMI regulator driver and read the real voltage instead
of relying on hardcoded values thay may differ between boards?

Konrad
>  drivers/regulator/qcom_smd-regulator.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
> index 1eb17d378897..49a36b07397c 100644
> --- a/drivers/regulator/qcom_smd-regulator.c
> +++ b/drivers/regulator/qcom_smd-regulator.c
> @@ -800,6 +800,7 @@ struct rpm_regulator_data {
>  	u32 id;
>  	const struct regulator_desc *desc;
>  	const char *supply;
> +	int boot_uV; /* To store the bootup voltage set by bootloaders */
>  };
>  
>  static const struct rpm_regulator_data rpm_mp5496_regulators[] = {
> @@ -809,7 +810,7 @@ static const struct rpm_regulator_data rpm_mp5496_regulators[] = {
>  };
>  
>  static const struct rpm_regulator_data rpm_ipq9574_mp5496_regulators[] = {
> -	{ "s1", QCOM_SMD_RPM_SMPA, 1, &ipq9574_mp5496_smpa1, "s1" },
> +	{ "s1", QCOM_SMD_RPM_SMPA, 1, &ipq9574_mp5496_smpa1, "s1", 875000 },
>  	{}
>  };
>  
> @@ -1394,6 +1395,9 @@ static int rpm_regulator_init_vreg(struct qcom_rpm_reg *vreg, struct device *dev
>  	vreg->type	= rpm_data->type;
>  	vreg->id	= rpm_data->id;
>  
> +	if (rpm_data->boot_uV)
> +		vreg->uV = rpm_data->boot_uV;
> +
>  	memcpy(&vreg->desc, rpm_data->desc, sizeof(vreg->desc));
>  	vreg->desc.name = rpm_data->name;
>  	vreg->desc.supply_name = rpm_data->supply;
