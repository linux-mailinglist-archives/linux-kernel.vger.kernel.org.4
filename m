Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DA570F483
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbjEXKrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbjEXKrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:47:43 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67370A3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 03:47:38 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
        by mail11.truemail.it (Postfix) with ESMTPA id EF0421F80A;
        Wed, 24 May 2023 12:47:34 +0200 (CEST)
Date:   Wed, 24 May 2023 12:47:30 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Alistair Francis <alistair@alistair23.me>,
        Fabio Estevam <festevam@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Hansson <newbie13xd@gmail.com>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: imx_v6_v7_defconfig: Remove KERNEL_LZO config
Message-ID: <ZG3rQppukyWCTQr6@francesco-nb.int.toradex.com>
References: <20230523212829.2539417-1-otavio@ossystems.com.br>
 <b8166ed7-2d3b-4bdd-b597-f0aeddb7ecdc@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8166ed7-2d3b-4bdd-b597-f0aeddb7ecdc@app.fastmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 08:48:26AM +0200, Arnd Bergmann wrote:
> On Tue, May 23, 2023, at 23:28, Otavio Salvador wrote:
> > The KERNEL_GZIP is used in most config and is the default, there is no
> > clear reason to diverge so let default be used.
> >
> > Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
> 
> If you are looking into cleaning up this file, maybe see if we can
> kill off these options:
> 
> CONFIG_VIDEO_IMX_MEDIA=y # not graduated from staging after 6 years
This would be a bad idea from my point of view, this is regularly used
despite the fact that it is in staging.

Of course, I agree on the graduating thingy ...

Francesco


