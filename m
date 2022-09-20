Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D785BE7A4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiITNwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbiITNwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:52:03 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B805A8BD
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:51:53 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n12so4368124wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=G+ob9gslUEjTfn2CBImEFZYMaoKP4Rt8AUUITXFerD8=;
        b=tg+D2tjd6jvRRlSzpJoFFTF6tp3n0TGMvUX2GCpiQvbixps9kCC7pVa/Sw5i50cHk1
         /7xx32axnrRUDPcTWUXIub1cMhiskS5B0r6Z8yY5S6K/iPMhQaMI7IoYwgypEkLGOziK
         4gjKAWxJWoSbdZhp7Qj2VdZGp4GWjI186EaNwdLgNc/qwCAaFZSPdJub3wi+iP1STrMH
         YiHuV9RUtr/KCWn6kO7VAoPtpyIuA8W/ymB6zn/7wXONvkThZmjKSI7d75RkNba2YwsI
         x4AJrsfrVhdc8JE9BbDEIuMhrhp+mT5MolF1I9v2PbXW0NiSb+UVU/zFVKVQteyExlvM
         rIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=G+ob9gslUEjTfn2CBImEFZYMaoKP4Rt8AUUITXFerD8=;
        b=NzXhUq6QrxdUaoRpCFZaARNR8d8Hq1Otl2bSysTwjXulIe+A+SjFjxtJbZWS02XHLJ
         1qdcDOMziSwPPBpbW0nTuryNF1B4xc+cMbYTa/TwDMkpASRq7hS4dyky09MjB8F3GO7l
         BF5TyIUFOG8HUOEg0/imrXGlacRl1zLaRnqlCHo/d2/fTbI8On/KQFW+WiELCDSRVQpZ
         M4rRqFRPiTto7JfbU9EUD8oU2ZxyRvCDEGzkuEObVUmQxVXzRgZnB8BORN9M7ij/5UO2
         V5tSivmqwEK0nj0BaXWVAKVgatP9XmIiBIQ2hNSIo/9PRjsI91u6fZeh980euFd4Z3GY
         1bmw==
X-Gm-Message-State: ACrzQf3IvFJYdbKfuNab4jdhs/lWpbP8BbXt6bRIiXU9pvUXUIlP4DcR
        4QcD18MQCFruf3aW/uwyIz583Q==
X-Google-Smtp-Source: AMsMyM7XZy4WhMpqk0na5Pt3bcrSDcK8pGIRp2z+EFvw1MegtlqB2GXpg/ZB+oEFHUGgm1BUHjXaUw==
X-Received: by 2002:a05:6000:1d8b:b0:22a:c046:946d with SMTP id bk11-20020a0560001d8b00b0022ac046946dmr13922372wrb.249.1663681911830;
        Tue, 20 Sep 2022 06:51:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7e10:f0f:43b2:9b5e? ([2a01:e0a:982:cbb0:7e10:f0f:43b2:9b5e])
        by smtp.gmail.com with ESMTPSA id z26-20020a05600c221a00b003b4727d199asm115535wml.15.2022.09.20.06.51.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 06:51:51 -0700 (PDT)
Message-ID: <898e1495-81ba-c861-1eaa-91a29f8ee52b@linaro.org>
Date:   Tue, 20 Sep 2022 15:51:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 11/17] phy: qcom-qmp: drop unused index field
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220920073826.20811-1-johan+linaro@kernel.org>
 <20220920073826.20811-12-johan+linaro@kernel.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro
