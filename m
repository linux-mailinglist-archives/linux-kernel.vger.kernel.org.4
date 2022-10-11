Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78ACC5FB3B8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 15:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJKNtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 09:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJKNtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:49:22 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EC276976
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 06:49:20 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id bs14so3982395ljb.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 06:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=95e1zfa1PsPhtqKhEzjg0I/Nc68FTTy+m8Ct/8lpeQ8=;
        b=dayUUKJSu+0Y7AuxMSsc0uU11Xur8HR4pNTBoupUJzfASm1iwkO3dzp/6mahuI3h4K
         RIV4xSxwvZDB8nWv9Xz/6TGNmn4I3uDNqlRRh+VX1oGujKho9GBFNqhUv/yUbFNY5e0c
         7rEYOs3Jm9/sGdkUPMncRp7iifYuddITKW3neMz55Isz6TBizUYBSx4g7LybLH6seQDQ
         OMsie44JeTjdGI5cLGmFctMSjpLBmcLTRnpIxVjW3A3km06qFN5RqEetaHXPq9AgMvO/
         ol6wFXxxGrx+H238aoX+G73q/eJ+5Y/+sBJeNH9m0Bagdd4WAEg4epqxcn8seC2nQKpG
         MhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=95e1zfa1PsPhtqKhEzjg0I/Nc68FTTy+m8Ct/8lpeQ8=;
        b=LNsnD38JH49mSg5GfAv67zMnX4UQBXZHaY7r9WhBT/TvChIajdplZDq1nSaQ6i0D4Z
         kGKzolhgxT1qfYw9iVf4M9/l5gAtT1YYLP8LFDCRwsRKqZw2HrMLV5k/5Lrh7OFIv33I
         8bjlmkSgjVzIwOX8k5W3T805OMDWHV6jAfUJTbpPrjoC1dSTASOhuCJNE1/d4gKN0pCh
         ILgmYB6ilWV07bz4xjldasNRXHUCZjV+5NZP5X7Si/wCYi0RxIdxzoY8YChuAynhTaM/
         fA9KSqIax8hd/JWF+j+Cpzuysu4lNPWJmfZQt+WixQh4ZxQimi0FsaNxhCLc/SFqLVzx
         z/wA==
X-Gm-Message-State: ACrzQf1YDAWFHDqB7r0Dg3+EEKw7n4bgCkyOPRUG9/5PR45vZFQ/OAju
        jSI81+Lfv1y3gQ+i4q4itEHodg==
X-Google-Smtp-Source: AMsMyM61FrMUAfb7Budd+1I+ins+sGxtHFRfmYTiHTZSNIURvWBPG4jjQ87/TLuylyi5cl/TEYalGA==
X-Received: by 2002:a2e:8947:0:b0:26e:1a9:654c with SMTP id b7-20020a2e8947000000b0026e01a9654cmr8288677ljk.102.1665496158341;
        Tue, 11 Oct 2022 06:49:18 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id j6-20020a2eb706000000b0026dcf81d804sm2154796ljo.31.2022.10.11.06.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 06:49:18 -0700 (PDT)
Message-ID: <fa00a1c7-64b5-4c2c-8775-867c3a4f0a11@linaro.org>
Date:   Tue, 11 Oct 2022 16:49:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 09/13] phy: qcom-qmp-pcie-msm8996: drop power-down delay
 config
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221011131416.2478-1-johan+linaro@kernel.org>
 <20221011131416.2478-10-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221011131416.2478-10-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 16:14, Johan Hovold wrote:
> The power-down delay was included in the first version of the QMP driver
> for MSM8996 as an optional delay after powering on the PHY (using
> POWER_DOWN_CONTROL) and just before starting it. Later changes modified
> this sequence by powering on before initialising the PHY, but the
> optional delay stayed where it was (i.e. before starting the PHY).
> 
> The vendor driver does not use a delay before starting the PHY and this
> is likely not needed on any platform unless there is a corresponding
> delay in the vendor kernel init sequence tables (i.e. in devicetree).
> 
> Let's keep the delay for now, but drop the redundant configuration
> options while increasing the unnecessarily low timer slack somewhat.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Note: the comment from the previous patch applies here too.

> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c | 15 ++-------------
>   1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
> index 31ac405d3785..899be7bd4d92 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
> @@ -41,7 +41,7 @@
>   
>   #define PHY_INIT_COMPLETE_TIMEOUT		10000
>   #define POWER_DOWN_DELAY_US_MIN			10
> -#define POWER_DOWN_DELAY_US_MAX			11
> +#define POWER_DOWN_DELAY_US_MAX			20
>   
>   struct qmp_phy_init_tbl {
>   	unsigned int offset;
> @@ -203,12 +203,6 @@ struct qmp_phy_cfg {
>   	unsigned int mask_com_pcs_ready;
>   	/* bit offset of PHYSTATUS in QPHY_PCS_STATUS register */
>   	unsigned int phy_status;
> -
> -	/* true, if PHY needs delay after POWER_DOWN */
> -	bool has_pwrdn_delay;
> -	/* power_down delay in usec */
> -	int pwrdn_delay_min;
> -	int pwrdn_delay_max;
>   };
>   
>   /**
> @@ -326,10 +320,6 @@ static const struct qmp_phy_cfg msm8996_pciephy_cfg = {
>   	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
>   	.mask_com_pcs_ready	= PCS_READY,
>   	.phy_status		= PHYSTATUS,
> -
> -	.has_pwrdn_delay	= true,
> -	.pwrdn_delay_min	= POWER_DOWN_DELAY_US_MIN,
> -	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
>   };
>   
>   static void qmp_pcie_msm8996_configure_lane(void __iomem *base,
> @@ -523,8 +513,7 @@ static int qmp_pcie_msm8996_power_on(struct phy *phy)
>   	 */
>   	qphy_setbits(pcs, QPHY_V2_PCS_POWER_DOWN_CONTROL, cfg->pwrdn_ctrl);
>   
> -	if (cfg->has_pwrdn_delay)
> -		usleep_range(cfg->pwrdn_delay_min, cfg->pwrdn_delay_max);
> +	usleep_range(POWER_DOWN_DELAY_US_MIN, POWER_DOWN_DELAY_US_MAX);
>   
>   	/* Pull PHY out of reset state */
>   	qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);

-- 
With best wishes
Dmitry

