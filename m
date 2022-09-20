Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E395BE5F3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiITMev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiITMeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:34:46 -0400
X-Greylist: delayed 175 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 20 Sep 2022 05:34:43 PDT
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C6095BE;
        Tue, 20 Sep 2022 05:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1663677099;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=ErJBayFsgwH9oyybGVYPA9jR24ryJHH2gKiq+4dbDIY=;
    b=F+4QyGhgowTNPm60ZZdCA13e7w/I7oMUWlL6vy6gRSr3NpcIs4IiyVIum2Jy10xPAX
    449essqWWE3UTMoyDr/h5qxG5dXk9CG5DA1JKJ8ovdflf/HZa5xBM3rRlWA4+fukKz14
    Xol7J/Squ+xoyoyAi7cjimO9Jxuh0rMB0GjufU40xtGBGkK+JUhz1P6xk0w2hSK5baNl
    J6AyjlNEmMEr8l2FurBrpNfh8osJufBvzPbMB+9c86T00jDVaarDCiPhuD1kSnoKLd+q
    c1RUWlglOJ4lfhBYk3O3j8QUk99C++TiTm+E2bGwbcX5dl6xLMzucGUTFaML+lxYNRha
    GWqg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Apz9PSN6LgsXcGZjzY="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 48.1.1 DYNA|AUTH)
    with ESMTPSA id x6434cy8KCVd0vL
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Tue, 20 Sep 2022 14:31:39 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: Usefulness of CONFIG_MACH_JZ47*
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <H34IIR.IGTU7CQ36OZK3@crapouillou.net>
Date:   Tue, 20 Sep 2022 14:31:38 +0200
Cc:     linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips <linux-mips@vger.kernel.org>,
        MIPS Creator CI20 Development 
        <mips-creator-ci20-dev@googlegroups.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F21B5D44-94D8-4BDB-BB34-9CBFC5F2B891@goldelico.com>
References: <af10570000d7e103d70bbea590ce8df4f8902b67.1661330532.git.christophe.jaillet@wanadoo.fr>
 <UC07HR.REF39SO0Y5PG2@crapouillou.net>
 <CDEACE3D-5433-457B-AF77-E41F39A04CA4@goldelico.com>
 <H34IIR.IGTU7CQ36OZK3@crapouillou.net>
To:     Paul Cercueil <paul@crapouillou.net>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

> Am 20.09.2022 um 11:09 schrieb Paul Cercueil <paul@crapouillou.net>:
>=20
> Hi Nikolaus,
>=20
> Le mar., sept. 20 2022 at 08:31:30 +0200, H. Nikolaus Schaller =
<hns@goldelico.com> a =C3=A9crit :
>> Hi Paul,
>> it seems as if there aren't many places left over where the =
MACH_JZ47* configs are still in use:
>> drivers/char/hw_ramdom/Kconfig
>> drivers/clk/ingenic/Kconfig
>> drivers/gpu/drm/ingenic/Kconfig
>> drivers/pinctrl/pinctrl-ingenic.c
>> Is it possible to get rid of them and just have =
CONFIG_MACH_INGENIC_GENERIC?
>> This might simplify my defconfig for multiple machines.
>=20
> CONFIG_MIPS_GENERIC_KERNEL=3Dy

This breaks compilation for me, e.g.

arch/mips/mm/cache.c:203:6: error: 'cpu_has_tx39_cache' undeclared =
(first use in this function)

> CONFIG_BOARD_INGENIC=3Dy

This config option does not exist (at least in v6.0-rc). Probably you =
refer to CONFIG_INGENIC_GENERIC_BOARD.

As far as I see, this does not choose to build any device tree blob.

I tried some patch to get the .dtb built, but the resulting kernel does =
not show any activity.

If I e.g. switch back from CONFIG_INGENIC_GENERIC_BOARD=3Dy to =
CONFIG_JZ4780_CI20=3Dy the kernel works.

>=20
> Then you can support all Ingenic-based boards alongside other MIPS =
boards.

Yes, I know, but why are the MACH_JZ47* not replaced by =
CONFIG_MACH_INGENIC_GENERIC if they are almost unused or completely =
removed?

BTW: there are also seems to be some board specific CONFIGs in processor =
specific code (e.g. CONFIG_JZ4780_CI20 in irqchip code).
So selecting a MACH is not sufficient to get these features.

All this looks a little fragile and incomplete... Maybe if I find some =
time (which is unfortunately quite unlikely) I can propose some fixes.

BR,
Nikolaus

