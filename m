Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B26F7343BB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 22:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346530AbjFQUlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 16:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346527AbjFQUlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 16:41:13 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681401BDF;
        Sat, 17 Jun 2023 13:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1687034465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ITzK5tHf4CvvqOhskx/ZcZ/qtZMlBo54Z1U4DimH8/M=;
        b=uA6C7QqWxjWc0fViga/Y5qGlbWHDQ9nFWAra0ICdgZ/9KCix3cTBXQJ2U94vlxdfZ5hB9v
        nM18qmcBGUVUfwuli1/tb2OGtd1Tl5RL8somC92hLon9v8NwwuMItfuwetLEuMlTQOHRPL
        FAd04d9JrsfRv6cYdoTpEPzM852TTkc=
Message-ID: <696b2c4144e454aa194e4487b41706075a70ae95.camel@crapouillou.net>
Subject: Re: [PATCH v2] drm/ingenic: Kconfig: select REGMAP and REGMAP_MMIO
From:   Paul Cercueil <paul@crapouillou.net>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Sui Jingfeng <suijingfeng@loongson.cn>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-mips@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Sat, 17 Jun 2023 22:41:03 +0200
In-Reply-To: <20230617194843.GA1854380@ravnborg.org>
References: <20230607110650.569522-1-suijingfeng@loongson.cn>
         <c70cb3cb326439a5868beb54d720538923f653d1.camel@crapouillou.net>
         <20230617194843.GA1854380@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le samedi 17 juin 2023 =C3=A0 21:48 +0200, Sam Ravnborg a =C3=A9crit=C2=A0:
> Hi Paul,
> On Sat, Jun 17, 2023 at 09:13:37PM +0200, Paul Cercueil wrote:
> > Hi,
> >=20
> > Le mercredi 07 juin 2023 =C3=A0 19:06 +0800, Sui Jingfeng a =C3=A9crit=
=C2=A0:
> > > Otherwise its failed to pass basic compile test on platform
> > > without
> > > REGMAP_MMIO selected by defconfig
> > >=20
> > > make -j$(nproc) ARCH=3Dmips CROSS_COMPILE=3Dmips64el-linux-gnuabi64-
> > >=20
> > > =C2=A0 SYNC=C2=A0=C2=A0=C2=A0 include/config/auto.conf.cmd
> > > =C2=A0 Checking missing-syscalls for N32
> > > =C2=A0 CALL=C2=A0=C2=A0=C2=A0 scripts/checksyscalls.sh
> > > =C2=A0 Checking missing-syscalls for O32
> > > =C2=A0 CALL=C2=A0=C2=A0=C2=A0 scripts/checksyscalls.sh
> > > =C2=A0 CALL=C2=A0=C2=A0=C2=A0 scripts/checksyscalls.sh
> > > =C2=A0 MODPOST Module.symvers
> > > ERROR: modpost: "__devm_regmap_init_mmio_clk"
> > > [drivers/gpu/drm/ingenic/ingenic-drm.ko] undefined!
> > > make[1]: *** [scripts/Makefile.modpost:136: Module.symvers] Error
> > > 1
> > > make: *** [Makefile:1978: modpost] Error 2
> > >=20
> > > V2: Order alphabetically
> > >=20
> > > Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> >=20
> > The patch looks good to me. But I need an ACK from someone else to
> > apply to drm-misc-next.
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

Thanks Sam!

Applied to drm-misc-next.

Cheers,
-Paul
