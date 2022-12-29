Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3BA658E3B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 16:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbiL2PM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 10:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiL2PM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 10:12:26 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABE813DEA;
        Thu, 29 Dec 2022 07:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1672326708;
        bh=xirCA9c8DIti9Fo5Dwsm15yj3OA0oAtHohoPlTTonIU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KMIX/nUtp7UuPb7FDZVa9mTDMixLkMDCa6qKzW38+jA8ZFxpGHIgQY/QJdrtk9huW
         VsDHEBfy7Sf/fs9KPFPVOS/CR+zxVPQJ/4JVjJkdqltlYFjrxPcUokFi+K9hWwKqbl
         yd81EJbRyXOB906tzY9wRtAPjz21NrRKuEt8oQGo6N2SqjcmAgmKbZmYACF+1Wi3n8
         GLfFU5dzmtuHBm2ElBs1qOh7RYg3aFMLZslkLE5V0LlX+vEBxQOxKWSEXWIAPNCR+M
         iz2GWBb9rt1K9i3u0D92v/m6ZgjOXFTEhejJetqM22D05eIi0iP957ng4yIOxDAhc1
         epSXJkggUUu9Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [80.245.77.213] ([80.245.77.213]) by web-mail.gmx.net
 (3c-app-gmx-bap35.server.lan [172.19.172.105]) (via HTTP); Thu, 29 Dec 2022
 16:11:48 +0100
MIME-Version: 1.0
Message-ID: <trinity-f4c66c53-204d-43c7-90f5-1ecf75e4bbad-1672326708689@3c-app-gmx-bap35>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Aw: Re: [PATCH v8 5/5] arm64: dts: mt7986: add Bananapi R3
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 29 Dec 2022 16:11:48 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <Y62s4+zMm1ECnMlH@makrotopia.org>
References: <20221229145023.55713-1-linux@fw-web.de>
 <20221229145023.55713-6-linux@fw-web.de> <Y62s4+zMm1ECnMlH@makrotopia.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:8Pqig6h4mKzYCwMQwatNyxCbSzbryuniyYILFjvgqWM0ZxKxqzsZwm+y6/oW/Z/QTsv+k
 ieQkbtQiHm64R+MJ7ItH1KnUsWKGNfXoQnJvCrVyOynrgtIYzTC5joEEKHKpx5pxGq2Bdsaf4H8K
 bKUOfsGpgdkFPcwsxxxl5oxL2w8F8fUQlCv0ylMNImDVthL12v4kwRczdHIC6RLnQbax82OSPKai
 eLW8B1ta/kRps7O4cAMMcLs74Bo2fPL3/t84/Htu5kn28KLvXgTGWo/Of1RlAojKYn/kRLIWp0Hx
 xE=
UI-OutboundReport: notjunk:1;M01:P0:RMr5q3HhiPQ=;bJNbwCfCkaGcHV5432yNa9sL2ER
 wiwQWMCCj8a1tzW+cZn91OlSqO3YTG7KjuriWaUChD9LbUvuRNXcR8tZI0YwMkQCyhmAwv2tN
 bMVIT0o1Qi4Hx6P2hJw66uFOFWTjb29SWJ8SxnRmK9bpc+u4y6IZdr+hZb5OLELXBfah4FPiv
 FsDbBT8sNG8TvaFpBY3QOiXUxptrPU8NBY/q7vJCMImSkBehhxu1zPm/DjCgix6FLwlKJUHit
 cMNaykC5mR2hytLBeteVgGqRoAA3cH/n/mdWIEqx0xdERB+GhILY5r+Pe51t8KXGgehFGYNlV
 gwd4MXChtmAPjEyH1Zu7Tt8dA3X00tJbR86cWQUs8oupY876TDFRIq6QzbWWLmzn7Q/1tsb/O
 T92AwuAXwVeNnd0BY+oHIdgAEI5e+2aXjzAGMUmCxb2fmGOlvIBY3f+0It6mM9ldZav0tvJoi
 YoHYRvZVXab05o8Me31Ugq+QP6r20ucXqYS6XhO1ZgsHFR1gtCpxP7V69kyCiRqZeO+93iT/+
 SgyX+q+Abg8l1dk/aa2J1i4DDQOtjwoK/6wPfkaRgK1YxZt4ZNB5WIIyx/Gj9AG6BrSTkxJk8
 yOZ7X0o4gwGxrrq1uL/bMoVuxbWk07zgxh6dPjw30bIc/jDwSTPdu6C/cKoEhtjMaRtwCqmvh
 b4LjCXUd3TL4m3n5FaPeTGvuOEHE3I4EhlQWNfMzVwcsueEesfr85Rw6skF/6Z+N+Bn2FxAxM
 DFEbfWzXJ8M30FDP+OCaJofJKqy5a4QDd8bj+Vgzi57z5QaZ10BjwwJf3nM4huKC7e30NqudZ
 oJ4o7HxDdKO14dX/1BkD4ruQ==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> Gesendet: Donnerstag, 29. Dezember 2022 um 16:06 Uhr
> Von: "Daniel Golle" <daniel@makrotopia.org>

> > diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sd.d=
tso b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sd.dtso
> > new file mode 100644
> > index 000000000000..08af778d8adc
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sd.dtso
> > @@ -0,0 +1,24 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +/*
> > + * Copyright (C) 2021 MediaTek Inc.
> > + * Author: Sam.Shih <sam.shih@mediatek.com>
> > + */
> > +
> > +/dts-v1/;
> > +/plugin/;
> > +
> > +/ {
> > +	compatible =3D "bananapi,bpi-r3", "mediatek,mt7986a";
> > +	model =3D "Bananapi BPI-R3 (sdmmc)";
>
> There is another model string here which shouldn't be.

sorry, missed this one, will drop it in next version

@all: anything else i need to change?

regards Frank
