Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2764364271D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 12:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiLELDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 06:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiLELDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 06:03:49 -0500
Received: from sender3-op-o18.zoho.com (sender3-op-o18.zoho.com [136.143.184.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B64223;
        Mon,  5 Dec 2022 03:03:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1670238205; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=dCg4L4dDwtUFfG26pp3MyF8p17XNUTGmBxNM8y8NIA4DDp7mqXy0T5jL5m16R5BfzufupFRzzCMTmrRM0Zxu7m4pHiCgFtEi0uk0GkhXSNlBhQdTvocuCGvA91fAebtA4syW7/fCUTpDwfoUDTah9GEd5WHaqPTjhliVrT9bS6I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1670238205; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=qqmUi98VANfk0PufkZdOVcDiymv+qgsHjWmqFJQ5X8s=; 
        b=fB9KHUif2F8HCU7guYPqfQrxRDHMI6hxL54nHOt9nX00zBB0MXJS5sXmmhAZwl4Y1BmYiaYSJ4CNqVF0Rqqc75GyiLxV0UZWgCcUcTUDBrCPyQib4IEHo7vNNxAg35Q9qLO6zbzyRZJsvpTBTeAjS8XHh5XhSMaNsG/7h4S5JI8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1670238205;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=qqmUi98VANfk0PufkZdOVcDiymv+qgsHjWmqFJQ5X8s=;
        b=V0Yb2KDHkPy5QzDgxAdB6hcvdIo9/h5nK28X5LTlXdnsK3121DiaM2Lg9LrNJmzi
        Q58YBu09jugZMqNS8TN3ywBkTNlkhfSpRaWIcWL7Ea+r+y67MwsscpEvpX1hYszT1ls
        q3QRTzqDI5eAaHms1lKEsXDVcv4HBpKNtNJ/CZXk=
Received: from edelgard.fodlan.icenowy.me (120.85.99.143 [120.85.99.143]) by mx.zohomail.com
        with SMTPS id 1670238202532178.59673950121748; Mon, 5 Dec 2022 03:03:22 -0800 (PST)
Message-ID: <75a3ef9a175b16c46b57b2829ecbe4f97737de8a.camel@icenowy.me>
Subject: Re: [PATCH 2/3] dt-bindings: timer: sifive,clint: add compatible
 for OpenC906
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Date:   Mon, 05 Dec 2022 19:03:17 +0800
In-Reply-To: <Y43Jt3YOSbFyh954@wendy>
References: <20221121041757.418645-1-uwu@icenowy.me>
         <20221121041757.418645-3-uwu@icenowy.me>
         <98005150-83a7-5439-0db1-d93d459c3809@linaro.org>
         <b924d37d716fa8b1fd93102b1d51fac221f43d59.camel@icenowy.me>
         <d0f3ce4f-5676-f5e1-f04f-dd069679b2d3@linaro.org>
         <81C2234E-C92D-4F78-8295-7C6DD0A9BBC4@icenowy.me>
         <20221130181330.GA2544489-robh@kernel.org> <Y4j+Gpptk3NAFBNV@spud>
         <4ad56fa249a30167844abcedac53d198606511d8.camel@icenowy.me>
         <Y43Jt3YOSbFyh954@wendy>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2022-12-05=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 10:36 +0000=EF=BC=
=8CConor Dooley=E5=86=99=E9=81=93=EF=BC=9A
> On Fri, Dec 02, 2022 at 02:12:54PM +0800, Icenowy Zheng wrote:
> > =E5=9C=A8 2022-12-01=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 19:18 +0000=EF=
=BC=8CConor Dooley=E5=86=99=E9=81=93=EF=BC=9A
> > > On Wed, Nov 30, 2022 at 12:13:30PM -0600, Rob Herring wrote:
> > > > On Tue, Nov 22, 2022 at 03:41:27PM +0800, Icenowy Zheng wrote:
> > > > >=20
> > > > >=20
> > > > > =E4=BA=8E 2022=E5=B9=B411=E6=9C=8822=E6=97=A5 GMT+08:00 =E4=B8=8B=
=E5=8D=883:35:48, Krzysztof Kozlowski
> > > > > <krzysztof.kozlowski@linaro.org> =E5=86=99=E5=88=B0:
> > > > > > On 22/11/2022 08:18, Icenowy Zheng wrote:
> > > > > > > =E5=9C=A8 2022-11-21=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 11:0=
6 +0100=EF=BC=8CKrzysztof Kozlowski=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > > On 21/11/2022 05:17, Icenowy Zheng wrote:
> > > > > > > > > T-Head OpenC906 is a open-source-licensed fixed-
> > > > > > > > > configuration of
> > > > > > > > > C906,
> > > > > > > > > which is now public and able to be integrated.
> > > > > > > > >=20
> > > > > > > > > Add a compatible for the CLINT shipped as part of
> > > > > > > > > OpenC906, which
> > > > > > > > > should
> > > > > > > > > just be ordinary C9xx CLINT.
> > > > > > > > >=20
> > > > > > > > > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > > > > > > > > ---
> > > > > > > > > =C2=A0Documentation/devicetree/bindings/timer/sifive,clin=
t
> > > > > > > > > .yam
> > > > > > > > > l | 1 +
> > > > > > > > > =C2=A01 file changed, 1 insertion(+)
> > > > > > > > >=20
> > > > > > > > > diff --git
> > > > > > > > > a/Documentation/devicetree/bindings/timer/sifive,clin
> > > > > > > > > t.ya
> > > > > > > > > ml
> > > > > > > > > b/Documentation/devicetree/bindings/timer/sifive,clin
> > > > > > > > > t.ya
> > > > > > > > > ml
> > > > > > > > > index aada6957216c..86703e995e31 100644
> > > > > > > > > ---
> > > > > > > > > a/Documentation/devicetree/bindings/timer/sifive,clin
> > > > > > > > > t.ya
> > > > > > > > > ml
> > > > > > > > > +++
> > > > > > > > > b/Documentation/devicetree/bindings/timer/sifive,clin
> > > > > > > > > t.ya
> > > > > > > > > ml
> > > > > > > > > @@ -35,6 +35,7 @@ properties:
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 - const: sifive,clint0
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - items:
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 - enum:
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 - thead,openc906-clint
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 - allwinner,sun20i-d1-clint
> > > > > > > >=20
> > > > > > > > Add entries sorted alphabetically. This should be
> > > > > > > > squashed
> > > > > > > > with
> > > > > > > > previous
> > > > > > > > patch.
> > > > > > >=20
> > > > > > > I make it a seperated patch because I think it's a
> > > > > > > questionable
> > > > > > > approach.
> > > > > > >=20
> > > > > > > If you think it's okay, I will just squash it and put it
> > > > > > > as
> > > > > > > the second
> > > > > > > patch in the next iteration, with adding openc906-plic as
> > > > > > > the
> > > > > > > first
> > > > > > > one.
> > > > > >=20
> > > > > > What is a questionable approach? Why commit msg is not
> > > > > > saying
> > > > > > this?
> > > > >=20
> > > > > Ah I mentioned it in the cover letter. The problem is just I
> > > > > doubt whether
> > > > > binding strings for single SoCs are necessary.
> > > >=20
> > > > They are.
> > > >=20
> > > > Unless all the quirks/bugs/features are somehow guaranteed to
> > > > be
> > > > exactly=20
> > > > the same as other SoCs sharing the same compatible string, or
> > > > there
> > > > is=20
> > > > another mechanism to identify the exact version (e.g. a version
> > > > register).
> > >=20
> > > Icenowy,
> > >=20
> > > Having thought about this a little - are we not *more* likely to
> > > see
> > > bug/quirk disparity between implementations of the OpenC906 stuff
> > > by
> > > the very nature of being an open-source IP?
> >=20
> > It's an open-source edition of a specific version of the commercial
> > IP,
> > a fixed configuration.
> >=20
> > In addition, maybe we can just retrieve the version infomation via
> > a T-
> > Head custom CPU configuration register, mcpuid. Despite the
> > implementation of this register is weird -- it contains 7 different
> > read-only values, with the most significant nibble behaving as an
> > index.
>=20
> You lot all know the situation here a lot more than I do...
> I don't think "letting" people use the bare "thead,c900-foo" makes
> much
> sense as it gives us no chance to deal with quirks down the line.

Well, after rechecking the manual, I found it possible to handle quirks
-- T-Head has a custom "mcpuid" CSR (@ RISC-V CSR 0xFC0), which can be
used to retrieve some identification info of the core, including its
model ID, version, etc; and the T-Head PLIC/CLINT are part of their
C906 SoC design that there's another "mapbaddr" CSR that could be used
to retrieve the base address of them.

So I think it okay to just use "thead,c900-clint" here, and when
necessary, try to retrieve mcpuid for dealing with quirks.

> I don't think that using "thead,openc906-clint", "thead,c900-clint"
> makes all that much sense either, in case someone does something
> wacky
> with the open-source version of the core.
>=20
> That leaves us with either:
> "vendor,soc-clint", "thead,openc906-clint", "thead,c900-clint"
> or:
> "vendor,soc-clint", "thead,c900-clint"
> right?
>=20
> The first one seems like possibly the better option as you'd kinda
> expect that, in a perfect word, all of the open-source IP
> implementations would share quirks etc?
>=20
> Thanks,
> Conor.
>=20

