Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8736F16CB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 13:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345847AbjD1LbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 07:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345833AbjD1LbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 07:31:05 -0400
Received: from forward500c.mail.yandex.net (forward500c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d500])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E32555A3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 04:31:03 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:b14:0:640:93f9:0])
        by forward500c.mail.yandex.net (Yandex) with ESMTP id 1FC2D5E7B0;
        Fri, 28 Apr 2023 14:31:01 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id xUHfdw0DZ8c0-MMVwmCQb;
        Fri, 28 Apr 2023 14:31:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1682681460;
        bh=NwxRsu8ht1atvOJT+L90HFqBBiIpbm8MFFmBYW6Zgcg=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=FNHvO6bWnBk2y/dQjZHyQBjMkk+QLTdaJbEjCUYIs+penWxplDFFFO+dB4tCQ/fMo
         jflzbouhJVv943orvd+aW26rts+UcxB08FeMf6IWBccjPGi5drQF9nfeaCxYJQUmQf
         PBVDDgNLnEzcNYdu9WyzcTAlgqQvROmLS3cS/MIs=
Authentication-Results: mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <bd4554f1910ba253d7833bae99d7c00b9098eae2.camel@maquefel.me>
Subject: Re: [PATCH 29/43] rtc: m48t86: add DT support for m48t86
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     andy.shevchenko@gmail.com
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 28 Apr 2023 17:31:01 +0300
In-Reply-To: <ZEkozMAM674O2r7e@surfacebook>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
         <20230424123522.18302-30-nikita.shubin@maquefel.me>
         <ZEkozMAM674O2r7e@surfacebook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-04-26 at 16:36 +0300, andy.shevchenko@gmail.com wrote:
> Mon, Apr 24, 2023 at 03:34:45PM +0300, Nikita Shubin kirjoitti:
> > - get regs from device tree
>=20
> ...
>=20
> > +#include <linux/of.h>
>=20
> mod_devicetable.h and drop ugly ifdeffery along with of_match_ptr().
>=20
> ...
>=20
> > +static const struct of_device_id m48t86_rtc_of_ids[] =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D "dallas,rt=
c-m48t86" },
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ /* end of table */ },
>=20
> No comma for the terminator entry
>=20
> > +};
>=20

Thanks you for all your comments and effort!

All will be fixed conforming your comments.
