Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BEF6FCC69
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 19:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjEIRLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 13:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbjEIRKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 13:10:53 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CA45591
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 10:09:06 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-55a83e80262so91386597b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 10:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683652142; x=1686244142;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jfm0KBQ9DR7STkQ4Ltw82WaUahZ6L6awN8JsOodBX0Y=;
        b=q3rd0xFj4mUdfXj00xHuH6LHaGJOT9PUs56S0vR5/NFQI8qTRY1k4iYPpEJWOVyycU
         igFKK0Wbossj63BbPvvkkcbBWl8S6sbUIz0j8poT29XMyUxZjBxtvCGgvRpnw4V6T/7o
         uteMFHakrZMtU2WGqWp5zZDFeouOtQeNM6bDSwvqpnJgit4D1xTAVSU0vq9KoEPFaILp
         E4m4uFmzaBlI++ouNpDzePi+YQi3jOhQKlguPwRBXIqgZedvN0NIGk6KISKFxIXThOVd
         JVRjQ2CWUDnXnou62SsiozIDJ4vQuJhGCS0Gb4QJXiWL5g2QqMHyXqArR54s0blAO1vm
         bsog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683652142; x=1686244142;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jfm0KBQ9DR7STkQ4Ltw82WaUahZ6L6awN8JsOodBX0Y=;
        b=Qdk+MAAr+O375ycV18Qn4hPwQUFko9MP6f4irNsu4mnsOKS23gcWMLNQRZp4jC9PtV
         FxFOiFZLTQLk+N+4svzsr3OrSEmnpzGrYQqpSCpZf3zVy790TL+BNHnu1XJ+GwHRvJ0z
         0Oixt2JU/iK9lvZYYUn3CvEEfVTqwYbUHjjXESou/e01uRxAXzm6EKDimTAhWM+aAPRD
         emRxxoirSbdNBP/g/WZYU2l4Fg0Q/O7hJahQHC2AfneHyxmeQqMoAyoo9LBvBJDc5pUF
         H+uIhwWTfZ1OGamZQYWV80bOBauqCrtV+LlfnkpOCR6NPIKtBvuhL9cKptSJs8hw7aAB
         z9MA==
X-Gm-Message-State: AC+VfDxp6nHS0/+6eVVOoyJrA+561D63C7DVs4fWxz4g7E2AXgG/CgqR
        ATTuh8wvzCrtTj6PAHpqsUi7jwA2jzYQL4TasgLenA==
X-Google-Smtp-Source: ACHHUZ79SEncwK77xAH4WbetBCAEI5m8i94f3WEMyQoN08RpAzmlGqR1IKtmAprylYYBaUwuT7FrSWJO0yWteZs+vMs=
X-Received: by 2002:a25:d1d0:0:b0:b9d:f271:49b3 with SMTP id
 i199-20020a25d1d0000000b00b9df27149b3mr13598722ybg.65.1683652141784; Tue, 09
 May 2023 10:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230506-msm8226-ocmem-v1-0-3e24e2724f01@z3ntu.xyz>
 <20230506-msm8226-ocmem-v1-3-3e24e2724f01@z3ntu.xyz> <c9d319a6-36c6-b58c-70ce-65578fd364c3@linaro.org>
 <3479852.e9J7NaK4W3@z3ntu.xyz>
In-Reply-To: <3479852.e9J7NaK4W3@z3ntu.xyz>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 9 May 2023 20:08:50 +0300
Message-ID: <CAA8EJpo_x=q8yBSUV=owYvQqD30YQbhU51iKHUjr-_doLk6HPw@mail.gmail.com>
Subject: Re: [PATCH 3/6] soc: qcom: ocmem: make iface clock optional
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Brian Masney <masneyb@onstation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 May 2023 at 19:47, Luca Weiss <luca@z3ntu.xyz> wrote:
>
> On Montag, 8. Mai 2023 13:34:23 CEST Dmitry Baryshkov wrote:
> > On 07/05/2023 12:12, Luca Weiss wrote:
> > > Some platforms such as msm8226 do not have an iface clk. Since clk_bulk
> > > APIs don't offer to a way to treat some clocks as optional simply add
> > > core_clk and iface_clk members to our drvdata.
> >
> > What about using devm_clk_bulk_get_optional()? I think it would be
> > simpler this way.
>
> Using that function both clocks would be optional which may or may not be a
> bad idea. Not sure how much binding yaml and/or driver should try and catch
> bad usages of the driver.

The generic rule is that we should not validate the DT unless required
(e.g. because of the possibility of legacy DT which used other
bindings or contained less information).

