Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5579640B52
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbiLBQzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbiLBQzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:55:00 -0500
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EA7D159C;
        Fri,  2 Dec 2022 08:54:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1670000066; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=nDjyPFgEloDmM8T/sBNrO/VlMDxo8r7LRbTRDALSR/0ucLLwORJlzGZ29coIGPEro/biYP4tUkD9b7WN88J5YnkXrdZodCcH7RMSsKc5SvD/SMuEM8dLlvNPdRG58BXEND8Rk0XSCO1yCKRhkxgiMfpM1tKnm4v+cPVl4Blw46c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1670000066; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=e1xazqjcXwEUoLesqlU4Blrrp+KuPG+K4ku0ElP/cxA=; 
        b=D5ZY3Ijf/zhMeYAD+yEGsHTHlmHyHqzGyaK9JqmmTNIPVvLhmK/flzm7eystCGyPP5VXUWSQLJomdjcCvvNxUnmHszFC8DQjRXtRefUo6SxSHmf11V+bEg9cRDzyRgqQCsddBZjwpYohed7C4FWuZoBeOxMIpveh5lr+yKpxUbE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1670000066;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=e1xazqjcXwEUoLesqlU4Blrrp+KuPG+K4ku0ElP/cxA=;
        b=VvQi8dcBCDb3e9NAUXLCWJRxiVEr3dtPpqx+r3MtjZ5NBmYOLpbOjY6CJH5wFFbT
        p3nDacOTxUyjdfgJejiwitZdzMInxBiPij6tHtl9PBkHWOvrtAE7Jeom0rZoAH5DnKC
        Er5IzWqt76AhOKRqwNisKFxVYOFFU+iIvI+5cPcs=
Received: from edelgard.fodlan.icenowy.me (120.85.99.143 [120.85.99.143]) by mx.zohomail.com
        with SMTPS id 1670000064421431.1187913489915; Fri, 2 Dec 2022 08:54:24 -0800 (PST)
Message-ID: <2f0f31551d361cf23abdd2c4117f2feb84e2b1a8.camel@icenowy.me>
Subject: Re: [PATCH v2 2/6] dt-bindings: usb: Add binding for Genesys Logic
 GL850G hub controller
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Date:   Sat, 03 Dec 2022 00:54:18 +0800
In-Reply-To: <b4ddf139-5604-bd04-e309-d7bc15e9d23b@linaro.org>
References: <20221202081647.3183870-1-uwu@icenowy.me>
         <20221202081647.3183870-3-uwu@icenowy.me>
         <b4ddf139-5604-bd04-e309-d7bc15e9d23b@linaro.org>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2022-12-02=E6=98=9F=E6=9C=9F=E4=BA=94=E7=9A=84 10:02 +0100=EF=BC=
=8CKrzysztof Kozlowski=E5=86=99=E9=81=93=EF=BC=9A
> On 02/12/2022 09:16, Icenowy Zheng wrote:
> > The Genesys Logic GL850G is a USB 2.0 Single TT hub controller that
> > features 4 downstream ports, an internal 5V-to-3.3V LDO regulator
> > (can
> > be bypassed) and an external reset pin.
> >=20
> > Add a device tree binding for its USB protocol part. The internal
> > LDO is
> > not covered by this and can just be modelled as a fixed regulator.
> >=20
> > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > ---
> > Changes in v2:
> > - Misc fixes suggested by Krzysztof, including property
> > descriptions,
> > =C2=A0 single-item "items" and fixing the example's gpio property.
> > - Fixed $id.
> >=20
> (...)
>=20
> > +
> > +examples:
> > +=C2=A0 - |
> > +=C2=A0=C2=A0=C2=A0 usb {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dr_mode =3D "host";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <1>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <0>;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hub: hub@1 {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 com=
patible =3D "usb5e3,608";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg=
 =3D <1>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res=
et-gpios =3D <&pio 7 2>;
>=20
> Use GPIO flags. What did you fix in the example?

It used to be here, but using it needs another include, which I don't
think it necessary here.

Maybe I should just drop this line in the example?

>=20
>=20
>=20
> Best regards,
> Krzysztof
>=20

