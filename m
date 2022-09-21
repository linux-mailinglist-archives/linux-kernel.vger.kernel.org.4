Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBB35BFC5F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 12:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiIUKce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 06:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiIUKcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 06:32:31 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D6690C5A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 03:32:29 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n12so9085116wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 03:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Y5JLfg2pqC8RO5BhkI7jAQbg+r/DxfqgDVqU4h6u7qU=;
        b=VvVajjqwBX64U8dWjJylZ09tBwKNaRtldtI6/LawRnc+pvREeiKaO4a7YZFT0sp9cR
         I+R4z/V8h6JmfCSQSdZ7eojsyb51qS5g/a4EnDjUyqmxY1xQnXSlmH9Kw9pV16vPFsVe
         2VMUpH5wnsxVZ96c8+QJcFsGJvyO8AI2hk8IxWWqcLWqktM+gIA/+PPRVQ7q7qwwM7xO
         UKHIYgi07SNTxHtluFN93UpOsHN/dyFZ85OSoEpXRHh5QH6Tg86AjiC+hkUWWFnGK+aK
         K6BXJ1QiDoG9WHBqSbPDv0MFi71ipCZk2DsroaKdlfxaQiK2QHCV6ZdAVbrMDyTirm1a
         AnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Y5JLfg2pqC8RO5BhkI7jAQbg+r/DxfqgDVqU4h6u7qU=;
        b=RdrmwHiYs0e0WJaHBQnuCAvnq//GZhPV1296G0hjx3g/lt+nqokctVPZEBU7H04udZ
         IbAqdl7XNDIgYGIoOkMXIkWK1o2iJm4rm3aaDkVaqHZ3H5reSrThKzAaRJkzuBRj94z0
         xm9kL5yT8fHmmsSquu43gk3aRt3KO/jqKw/+b/0X4TK+EHwTKyyqIGeQCGE30xVkoZIu
         Buq1xES1di1zdAnj3n0p+RxEMpDk8ODARF99L2C3XvEVqpgjwMfFlbDyU3AqTIX4dZXt
         9Ds7I7EJbV21JZP+dZSNNURo++svgSmvdrQtvbaOcpJxzEbUsCQpnRx0rre9fd7029jC
         Kz5w==
X-Gm-Message-State: ACrzQf1rmMHTOHtywmXvXfvrgljnOFjEb3Na0JMepzzy29a32dtq5rp7
        EO6LlYKlbRdHXEpJ1UpaCh126VYcdsMnHbxBtZw5GQ==
X-Google-Smtp-Source: AMsMyM7lHyvT1H8bURac3iIYrn13yuUKAIkzFQ4nOhI5AgXVWL4DVuEm7D0a6h73h9bVGNRdmhbtDIv9kGo19eXSZZ0=
X-Received: by 2002:a05:6000:81e:b0:228:a17f:92f0 with SMTP id
 bt30-20020a056000081e00b00228a17f92f0mr17216767wrb.31.1663756348493; Wed, 21
 Sep 2022 03:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220919181309.286611-1-dinguyen@kernel.org> <20220919181309.286611-2-dinguyen@kernel.org>
 <CAPDyKFoB7Z6kDOBd9rVLXU5yRQK7d5A-ut5CRroepbAfQpuByw@mail.gmail.com>
 <50c7d35b-f395-6421-1422-56e30a580318@kernel.org> <07c118cb-4daf-8e82-2969-1cff072ec52a@linaro.org>
In-Reply-To: <07c118cb-4daf-8e82-2969-1cff072ec52a@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 21 Sep 2022 12:31:50 +0200
Message-ID: <CAPDyKFoQJsf4EAoQRO9hoKWug+QTX2Hw1ukFqhr0sNQCCwR8Bg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc-pltfm: socfpga: add method to configure clk-phase
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     jh80.chung@samsung.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
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

