Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF276225BD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiKIIrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiKIIrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:47:18 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6263813DDF;
        Wed,  9 Nov 2022 00:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1667983597;
        bh=PRVwWrjJDCQx2PTwDXm20wxkOYYY83T6jZ7prdQHy30=;
        h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
         References;
        b=gEoRVWsYKdnB/rSvLatOuN1uNvbJw6dbVKqfNn9R64mJBvcFdMo6cBDEbxGAvqPKM
         WpIZlPdP1F2hUiak6yx7XW/yJRysiGvxJtIWC2k1cH4GCutUQmqJD3QGeMNAXv8n7o
         /mtRP/rmbT7Lk1uBbpZHmFLpvzO8lvewtbjUl7bIPdoE5nMu+aZhw6cz38CD2OWb1u
         EjQ6e0nHrLj/OWbARNGOyCUPHukY672dZ80JmuuigM+UCWhYnWHzNoPIDcu57lxKhS
         RrH2miHq/+S85DO1z8CfS3kr7J2Wx/vTETwRoxXdmIF4VgT8NJu4+D24xfi8Xb1f/x
         9Yc/g+9dYTqsQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([80.245.72.218]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeCpR-1pSIzi1wRT-00bKIF; Wed, 09
 Nov 2022 09:46:37 +0100
Date:   Wed, 09 Nov 2022 09:46:30 +0100
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Rob Herring <robh@kernel.org>, Frank Wunderlich <linux@fw-web.de>,
        Sam Shih <sam.shih@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sean Wang <sean.wang@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_Re=3A_=5BPATCH_v1_1/4=5D_dt-bindings=3A_pinct?= =?US-ASCII?Q?rl=3A_mt7986=3A_add_generic_bias-pull*_support?=
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <CACRpkdZsP-aj6hcD2sOB8ypVqdxwC8dWOo0d52qnDpxppUwNAA@mail.gmail.com>
References: <20221105084905.9596-1-linux@fw-web.de> <20221105084905.9596-2-linux@fw-web.de> <166765939131.4158830.8416727494529058690.robh@kernel.org> <trinity-c732b826-2a12-4ab1-aaac-294ac5524926-1667660774779@3c-app-gmx-bap26> <CACRpkdZsP-aj6hcD2sOB8ypVqdxwC8dWOo0d52qnDpxppUwNAA@mail.gmail.com>
Message-ID: <6752A6BE-3750-4195-821A-917205F59258@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jHtmrCYPElP8JtRuEiA7NPBiK7ne0lZA2T52PK4SqtN3oFto41e
 NGuuF+JH3JRGNhbou6J8OX3FKcKEb+neiidWWEMEBOb9haLmrkCrjKZA1I23S5mC24I9pAo
 C7oCYwBOW+psA88hZZzYtg61yyDrVrmQGbm9Db4VvJrm7jReOjYZOTGwJU3lItWU3JKjIi4
 L0Sy8AeH39BsxDiaTJUdQ==
UI-OutboundReport: notjunk:1;M01:P0:ZxB4zEPrxfU=;JLtousEZBz6ZHywN4c7nHNSTlW2
 ICihBS2ALeVKO1JYgkwWYwCarSmjhYnmzpEPZhYFJ/CQr56GHvqq1RLnOGsWPWuIay6qu4LwE
 /dX2BfTIMBRNAzi7L+5jUZ9UxuaZYZu45B0uIjYkgdGuUDeeoxqy5JTNrT+GHz+wNl587eNgt
 dyaKdEudzRuRasc9N1kkExxWQFLOmbtL/IXZxn1u8tlOEdNAaoCvNsIelqx2DYj8wmbCD4Dmf
 hia57i4GSDNkNw/b3tNeKaOkk3tEtKtK1Fluu2N83wQY+whFDwowtD3c+yKRp7EZ+FEjL8ZVk
 qvAyv/1Y6nkjIVJIfCn57Lo9hdIMhIchvLTc7IHON0TrLMZT6rlcgk1ntWH+RQXjBiX5p278j
 Vbv8ydhZlQoAzjIsHjY9Tr1trubrzOXzXrHTd5CIc2g7F3PsbpTCpyefkXqz0P1LWKDNEjH2t
 ISm6jy/rQqEEyrCzBsLS8oCD8oya7vjwm2FwuHtUKTdmnRH0T0K8G/3zOykyFJIab24hIY/wG
 nPMLh330svNlgcpXFhNpYIAI1iWocS3uaGcL+H31Eo9wONsh7rsA9u+zcI9mXMJNvgJNhj5SV
 ejgoJXLxSEYFhUiWOODYV3M+SHqisrljYEW1QKbXInz8HrOtwUDEXLMF4PtXBsfBgxfFVEu8V
 HtegHtJMXhDnK+cWJahkN9CdkKIggWEsnfxFI2mE3Bymh1tyyBA0RQOwKVqZfTFM5uQmjgthI
 9xiVenpgbBN4DjyC+RkonzHnTF9CGrcCwZeyh6WAlnRHQdgD5UyfdFYoyjeIS069vITYHKUQN
 /stzNrIngSl/+kCGXzvayP1VT8Yh3WvfDq22PcX4L1hlSyMeSYoExcr+7z6UgQvbk6GXDLN+M
 QS2Ij/w00u/lZVvy7/GCryjRibr/qdLpV76onBU3ys0xPQJXs4rM6vxzMt2gZLsvE+bdPcvzv
 VDR2GA==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 9=2E November 2022 09:38:03 MEZ schrieb Linus Walleij <linus=2Ewalleij@l=
inaro=2Eorg>:
>On Sat, Nov 5, 2022 at 4:06 PM Frank Wunderlich <frank-w@public-files=2Ed=
e> wrote:
>

>That patch in turn says it needs another patch first=2E
>
>Now I am utterly confused, it is really hard to follow these trains
>of patches depending on and breaking each other left and right=2E=2E=2E
>
>Can you please tell me which patches I need to apply and
>in which order?

Sorry, picked the wrong link=2E Put all pinctrl patches together into this=
 series to make it easier to follow (but v2 because v1 was for changing onl=
y mmc pinctrl and to have no conflicts or "broken" commits):

https://patchwork=2Ekernel=2Eorg/project/linux-mediatek/list/?series=3D692=
462

>Yours,
>Linus Walleij


regards Frank