> But honestly the current usage of the bulk API seems a bit clunky, we have a
> static array of clocks that we use (not in struct ocmem for some reason) and
> then we refer to the core clock by index? Feels better to just have the two
> clock references in the device struct and then we're good.
>
> Let me know.
>
> Regards
> Luca
>
> >
> > > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > > ---
> > >
> > >   drivers/soc/qcom/ocmem.c | 42 ++++++++++++++++++++++++------------------
> > >   1 file changed, 24 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/drivers/soc/qcom/ocmem.c b/drivers/soc/qcom/ocmem.c
> > > index a11a955a1327..6235065d3bc9 100644
> > > --- a/drivers/soc/qcom/ocmem.c
> > > +++ b/drivers/soc/qcom/ocmem.c
> > > @@ -54,6 +54,8 @@ struct ocmem {
> > >
> > >     const struct ocmem_config *config;
> > >     struct resource *memory;
> > >     void __iomem *mmio;
> > >
> > > +   struct clk *core_clk;
> > > +   struct clk *iface_clk;
> > >
> > >     unsigned int num_ports;
> > >     unsigned int num_macros;
> > >     bool interleaved;
> > >
> > > @@ -91,16 +93,6 @@ struct ocmem {
> > >
> > >   #define OCMEM_PSGSC_CTL_MACRO2_MODE(val)  FIELD_PREP(0x00000700,
> (val))
> > >   #define OCMEM_PSGSC_CTL_MACRO3_MODE(val)  FIELD_PREP(0x00007000,
> (val))
> > >
> > > -#define OCMEM_CLK_CORE_IDX                 0
> > > -static struct clk_bulk_data ocmem_clks[] = {
> > > -   {
> > > -           .id = "core",
> > > -   },
> > > -   {
> > > -           .id = "iface",
> > > -   },
> > > -};
> > > -
> > >
> > >   static inline void ocmem_write(struct ocmem *ocmem, u32 reg, u32 data)
> > >   {
> > >
> > >     writel(data, ocmem->mmio + reg);
> > >
> > > @@ -316,9 +308,15 @@ static int ocmem_dev_probe(struct platform_device
> > > *pdev)>
> > >     ocmem->dev = dev;
> > >     ocmem->config = device_get_match_data(dev);
> > >
> > > -   ret = devm_clk_bulk_get(dev, ARRAY_SIZE(ocmem_clks), ocmem_clks);
> > > -   if (ret)
> > > -           return dev_err_probe(dev, ret, "Unable to get clocks\n");
> > > +   ocmem->core_clk = devm_clk_get(dev, "core");
> > > +   if (IS_ERR(ocmem->core_clk))
> > > +           return dev_err_probe(dev, PTR_ERR(ocmem->core_clk),
> > > +                                "Unable to get core clock\n");
> > > +
> > > +   ocmem->iface_clk = devm_clk_get_optional(dev, "iface");
> > > +   if (IS_ERR(ocmem->iface_clk))
> > > +           return dev_err_probe(dev, PTR_ERR(ocmem->iface_clk),
> > > +                                "Unable to get iface clock\n");
> > >
> > >     ocmem->mmio = devm_platform_ioremap_resource_byname(pdev, "ctrl");
> > >     if (IS_ERR(ocmem->mmio))
> > >
> > > @@ -333,11 +331,15 @@ static int ocmem_dev_probe(struct platform_device
> > > *pdev)>
> > >     }
> > >
> > >     /* The core clock is synchronous with graphics */
> > >
> > > -   WARN_ON(clk_set_rate(ocmem_clks[OCMEM_CLK_CORE_IDX].clk, 1000) < 0);
> > > +   WARN_ON(clk_set_rate(ocmem->core_clk, 1000) < 0);
> > > +
> > > +   ret = clk_prepare_enable(ocmem->core_clk);
> > > +   if (ret)
> > > +           return dev_err_probe(ocmem->dev, ret, "Failed to enable
> core clock\n");
> > >
> > > -   ret = clk_bulk_prepare_enable(ARRAY_SIZE(ocmem_clks), ocmem_clks);
> > > +   ret = clk_prepare_enable(ocmem->iface_clk);
> > >
> > >     if (ret)
> > >
> > > -           return dev_err_probe(ocmem->dev, ret, "Failed to enable
> clocks\n");
> > > +           return dev_err_probe(ocmem->dev, ret, "Failed to enable
> iface
> > > clock\n");
> > >
> > >     if (qcom_scm_restore_sec_cfg_available()) {
> > >
> > >             dev_dbg(dev, "configuring scm\n");
> > >
> > > @@ -396,13 +398,17 @@ static int ocmem_dev_probe(struct platform_device
> > > *pdev)>
> > >     return 0;
> > >
> > >   err_clk_disable:
> > > -   clk_bulk_disable_unprepare(ARRAY_SIZE(ocmem_clks), ocmem_clks);
> > > +   clk_disable_unprepare(ocmem->core_clk);
> > > +   clk_disable_unprepare(ocmem->iface_clk);
> > >
> > >     return ret;
> > >
> > >   }
> > >
> > >   static int ocmem_dev_remove(struct platform_device *pdev)
> > >   {
> > >
> > > -   clk_bulk_disable_unprepare(ARRAY_SIZE(ocmem_clks), ocmem_clks);
> > > +   struct ocmem *ocmem = platform_get_drvdata(pdev);
> > > +
> > > +   clk_disable_unprepare(ocmem->core_clk);
> > > +   clk_disable_unprepare(ocmem->iface_clk);
> > >
> > >     return 0;
> > >
> > >   }
>
>
>
>


-- 
With best wishes
Dmitry
