Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B0E69BF4B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 10:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjBSJDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 04:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjBSJDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 04:03:08 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 791EA11657;
        Sun, 19 Feb 2023 01:03:07 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pTfaz-0000LC-02; Sun, 19 Feb 2023 10:02:57 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 0B146C28CF; Sun, 19 Feb 2023 09:31:06 +0100 (CET)
Date:   Sun, 19 Feb 2023 09:31:06 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        riccardo Mottola <riccardo.mottola@libero.it>,
        paul@boddie.org.uk, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Subject: Re: [RFC 1/3] MIPS: DTS: jz4780: add #clock-cells to rtc_dev
Message-ID: <20230219083105.GC2924@alpha.franken.de>
References: <cover.1676482318.git.hns@goldelico.com>
 <77bcc96a2b81e42b32d48a041d7fac31e7240e56.1676482318.git.hns@goldelico.com>
 <420c4453e236b9881fcdfdc90a10d12bf0eab323.camel@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <420c4453e236b9881fcdfdc90a10d12bf0eab323.camel@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 04:29:54PM +0000, Paul Cercueil wrote:
> Le mercredi 15 février 2023 à 18:31 +0100, H. Nikolaus Schaller a
> écrit :
> > This makes the driver present the clk32k signal if requested.
> > It is needed to clock the PMU of the BCM4330 WiFi and Bluetooth
> > module of the CI20 board.
> > 
> > Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> 
> Reviewed-by: Paul Cercueil <paul@crapouillou.net>
> 
> Cheers,
> -Paul
> 
> > ---
> >  arch/mips/boot/dts/ingenic/jz4780.dtsi | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi
> > b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> > index c182a656d63bc..18affff85ce38 100644
> > --- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
> > +++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> > @@ -155,6 +155,8 @@ rtc_dev: rtc@10003000 {
> >  
> >                 clocks = <&cgu JZ4780_CLK_RTCLK>;
> >                 clock-names = "rtc";
> > +
> > +               #clock-cells = <0>;
> >         };
> >  
> >         pinctrl: pin-controller@10010000 {

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
