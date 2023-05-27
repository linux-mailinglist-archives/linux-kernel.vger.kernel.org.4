Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D268B7134D0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 14:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjE0Mor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 08:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjE0Mop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 08:44:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CF4E4
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 05:44:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E4FD60DCB
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 12:44:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D7AC433EF;
        Sat, 27 May 2023 12:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685191483;
        bh=kSeecO9Efyz5E9drHd9rNMxApa0b1iYO6sWDdA287fU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VThBUq+QFV3GPwN+S+T8k/f7LXIG18qqxD2fTz9PY1m9kAsCvBDfYWlK6SvbvyUDV
         /WOMOFHupKBF5buvznDVEXEN3Hox6IuldCn7+mq2Ij3XMgob/BTsw0Py3Ol+7FxY/t
         9pA72do8aGdtq2Kk1PdfaANHsOH/6iCu4fThkjYArv99v9u7ZrxH3dNbatIMRXbnyH
         J+ooxX74Dr7v3gp+qBUYVglgFLxaSAJTvvPc6M1I+CpFhGTLv2n5qfjcO3QqbgaMDT
         lyyX8ai0XhNj8VqmntEupCeIIkk7Te9+TAKN2Ki6zjafEVj7AFdOpotoneW2uTBYAv
         5bB2+ln3Iq+Eg==
Date:   Sat, 27 May 2023 20:44:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
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
Message-ID: <20230527124428.GT528183@dragon>
References: <20230523212829.2539417-1-otavio@ossystems.com.br>
 <b8166ed7-2d3b-4bdd-b597-f0aeddb7ecdc@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8166ed7-2d3b-4bdd-b597-f0aeddb7ecdc@app.fastmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
> I don't mind that change, but it seems odd to single this one out, as
> there are many other options in that particular defconfig that
> stick out more, picking LZO seems like a reasonable choice for slightly
> faster booting, though ZSTD would be the more modern choice.
> 
> If you are looking into cleaning up this file, maybe see if we can
> kill off these options:
> 
> CONFIG_EXPERT=y
> CONFIG_ARCH_FORCE_MAX_ORDER=13
> CONFIG_CMDLINE="noinitrd console=ttymxc0,115200"
> CONFIG_CS89x0_PLATFORM=y # none of these four are in dts files
> CONFIG_SMC91X=y
> CONFIG_SMC911X=y
> CONFIG_SMSC911X=y
> CONFIG_STAGING=y
> CONFIG_STAGING_MEDIA=y
> CONFIG_VIDEO_IMX_MEDIA=y # not graduated from staging after 6 years
> CONFIG_EXT2_FS=y
> CONFIG_EXT3_FS=y # select EXT4 instead
> CONFIG_ISO9660_FS=m
> 
> I have not investigated why any of them were added originally,
> so it's likely that some are actually needed.

Otavio,

Would you investigate the suggested options and see if we can clean up
more than just KERNEL_LZO?

Shawn
