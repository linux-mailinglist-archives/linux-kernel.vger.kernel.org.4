Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3325BFEA4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 15:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiIUNGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 09:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiIUNGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 09:06:15 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F3A883E0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 06:06:13 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id h3so6960709lja.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 06:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=gAZ4zcbB2orsLPAQ8EJjR8EjPWSXSxUFgQ5EnML0I7I=;
        b=OJiVAcCSHD7qCGHeeMts6h6iBTjME+np3LrBiZF09r2NsgKvfKDb0UgyATfCdMPZIM
         fhCz17ALMAKbZszbda79CmL9JlQLDD1iFfBk6Jx9UOMe3ZK1xMsxv3Ror5XAzD1HLzov
         91tOUuF+HqBxI4NdgjzgJA6UXtMJFj6uhGiqaSvbVmGpnSxLFLjMeR91p41SFUxqayCt
         QFrJ/x5GRpGEygOzZJBn24KmIvpHVuCd2t0jOwRcbALvNY38OxjdeEBNR3DEtUY6Fw8R
         78UbNc/tiv1q6sMVQZp+MiaX8xoe8+EwemNx7sstZSMGz8ptpqPTqjWpslzUrzIgEyIn
         Iquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=gAZ4zcbB2orsLPAQ8EJjR8EjPWSXSxUFgQ5EnML0I7I=;
        b=r0mdmjYiXqOPqJnLFEsUHlrFRuiA6PU0pxt50kzJu5GUCthiU3xFeqsqYgCqstLTtE
         u5Jwge8K1Oca/kM5Vdky0SUKcuxf00L/LktK2Y4nguIpzvr2uxKY4Rp8GIrv/G9dmjYG
         Izf9+wXfu5bZhT/iw/Jug64A1/FGKXFLLUn1v7rREePWBt0x/TnJAvdhXO3ocffN61jW
         RVm0EsDkbxFPFdvHQ3LLe8mSEsAW17FFAccfyOyLOpmQaEL5qerYw2UEouLWRws2w8xW
         ue07enWuLaw4Es1CseF6SBfZCX8Z2mJwwhClV1tAofGe0Cdcn8qkekMYMr3Rixiygx5R
         +4sA==
X-Gm-Message-State: ACrzQf35GD9ZPoReO8Da22NhgOJdiIz28kvYRewY6wmZLgI7JkqRlpGl
        jtR6e1rMtZ/aIDBm5JDCbmxMhb8gsMflxQ==
X-Google-Smtp-Source: AMsMyM6+sJnzoKk2ra9r0XoN+2znerZ9uj5UFe4DJYjXt9KsiXp045FDLjIa6Ele9KhkbFcAn/wJqA==
X-Received: by 2002:a2e:a887:0:b0:26a:ba85:8fbe with SMTP id m7-20020a2ea887000000b0026aba858fbemr8367222ljq.14.1663765572108;
        Wed, 21 Sep 2022 06:06:12 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id s3-20020a056512314300b0048a9e18ae67sm429912lfi.84.2022.09.21.06.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 06:06:11 -0700 (PDT)
Message-ID: <f6ab7125-4f1a-61fc-cfeb-8988921c35b4@linaro.org>
Date:   Wed, 21 Sep 2022 16:06:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] phy: qcom-qmp-pcie: Fix the SM8450 PCS registers
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        vkoul@kernel.org, andersson@kernel.org
Cc:     kishon@ti.com, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220910063857.17372-1-manivannan.sadhasivam@linaro.org>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220910063857.17372-1-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/2022 09:38, Manivannan Sadhasivam wrote:
> In the PCS region, registers QPHY_V5_PCS_EQ_CONFIG4 and
> QPHY_V5_PCS_EQ_CONFIG5 should be used instead of QPHY_V5_PCS_EQ_CONFIG2
> and QPHY_V5_PCS_EQ_CONFIG3.
> 
> This causes high latency when ASPM is enabled, so fix it!

I have checked against vendor's tree [1]. The registers in question have 
offsets 0x01c0f3e0 / 0x01c0f3e4. The sm8450.dtsi uses 0x1c0f200 as the 
PCS region base for the PCIe PHY1. Thus the correct offsets for the 
table are 0x1e0/0x1e4.

There might be a mistake in the name of the register, but the address 
corresponds to the address in the vendor's tree.

[1] 
https://github.com/MiCode/kernel_devicetree/blob/zeus-s-oss/qcom/waipio-pcie.dtsi#L520

> 
> Fixes: 2c91bf6bf290 ("phy: qcom-qmp: Add SM8450 PCIe1 PHY support")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c   | 4 ++--
>   drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index 4648467d5cac..b508903d77d0 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -1332,8 +1332,8 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_rx_tbl[] = {
>   };
>   
>   static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_pcs_tbl[] = {
> -	QMP_PHY_INIT_CFG(QPHY_V5_PCS_EQ_CONFIG2, 0x16),
> -	QMP_PHY_INIT_CFG(QPHY_V5_PCS_EQ_CONFIG3, 0x22),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_EQ_CONFIG4, 0x16),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_EQ_CONFIG5, 0x22),
>   	QMP_PHY_INIT_CFG(QPHY_V5_PCS_G3S2_PRE_GAIN, 0x2e),
>   	QMP_PHY_INIT_CFG(QPHY_V5_PCS_RX_SIGDET_LVL, 0x99),
>   };
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h
> index 61a44519f969..cca6455ec98c 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h
> @@ -11,7 +11,7 @@
>   #define QPHY_V5_PCS_G3S2_PRE_GAIN			0x170
>   #define QPHY_V5_PCS_RX_SIGDET_LVL			0x188
>   #define QPHY_V5_PCS_RATE_SLEW_CNTRL1			0x198
> -#define QPHY_V5_PCS_EQ_CONFIG2				0x1e0
> -#define QPHY_V5_PCS_EQ_CONFIG3				0x1e4
> +#define QPHY_V5_PCS_EQ_CONFIG4				0x2e0
> +#define QPHY_V5_PCS_EQ_CONFIG5				0x2e4
>   
>   #endif

-- 
With best wishes
Dmitry

