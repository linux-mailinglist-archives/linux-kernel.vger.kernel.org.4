Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDCF5FCCDA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 23:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiJLVOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 17:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiJLVOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 17:14:32 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D243115C19
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 14:14:20 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id m23so60625lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 14:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k2wHfeYVczJ7pTmpwYQg5AHr9jzgUcdFH8v2Yq9evuY=;
        b=yAtZrddc3MZD0cYVyNGcrcByzmQI0MosWirM10UwAJre9HSEuICNwu9G3LH5csOhe7
         XLRM9870ZU8Gt0MtgXvPHTHeDRRm0FonC6ZQW69kyyxazEyB0dB3ScesYQMNxfCRAaOf
         jvK8AtvJ4EV3fTQDR79QudKQfviO7ekHYlDa/OJ63Yk7qjaoWfEERgyYQOHP8eFCW/e+
         f34c1X72QedByimJK95WQ4FjEYwxN1k7uGf50wtQnSOAF7AC3y7eeqPaipk9xiFOnK+G
         gjsbIvmko4Ww1BtQvgvWbzqlGpKasYh0iTjnR78zasP4nF9DPGoBgUXRgDkVVtH0uP+u
         5/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k2wHfeYVczJ7pTmpwYQg5AHr9jzgUcdFH8v2Yq9evuY=;
        b=eVRsKl5lRsRCFcRUvUhoNf4ivc8YTi3WDgS+uSG8qwrlWVTtqxwGDYMc3DEH+Gknz3
         BP2xPRba+vbyPWWm1kAaCBSdk1vKReMP3iNKbCZ4ecNpCPUYTbBGgyGou7lQdr1tNqgx
         hyOI+MuMdNkaavjUsshe+sQGZkbUk6mB7JFjgyeuIGzkaV9WC4KPsjJ3mzk2rAWyAdZR
         56gLPV9FdyHxhUUv/ahZj4oFZOIjH/PP88tM4X14SDjTAyvZIREzHh5vko+iQNv+AwZe
         67tlf1o1gjcTLrEdpUJaqxXeP7W3Yolq3liJkxY6hRA71ydbuTNLu64mfHhyVN+GfJGM
         Srhw==
X-Gm-Message-State: ACrzQf1dyyC6wJe4bVG2bMjhkm8XOWF5Z84x/flBUsE5jeMKYpj1pjHX
        V20lrWXL4WutYtcotQ5xsr0QqA==
X-Google-Smtp-Source: AMsMyM7BUlUaBh67kpcRmFBSY56N1BjyNPwpKtT3CxzjKJVNnPUOrReFRfvSZW/wQDKBXLEWxYaeFw==
X-Received: by 2002:a2e:a910:0:b0:261:b408:1169 with SMTP id j16-20020a2ea910000000b00261b4081169mr12189526ljq.360.1665609258091;
        Wed, 12 Oct 2022 14:14:18 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id j28-20020ac253bc000000b00494792ea34esm98713lfh.273.2022.10.12.14.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 14:14:17 -0700 (PDT)
Message-ID: <ca4eef6a-dedd-1823-9525-67d695ac3e58@linaro.org>
Date:   Thu, 13 Oct 2022 00:14:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 08/20] phy: qcom-qmp-combo: clean up status polling
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221012084846.24003-1-johan+linaro@kernel.org>
 <20221012085002.24099-1-johan+linaro@kernel.org>
 <20221012085002.24099-8-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221012085002.24099-8-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2022 11:49, Johan Hovold wrote:
> Clean up the PHY status polling by dropping the configuration mask which
> is no longer needed since the QMP driver split.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

This comes in expectation that 4.20 / 5.20 PHYs will be limited to PCIe. 
I'd add this to the commit message. With that fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 14 ++------------
>   1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> index 82055d3a3536..e312cad6d9c2 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> @@ -853,8 +853,6 @@ struct qmp_phy_cfg {
>   
>   	unsigned int start_ctrl;
>   	unsigned int pwrdn_ctrl;
> -	/* bit offset of PHYSTATUS in QPHY_PCS_STATUS register */
> -	unsigned int phy_status;
>   
>   	/* true, if PHY needs delay after POWER_DOWN */
>   	bool has_pwrdn_delay;
> @@ -1023,7 +1021,6 @@ static const struct qmp_phy_cfg sc7180_usb3phy_cfg = {
>   
>   	.start_ctrl		= SERDES_START | PCS_START,
>   	.pwrdn_ctrl		= SW_PWRDN,
> -	.phy_status		= PHYSTATUS,
>   
>   	.has_pwrdn_delay	= true,
>   };
> @@ -1092,7 +1089,6 @@ static const struct qmp_phy_cfg sdm845_usb3phy_cfg = {
>   
>   	.start_ctrl		= SERDES_START | PCS_START,
>   	.pwrdn_ctrl		= SW_PWRDN,
> -	.phy_status		= PHYSTATUS,
>   
>   	.has_pwrdn_delay	= true,
>   };
> @@ -1127,7 +1123,6 @@ static const struct qmp_phy_cfg sm8150_usb3phy_cfg = {
>   
>   	.start_ctrl		= SERDES_START | PCS_START,
>   	.pwrdn_ctrl		= SW_PWRDN,
> -	.phy_status		= PHYSTATUS,
>   
>   	.has_pwrdn_delay	= true,
>   };
> @@ -1197,7 +1192,6 @@ static const struct qmp_phy_cfg sc8280xp_usb43dp_usb_cfg = {
>   
>   	.start_ctrl		= SERDES_START | PCS_START,
>   	.pwrdn_ctrl		= SW_PWRDN,
> -	.phy_status		= PHYSTATUS,
>   };
>   
>   static const struct qmp_phy_cfg sc8280xp_usb43dp_dp_cfg = {
> @@ -1267,7 +1261,6 @@ static const struct qmp_phy_cfg sm8250_usb3phy_cfg = {
>   
>   	.start_ctrl		= SERDES_START | PCS_START,
>   	.pwrdn_ctrl		= SW_PWRDN,
> -	.phy_status		= PHYSTATUS,
>   
>   	.has_pwrdn_delay	= true,
>   };
> @@ -2017,7 +2010,7 @@ static int qmp_combo_power_on(struct phy *phy)
>   	void __iomem *rx = qphy->rx;
>   	void __iomem *pcs = qphy->pcs;
>   	void __iomem *status;
> -	unsigned int mask, val, ready;
> +	unsigned int val;
>   	int ret;
>   
>   	qmp_combo_serdes_init(qphy);
> @@ -2059,10 +2052,7 @@ static int qmp_combo_power_on(struct phy *phy)
>   		qphy_setbits(pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
>   
>   		status = pcs + cfg->regs[QPHY_PCS_STATUS];
> -		mask = cfg->phy_status;
> -		ready = 0;
> -
> -		ret = readl_poll_timeout(status, val, (val & mask) == ready, 10,
> +		ret = readl_poll_timeout(status, val, !(val & PHYSTATUS), 10,
>   					 PHY_INIT_COMPLETE_TIMEOUT);
>   		if (ret) {
>   			dev_err(qmp->dev, "phy initialization timed-out\n");

-- 
With best wishes
Dmitry

