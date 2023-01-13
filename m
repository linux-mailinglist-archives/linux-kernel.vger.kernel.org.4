Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D10669A4C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjAMOdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjAMOcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:32:02 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDE660E3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 06:25:33 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id v10so30173799edi.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 06:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YEUcQJgo4nd7YRU9VbAj1BQarAeAhdaCCvt7HZueth4=;
        b=k6r9nxffwxxByM++kGiGb1vHHyRXAE938BBi8hokhVcsx9RQWHVSsX/cqY4Pc6ObvP
         Fl/uwzCHjMccvMnIfnDa0Bs4yN7HT1OdK+AxVzTnxnDh8AFQh3CLtN5W+YsKXUXG34K1
         vUBV3KfCaTR5NqkFXScK8219n0P0mlxC8eg5Ab68JYMIIeQ28blbm8Od/N2C2V2cQxf0
         bgqb8ORnhcs+vourTXKeoCNZOdzLiPaJQ9anjnOjinn7XNJQ8Z5gpXQ32Xpuq/40DqvP
         AC2pJ1lYVnlQU7fqLKePJVO/GF7jyt9NXRi3UbRjAqK3CkssoaFX4SDICxjJjyFXO6uD
         L2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YEUcQJgo4nd7YRU9VbAj1BQarAeAhdaCCvt7HZueth4=;
        b=4OhD/RMlpNDU6E/Iu++8Wadlu5Y9B05eZzILtNtSBmrs/NEYEITBFXJf/aG4mJFXEL
         n1ECggqVMhz5Hi7INCeDXG1jqcsjsdXH9eJZA30xhvnbBlgiZOo5NMoU8TvauQm61TaN
         d3ZBNccdJxosY4TBDbZpDMIyEq4A7DoJPCB9dPWaX6fR3qEJsjl9fCPBCTOzoERswhj8
         WVV97pK+IKcDrwDhgmnaciTYTDWVPGYFayHmmlwyzxE4FN1DlnOztBqv2HbZW+8tbMrB
         e5mWH+8r5HGQcFnMMUZTuXqk8MR0Y7n+ATqT9fAvVGxk/LwY2HLmcbFU4IEzb5aRRL2Z
         tFGw==
X-Gm-Message-State: AFqh2ko8hrZZg13i0MbU1ZIHtAGXn8FIYZJROSFq0FMF+dUzKaSyxhfN
        TzYbyLUgxBJNmY25G58Bivntg8kHrU9YhWEYA3mp1A==
X-Google-Smtp-Source: AMrXdXulmidvZ1oMRAo6JmZyF47HXbfqDleSFL/Eiv4c6UJxSDGmEO8n3WxUW+wsM7qr+H6GXfGk9iaQMny1qwxvTPo=
X-Received: by 2002:a05:6402:4013:b0:49a:b8ee:ef4b with SMTP id
 d19-20020a056402401300b0049ab8eeef4bmr787211eda.143.1673619932279; Fri, 13
 Jan 2023 06:25:32 -0800 (PST)
MIME-Version: 1.0
References: <20230112152855.216072-1-bchihi@baylibre.com> <20230112152855.216072-7-bchihi@baylibre.com>
 <daed4793-3aae-f927-5634-cfb876709f93@gmail.com>
In-Reply-To: <daed4793-3aae-f927-5634-cfb876709f93@gmail.com>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Fri, 13 Jan 2023 15:24:55 +0100
Message-ID: <CAGuA+orPcSkztt_9vUmrSD8R0tifAtdHt=KsKVebJFXpe6zBzA@mail.gmail.com>
Subject: Re: [PATCH v10 6/6] arm64/dts/mt8195: Add temperature mitigation threshold
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 12:49 PM Matthias Brugger
<matthias.bgg@gmail.com> wrote:
>
>
>
> On 12/01/2023 16:28, bchihi@baylibre.com wrote:
> > From: Balsam CHIHI <bchihi@baylibre.com>
> >
> > The mt8195 board has several hotspots around the CPUs. Specify the
> > targeted temperature threshold when to apply the mitigation and define
> > the associated cooling devices.
> >
> > Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> > ---
> >   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 153 ++++++++++++++++++++---
> >   1 file changed, 137 insertions(+), 16 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > index 683e5057d68d..0d6642603095 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > @@ -14,6 +14,7 @@
> >   #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
> >   #include <dt-bindings/power/mt8195-power.h>
> >   #include <dt-bindings/reset/mt8195-resets.h>
> > +#include <dt-bindings/thermal/thermal.h>
> >   #include <dt-bindings/thermal/mediatek-lvts.h>
> >
> >   / {
> > @@ -2413,107 +2414,227 @@ dp_tx: dp-tx@1c600000 {
> >
> >       thermal_zones: thermal-zones {
> >               cpu0-thermal {
> > -                     polling-delay = <0>;
> > -                     polling-delay-passive = <0>;
> > +                     polling-delay = <1000>;
> > +                     polling-delay-passive = <250>;
> >                       thermal-sensors = <&lvts_mcu MT819x_MCU_LITTLE_CPU0>;
>
> New line here please.
>
> >                       trips {
> > +                             cpu0_alert: trip-alert {
> > +                                     temperature = <85000>;
> > +                                     hysteresis = <2000>;
> > +                                     type = "passive";
> > +                             };
>
> New line here please and on other trip point definitions.
>

Hi Matthias,

Thank you for the feedback!
It will be added in the next version.

Best regards,
Balsam

> Regards,
> Matthias
