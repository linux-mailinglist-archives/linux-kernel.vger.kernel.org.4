Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C204860C038
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbiJYAxO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Oct 2022 20:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiJYAwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:52:40 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACE115994D;
        Mon, 24 Oct 2022 16:34:13 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1omzeK-00031R-RG; Mon, 24 Oct 2022 17:46:00 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnaud Patard <arnaud.patard@rtp-net.org>,
        Christer Weinigel <christer@weinigel.se>,
        Guillaume GOURAT <guillaume.gourat@nexvision.tv>,
        openmoko-kernel@lists.openmoko.org,
        Jonathan Corbet <corbet@lwn.net>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-doc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, linux-clk@vger.kernel.org
Subject: Re: [PATCH 01/21] ARM: s3c: remove all s3c24xx support
Date:   Mon, 24 Oct 2022 17:45:59 +0200
Message-ID: <2120112.irdbgypaU6@diego>
In-Reply-To: <8d6ddb0d-98be-4c4d-9523-f024c339c8d0@app.fastmail.com>
References: <20221021202254.4142411-1-arnd@kernel.org> <2204103.iZASKD2KPV@diego> <8d6ddb0d-98be-4c4d-9523-f024c339c8d0@app.fastmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 24. Oktober 2022, 16:27:31 CEST schrieb Arnd Bergmann:
> On Sat, Oct 22, 2022, at 22:56, Heiko Stübner wrote:
> > Am Freitag, 21. Oktober 2022, 22:27:34 CEST schrieb Arnd Bergmann:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >> 
> >> The platform was deprecated in commit 6a5e69c7ddea ("ARM: s3c: mark
> >> as deprecated and schedule removal") and can be removed. This includes
> >> all files that are exclusively for s3c24xx and not shared with s3c64xx,
> >> as well as the glue logic in Kconfig and the maintainer file entries.
> >> 
> >> Cc: Arnaud Patard <arnaud.patard@rtp-net.org>
> >> Cc: Ben Dooks <ben-linux@fluff.org>
> >> Cc: Christer Weinigel <christer@weinigel.se>
> >> Cc: Guillaume GOURAT <guillaume.gourat@nexvision.tv>
> >> Cc: Heiko Stuebner <heiko@sntech.de>
> >> Cc: Simtec Linux Team <linux@simtec.co.uk>
> >> Cc: openmoko-kernel@lists.openmoko.org
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > So many memories of me starting out in the kernel on s3c24xx.
> > But it's no use trying to keep stuff around that nobody will likely
> > ever use again. So with a sad face
> >
> > Acked-by: Heiko Stuebner <heiko@sntech.de>
> >
> >
> > though you might want to also include
> > 	drivers/dma/s3c24xx-dma.c
> 
> This was in a separate patch that removes the driver:
> 
> https://lore.kernel.org/linux-arm-kernel/20221021203329.4143397-14-arnd@kernel.org/

ah ok, I guess git-send-email didn't want to send me that patch.
So all is good in that part then :-)


Heiko


