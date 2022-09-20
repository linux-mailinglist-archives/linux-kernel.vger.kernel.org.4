Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08765BE172
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbiITJKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbiITJJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:09:36 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633A110CB;
        Tue, 20 Sep 2022 02:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1663664966; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ySh3D2SOq4g6qEsGpMnykSFLXse4yj9w/l/XIqBZ2Og=;
        b=JfhOTAbB/hvODgyw0jRpZ6QwatVVM2IIzee9NL0dM1a5I+uHK75VJQewq21BrxJJm3Y5fT
        dIv8JkRdI0XNZP6utglSZBDk3ry9n62+f4PmLKdTGmtPiJzhGliGAarOaivFw+D4lA0+mh
        gDG0J632tT9ovW9XNaRkOvYlyPFw4gQ=
Date:   Tue, 20 Sep 2022 10:09:17 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: Usefulness of CONFIG_MACH_JZ47*
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips <linux-mips@vger.kernel.org>
Message-Id: <H34IIR.IGTU7CQ36OZK3@crapouillou.net>
In-Reply-To: <CDEACE3D-5433-457B-AF77-E41F39A04CA4@goldelico.com>
References: <af10570000d7e103d70bbea590ce8df4f8902b67.1661330532.git.christophe.jaillet@wanadoo.fr>
        <UC07HR.REF39SO0Y5PG2@crapouillou.net>
        <CDEACE3D-5433-457B-AF77-E41F39A04CA4@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikolaus,

Le mar., sept. 20 2022 at 08:31:30 +0200, H. Nikolaus Schaller=20
<hns@goldelico.com> a =E9crit :
> Hi Paul,
> it seems as if there aren't many places left over where the=20
> MACH_JZ47* configs are still in use:
>=20
> drivers/char/hw_ramdom/Kconfig
> drivers/clk/ingenic/Kconfig
> drivers/gpu/drm/ingenic/Kconfig
> drivers/pinctrl/pinctrl-ingenic.c
>=20
> Is it possible to get rid of them and just have=20
> CONFIG_MACH_INGENIC_GENERIC?
>=20
> This might simplify my defconfig for multiple machines.

CONFIG_MIPS_GENERIC_KERNEL=3Dy
CONFIG_BOARD_INGENIC=3Dy

Then you can support all Ingenic-based boards alongside other MIPS=20
boards.

> BR and thanks,
> Nikolaus

Cheers,
-Paul


