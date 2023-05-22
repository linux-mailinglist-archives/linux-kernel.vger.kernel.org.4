Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD9C70B792
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjEVI0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjEVI0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:26:50 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC94DB6;
        Mon, 22 May 2023 01:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1684743994; i=frank-w@public-files.de;
        bh=iJE87Et1+i7od+AUi+yEibwB8gDZBBZCoiwY+GJCKSY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=em9IA7mS7pr2vumrK+0oMJMvK07ADhacGr30BSJsNtI+fDq25r1mJK5LxI6efwajq
         0WoOTa+p+JA8IWNJnr4b+OqSDImMLjQkiG6aju6NHcmP9vE+GZRorBupJxY2rBouEm
         OjLz+kJIf0M1ZxYOZF66ylFjV/8kqzTbdCUL9uCIKwlP3ojg+ZFZbRbSm8tXBNhxgk
         4uvx8LjCirBN0GwUbhaWhwTCOyG5l3FdPFN+k1TpF1jg4uqvZVp9wgW1yGx8I9s0KW
         HtdtzBZD3OmRQnIZjQxOjems8QI4bI+z7R2A0eo2BuxsklQkqc4cZRBv7hI/mxeBft
         hQj68PagPeeDg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.155.92] ([217.61.155.92]) by web-mail.gmx.net
 (3c-app-gmx-bs66.server.lan [172.19.170.210]) (via HTTP); Mon, 22 May 2023
 10:26:34 +0200
MIME-Version: 1.0
Message-ID: <trinity-8c109262-658a-4a4e-a807-1cd8f640fdc4-1684743994291@3c-app-gmx-bs66>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Aw: Re: [PATCH] arm64: dts: mt7986: set Wifi Leds low-active for
 BPI-R3
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 22 May 2023 10:26:34 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <3a43ce55-ff6a-0cd2-b020-d5fefe8aca0a@collabora.com>
References: <20230205174833.107050-1-linux@fw-web.de>
 <8f04f2b5-320e-50d4-9517-6dac989f63b3@gmail.com>
 <3a43ce55-ff6a-0cd2-b020-d5fefe8aca0a@collabora.com>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:9HKDyGxPRL9Yhd/YC7Z3n+yXLC68nN9emK2ktuC8U6wz6JHq56A8NcXUWqIQtzljYirmE
 gke/KKu6xKmuIy327JL63asHMmvpMEO4fWrg02un03Uc60bWUWEI5bjAK1np8wIsqNfqhKVE1AVG
 haO2zutpvCHnfRBh3vMCtmd8ZMw7cjPkXcUGn8YbRrzV3kAbyMHDcw4NjhoIAmx/Tytb9xV+jNId
 L6vivZs5VbqUEvWRfCZI4QNAMfrbE+55bauLGtR6Q1Tf35Tlqjn9hyOOL1MnmXwfX0sa9Zr73tPN
 Hw=
UI-OutboundReport: notjunk:1;M01:P0:nkS8x8yAfKQ=;kSUXqTCb3/4/ThFRC1fkJbE5Lj0
 JqlFM5l+gGaUOCIzXJFAzpsLXYE9n+6G61AncanneZVhTXBtBXMY5+giQzBn+lZ3wTC7NAtc/
 aEoX/iMnavtG2vN0Uz0wffiXHVpYS14osm1YzhKqJ2lFDCGoBecVjyEcquA/MftA2PyvF6+Wj
 gWAd7dJEQjX1hXTl9DGx49FAIYf4oRZ8Q97LasaQPMYoGKYgD3UGyxYkE3GdES1qFvNRdfK2M
 Q7xIyEsc6+pn/XPV44K4pw6k7jNMBkdIEyQza3S6Ik7SYnqvxDya2MYn/B034VeLxrEuFTkc4
 zz0q55gIl7tABo4LSDLdg0W0VlZjez+htY3uKnnMjvCVzn5krGhu1kfwtIFlN3tJSgb/++CQo
 JvpG8gV3ygRU0ERo4Nh8H+JUnMuc8WNzt95ePbmBMj2NuhDXYoAZS4WrgGUPkVdiY97OUeXVg
 TZTtkBZFfsGRaoH6w0g0CRu3xN46xHVAqzyHu0Ijk0TkRGfD5RSd7ASBt07RkkTi7hmAK7eeA
 IXluMp+xFxlODO4Zmi4m8U0ROd5aE8qPZpMkVrAr+tyQrqMAzc6vqUodcK+pnYW6tppMMAMuF
 RIPNBtmlxwfjGApcmOSPFRHYTl+m4rrUitrr7Y+1cdElAeRNNE5nwH1VoHN2FruhKwBDG/ZEM
 QN5ajdXtlG0XqLtNiuobJKYgK4ekM7T022s4y0q5ofZ+35waxijEiMt/HY79lbQWIGZN2WESZ
 fZxT9tAZABj13wcFbVQTBCgcKg0Mxq+a4GCE+yu6vxbxX+rBJ+01ml3di5KUwk7d6zFPQTiuo
 /TPCo3uqpygDqyXJt830RbFg==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Gesendet: Dienstag, 07=2E Februar 2023 um 17:17 Uhr
> Von: "AngeloGioacchino Del Regno" <angelogioacchino=2Edelregno@collabora=
=2Ecom>
> Il 06/02/23 21:20, Matthias Brugger ha scritto:
> >=20
> >=20
> > On 05/02/2023 18:48, Frank Wunderlich wrote:
> >> From: Frank Wunderlich <frank-w@public-files=2Ede>
> >>
> >> Leds for Wifi are low-active, so add property to devicetree=2E
> >>
> >> Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
> >> ---
> >> =C2=A0 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3=2Edts | 4=
 ++++
> >> =C2=A0 1 file changed, 4 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3=2Ed=
ts=20
> >> b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3=2Edts
> >> index 33bd6febc160=2E=2E2b028141f1f7 100644
> >> --- a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3=2Edts
> >> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3=2Edts
> >> @@ -446,5 +446,9 @@ &wifi {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-names =3D "default", "dbdc";
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-0 =3D <&wf_2g_5g_pins>, <&wf_l=
ed_pins>;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-1 =3D <&wf_dbdc_pins>, <&wf_le=
d_pins>;
> >> +
> >> +=C2=A0=C2=A0=C2=A0 led {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 led-active-low;
> >> +=C2=A0=C2=A0=C2=A0 };
> >=20
> > The binding is missing this property also the driver implements it=2E =
Could you=20
> > please update the bindind description properly?
> > Thanks
> > Matthias
>=20
>=20
> After and only after [1] is picked,
>=20
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino=2Edelregno@col=
labora=2Ecom>
>=20
> [1]:=20
> https://patchwork=2Ekernel=2Eorg/project/linux-mediatek/patch/2023020713=
3504=2E21826-1-linux@fw-web=2Ede/

Hi Matthias,

Can you take this patch into your tree? binding is already merged

https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/torvalds/linux=2Egit/t=
ree/Documentation/devicetree/bindings/net/wireless/mediatek,mt76=2Eyaml#n11=
4

regards Frank

