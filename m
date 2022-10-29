Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F1061259F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 23:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiJ2Vs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 17:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJ2Vs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 17:48:26 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F36541B2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 14:48:24 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id bn35so12481254ljb.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 14:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=60gE0VpcoGAPlbRv1xoX9SZPevsEIxkl5Hy3ZJtcGLM=;
        b=MAtfuTHl4dtfu3T77+nZgTnE7t3bSENdQJryoXbdhhVaonf/mbK8WoPIj9pmr8Q4CD
         DO3kqyYsY6EctI6xxXhuNIhg/xkTyttwKO2HNgUh/JU1ScMHfG5o4tXClupgc97uCNP1
         vaagYkVuaQdqrhKFtMOFYQT4a2cZO0bG9RfbvNHuyW0wCpCWJSti7mZD6GNjt6wHCs0D
         RoPR+z2BqTFaCEEY3lmUeiLB0vj8rGB8eudbVH5kcsiibKCfOHCtX9cOih+TXIR1QmHk
         uGUqK913/lIQd/WYTN0fqEOtF8WpkhrzAN6UHoUYbp6rMaQGpHzkrohhMKNxd4tvQ+To
         1xjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=60gE0VpcoGAPlbRv1xoX9SZPevsEIxkl5Hy3ZJtcGLM=;
        b=qLndhCrUyA9yPAT9agj8OjJhQv3GjOGmFDSQqsboeBlc7AJXHDKPB9GeoaCYggzT57
         2WoE+nbu5TdChE5AmIky2qRYAgFnhXusF0sNp5tXRFIZKPSJQYtGC/UPzJTjv99ZuHwd
         0diHLPVMqa1DTNzXiftSzoKCnPhbeIBQ23R/iVgD88bNwWEzyxQ3PsDJMQo4iTNJBDwy
         BVbYo38qY4HyCOCsEBZzh8OfMaPjyldQ0ym22DNxOz9RXLveIsYbBW0UfcQXVjP4SjOk
         okQ0J+ejrUEDwk+dC4ibIIwgl3nsQu9371s2UD5ycmhsqrDELJ+IYQuF701zfuUdSYoy
         vwkg==
X-Gm-Message-State: ACrzQf0tvE9tJIR6M7VanVuiTlBSbf6l1J/QlNiFl11ltEOgfsPzTNR0
        sCx2NAIPG1NJ0zSZXxkSzbefWg==
X-Google-Smtp-Source: AMsMyM6yzSiQ96HOcDj/ORv3kfBljuuQYibHSlOCiCEiivXOHwWoN/gIdjwW9GvlC69HZGmF5O+thg==
X-Received: by 2002:a2e:8397:0:b0:277:35fa:84d6 with SMTP id x23-20020a2e8397000000b0027735fa84d6mr2126944ljg.429.1667080103304;
        Sat, 29 Oct 2022 14:48:23 -0700 (PDT)
Received: from [10.27.10.248] ([195.165.23.90])
        by smtp.gmail.com with ESMTPSA id h4-20020ac24da4000000b004a45ed1ae21sm443956lfe.224.2022.10.29.14.48.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Oct 2022 14:48:22 -0700 (PDT)
Message-ID: <cf8dcf53-f131-68f4-c6aa-d41e02ac6d5c@linaro.org>
Date:   Sun, 30 Oct 2022 00:48:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 14/15] scsi: ufs: ufs-qcom: Add support for finding HS
 gear on new UFS versions
Content-Language: en-GB
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        quic_cang@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20221029141633.295650-1-manivannan.sadhasivam@linaro.org>
 <20221029141633.295650-15-manivannan.sadhasivam@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221029141633.295650-15-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/10/2022 17:16, Manivannan Sadhasivam wrote:
