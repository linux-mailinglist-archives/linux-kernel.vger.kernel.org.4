Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7557612616
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 00:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiJ2WCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 18:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJ2WCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 18:02:37 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F6C2CC92
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 15:02:35 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id g12so13701851lfh.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 15:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5E055D0LraQtXxVm7spy38VDfZkDycL7gLDgoeNA16o=;
        b=j+7ijpO0/3KSJT8VqP7+9KbWRoZ/P+8Pt6ftg3RYrDzOQG/OoUV3jZOVwlzUM/mUoE
         Omp1Y/opkSMuvoGniucEoYxxLubo8YorcLW3UC4oUz6VTsVEaHyQTMjT0ricldnbA0Kx
         Q7XY6n1TR3nT4arq0EucIOCEApbF8g2lZ47I33YD9Z18W0PYYdY6EQ0y+Ym6rw2rtccA
         w4RfDNWehGXZrzjOmFTrIzYZQT+uQGlanuCHvKts3N4YkiAR74fC9jSvI9aKI9pxPy6J
         iJogk19yBiCAPzTiF0eH5T+eZ9Ut5hcoKdi8Sh1LETftUSkJcmmB1zHQSfRpb1JuTPiz
         t6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5E055D0LraQtXxVm7spy38VDfZkDycL7gLDgoeNA16o=;
        b=Hu1jgZeKyJdfbiplPAWD5p2simZn2d6zYZLnQAT35OWpgV0lINGnVaqymZcu/E3z1w
         7QPAdPS6ADhD7oJaKp4FvPL4e9PWE0LNOpBLrwQTNlKVPA+EjFxnmoiYsqVQw55g915E
         oWM+zpF3QKoB3hxDskJEdS0CSXtR4CtgObajrdV/sPMsrR564Ybi56xHSWbARWkpkCJT
         wG/sOD2P8G9xauxJwfZZhifnBVtryqOVcA4rmNTrp5ItCN8LOG3hge5H96KWEOhLawk0
         LG4ozdCMOXj7R91EX2Tso3OOMM82WbR4CQrS4THNZtykWOY6dKf8Aqep8QkV3cOeWQqT
         XlKg==
X-Gm-Message-State: ACrzQf1S4oXNnBrbaEwMYj1lrtUGB+5Cqb9LLuOkGOw5a/YuIfYu+aHV
        40U3pmJzJ89+OLgSGXeq1hlONw==
X-Google-Smtp-Source: AMsMyM4pm04TNdTofIp5vVw8Exv2fHuV0kBcqVC+ddmDOKxb5o54kJtyQCL/FSn1KaXk+T9gB25qYw==
X-Received: by 2002:a05:6512:48f:b0:4a4:7988:b737 with SMTP id v15-20020a056512048f00b004a47988b737mr2152049lfq.28.1667080739088;
        Sat, 29 Oct 2022 14:58:59 -0700 (PDT)
Received: from [10.27.10.248] ([195.165.23.90])
        by smtp.gmail.com with ESMTPSA id t8-20020a05651c204800b00277092c03e7sm437615ljo.33.2022.10.29.14.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Oct 2022 14:58:58 -0700 (PDT)
Message-ID: <01a01fb3-2520-58ce-6432-b278bb8118f5@linaro.org>
Date:   Sun, 30 Oct 2022 00:58:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 10/15] scsi: ufs: ufs-qcom: Use bitfields where
 appropriate
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
 <20221029141633.295650-11-manivannan.sadhasivam@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221029141633.295650-11-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/10/2022 17:16, Manivannan Sadhasivam wrote:
