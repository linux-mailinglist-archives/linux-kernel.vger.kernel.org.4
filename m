Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5F65BE793
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiITNvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiITNvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:51:12 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8368D419A9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:51:10 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n12so4364757wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=LrxrlfgogzKxFXnVwSOeSnz3Pf0bksNj/SZqFupjFPg=;
        b=zM8VfJhUiAkb1Qb+niEHKxiCFjouT0+7xy1OYBskmZYdfToN54rUGdj2svNO06uhzu
         SST0CYwtqofGShJL0qZCk42fkute5DP+8kGlNO+mIJSSw6h8lR+k+Gc704NwPHJTcxbK
         F2QP62z4x6oJ3obznrc3PgncVkRG+ePRMTe/74Q6WeigxrzlINqmAqO09GUp5mju5m6w
         UM/5k1uQy244MscHq2RN9bZTKKnBEBCIND8yqnh9yFBjmOWIwWXuA7SznJu2xzQ/N4MK
         WqhYdd9otxZYMb+YvpwhgGawW3rhsoJjxu6KZG3VhN7LA6RRHfPEITP/5T0GdZBAhpjJ
         DW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=LrxrlfgogzKxFXnVwSOeSnz3Pf0bksNj/SZqFupjFPg=;
        b=59Xp+bvR/DgLRkTaY4cKzWYfPf/yIcdV38rt6hYk3LpJ0xpzBYWUYpX5gJMVRo3t5W
         rUJbF41vyqpQmtlanWO7tkJl1jGfvH5NUQ8VQ3YXxo80Y0KbKtFDe35QejD1Vr+ppqRC
         hylnbh2C/qA1KDELCZiUTlkvp+/ESLuTayrbU/Wx99nyHKOoMVXfZlmdmu7E29O6Eni4
         4g45zY2CEgwV1/bQ+KHKq0kXjwtP/3i8FrFwHuYqIe/rz+ur1iQMalmvOee/bsnMwjpN
         a5atzeRycHnoHnkMV30VzVvhDYmgO7I1sMzrkAHzjzSmS7G7Zm996mkEvU6KPmE3Cxgn
         PS8A==
X-Gm-Message-State: ACrzQf3dNmm+lMsp7LsA50nqzxFvTjPTpYt/Q1iHdTB3s9RvezGD5uAE
        4UI+bm5NpJ/UX7Sywz4xUF2y/w==
X-Google-Smtp-Source: AMsMyM5W/9aDbYyp8ScDfKrY39kx2CCpPiVocGA8eRuESI6Qhka1HvMz8tW8DDl6Nw/zeHL2noYkew==
X-Received: by 2002:adf:e609:0:b0:22a:a6fd:cfe1 with SMTP id p9-20020adfe609000000b0022aa6fdcfe1mr14599637wrm.0.1663681868927;
        Tue, 20 Sep 2022 06:51:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7e10:f0f:43b2:9b5e? ([2a01:e0a:982:cbb0:7e10:f0f:43b2:9b5e])
        by smtp.gmail.com with ESMTPSA id bg7-20020a05600c3c8700b003b47b913901sm394307wmb.1.2022.09.20.06.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 06:51:07 -0700 (PDT)
Message-ID: <112a306f-0687-36c7-bba2-7cdddbb14530@linaro.org>
Date:   Tue, 20 Sep 2022 15:51:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 03/17] phy: qcom-qmp-ufs: drop unused type from config
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
 <20220920073826.20811-4-johan+linaro@kernel.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro
In-Reply-To: <20220920073826.20811-4-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 09:38, Johan Hovold wrote:
> The configuration PHY type is no longer used since the QMP driver split
> so drop it from the configuration.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> index 7b335b50b4a1..e5c8d3a4fdaa 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> @@ -535,8 +535,6 @@ struct qmp_phy;
>   
>   /* struct qmp_phy_cfg - per-PHY initialization config */
>   struct qmp_phy_cfg {
> -	/* phy-type - PCIE/UFS/USB */
> -	unsigned int type;
>   	/* number of lanes provided by phy */
>   	int nlanes;
>   
> @@ -668,7 +666,6 @@ static const char * const qmp_phy_vreg_l[] = {
>   };
>   
>   static const struct qmp_phy_cfg msm8996_ufs_cfg = {
> -	.type			= PHY_TYPE_UFS,
>   	.nlanes			= 1,
>   
>   	.serdes_tbl		= msm8996_ufs_serdes_tbl,
> @@ -694,7 +691,6 @@ static const struct qmp_phy_cfg msm8996_ufs_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
> -	.type			= PHY_TYPE_UFS,
>   	.nlanes			= 2,
>   
>   	.serdes_tbl		= sdm845_ufsphy_serdes_tbl,
> @@ -720,7 +716,6 @@ static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg sm6115_ufsphy_cfg = {
> -	.type			= PHY_TYPE_UFS,
>   	.nlanes			= 1,
>   
>   	.serdes_tbl		= sm6115_ufsphy_serdes_tbl,
> @@ -744,7 +739,6 @@ static const struct qmp_phy_cfg sm6115_ufsphy_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg sm8150_ufsphy_cfg = {
> -	.type			= PHY_TYPE_UFS,
>   	.nlanes			= 2,
>   
>   	.serdes_tbl		= sm8150_ufsphy_serdes_tbl,
> @@ -769,7 +763,6 @@ static const struct qmp_phy_cfg sm8150_ufsphy_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg sm8350_ufsphy_cfg = {
> -	.type			= PHY_TYPE_UFS,
>   	.nlanes			= 2,
>   
>   	.serdes_tbl		= sm8350_ufsphy_serdes_tbl,
> @@ -794,7 +787,6 @@ static const struct qmp_phy_cfg sm8350_ufsphy_cfg = {
>   };
>   
>   static const struct qmp_phy_cfg sm8450_ufsphy_cfg = {
> -	.type			= PHY_TYPE_UFS,
>   	.nlanes			= 2,
>   
>   	.serdes_tbl		= sm8350_ufsphy_serdes_tbl,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
