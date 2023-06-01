Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0A47198DB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjFAKPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbjFAKPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:15:06 -0400
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28998E6F;
        Thu,  1 Jun 2023 03:12:52 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-49.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-49.vla.yp-c.yandex.net [IPv6:2a02:6b8:c18:3487:0:640:5432:0])
        by forward500a.mail.yandex.net (Yandex) with ESMTP id 6C3D15ECD9;
        Thu,  1 Jun 2023 13:12:09 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-49.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 8CLA8e0DYuQ0-ISJWthyb;
        Thu, 01 Jun 2023 13:12:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1685614328;
        bh=mKkVNkgkXY6MNVho2Qm6KsUuypPCjCch512PkoPBmg4=;
        h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
        b=aH7v70ehGwAeeDJStZ0281Nf5k6pbQlE+puD8q8C/MMZsdFJLGbRx79WQz4z+WPiH
         FzFtGnSHeAUGM4E4FdfDER76nRKAVn9ssGfz+OK9tzSLmWW4+0tkD9XxGqiWhQPoV/
         NAuo1VdmEkiLZaHxpqFHRkWrOBUigMalwP7afqX0=
Authentication-Results: mail-nwsmtp-smtp-production-main-49.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Date:   Thu, 1 Jun 2023 13:12:08 +0300
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 16/43] pwm: ep93xx: add DT support for Cirrus EP93xx
Message-ID: <20230601131208.7ee17749@redslave.neermore.group>
In-Reply-To: <20230601070128.ejvigvxwm6cg4izf@pengutronix.de>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
        <20230601053546.9574-17-nikita.shubin@maquefel.me>
        <20230601070128.ejvigvxwm6cg4izf@pengutronix.de>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Uwe!

On Thu, 1 Jun 2023 09:01:28 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> Hello,
>=20
> On Thu, Jun 01, 2023 at 08:34:07AM +0300, Nikita Shubin wrote:
> > - find register range from the device tree
> > - provide clock access via of
> >=20
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me> =20
>=20
> Looks good to me,
>=20
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Thank you.

>=20
> There don't seem to be dependencies interdependencies to other patches
> in this series?! What is the merge plan here. Should this patch go in
> via the PWM tree, or will the whole series go in via armsoc?

We are hoping to get it merged as a whole, and not in pieces.

So we are trying to get Ack for all patches in series.

>=20
> Best regards
> Uwe
>=20

