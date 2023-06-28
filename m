Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E117413AF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjF1OTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:19:18 -0400
Received: from mx1.sberdevices.ru ([37.18.73.165]:64328 "EHLO
        mx1.sberdevices.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjF1OSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:18:42 -0400
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 57235100010;
        Wed, 28 Jun 2023 17:18:40 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 57235100010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1687961920;
        bh=Svbfgf0j0KalI3BkPbMkKrb1SmgOXFuqi609v02vEJo=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=YmokS3sh6Ig+a8MRqX0d7lPrHlCbjVkd3bk6UbfFYyxorfvqGLazMnPB9GOTCI1/A
         TGMgo7N8FdDrix2YNOh7Vu7FegtMSE3q96KHviLB5kpO0JqcGZvCHJRKogeCcxnAa5
         bmzVxjACdOyl8I81ff9Rtia4TjQXW9S/vd7mhFwZfKnGn3hdS600ahvhCp6Mst+WuB
         P3MEBtazWT0mlXqGnZlEdNTXmukt5J1bCXis6oBgQTTM1Xnc9AVPuQ5DsqqHDWeOjg
         uJymijvh1v39yzQAEIWFS1HA20EE+W6uxvF67BR7YnECXZLZ3TXjSyWjLFdRofpmtl
         jVyPIa9xr0+xg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed, 28 Jun 2023 17:18:40 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 28 Jun
 2023 17:17:42 +0300
Date:   Wed, 28 Jun 2023 17:18:39 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <khilman@baylibre.com>, <conor+dt@kernel.org>,
        <kernel@sberdevices.ru>, <sdfw_system_team@sberdevices.ru>,
        <rockosov@gmail.com>, <linux-amlogic@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 1/6] arm64: dts: meson: a1: introduce PLL and
 Peripherals clk controllers
Message-ID: <20230628141839.ea7qzotr5un6f2ij@CAB-WSD-L081021>
References: <20230607201641.20982-1-ddrokosov@sberdevices.ru>
 <20230607201641.20982-2-ddrokosov@sberdevices.ru>
 <CAFBinCAO14zcgY66UyJO9UxuCWf1N-Lsx=iYNTJL=cwXoJv__Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFBinCAO14zcgY66UyJO9UxuCWf1N-Lsx=iYNTJL=cwXoJv__Q@mail.gmail.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178314 [Jun 28 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: DDRokosov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 517 517 b0056c19d8e10afbb16cb7aad7258dedb0179a79, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;sberdevices.ru:7.1.1,5.0.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/06/28 08:00:00 #21591748
X-KSMG-AntiVirus-Status: Clean, skipped
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Martin,

Thank you for the review!

On Sun, Jun 25, 2023 at 11:00:06PM +0200, Martin Blumenstingl wrote:
> On Wed, Jun 7, 2023 at 10:16 PM Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
> >
> > This patch adds clkc and clkc_pll dts nodes to A1 SoC main dtsi.
> > The first one clk controller is responsible for all SoC peripherals
> > clocks excluding audio clocks. The second one clk controller is used by
> > A1 SoC PLLs. Actually, there are two different APB heads, so we have two
> > different drivers.
> >
> > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> > ---
> >  arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 26 +++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> > index eed96f262844..a24228808c9c 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> > +++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> > @@ -6,6 +6,8 @@
> >  #include <dt-bindings/interrupt-controller/irq.h>
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >  #include <dt-bindings/gpio/meson-a1-gpio.h>
> > +#include <dt-bindings/clock/amlogic,a1-pll-clkc.h>
> > +#include <dt-bindings/clock/amlogic,a1-peripherals-clkc.h>
> >
> >  / {
> >         compatible = "amlogic,a1";
> > @@ -126,6 +128,30 @@ uart_AO_B: serial@2000 {
> >                                 status = "disabled";
> >                         };
> >
> > +                       clkc_periphs: clock-controller@800 {
> please keep the entries sorted - so &clkc_periphs should come after
> &periphs_pinctrl
> 

Sure

> > +                               compatible = "amlogic,a1-peripherals-clkc";
> > +                               reg = <0 0x800 0 0x104>;
> > +                               #clock-cells = <1>;
> > +                               clocks = <&clkc_pll CLKID_FCLK_DIV2>,
> > +                                        <&clkc_pll CLKID_FCLK_DIV3>,
> > +                                        <&clkc_pll CLKID_FCLK_DIV5>,
> > +                                        <&clkc_pll CLKID_FCLK_DIV7>,
> > +                                        <&clkc_pll CLKID_HIFI_PLL>,
> > +                                        <&xtal>;
> > +                               clock-names = "fclk_div2", "fclk_div3",
> > +                                             "fclk_div5", "fclk_div7",
> > +                                             "hifi_pll", "xtal";
> > +                       };
> [...]
> 
> >                         gpio_intc: interrupt-controller@0440 {
> note to self: at some point we'll have to re-order &gpio_intc, but
> that's out of scope for this patch

I have noticed that the 'meson-a1.dtsi' file contains unsorted items. As
part of the current patch series, I can re-order them to improve the dt
structure.

-- 
Thank you,
Dmitry
