Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184265EF34C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbiI2KTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235130AbiI2KSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:18:50 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78A013F2AC
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 03:18:16 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-3529c491327so9439717b3.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 03:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=NhXvH9AQ64CDT9deNwc0z/+QutsFRT1qPR0raiobye4=;
        b=IxPs1daKz3m8okjBPeKXX3OHtzBJtFTUqLw/wqWawIx5H9bHEnQ3rZ5KjnXnOARpo+
         R0hImaZHia1Y/Auu+ntHIpT3FW3eThRWEmyMFjBdH4yax56YnlsRZj7VWkjH0ge/hEA3
         jbDxaXBB75ZdC+0bMEB5yHp8Y6rKsffRr9lCGCKJrWSbByg0DKTrw+9emMS3YhioHvA0
         BnuWSvfDcaS9z7tC1tCZnEfWzcwIdiEM3xYHbZwibQITZLEqGEZLSUPEuivHevbaUY1V
         wIsUc6eBVGap7dSSVR997rauiMrOzTLfxxPNrRbU+vR/JGO6c23pLbwScLL7w4YDjD4X
         Xmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=NhXvH9AQ64CDT9deNwc0z/+QutsFRT1qPR0raiobye4=;
        b=hpqoiidJqXnQq6FSKj7y+TKxYrOz0dvA9JwNLH3GyVKVfHQgFOQRMbj8Qtjg22l2KM
         Rz0W/AngHIGx5aJgm5EYo+HUPNQn2LMbqwotThKwIbB7O0/RR8pm9HC04qcoUe1CmfJq
         kFaiejHED6+175zVP2CLOXROitZr3WgBcibJjGAhlmksTUB14HaaOHR/XA/G6r6ZQFpg
         OY2sFDi0YVd+iTV1Qe9c7HPmLLCoM++KzMDhuXDYp60caedUeT9nxVS7vSLVLH31r/Ud
         avGE1CM3UoHARzCtNPevsXUQhn34wLz+C+2QTQ+pDSL4UDr8vXZN6pq8kx7okTZsrPlX
         5/bw==
X-Gm-Message-State: ACrzQf3n13TnJ5Be27I+xkE6M40yYmNR+fFaWlLO8LsiUKyWSuOvL+qs
        0HU4Zj1Hs0Qce0fNWFBm9Ay11PrJzCpzBq64NAOqlw==
X-Google-Smtp-Source: AMsMyM7S8sVj2wFYLLHBC/KRMOrj63E3Md2RN0DSzsQX8JVHNTP5i4USmqzOII3+6brbfhfabn+BW25xgyUXYLKSKPQ=
X-Received: by 2002:a81:b40f:0:b0:352:477a:659e with SMTP id
 h15-20020a81b40f000000b00352477a659emr2398042ywi.127.1664446695941; Thu, 29
 Sep 2022 03:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220929092916.23068-1-johan+linaro@kernel.org> <20220929092916.23068-12-johan+linaro@kernel.org>
In-Reply-To: <20220929092916.23068-12-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 29 Sep 2022 13:18:05 +0300
Message-ID: <CAA8EJpp+j1fx46V3zNgiYxsMbQ5UmB4+7o5dojS2FLjwUL=hRg@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] phy: qcom-qmp-pcie: drop bogus register update
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sept 2022 at 12:29, Johan Hovold <johan+linaro@kernel.org> wrote:
>
> Since commit 0d58280cf1e6 ("phy: Update PHY power control sequence") the
> PHY is powered on before configuring the registers and only the MSM8996
> PCIe PHY, which includes the POWER_DOWN_CONTROL register in its PCS
> initialisation table, may possibly require a second update afterwards.
>
> To make things worse, the POWER_DOWN_CONTROL register lies at a
> different offset on more recent SoCs so that the second update, which
> still used a hard-coded offset, would write to an unrelated register
> (e.g. a revision-id register on SC8280XP).
>
> As the MSM8996 PCIe PHY is now handled by a separate driver, simply drop
> the bogus register update.
>
> Fixes: e4d8b05ad5f9 ("phy: qcom-qmp: Use proper PWRDOWN offset for sm8150 USB") added support

Unless somebody confirms that this write is not needed on 8998 and
sdm845, I'd prefer a two stage fix here:
- changing this to write to proper register (and maybe moving to the
top of patch series, as we'd want to backport this to the last few
kernels)
- dropping the write completely.

Meanwhile I'll try testing this patchset on rb3 and checking whether
it makes any difference or not.

> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index a0f62e9633d9..90bdbeee8372 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -1963,12 +1963,6 @@ static int qmp_pcie_power_on(struct phy *phy)
>         qmp_pcie_configure(pcs_misc, cfg->regs, cfg->pcs_misc_tbl, cfg->pcs_misc_tbl_num);
>         qmp_pcie_configure(pcs_misc, cfg->regs, cfg->pcs_misc_tbl_sec, cfg->pcs_misc_tbl_num_sec);
>
> -       /*
> -        * Pull out PHY from POWER DOWN state.
> -        * This is active low enable signal to power-down PHY.
> -        */
> -       qphy_setbits(pcs, QPHY_V2_PCS_POWER_DOWN_CONTROL, cfg->pwrdn_ctrl);
> -
>         if (cfg->has_pwrdn_delay)
>                 usleep_range(cfg->pwrdn_delay_min, cfg->pwrdn_delay_max);
>
> --
> 2.35.1
>


-- 
With best wishes
Dmitry
