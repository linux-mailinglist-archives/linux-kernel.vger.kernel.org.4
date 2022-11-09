Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FFF622806
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiKIKIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiKIKIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:08:19 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B22922BEE;
        Wed,  9 Nov 2022 02:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1667988490; bh=kd8KI0VvTgYS616XjUKkZ7Ghx5h6RnT4rDbBnzCkVnk=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=hv3S7WHUR5IfwXEOq7pdqvjEH2A3PNbF9tOwgT7dBHgTscbhkZf4wjY7wVlswffGO
         F1izqEspC3ojgZIkERAK1FkK9XXXNx61lpXaK7tznsEzy29t6uC8CD/5CGvoKsUtWt
         4QvnYZ2OUY4D1Nj7akVe2HvNmM4Z4nMwq/CY9KJpj48mG1gTqA4gHK91W43TnUmaRm
         QJ6vezOl4LnqcQv/tUvYXjGlcKvcLXTRUy8haGDvY2Htu+uqw1S2PRGl1n8zCBWFnF
         e3m6YiuZnZi8DUe6Sj89t0Htm171AvscKAUVZfZrpSy2xTYEeQE+38PIN2h4GIc7BU
         6no8qE7AiwEAQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.31]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MS3mz-1oPB450iJX-00TQgw; Wed, 09
 Nov 2022 11:08:10 +0100
Date:   Wed, 9 Nov 2022 11:08:09 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-spi@vger.kernel.org, openbmc@lists.ozlabs.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 0/8] Nuvoton WPCM450 FIU SPI flash controller
Message-ID: <Y2t8CYaBfXB0RBkp@probook>
References: <20221105185911.1547847-1-j.neuschaefer@gmx.net>
 <CACRpkdaUv0=Q4X3VyN6hDZKTrchKpiA-H-aBSnj+8CWU6=TfXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CACRpkdaUv0=Q4X3VyN6hDZKTrchKpiA-H-aBSnj+8CWU6=TfXQ@mail.gmail.com>
X-Provags-ID: V03:K1:/uV95BZUCz/kdf3R+oZrIwHNFn3eUKIPK1T4QVkOSBcbBI0KsjV
 pCReinysjykzMdIBCqbJvAO/UNY1Bb/vk85bxxC0FGsXb9i95XaLotvXEqswT3Bsl5IOOZ8
 UDbWMTRUtH+dcZBlmLayitAIyaZsSyqe/QV6ZQJnUpmnPVHlES5X0ZdGLQvumgA4HMKPACR
 o13WovKkBqBa0+8RPUC7g==
UI-OutboundReport: notjunk:1;M01:P0:+x4fTq1f/R0=;9QDlaw3XAmZieT+Qnphn3tjxCvx
 Gbt1+QJfVDuWUr0NYRcIQIXYS9VkbQ2tqjuLqu7BiCZ1ksSOYoQrY+otHODD/gbUDusE8OgXj
 9UENzGSWuWwa7dT0nwJwsXYqS6bCDMwyO6iZQ7OSabDR7J6ALuSOEiIMnV1q2qmeiAgOXdqug
 jiaNGyF4pf4UwPdzf4fHzlLsjXjd6Roh2a3Q/48dLcDBzsXRkJ3EFkzBOiEJeTm9ZH1stZnal
 T81NgTbOmY0C+tZRtDyYS3ziyfkkCMms9Ql4BArIgPVUoBZsvg95MypLjv1RZpAn2fEr+ym0I
 YD9plPQuHYhHKZ6L6cIZ3TUpcYnczXLB4eIINxnuNmcRbPtoO2RK2BPaKgnf6zgy1e7ZzZzaF
 R3AnwnI/nlOzWFeLEQnyj2gpMfY5cpTA4U+LgI1SN951J6jUgfo9cBg8EB2RyeqWWY2jun5Bg
 QTHiLEv1mHMHCayXkhOMGU9nUzuHJjKzgjWCsANKRzCCY4nWvsYWXoiXMUmsX2kK+ff55fLt9
 t/JE98/H255T/e4q6E4SAOQMYDsF6cSbM0OPmrR8xoLrDWgSk2cYaB/zve4oiXxHgt9Aqqqfo
 2KCkEwtTakOSn4P9SwLLpzQBYJAKUMfmUAEoHQZcGSozn+W56QMdpWAanCvgaglh5xY05fumv
 gHm15UbQKlUiVs8MAwPgnjymZJFhxZIUKo0zMYpy909WkwFFSZgnc5cZ23EQquiZdZZdW6QHq
 dyFpihEQAKqFZlZVTGOZx32Ca05rAyj569nSY7XsGjhwtVr1YFIlvPbwK1f2VIeYWVbmKrQZE
 +vCVYtGToAWTOyUgt4wNkCrBHTelGHdsxlNI7VcfkrwJQxGL92JSSvZmcBNiTczETPdmAVBHT
 wQEQKI+gtTzb+kXuRJFPxMUYeZFB+qskkJau1H2MFF5fwhJSuuk6zbIhlxekG1E4Cph+gZaqP
 0mRT2pQ+C2yskoBXNoalSqx09ts=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 09:41:04AM +0100, Linus Walleij wrote:
> On Sat, Nov 5, 2022 at 7:59 PM Jonathan Neusch=C3=A4fer
> <j.neuschaefer@gmx.net> wrote:
>
> > Jonathan Neusch=C3=A4fer (8):
> >   pinctrl: nuvoton: wpcm450: Refactor MFSEL setting code
> >   pinctrl: nuvoton: wpcm450: Fix handling of inverted MFSEL bits
>
> I just applied these two patches to the pinctrl tree, it looks like they
> can be applied independently of the others so I just did.

Yes, that's the intention.

>
> So no need to resend these or include me on subsequent patch
> series.

Thanks!
Jonathan