On Tue, 20 Sept 2022 at 17:19, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 20/09/2022 15:24, Dinh Nguyen wrote:
> >
> > Hi Ulf,
> >
> > Thanks for the review!
> >
> > On 9/20/22 07:17, Ulf Hansson wrote:
> >> On Mon, 19 Sept 2022 at 20:13, Dinh Nguyen <dinguyen@kernel.org> wrote:
> >>>
> >>> The clock-phase settings for the SDMMC controller in the SoCFPGA
> >>> Strarix10/Agilex/N5X platforms reside in a register in the System
> >>> Manager. Add a method to access that register through the syscon
> >>> interface.
> >>>
> >>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> >>> ---
> >>>   drivers/mmc/host/dw_mmc-pltfm.c | 68 ++++++++++++++++++++++++++++++++-
> >>>   1 file changed, 67 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
> >>> index 9901208be797..9e3237c18a9d 100644
> >>> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> >>> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> >>> @@ -17,10 +17,15 @@
> >>>   #include <linux/mmc/host.h>
> >>>   #include <linux/mmc/mmc.h>
> >>>   #include <linux/of.h>
> >>> +#include <linux/mfd/altera-sysmgr.h>
> >>> +#include <linux/regmap.h>
> >>>
> >>>   #include "dw_mmc.h"
> >>>   #include "dw_mmc-pltfm.h"
> >>>
> >>> +#define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel) \
> >>> +       ((((smplsel) & 0x7) << 4) | (((drvsel) & 0x7) << 0))
> >>> +
> >>>   int dw_mci_pltfm_register(struct platform_device *pdev,
> >>>                            const struct dw_mci_drv_data *drv_data)
> >>>   {
> >>> @@ -62,9 +67,70 @@ const struct dev_pm_ops dw_mci_pltfm_pmops = {
> >>>   };
> >>>   EXPORT_SYMBOL_GPL(dw_mci_pltfm_pmops);
> >>>
> >>> +static int dw_mci_socfpga_priv_init(struct dw_mci *host)
> >>> +{
> >>> +       struct device_node *np = host->dev->of_node;
> >>> +       struct regmap *sys_mgr_base_addr;
> >>> +       u32 clk_phase[2] = {0}, reg_offset;
> >>> +       int i, rc, hs_timing;
> >>> +
> >>> +       rc = of_property_read_variable_u32_array(np, "clk-phase-sd-hs", &clk_phase[0], 2, 0);
> >>
> >> This needs to be documented through updated DT bindings.
> >
> > Ok, but it looks like clk-phase-sd-hs is already documented in
> > Documentation/devicetree/bindings/mmc/mmc-controller.yaml
>
> Not in next-20220919.

Dinh is right!

It seems like both me and Krzysztof missed the already documented
binding. Probably because the property is named like below and that I
did "git grep clk-phase-sd" :-)

"^clk-phase-(legacy|sd-hs|mmc-(hs|hs[24]00|ddr52)|uhs-(sdr(12|25|50|104)|ddr50))$":

>
> >
> > Should I create a specific documentation just for
> > "altr,socfpga-dw-mshc" and document "clk-phase-sd-hs"?
>
> All properties must be documented.

Yes, but as stated above, we should be okay in this case.

>
> >
> >>
> >>> +       if (rc) {
> >>> +               sys_mgr_base_addr =
> >>> +                       altr_sysmgr_regmap_lookup_by_phandle(np, "altr,sysmgr-syscon");
> >>
> >> DT bindings?
> >
> > "altr,sysmgr-syscon" has already been documented in
> > Documentation/devicetree/bindings/net/socfpga-dwmac.txt
>
> This is not documentation of nodes you are changing here and in patch 1.
>
> You linked altr,socfpga-stmmac and here you have altr,socfpga-dw-mshc...

Right.

I guess an option is to convert
Documentation/devicetree/bindings/net/socfpga-dwmac.txt into the yaml
based format and then reference that binding from
synopsys-dw-mshc-common.yaml?

>
> Best regards,
> Krzysztof

Kind regards
Uffe
