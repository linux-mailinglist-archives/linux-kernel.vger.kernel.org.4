Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C1C74143A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjF1OuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:50:20 -0400
Received: from mx2.sberdevices.ru ([45.89.224.132]:38861 "EHLO
        mx1.sberdevices.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231921AbjF1Oty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:49:54 -0400
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 24DCA120003;
        Wed, 28 Jun 2023 17:49:36 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 24DCA120003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1687963776;
        bh=ITqZMbjUWmbRB4x96Vne7PtoeN8QuM2q0MmJhQ/nKpI=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=oV2LGSLukBS6FXn4Jmetv8SIvz2qDSYr0Q2RjFXY/A19VryG+jlxdkMWEgN2vKlPd
         JHgWHOnPPD8VGQLm554l10oy6gtmutSvkcXJADvRCFUOJazFW1etrWYXQ+G+39J1sV
         TqKBYRRL1hx2r5iPUcNboflsWlLFRvDBFU1vTAU7Hi+hJpbqeyKd8VUkMCU3N0L3F7
         CHBpY01TfRreGb/8FSvxPbjqtjZk9GfaBeqgvf1HepRnQEUzYMbfDQsuPQd5p4K+U9
         7tvXebM5RDfQKs9+NLXJe2neZOhvK+DLLaOEItjqbX3acwaT0p8rJZyM8ZXUSZKM7K
         fvTpo1qa8z5dw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed, 28 Jun 2023 17:49:35 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 28 Jun
 2023 17:48:37 +0300
Date:   Wed, 28 Jun 2023 17:49:34 +0300
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
        <linux-arm-kernel@lists.infradead.org>,
        Oleg Lyovin <ovlevin@sberdevices.ru>
Subject: Re: [PATCH v1 5/6] arm64: dts: meson: a1: introduce UART_AO mux
 definitions
Message-ID: <20230628144934.sbtvdktg6boo5opj@CAB-WSD-L081021>
References: <20230607201641.20982-1-ddrokosov@sberdevices.ru>
 <20230607201641.20982-6-ddrokosov@sberdevices.ru>
 <CAFBinCD-5RD_iszZZRg58XqTHDEHnipJkf2aAex8MdUyh=bVCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFBinCD-5RD_iszZZRg58XqTHDEHnipJkf2aAex8MdUyh=bVCw@mail.gmail.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 517 517 b0056c19d8e10afbb16cb7aad7258dedb0179a79, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/06/28 08:00:00 #21591748
X-KSMG-AntiVirus-Status: Clean, skipped
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin,

On Sun, Jun 25, 2023 at 11:07:51PM +0200, Martin Blumenstingl wrote:
> On Wed, Jun 7, 2023 at 10:16 PM Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
> >
> > From: Oleg Lyovin <ovlevin@sberdevices.ru>
> >
> > The Amlogic A1 has a UART_AO port, which can be used, for example, for
> > BT HCI H4 connection.
> >
> > This patch adds mux definitions for it.
> In the past we've only taken the pinctrl definitions if we have a
> board that uses them.
> Neil, do we still have the same policy in place? If so this patch
> should be sent with the series that adds support for your A1 board.
> 
> > Signed-off-by: Oleg Lyovin <ovlevin@sberdevices.ru>
> > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> > ---
> >  arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> > index 0efd922ca7e1..3eb6aa9c00e0 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> > +++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> > @@ -118,6 +118,22 @@ gpio: bank@400 {
> >                                         gpio-ranges = <&periphs_pinctrl 0 0 62>;
> >                                 };
> >
> > +                               uart_a_pins: uart_a {
> Only our newer .dtsi (e.g. meson-g12-common.dtsi) are following the
> pattern where node names should use dashes instead of underscores.
> So please use: uart_a_pins: uart-a { ...
> 

Okay, no problem. I'll rename the nodes in the next patch series
version.

> [...]
> > +                               uart_a_cts_rts_pins: uart_a_cts_rts {
> similar to the comment from above:
> uart_a_cts_rts_pins: uart-a-cts-rts { ...
> 

Ok

> > +                                       mux {
> > +                                               groups = "uart_a_cts",
> > +                                                        "uart_a_rts";
> > +                                               function = "uart_a";
> > +                                               bias-pull-down;
> Out of curiosity: is this pull down needed on all boards or just specific ones?
> It seems like all other SoCs use bias-disable for the RTS/CTS pins.
> 

That's a good question. The Amlogic custom kernel DTSI declares
bias-pull-down for CTS/RTS pins in UART_A. There is no information about
this in the A1 datasheet. However, from my understanding, it is related
to the usage of the UART_A. Typically, the UART_A endpoint on A1 boards
is used for BT connections, which is why Amlogic applies bias-pull-down
in the common DTSI. If my assumption is correct, it would be better to
move the bias-pull-down node parameter to the custom board DTS. I will
investigate this further and rework it in the next version if necessary.

-- 
Thank you,
Dmitry
