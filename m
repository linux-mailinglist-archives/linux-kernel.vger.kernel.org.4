Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B83466A36C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjAMTeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjAMTdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:33:38 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090228A23B
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:31:52 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id p188so23605326yba.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3w2TiU+Lm4nUzsmAN2R9y6Z1pBbZIeSZTFy+e+i1Wk=;
        b=wwkkD/BbYvU5NuTiZHjqY6R/O+FRehpJ86yRYqvetizP1k1TrxND2a8wx5XckTHlAR
         +bzA9nNbrS8Hi2ckThe8kGGYkIxYsP9CReFyV5gT9J4XPS8UJ7Cp7zUobVzaDAxHL+Rd
         29Xk+FkVcheDmHH0IhvWxzPdfRREwBTEbwmN6Ssd+33B7k+QEHeUedzmqn7VIvFFSw6U
         AAohESqAXJJNdAOFkDqC6I6VRaxf8qWA+GveIBguZcE+sk92sku8QQdQbLOh1pjKaXnI
         0L2eTI4kOu03otfB272qaDnq8eASvQfg2uFIuIMEzYAv724TEzM12sAWMNa1wrw3XOtu
         Q6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q3w2TiU+Lm4nUzsmAN2R9y6Z1pBbZIeSZTFy+e+i1Wk=;
        b=zPjU82WrpDt/1YYiT5ym8hWJCOlQlj061ORlB/Od/G7MeejLtfKqzFn+h/fg3C+y2H
         m86fjgrnV8hQYV9McGMRebgT+MlTk8tSS2KCGmR7h41IQwuXFA/gPyJ3N6E9o5LLVAHG
         kR9/MILS8RIUDiG5TDqc2vcjo7dvTBwFYd6AnFWPHOC9+a4HmkLIiJ4gGF3gcPUqHw0M
         Kf0EulekVHis6sMLBJAwQXXpHEerFirzeeq8QX3nkWdYzxbAfuzAio5/Q/zpNNe7r5cM
         O2cR7UD7qYlahgfbdm9sJT25yD2AwR3EVWxvWOozGfiePZNl0F1pygPowYs0tfvPR+53
         aMHg==
X-Gm-Message-State: AFqh2kocjY3fxN/6y4y3esM3wB+IbAnA4Y655cLruvpwBsnX/ECXvPri
        OS5P7p8Z6muOwubIAw7TffqMe1MN40uaH5AnVvU4tw==
X-Google-Smtp-Source: AMrXdXtimzxWwdAam5pUjv6lnc370dF1DqEq+lHlc6Ucv3r0ITCLyfKNu6YkXfF2piMkkorsB+TRlnbtQAkbkc0H55Q=
X-Received: by 2002:a25:cc7:0:b0:6e0:c7d3:f026 with SMTP id
 190-20020a250cc7000000b006e0c7d3f026mr8920588ybm.275.1673638311180; Fri, 13
 Jan 2023 11:31:51 -0800 (PST)
MIME-Version: 1.0
References: <20230108195336.388349-1-they@mint.lgbt> <20230108195336.388349-4-they@mint.lgbt>
In-Reply-To: <20230108195336.388349-4-they@mint.lgbt>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 13 Jan 2023 21:31:40 +0200
Message-ID: <CAA8EJpp-RwPOv61MtoXYb3Tuy5LDWWBCvYSrGUOvg8vWhid_tw@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] phy: qcom-qmp: Add SM6125 UFS PHY support
To:     Lux Aliaga <they@mint.lgbt>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-hardening@vger.kernel.org,
        phone-devel@vger.kernel.org, martin.botka@somainline.org,
        marijn.suijten@somainline.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jan 2023 at 21:54, Lux Aliaga <they@mint.lgbt> wrote:
>
> The SM6125 UFS PHY is compatible with the one from SM6115. Add a
> compatible for it and modify the config from SM6115 to make them
> compatible with the SC8280XP binding
>
> Signed-off-by: Lux Aliaga <they@mint.lgbt>
> Reviewed-by: Martin Botka <martin.botka@somainline.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> index 318eea35b972..f33c84578940 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> @@ -693,6 +693,8 @@ static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
>  static const struct qmp_phy_cfg sm6115_ufsphy_cfg = {
>         .lanes                  = 1,
>
> +       .offsets                = &qmp_ufs_offsets_v5,

Please don't randomly reuse generation-specific structures. This
structure is clearly related to v5, while the PHY is from the v2
generation.

> +
>         .serdes_tbl             = sm6115_ufsphy_serdes_tbl,
>         .serdes_tbl_num         = ARRAY_SIZE(sm6115_ufsphy_serdes_tbl),
>         .tx_tbl                 = sm6115_ufsphy_tx_tbl,
> @@ -1172,6 +1174,9 @@ static const struct of_device_id qmp_ufs_of_match_table[] = {
>         }, {
>                 .compatible = "qcom,sm6115-qmp-ufs-phy",
>                 .data = &sm6115_ufsphy_cfg,
> +       }, {
> +               .compatible = "qcom,sm6125-qmp-ufs-phy",
> +               .data = &sm6115_ufsphy_cfg,
>         }, {
>                 .compatible = "qcom,sm6350-qmp-ufs-phy",
>                 .data = &sdm845_ufsphy_cfg,
> --
> 2.39.0
>


-- 
With best wishes
Dmitry
