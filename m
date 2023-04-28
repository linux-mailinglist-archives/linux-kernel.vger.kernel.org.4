Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7036F16F7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 13:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345825AbjD1Lo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 07:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjD1LoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 07:44:25 -0400
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [178.154.239.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BD055A3;
        Fri, 28 Apr 2023 04:44:23 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:26a7:0:640:a2d5:0])
        by forward502a.mail.yandex.net (Yandex) with ESMTP id 7926E5EB96;
        Fri, 28 Apr 2023 14:44:21 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id KiHVIE1Ba8c0-kLMgT63n;
        Fri, 28 Apr 2023 14:44:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1682682261;
        bh=P5dAEFXCyQi6+rdwlxT4TYQBkm3BseljpBsRS20Ci8M=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=GOJgSUi30rxJXVvgNEnAr96wjzGSIXWH0TV+ZOfFqq17/ayGyrdh/jHhwg7442ixu
         bYUDrbIcdC7sBc+aeLcre2Cl1uQzgM88pmN3dYEs5zokzhQEQ0zt91rp1FubbCtv3O
         DNL/PvTtQWYXxbU4lmFTcdczNuQPrwAgEWEYq+80=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <db1013a28b517a7d37a052290173d4f12b6325b9.camel@maquefel.me>
Subject: Re: [PATCH 32/43] dt-bindings: gpio: Add DT bindings ep93xx gpio
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 28 Apr 2023 17:44:22 +0300
In-Reply-To: <CACRpkdY_1-4QPzuQs0aqX4M=RDzT3y9m7FTA_Dq71vEn22A8qw@mail.gmail.com>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
         <20230424123522.18302-33-nikita.shubin@maquefel.me>
         <20230424163203.GK2701399-robh@kernel.org>
         <CACRpkdY_1-4QPzuQs0aqX4M=RDzT3y9m7FTA_Dq71vEn22A8qw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus!

On Wed, 2023-04-26 at 22:48 +0200, Linus Walleij wrote:
> On Mon, Apr 24, 2023 at 6:32=E2=80=AFPM Rob Herring <robh@kernel.org> wro=
te:
> > On Mon, Apr 24, 2023 at 03:34:48PM +0300, Nikita Shubin wrote:
>=20
> > > Add YAML bindings for ep93xx SoC.
> > >=20
> > > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> (...)
> > > +=C2=A0 chip-label:
> > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > +=C2=A0=C2=A0=C2=A0 description: human readable name.
> >=20
> > Why do you need this? It's not standard and I don't see other GPIO
> > controllers needing it.
>=20
> Caught my eye too, Nikita can you live without this and just use
> dev_name()
> or something to name the chip in Linux?
>=20
> If it is to conform to EP93xx documentation naming I guess it should
> be
> cirrus,ep93xx-gpio-chip-name =3D "..."; ?

Nah, i should drop it, it was a reverence to people which are sad about
gpio index reordering.

Through i like the idea of "cirrus,ep93xx-gpio-chip-name".

>=20
> Yours,
> Linus Walleij

