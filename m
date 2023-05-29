Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0954714AAB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjE2NuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjE2Nt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:49:57 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D591EA7;
        Mon, 29 May 2023 06:49:53 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 0756D5FD0A;
        Mon, 29 May 2023 16:49:51 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1685368191;
        bh=THwSTiUgcfU0pN7hOf4QtxshefiF8YvUMoTpottLmWg=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=mddf9/y8v6hAkp68ikcDPDEEZPFmcm9XfJgm/d/pBwXY7Tnrz9IJCEJl5RorF9lki
         Ss2Hje9CJuNmumleXd+y9THp7TpXjfmScVhtEKAPtqeh5VlHHWpUKIha7S3OgwMMHo
         JtcHoeLzZ81xVgpo2CabIB4th5WCdbc9HW6/c4nW4Lihra0ozcL/fJf+OQCwTgOiuC
         eTW/Noa0ZWB/YB4eTZAGTD7qua/4yoG4g4BlJ72F5BqwnCNSi6x3kOmqBpkJqLdYGc
         LiC6yZgLICBN8DiAblqAdXsEP19n/RS8RC14rFy1TNPtyOaYQjGMUEA0jmqd34hH/z
         yNMiW6geR5ZbQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 29 May 2023 16:49:49 +0300 (MSK)
Date:   Mon, 29 May 2023 16:49:44 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <khilman@baylibre.com>, <jian.hu@amlogic.com>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v13 4/6] clk: meson: a1: add Amlogic A1 PLL clock
 controller driver
Message-ID: <20230529134944.dh7isqg5ontfbtpa@CAB-WSD-L081021>
References: <20230405195927.13487-1-ddrokosov@sberdevices.ru>
 <20230405195927.13487-5-ddrokosov@sberdevices.ru>
 <CAFBinCA3uZXzr3RgnWnKV5Qr-CPaZQX5joDg319i_cgzhLJy2g@mail.gmail.com>
 <20230425123304.xjmrkraybp2siwdw@CAB-WSD-L081021>
 <CAFBinCCqx1oHf+PcXBkeRYHnGQChbTTPRyD8SJU+ait+TG+AjQ@mail.gmail.com>
 <20230511132606.vk52yorf43alwgew@CAB-WSD-L081021>
 <CAFBinCCmNLQF_qV3k4kgDEAsemEsjL-GQtPex7Pmxrc2sHx30A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFBinCCmNLQF_qV3k4kgDEAsemEsjL-GQtPex7Pmxrc2sHx30A@mail.gmail.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/29 07:59:00 #21367693
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Martin,

As I promised before, I'm now back with the vendor's reply regarding
AUDDDS. The information is still incomplete, but I have provided the
available details below. Please take a look.

On Sun, May 14, 2023 at 10:53:53PM +0200, Martin Blumenstingl wrote:
> Hi Dmitry.
> 
> On Thu, May 11, 2023 at 3:26 PM Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
> [...]
> > > If you agree with my statement from above I'll be able to make my
> > > original question more specific:
> > > Since we know that we have all the required inputs for fixed_pll,
> > > sys_pll and hifi_pll - do you know what AUDDDS is and whether it
> > > requires any specific clock inputs (other than "fixpll_in" and
> > > "hifipll_in")?
> > >
> >
> > To be honest, I have prepared A1 peripherals and A1 PLL drivers based on very
> > poor Amlogic datasheets and custom 4.19-based vendor drivers.
> > The vendor driver has an AUDDDS clock in the PLL clock part, but it is not
> > used anywhere. Unfortunately, as usual, the datasheet doesn't provide any
> > information or explanation about what it is. However, the driver has a few
> > lines of comments that indicate:
> >
> >     /*
> >      * aud dds clock is not pll clock, not divider clock,
> >      * No clock model can describe it.
> >      * So we regard it as a gate, and the gate ops
> >      * should realize lonely.
> >      */
> >
> > Additionally, the vendor driver states that AUDDDS has a 49Mhz clock,
> > but I do not see any relationship with other clocks (including the exported
> > GENCLK).
> > Jian did not include it in the first version of the PLL driver, and I have
> > decided not to change it either.
> >
> > I also noticed a few lines of AUDDDS initialization sequences in the vendor
> > driver, which may affect CPU clock objects (from my point of view).
> > However, they are currently under development, and I will try to figure it
> > out with Amlogic support.
> >
> > > > However, I do not believe this to be a significant issue. The clock DT
> > > > bindings are organized to simplify the process of introducing new bindings,
> > > > whether public or private. For instance, we may add new bindings to
> > > > include/dt-bindings at the end of the list and increase the overall number,
> > > > without disrupting the DT bindings ABI (the old numbers will remain
> > > > unchanged).
> > > Yep, this part is clear to me. I should have been more specific that I
> > > was asking about the inputs that are described in the .yaml file, not
> > > the clock IDs.
> >
> > Actually, AUDDDS has an xtal2dds parent clock, and if we need to have
> > the AUDDDS clock in the PLL driver, we should add one more link between
> > peripherals and PLL drivers.
> >
> > Let me know if you have any questions.
> I have no questions - all I can say is that:
> - I like your approach of clarifying details of the AUDDDS clock with Amlogic
> - and I fully agree with your conclusion that (depending on what
> Amlogic says) we need one more link from the PLL driver to the AUDDDS
> clock
> 
> Thank you for your persistence with this series, I'm sure it will pay
> off in the long run!

AUDDDS is a direct digital synthesizer used as a clock source.  It is
not used as default. You need to modify some clk registers in dts to
enable it. Basically, it is used for audio.

In A1 design, you can use AUD DDS as a clock source and it is not
necessary. It is not used in the Amlogic default setting.

According to the vendor, it is not necessary and is currently disabled
by default. While we don't have much information about AUDDDS, the
vendor suggests that it's not a commonly used clock object in A1
projects and it may be skipped if not needed.

Based on all above information, I suppose we can skip it now.

-- 
Thank you,
Dmitry
