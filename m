Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FC9604955
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiJSOe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiJSOdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:33:36 -0400
X-Greylist: delayed 1029 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Oct 2022 07:18:12 PDT
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [IPv6:2001:4b98:dc4:8::240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C150B14DF06
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:18:12 -0700 (PDT)
Received: from relay9-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::229])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id CB6B0CF275
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 14:07:27 +0000 (UTC)
Received: (Authenticated sender: kory.maincent@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3DE47FF816;
        Wed, 19 Oct 2022 14:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666188313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YmKUwsaSVzqSAHfmohkAqKye3Xzq9FRt8rzqK9nObPk=;
        b=olgC63+qWHyVZCmfhIBgXnA/GXQs6af4C6+WktaClwnJQZI64e3QHW+0dN0IjH1sOMgIX7
        wABV2Z2+zZN8pqpyLqI2aCLWELOEEzKaR2h0aiiHdsyp0lA77upvZYZuzeyHKBhTpx+l4e
        VCECbRwnFufoGStDpP9vm1dqkdZ72eRqL9IYijC+gktCxn3TrzvcHp4B2bNvP1opizVO7M
        ocXYQSls/0iy+qPpFGdyReTR/3zVer86mVXvRNxnK7uFXqJSZbrayddTdl8Ce8dw2VAniL
        DLaoQQ31Mt6YgIH0ZdUUzujdVYc8IOEKYXzzsOyxZ8hH9gR5kK76ld35AA2yWw==
Date:   Wed, 19 Oct 2022 16:05:09 +0200
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>
Subject: Re: [PATCH 3/6] arm: configs: spear6xx: Enable PL110 display
 controller
Message-ID: <20221019160509.6252f9d1@kmaincent-XPS-13-7390>
In-Reply-To: <644c4a8a-8e30-5f00-7b9f-55c2d59e0d69@linaro.org>
References: <20221019133208.319626-1-kory.maincent@bootlin.com>
        <20221019133208.319626-4-kory.maincent@bootlin.com>
        <5e6858b7-231a-187c-acaf-f82b82a956bf@linaro.org>
        <20221019154841.1cb2a15a@kmaincent-XPS-13-7390>
        <644c4a8a-8e30-5f00-7b9f-55c2d59e0d69@linaro.org>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof

On Wed, 19 Oct 2022 09:57:26 -0400
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 19/10/2022 09:48, K=C3=B6ry Maincent wrote:
> > Hello Krzysztof,
> >=20
> > On Wed, 19 Oct 2022 09:38:45 -0400
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >  =20
> >> On 19/10/2022 09:32, K=C3=B6ry Maincent wrote: =20
> >>> From: Kory Maincent <kory.maincent@bootlin.com>
> >>>
> >>> Enable the PL110 DRM driver, used by the spear600.
> >>>
> >>> CONFIG_I2C is dropped from the defconfig as it is selected by CONFIG_=
DRM.
> >>>   =20
> >>
> >> I2C as a user-selectable option should stay. Don't remove such
> >> (user-selectable) top-level options just because something else select=
ed
> >> it. =20
> >=20
> > As the CONFIG_DRM selects it, the "make savedefconfig" removes it by
> > default. Why keeping something that is already automatically enabled by
> > CONFIG_DRM? =20
>=20
> Same question every few months :)
>=20
> Because otherwise we can drop select in DRM and do not update the
> defconfigs.

Alright, thanks, I will update it in V2.
I will be more careful with savedefconfig for now !

K=C3=B6ry