> Starting from UFS controller v4, Qcom supports dual gear mode (i.e., the
> controller/PHY can be configured to run in two gear speeds). But that
> requires an agreement between the UFS controller and the UFS device.
> This commit finds the max gear supported by both controller and device
> then decides which one to use.
> 
> UFS controller's max gear can be read from the REG_UFS_PARAM0 register and
> UFS device's max gear can be read from the "max-gear" devicetree property.
> 
> The UFS PHY also needs to be configured with the decided gear using the
> phy_set_mode_ext() API.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/ufs/host/ufs-qcom.c | 35 ++++++++++++++++++++++++++++++++---
>   drivers/ufs/host/ufs-qcom.h |  4 ++++
>   2 files changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index f952cc76919f..268463e92d67 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -281,6 +281,9 @@ static int ufs_qcom_host_reset(struct ufs_hba *hba)
>   static u32 ufs_qcom_get_hs_gear(struct ufs_hba *hba, u32 hs_gear)
>   {
>   	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> +	struct device *dev = hba->dev;
> +	u32 max_gear, hcd_max_gear, reg;
> +	int ret;
>   
>   	if (host->hw_ver.major == 0x1) {
>   		/*
> @@ -292,8 +295,33 @@ static u32 ufs_qcom_get_hs_gear(struct ufs_hba *hba, u32 hs_gear)
>   		 */
>   		if (hs_gear > UFS_HS_G2)
>   			return UFS_HS_G2;
> +	} else if (host->hw_ver.major > 0x3) {
> +		/*
> +		 * Starting from UFS controller v4, Qcom supports dual gear mode (i.e., the
> +		 * controller/PHY can be configured to run in two gear speeds). But that
> +		 * requires an agreement between the UFS controller and the device. Below
> +		 * code tries to find the max gear of both and decides which gear to use.
> +		 *
> +		 * First get the max gear supported by the UFS device if available.
> +		 * If the property is not defined in devicetree, then use the default gear.
> +		 */
> +		ret = of_property_read_u32(dev->of_node, "max-gear", &max_gear);
> +		if (ret)
> +			goto err_out;

Can we detect the UFS device's max gear somehow? If not, the 'max-gear' 
property name doesn't sound good. Maybe calling it 'device-gear' would 
be better.

> +
> +		/* Next get the max gear supported by the UFS controller */
> +		reg = ufshcd_readl(hba, REG_UFS_PARAM0);
> +		hcd_max_gear = UFS_QCOM_MAX_GEAR(reg);
> +
> +		/*
> +		 * Now compare both the gears. If the max gear supported by the UFS device
> +		 * is compatible with UFS controller, then use the UFS device's max gear
> +		 * speed. Otherwise, use the UFS controller supported max gear speed.
> +		 */
> +		return (max_gear <= hcd_max_gear) ? max_gear : hcd_max_gear;

return max(max_gear, hcd_max_gear); ?

>   	}
>   
> +err_out:
>   	/* Default is HS-G3 */
>   	return UFS_HS_G3;
>   }
> @@ -303,7 +331,7 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
>   	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>   	struct phy *phy = host->generic_phy;
>   	int ret;
> -	bool is_rate_B = UFS_QCOM_LIMIT_HS_RATE == PA_HS_MODE_B;
> +	u32 hs_gear;
>   
>   	/* Reset UFS Host Controller and PHY */
>   	ret = ufs_qcom_host_reset(hba);
> @@ -311,8 +339,9 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
>   		dev_warn(hba->dev, "%s: host reset returned %d\n",
>   				  __func__, ret);
>   
> -	if (is_rate_B)
> -		phy_set_mode(phy, PHY_MODE_UFS_HS_B);
> +	/* UFS_HS_G2 is used here since that's the least gear supported by legacy Qcom platforms */
> +	hs_gear = ufs_qcom_get_hs_gear(hba, UFS_HS_G2);
> +	phy_set_mode_ext(phy, PHY_MODE_UFS_HS_B, hs_gear);
>   
>   	/* phy initialization - calibrate the phy */
>   	ret = phy_init(phy);
> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> index 214ea50acab9..c93bc52ea848 100644
> --- a/drivers/ufs/host/ufs-qcom.h
> +++ b/drivers/ufs/host/ufs-qcom.h
> @@ -89,6 +89,10 @@ enum {
>   #define TMRLUT_HW_CGC_EN	BIT(6)
>   #define OCSC_HW_CGC_EN		BIT(7)
>   
> +/* bit definitions for REG_UFS_PARAM0 */
> +#define MAX_HS_GEAR_MASK	GENMASK(6, 4)
> +#define UFS_QCOM_MAX_GEAR(x)	FIELD_GET(MAX_HS_GEAR_MASK, (x))
> +
>   /* bit definition for UFS_UFS_TEST_BUS_CTRL_n */
>   #define TEST_BUS_SUB_SEL_MASK	GENMASK(4, 0)  /* All XXX_SEL fields are 5 bits wide */
>   

-- 
With best wishes
Dmitry

