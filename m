Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE81E747781
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 19:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjGDRI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 13:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjGDRIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 13:08:54 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9FAF3;
        Tue,  4 Jul 2023 10:08:51 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 40067120055;
        Tue,  4 Jul 2023 20:08:49 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 40067120055
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1688490529;
        bh=8d0OwtdWSpRCoapxDUbREP4MhLA/RupKH+dbf1QT6zs=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=laDdvl0kA1WTKVR9c4wPGtqTYKqxsfWD/f5pLKXJwwySJe2000Slfm7gy0nTas0EN
         JtvD0aWJG8YojgZ+YoPEhiveOSaa0+RnmFpOsIRnmESvG0v6vm0t5u0+fEyPeLFWF2
         6nLnICI+wRxr5N2FwKYzMQ0Q/Jzd6P9Zf4H+e61TpYfAbIfRg3t7dDDr830TYVoWDT
         c7HnZDtVhAfLk8rp2IFr861gPY8ULAVoAyFsqdgL1ztHdzVA371iIQQgIqjkhEGM7Q
         DozFUaEV7RQg9zJTCDLu3bcNt0joGFJY+NbkFVLMS4uMRl7io2w6mwEXdnLuT5Q7DK
         wEHHDjz27hYIQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Tue,  4 Jul 2023 20:08:49 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 4 Jul
 2023 20:08:37 +0300
Date:   Tue, 4 Jul 2023 20:08:43 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Conor Dooley <conor@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <jirislaby@kernel.org>, <khilman@baylibre.com>,
        <martin.blumenstingl@googlemail.com>, <kelvin.zhang@amlogic.com>,
        <xianwei.zhao@amlogic.com>, <kernel@sberdevices.ru>,
        <rockosov@gmail.com>, <linux-amlogic@lists.infradead.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 5/5] arm64: dts: meson: a1: change uart compatible
 string
Message-ID: <20230704170843.wksxekltre2ob4en@CAB-WSD-L081021>
References: <20230704135936.14697-1-ddrokosov@sberdevices.ru>
 <20230704135936.14697-6-ddrokosov@sberdevices.ru>
 <20230704-cannabis-cannon-19397cd806bc@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230704-cannabis-cannon-19397cd806bc@spud>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178431 [Jul 04 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: DDRokosov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 520 520 ccb018a655251011855942a2571029252d3d69a2, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;sberdevices.ru:5.0.1,7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/04 05:54:00 #21559896
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 06:02:58PM +0100, Conor Dooley wrote:
> On Tue, Jul 04, 2023 at 04:59:36PM +0300, Dmitry Rokosov wrote:
> > In the current implementation, the meson-a1 configuration incorporates a
> > unique compatibility tag "amlogic,meson-a1-uart' within the meson-uart
> > driver due to its usage of the new console device name "ttyS".
> > Consequently, the previous compatibility tag designated for the
> > 'amlogic,meson-gx-uart' configuration has become obsolete and is no
> > longer relevant to the current setup.
> 
> I don't really see why you would remove the gx-uart to be honest, and
> not use it as a fallback. Neil's platform though, so his call :)
> 

Because of amlogic,meson-gx-uart has legacy devname, we do not want to
use it in the A1.

> > 
> > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> > ---
> >  arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> > index c5567031ba12..6273b9c862b3 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> > +++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> > @@ -344,7 +344,7 @@ mux {
> >  			};
> >  
> >  			uart_AO: serial@1c00 {
> > -				compatible = "amlogic,meson-gx-uart",
> > +				compatible = "amlogic,meson-a1-uart",
> >  					     "amlogic,meson-ao-uart";
> >  				reg = <0x0 0x1c00 0x0 0x18>;
> >  				interrupts = <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>;
> > @@ -354,7 +354,7 @@ uart_AO: serial@1c00 {
> >  			};
> >  
> >  			uart_AO_B: serial@2000 {
> > -				compatible = "amlogic,meson-gx-uart",
> > +				compatible = "amlogic,meson-a1-uart",
> >  					     "amlogic,meson-ao-uart";
> >  				reg = <0x0 0x2000 0x0 0x18>;
> >  				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
> > -- 
> > 2.36.0
> > 



-- 
Thank you,
Dmitry
