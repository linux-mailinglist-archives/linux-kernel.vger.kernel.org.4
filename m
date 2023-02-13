Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E39E694B5E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjBMPig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjBMPic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:38:32 -0500
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A5A193EC;
        Mon, 13 Feb 2023 07:38:30 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id u21so13495240edv.3;
        Mon, 13 Feb 2023 07:38:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/87Mt+OfWS54SLniYHSHhoF1OzMVcQInuz6lOAm1ITI=;
        b=12PeChOFvadL61YN+kpNPivvcI+AupHwBRLOyFGuRGU9WPRrmJfLbCrUIqvcAtydQn
         nni504tZApnMh1JEAq16k6PMcJ3OngZPjKAFhbrzA/bmE10YKzHVXAWUlcIkDdQVQi35
         Jo6cOkyJrvALCSFb2QcZz5r9APvgkV1FSk2IeaeY5hlSWf5O0fHP0J4aR+GsIEfkm06J
         f1spg7De5BBvXyXKFalB5iDV8XyeaX0snOvq5l9BbqoRVRpiUxzmgQDGVIukIFhbDTDP
         deEHz9xf+2tk7gJCn7zHasHUomZK7NsNyC+def3Mas1fBYaHF5howDm2R+V3oLUs6MFR
         Fwig==
X-Gm-Message-State: AO0yUKXVNIdUt6/RVekPN69YXjtX5DAIYaS2AuDaYKInMI8BgVav5EEv
        s1hAc3z1ebzj4w5xr+izMy4oNWQvL9no4YUnPtk=
X-Google-Smtp-Source: AK7set/gPlIC2eOAY2XqGE6GdihDj9jHSedBktD5q34/c7R5wMsZ0nx0m0yQIbiWvGC7F0L1/Il/JyPSJjgkmU9F/oY=
X-Received: by 2002:a50:baab:0:b0:4ac:cdd9:1c97 with SMTP id
 x40-20020a50baab000000b004accdd91c97mr1078170ede.6.1676302708989; Mon, 13 Feb
 2023 07:38:28 -0800 (PST)
MIME-Version: 1.0
References: <20230206153432.1017282-1-daniel.lezcano@linaro.org> <20230210094056.GC175687@linaro.org>
In-Reply-To: <20230210094056.GC175687@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Feb 2023 16:38:17 +0100
Message-ID: <CAJZ5v0iEYtFJAh94w+K-T90PXLRDzyUgvb_OPL9aOvphTH2CGg@mail.gmail.com>
Subject: Re: [PATCH] thermal: Remove core header inclusion from drivers
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Guillaume La Roque <glaroque@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Haowen Bai <baihaowen@meizu.com>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        "open list:THERMAL DRIVER FOR AMLOGIC SOCS" 
        <linux-amlogic@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:RENESAS R-CAR THERMAL DRIVERS" 
        <linux-renesas-soc@vger.kernel.org>,
        "open list:SAMSUNG THERMAL DRIVER" 
        <linux-samsung-soc@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 10:41 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Hi Rafael,
>
> On Mon, Feb 06, 2023 at 04:34:29PM +0100, Daniel Lezcano wrote:
> > As the name states "thermal_core.h" is the header file for the core
> > components of the thermal framework.
> >
> > Too many drivers are including it. Hopefully the recent cleanups
> > helped to self encapsulate the code a bit more and prevented the
> > drivers to need this header.
> >
> > Remove this inclusion in every place where it is possible.
> >
> > Some other drivers did a confusion with the core header and the one
> > exported in linux/thermal.h. They include the former instead of the
> > latter. The changes also fix this.
> >
> > The tegra/soctherm driver still remains as it uses an internal
> > function which need to be replaced.
> >
> > The Intel HFI driver uses the netlink internal framework core and
> > should be changed to prevent to deal with the internals.
> >
> > No functional changes
>
> Are you ok if I take this patch ?

Well, you've already done that.
