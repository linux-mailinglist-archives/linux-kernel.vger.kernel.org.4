Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABA55FB3A1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 15:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiJKNrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 09:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiJKNq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:46:59 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF059FD7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 06:46:56 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id b1so16194019lfs.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 06:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Br0NTj8ZuH0OMXFiG8Wg0lpHMqpiMdL9G9IUbDLd/Zs=;
        b=RQSrGdfX0bpIJ+tAeoNzDiC1J6uuDKzs+4KorXjRVyWtREspgXAUskhA/H67L51QTc
         VLbYqejgMfLEPc3Jdwl4hVyrgFyq6q+kwAAYqM3ojG+9BRx0MNlqlE2g1ym8KiTpBtsZ
         LbJ15asNufiZcc1paa60exl/aSLvMaD6Yc6OVz+V8xs0bcUjMUo62qMzW/4QNCevKipm
         hqO53NlKsBBtZnkfn90wERhPBaBP2Xf2rYSpLKZ9R/fuTX2V9yhevm88zjenHxnQDMNr
         fSsY0WsL1yLowE7ChAilBqRR04wdAxOrINdDiAOL7TGC94mo4lvIxFYm8S+1f3sGm29A
         iHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Br0NTj8ZuH0OMXFiG8Wg0lpHMqpiMdL9G9IUbDLd/Zs=;
        b=lHO+I8tS2TiKmKHARW/XgxXqQo5ETnFO0mWC3MKEbM6jSwIORRbbjVlhRHBW5PJMJS
         FoNnbua4EMB4H9ATWZZ3DHnohMmdM6aaQUYkeedIhR5Tdv5v/8hYesxdEuFRFHPYax+f
         RpE5K5BgxQ9DfO1itZmjGp538muQoZBtGAAqgfDlIYDwPky12SNDkBZFUPmQtqPB5vDQ
         ErHgPUkm/emCzFG/gY9uQ6rESTcEQJrkuHPznrOe+dVodWl3gfTRXZLTm02xMC+pH/QH
         03GtLwVhIXMsYGN4ECj3jOsdflQgBgmYCGKkkbxunWoD/PEHs0JzFe3pJ0BDhlH9a2UN
         O0wQ==
X-Gm-Message-State: ACrzQf11K2SZLAB4NwseuLcyiaxsrl5qE80WqvcSjUqTtkYxUyeEo6Iz
        GqNG02hRmbnEvOpfkOHALMvBuQ==
X-Google-Smtp-Source: AMsMyM6dqVFivVBAfJnusOTTHFixr6ta36EYELj9FkxhYexenNncJW1G3ektGPum7oYy8DXfnSf/1w==
X-Received: by 2002:a05:6512:3b13:b0:4a2:564e:6cea with SMTP id f19-20020a0565123b1300b004a2564e6ceamr8373899lfv.242.1665496014326;
        Tue, 11 Oct 2022 06:46:54 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id z18-20020a056512371200b0049313f77755sm1858954lfr.213.2022.10.11.06.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 06:46:53 -0700 (PDT)
Message-ID: <66261491-530d-c368-6cc8-daeef74fcbda@linaro.org>
Date:   Tue, 11 Oct 2022 16:46:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 08/13] phy: qcom-qmp-pcie: drop power-down delay config
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
 <20221011131416.2478-9-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221011131416.2478-9-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 16:14, Johan Hovold wrote:
> The power-down delay was included in the first version of the QMP driver
> as an optional delay after powering on the PHY (using
> POWER_DOWN_CONTROL) and just before starting it. Later changes modified
> this sequence by powering on before initialising the PHY, but the
> optional delay stayed where it was (i.e. before starting the PHY).
> 
> The vendor driver does not use a delay before starting the PHY and this
> is likely not needed on any platform unless there is a corresponding
> delay in the vendor kernel init sequence tables (i.e. in devicetree).
> 
> Let's keep the delay for now, but drop the redundant delay period
> configuration while increasing the unnecessarily low timer slack
> somewhat.

Actually, the vendor driver does this 995..1005 sleep. But contrary to 
our driver it does that after programming whole PHY init sequence, which 
includes SW_RESET / START_CTL, but before programming the pipe clocks.

I think we can either drop this delay completely, or move it before 
read_poll_timeout().

> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 27 +-----------------------
>   1 file changed, 1 insertion(+), 26 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index fa8bc6aeedf1..315de484f875 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -1362,9 +1362,6 @@ struct qmp_phy_cfg {
>   
>   	/* true, if PHY needs delay after POWER_DOWN */
>   	bool has_pwrdn_delay;
> -	/* power_down delay in usec */
> -	int pwrdn_delay_min;
> -	int pwrdn_delay_max;
>   
>   	/* QMP PHY pipe clock interface rate */
>   	unsigned long pipe_clock_rate;
> @@ -1500,8 +1497,6 @@ static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
>   	.phy_status		= PHYSTATUS,
>   
>   	.has_pwrdn_delay	= true,
> -	.pwrdn_delay_min	= 995,		/* us */
> -	.pwrdn_delay_max	= 1005,		/* us */
>   };
>   
>   static const struct qmp_phy_cfg ipq8074_pciephy_gen3_cfg = {
> @@ -1529,8 +1524,6 @@ static const struct qmp_phy_cfg ipq8074_pciephy_gen3_cfg = {
>   	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
>   
>   	.has_pwrdn_delay	= true,
> -	.pwrdn_delay_min	= 995,		/* us */
> -	.pwrdn_delay_max	= 1005,		/* us */
>   
>   	.pipe_clock_rate	= 250000000,
>   };
> @@ -1562,8 +1555,6 @@ static const struct qmp_phy_cfg ipq6018_pciephy_cfg = {
>   	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
>   
>   	.has_pwrdn_delay	= true,
> -	.pwrdn_delay_min	= 995,		/* us */
> -	.pwrdn_delay_max	= 1005,		/* us */
>   };
>   
>   static const struct qmp_phy_cfg sdm845_qmp_pciephy_cfg = {
> @@ -1594,8 +1585,6 @@ static const struct qmp_phy_cfg sdm845_qmp_pciephy_cfg = {
>   	.phy_status		= PHYSTATUS,
>   
>   	.has_pwrdn_delay	= true,
> -	.pwrdn_delay_min	= 995,		/* us */
> -	.pwrdn_delay_max	= 1005,		/* us */
>   };
>   
>   static const struct qmp_phy_cfg sdm845_qhp_pciephy_cfg = {
> @@ -1624,8 +1613,6 @@ static const struct qmp_phy_cfg sdm845_qhp_pciephy_cfg = {
>   	.phy_status		= PHYSTATUS,
>   
>   	.has_pwrdn_delay	= true,
> -	.pwrdn_delay_min	= 995,		/* us */
> -	.pwrdn_delay_max	= 1005,		/* us */
>   };
>   
>   static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
> @@ -1666,8 +1653,6 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
>   	.phy_status		= PHYSTATUS,
>   
>   	.has_pwrdn_delay	= true,
> -	.pwrdn_delay_min	= 995,		/* us */
> -	.pwrdn_delay_max	= 1005,		/* us */
>   };
>   
>   static const struct qmp_phy_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
> @@ -1708,8 +1693,6 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
>   	.phy_status		= PHYSTATUS,
>   
>   	.has_pwrdn_delay	= true,
> -	.pwrdn_delay_min	= 995,		/* us */
> -	.pwrdn_delay_max	= 1005,		/* us */
>   };
>   
>   static const struct qmp_phy_cfg msm8998_pciephy_cfg = {
> @@ -1765,8 +1748,6 @@ static const struct qmp_phy_cfg sc8180x_pciephy_cfg = {
>   	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
>   
>   	.has_pwrdn_delay	= true,
> -	.pwrdn_delay_min	= 995,		/* us */
> -	.pwrdn_delay_max	= 1005,		/* us */
>   };
>   
>   static const struct qmp_phy_cfg sdx55_qmp_pciephy_cfg = {
> @@ -1797,8 +1778,6 @@ static const struct qmp_phy_cfg sdx55_qmp_pciephy_cfg = {
>   	.phy_status		= PHYSTATUS_4_20,
>   
>   	.has_pwrdn_delay	= true,
> -	.pwrdn_delay_min	= 995,		/* us */
> -	.pwrdn_delay_max	= 1005,		/* us */
>   };
>   
>   static const struct qmp_phy_cfg sm8450_qmp_gen3x1_pciephy_cfg = {
> @@ -1829,8 +1808,6 @@ static const struct qmp_phy_cfg sm8450_qmp_gen3x1_pciephy_cfg = {
>   	.phy_status		= PHYSTATUS,
>   
>   	.has_pwrdn_delay	= true,
> -	.pwrdn_delay_min	= 995,		/* us */
> -	.pwrdn_delay_max	= 1005,		/* us */
>   };
>   
>   static const struct qmp_phy_cfg sm8450_qmp_gen4x2_pciephy_cfg = {
> @@ -1876,8 +1853,6 @@ static const struct qmp_phy_cfg sm8450_qmp_gen4x2_pciephy_cfg = {
>   	.phy_status		= PHYSTATUS_4_20,
>   
>   	.has_pwrdn_delay	= true,
> -	.pwrdn_delay_min	= 995,		/* us */
> -	.pwrdn_delay_max	= 1005,		/* us */
>   };
>   
>   static void qmp_pcie_configure_lane(void __iomem *base,
> @@ -2037,7 +2012,7 @@ static int qmp_pcie_power_on(struct phy *phy)
>   	qmp_pcie_pcs_init(qphy, mode_tables);
>   
>   	if (cfg->has_pwrdn_delay)
> -		usleep_range(cfg->pwrdn_delay_min, cfg->pwrdn_delay_max);
> +		usleep_range(1000, 1200);
>   
>   	/* Pull PHY out of reset state */
>   	qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);

-- 
With best wishes
Dmitry

