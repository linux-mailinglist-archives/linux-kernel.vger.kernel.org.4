Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F907413CF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjF1OXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:23:51 -0400
Received: from mx2.sberdevices.ru ([45.89.224.132]:54653 "EHLO
        mx1.sberdevices.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231236AbjF1OXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:23:23 -0400
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 7F15112001B;
        Wed, 28 Jun 2023 17:23:06 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7F15112001B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1687962186;
        bh=Tv9CtTxw2JKJilL1q5p5p8VeT0w+UW8IFg0I9fdWF8M=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=LVWbl87nYqaExJtjTCAaPNVQyp5eo3g1SzIU6ihFZn0+cWiEWSFm/SfiB79VCv0kB
         58HxGcNPjq6KC7ElUcj2wEzrIU2Xw+TtlK47TsDafoKlWvq4A/YLiWUDV56QSrQvjx
         MgwEddYDQO6K+Qu/crzXR+ZeZuzje2KCguxuSRYkSJilQLljUboOSraUnYrPirOagi
         JGZ8Eebw0sXD8ONc+2YCVslgzm9Y769MZD2s1lCqRkrPqWAadEB/x1M2JjVSTuLRLt
         cyCozAbGUPj24Y895BwyAsRa0GlsPg3t/goT3ehTj7AmzplMobvub5tK2JTxZMxsfH
         +G0Iwxs8H0Baw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed, 28 Jun 2023 17:23:05 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 28 Jun
 2023 17:22:07 +0300
Date:   Wed, 28 Jun 2023 17:23:05 +0300
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
        Martin Kurbanov <mmkurbanov@sberdevices.ru>
Subject: Re: [PATCH v1 4/6] arm64: dts: meson: a1: introduce SPI Flash
 Controller
Message-ID: <20230628142305.74fkh6ektxhww3v7@CAB-WSD-L081021>
References: <20230607201641.20982-1-ddrokosov@sberdevices.ru>
 <20230607201641.20982-5-ddrokosov@sberdevices.ru>
 <CAFBinCAGLerkDrz98WbpyVAV3jukkPXqDGSV0vOWY0jNiKaJvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFBinCAGLerkDrz98WbpyVAV3jukkPXqDGSV0vOWY0jNiKaJvQ@mail.gmail.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 517 517 b0056c19d8e10afbb16cb7aad7258dedb0179a79, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, sberdevices.ru:7.1.1,5.0.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/06/28 08:00:00 #21591748
X-KSMG-AntiVirus-Status: Clean, skipped
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 11:03:21PM +0200, Martin Blumenstingl wrote:
> On Wed, Jun 7, 2023 at 10:16 PM Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
> >
> > From: Martin Kurbanov <mmkurbanov@sberdevices.ru>
> >
> > This controller can be used for spinand flash connection.
> >
> > Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
> > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> > ---
> >  arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> > index 63faccfc1134..0efd922ca7e1 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> > +++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> > @@ -199,6 +199,16 @@ gic: interrupt-controller@ff901000 {
> >                         #address-cells = <0>;
> >                 };
> >
> > +               spifc: spi@fd000400 {
> please also sort this numerically, so it should appear before &apb

Sure, not a problem. If things have base addresses, all of them ought to
be sorted numerically.

-- 
Thank you,
Dmitry
