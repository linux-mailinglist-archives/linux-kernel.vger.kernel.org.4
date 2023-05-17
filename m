Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E6F706DDE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjEQQRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjEQQRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:17:13 -0400
X-Greylist: delayed 76 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 17 May 2023 09:17:12 PDT
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22987E66;
        Wed, 17 May 2023 09:17:12 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1pzJLB-00050y-T9; Wed, 17 May 2023 17:45:25 +0200
Date:   Wed, 17 May 2023 17:45:25 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>, soc@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-clk@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 05/13] ARM: imx: remove unused mx25_revision()
Message-ID: <20230517154525.ljoamjlfhpejtizm@viti.kaiser.cx>
References: <20230516153109.514251-1-arnd@kernel.org>
 <20230516153109.514251-6-arnd@kernel.org>
 <CAOMZO5B0stW2X6YqPTTKDpCOAzPDvm=4HT8jfBAgbTy11gnKgg@mail.gmail.com>
 <4e026f08-d733-4b01-ab47-e921d041e74e@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e026f08-d733-4b01-ab47-e921d041e74e@app.fastmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Arnd Bergmann (arnd@arndb.de):

> I think either way is ok to address the warning. If we wanted to do this
> properly, the mx{25,27,31,35,5}_revision functions could all be removed
> and the logic hooked up to imx_set_soc_revision() in the same way that
> they already use mxc_set_cpu_type() for drivers/soc/imx/soc-imx.c.

> I'll leave it up to you, if you want to merge Martin's patches or
> a replacement for the soc-imx driver through the imx tree for 6.5,
> I'll drop my patch from this series, otherwise I'll keep it for now
> and we can still do it better at later point.

I suggest we merge my patches for imx25 first and then clean up all the
older imx families to use the common functions.

I've just rebased the patches against today's linux-next. My understanding
is that they have to go through the clk tree.

Thanks,
Martin