> Use bitfield macros where appropriate to simplify the driver.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/ufs/host/ufs-qcom.h | 58 ++++++++++++++++---------------------
>   1 file changed, 25 insertions(+), 33 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> index 44466a395bb5..6cb0776456b3 100644
> --- a/drivers/ufs/host/ufs-qcom.h
> +++ b/drivers/ufs/host/ufs-qcom.h
> @@ -17,12 +17,9 @@
>   #define DEFAULT_CLK_RATE_HZ     1000000
>   #define BUS_VECTOR_NAME_LEN     32
>   
> -#define UFS_HW_VER_MAJOR_SHFT	(28)
> -#define UFS_HW_VER_MAJOR_MASK	(0x000F << UFS_HW_VER_MAJOR_SHFT)
> -#define UFS_HW_VER_MINOR_SHFT	(16)
> -#define UFS_HW_VER_MINOR_MASK	(0x0FFF << UFS_HW_VER_MINOR_SHFT)
> -#define UFS_HW_VER_STEP_SHFT	(0)
> -#define UFS_HW_VER_STEP_MASK	(0xFFFF << UFS_HW_VER_STEP_SHFT)
> +#define UFS_HW_VER_MAJOR_MASK	GENMASK(31, 28)
> +#define UFS_HW_VER_MINOR_MASK	GENMASK(27, 16)
> +#define UFS_HW_VER_STEP_MASK	GENMASK(15, 0)
>   
>   /* vendor specific pre-defined parameters */
>   #define SLOW 1
> @@ -76,24 +73,24 @@ enum {
>   #define UFS_CNTLR_3_x_x_VEN_REGS_OFFSET(x)	(0x400 + x)
>   
>   /* bit definitions for REG_UFS_CFG1 register */
> -#define QUNIPRO_SEL		0x1
> -#define UTP_DBG_RAMS_EN		0x20000
> +#define QUNIPRO_SEL		BIT(0)
> +#define UTP_DBG_RAMS_EN		BIT(17)
>   #define TEST_BUS_EN		BIT(18)
>   #define TEST_BUS_SEL		GENMASK(22, 19)
>   #define UFS_REG_TEST_BUS_EN	BIT(30)
>   
>   /* bit definitions for REG_UFS_CFG2 register */
> -#define UAWM_HW_CGC_EN		(1 << 0)
> -#define UARM_HW_CGC_EN		(1 << 1)
> -#define TXUC_HW_CGC_EN		(1 << 2)
> -#define RXUC_HW_CGC_EN		(1 << 3)
> -#define DFC_HW_CGC_EN		(1 << 4)
> -#define TRLUT_HW_CGC_EN		(1 << 5)
> -#define TMRLUT_HW_CGC_EN	(1 << 6)
> -#define OCSC_HW_CGC_EN		(1 << 7)
> +#define UAWM_HW_CGC_EN		BIT(0)
> +#define UARM_HW_CGC_EN		BIT(1)
> +#define TXUC_HW_CGC_EN		BIT(2)
> +#define RXUC_HW_CGC_EN		BIT(3)
> +#define DFC_HW_CGC_EN		BIT(4)
> +#define TRLUT_HW_CGC_EN		BIT(5)
> +#define TMRLUT_HW_CGC_EN	BIT(6)
> +#define OCSC_HW_CGC_EN		BIT(7)
>   
>   /* bit definition for UFS_UFS_TEST_BUS_CTRL_n */
> -#define TEST_BUS_SUB_SEL_MASK	0x1F  /* All XXX_SEL fields are 5 bits wide */
> +#define TEST_BUS_SUB_SEL_MASK	GENMASK(4, 0)  /* All XXX_SEL fields are 5 bits wide */
>   
>   #define REG_UFS_CFG2_CGC_EN_ALL (UAWM_HW_CGC_EN | UARM_HW_CGC_EN |\
>   				 TXUC_HW_CGC_EN | RXUC_HW_CGC_EN |\
> @@ -101,17 +98,12 @@ enum {
>   				 TMRLUT_HW_CGC_EN | OCSC_HW_CGC_EN)
>   
>   /* bit offset */
> -enum {
> -	OFFSET_UFS_PHY_SOFT_RESET           = 1,
> -	OFFSET_CLK_NS_REG                   = 10,
> -};
> +#define OFFSET_CLK_NS_REG		0xa
>   
>   /* bit masks */
> -enum {
> -	MASK_UFS_PHY_SOFT_RESET             = 0x2,
> -	MASK_TX_SYMBOL_CLK_1US_REG          = 0x3FF,
> -	MASK_CLK_NS_REG                     = 0xFFFC00,
> -};
> +#define MASK_UFS_PHY_SOFT_RESET		BIT(1)
> +#define MASK_TX_SYMBOL_CLK_1US_REG	GENMASK(9, 0)
> +#define MASK_CLK_NS_REG			GENMASK(23, 10)
>   
>   /* QCOM UFS debug print bit mask */
>   #define UFS_QCOM_DBG_PRINT_REGS_EN	BIT(0)
> @@ -135,15 +127,15 @@ ufs_qcom_get_controller_revision(struct ufs_hba *hba,
>   {
>   	u32 ver = ufshcd_readl(hba, REG_UFS_HW_VERSION);
>   
> -	*major = (ver & UFS_HW_VER_MAJOR_MASK) >> UFS_HW_VER_MAJOR_SHFT;
> -	*minor = (ver & UFS_HW_VER_MINOR_MASK) >> UFS_HW_VER_MINOR_SHFT;
> -	*step = (ver & UFS_HW_VER_STEP_MASK) >> UFS_HW_VER_STEP_SHFT;
> +	*major = FIELD_GET(UFS_HW_VER_MAJOR_MASK, ver);
> +	*minor = FIELD_GET(UFS_HW_VER_MINOR_MASK, ver);
> +	*step = FIELD_GET(UFS_HW_VER_STEP_MASK, ver);
>   };
>   
>   static inline void ufs_qcom_assert_reset(struct ufs_hba *hba)
>   {
> -	ufshcd_rmwl(hba, MASK_UFS_PHY_SOFT_RESET,
> -			1 << OFFSET_UFS_PHY_SOFT_RESET, REG_UFS_CFG1);
> +	ufshcd_rmwl(hba, MASK_UFS_PHY_SOFT_RESET, FIELD_PREP(MASK_UFS_PHY_SOFT_RESET, 1),

Nit: I'd just define the value too and use the defined name here.

> +		    REG_UFS_CFG1);
>   
>   	/*
>   	 * Make sure assertion of ufs phy reset is written to
> @@ -154,8 +146,8 @@ static inline void ufs_qcom_assert_reset(struct ufs_hba *hba)
>   
>   static inline void ufs_qcom_deassert_reset(struct ufs_hba *hba)
>   {
> -	ufshcd_rmwl(hba, MASK_UFS_PHY_SOFT_RESET,
> -			0 << OFFSET_UFS_PHY_SOFT_RESET, REG_UFS_CFG1);
> +	ufshcd_rmwl(hba, MASK_UFS_PHY_SOFT_RESET, FIELD_PREP(MASK_UFS_PHY_SOFT_RESET, 0),

Nit: FIELD_PREP is always 0.

> +		    REG_UFS_CFG1);
>   
>   	/*
>   	 * Make sure de-assertion of ufs phy reset is written to

-- 
With best wishes
Dmitry