In-Reply-To: <20220920073826.20811-12-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 09:38, Johan Hovold wrote:
> Only the MSM8996 PCIe QMP driver uses the index field so drop it from
> the other drivers.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 3 ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c  | 3 ---
>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c   | 3 ---
>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c   | 3 ---
>   4 files changed, 12 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> index 41f938126ff1..08e96e383a29 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> @@ -906,7 +906,6 @@ struct qmp_phy_combo_cfg {
>    * @pcs_misc: iomapped memory space for lane's pcs_misc
>    * @pcs_usb: iomapped memory space for lane's pcs_usb
>    * @pipe_clk: pipe clock
> - * @index: lane index
>    * @qmp: QMP phy to which this lane belongs
>    * @mode: current PHY mode
>    * @dp_aux_cfg: Display port aux config
> @@ -925,7 +924,6 @@ struct qmp_phy {
>   	void __iomem *pcs_misc;
>   	void __iomem *pcs_usb;
>   	struct clk *pipe_clk;
> -	unsigned int index;
>   	struct qcom_qmp *qmp;
>   	enum phy_mode mode;
>   	unsigned int dp_aux_cfg;
> @@ -2779,7 +2777,6 @@ static int qmp_combo_create(struct device *dev, struct device_node *np, int id,
>   	}
>   
>   	qphy->phy = generic_phy;
> -	qphy->index = id;
>   	qphy->qmp = qmp;
>   	qmp->phys[id] = qphy;
>   	phy_set_drvdata(generic_phy, qphy);
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index d22d2cf2fc18..387abed33727 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -1371,7 +1371,6 @@ struct qmp_phy_cfg {
>    * @rx2: iomapped memory space for second lane's rx (in dual lane PHYs)
>    * @pcs_misc: iomapped memory space for lane's pcs_misc
>    * @pipe_clk: pipe clock
> - * @index: lane index
>    * @qmp: QMP phy to which this lane belongs
>    */
>   struct qmp_phy {
> @@ -1385,7 +1384,6 @@ struct qmp_phy {
>   	void __iomem *rx2;
>   	void __iomem *pcs_misc;
>   	struct clk *pipe_clk;
> -	unsigned int index;
>   	struct qcom_qmp *qmp;
>   };
>   
> @@ -2264,7 +2262,6 @@ static int qmp_pcie_create(struct device *dev, struct device_node *np, int id,
>   	}
>   
>   	qphy->phy = generic_phy;
> -	qphy->index = id;
>   	qphy->qmp = qmp;
>   	qmp->phys[id] = qphy;
>   	phy_set_drvdata(generic_phy, qphy);
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> index cc49dec46df4..ca9a42250556 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> @@ -580,7 +580,6 @@ struct qmp_phy_cfg {
>    * @tx2: iomapped memory space for second lane's tx (in dual lane PHYs)
>    * @rx2: iomapped memory space for second lane's rx (in dual lane PHYs)
>    * @pcs_misc: iomapped memory space for lane's pcs_misc
> - * @index: lane index
>    * @qmp: QMP phy to which this lane belongs
>    */
>   struct qmp_phy {
> @@ -593,7 +592,6 @@ struct qmp_phy {
>   	void __iomem *tx2;
>   	void __iomem *rx2;
>   	void __iomem *pcs_misc;
> -	unsigned int index;
>   	struct qcom_qmp *qmp;
>   };
>   
> @@ -1149,7 +1147,6 @@ static int qmp_ufs_create(struct device *dev, struct device_node *np, int id,
>   	}
>   
>   	qphy->phy = generic_phy;
> -	qphy->index = id;
>   	qphy->qmp = qmp;
>   	qmp->phys[id] = qphy;
>   	phy_set_drvdata(generic_phy, qphy);
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> index 820062a95211..a34320738f60 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> @@ -1491,7 +1491,6 @@ struct qmp_phy_cfg {
>    * @pcs_misc: iomapped memory space for lane's pcs_misc
>    * @pcs_usb: iomapped memory space for lane's pcs_usb
>    * @pipe_clk: pipe clock
> - * @index: lane index
>    * @qmp: QMP phy to which this lane belongs
>    * @mode: current PHY mode
>    */
> @@ -1507,7 +1506,6 @@ struct qmp_phy {
>   	void __iomem *pcs_misc;
>   	void __iomem *pcs_usb;
>   	struct clk *pipe_clk;
> -	unsigned int index;
>   	struct qcom_qmp *qmp;
>   	enum phy_mode mode;
>   };
> @@ -2648,7 +2646,6 @@ int qmp_usb_create(struct device *dev, struct device_node *np, int id,
>   	}
>   
>   	qphy->phy = generic_phy;
> -	qphy->index = id;
>   	qphy->qmp = qmp;
>   	qmp->phys[id] = qphy;
>   	phy_set_drvdata(generic_phy, qphy);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
