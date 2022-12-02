Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7440640027
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 07:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbiLBGNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 01:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiLBGNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 01:13:16 -0500
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9ADFA6CD7;
        Thu,  1 Dec 2022 22:13:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1669961582; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=njvltCNXE9INRA89a/A8l9GSmbg7W3g4FmXRdRNuO6xdy4g0oujIcGE5Gu4+tKwiFtaJlFEEgt5kTraGV3RVz2FWZ9dAjc8ibSG4Y8Vs7EHPAvU9GQUld2EKFI4/vfY1cOzTM3z0KdoFYOiWnweKh3zrh18nCrbNUROc0NmKst8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1669961582; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=LbijN6aeKiT2uH/R45xRpGeOX2EWdCb/9cdCuJ6Cl7A=; 
        b=IYxavsz+nDjTwFh2K1reKptJC/obpCniagPMTSMXDYsiGpn0GdXbR9hOYEnShHbS93yhlMLiSz+ml4jfOX1YGwExmpdv15Q3of8S0R6YYYmJN5p9Qhqk1cdPsap0WqeRIY/msNsF8+/1ZY2lWobaJQtqaEG3tt7/Nga26itY764=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1669961582;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=LbijN6aeKiT2uH/R45xRpGeOX2EWdCb/9cdCuJ6Cl7A=;
        b=iGu6Yzy2Pe5JHoPFFZBwlu8t1jOTksdOAjcSNJgzdU0IhBZg38k0FR7uaJfibg8D
        PCHgSeY7O7OJrVJGfpvjpgV9iosHNVNlftO+eb9JLWHb6n5rcu9ANPyxDIEMnPcgDEk
        WU7sPRNhg9sNk1ASyVsweBSKE4hmDVaIniji3aCw=
Received: from edelgard.fodlan.icenowy.me (120.85.99.229 [120.85.99.229]) by mx.zohomail.com
        with SMTPS id 1669961580397796.7845658650348; Thu, 1 Dec 2022 22:13:00 -0800 (PST)
Message-ID: <4ad56fa249a30167844abcedac53d198606511d8.camel@icenowy.me>
Subject: Re: [PATCH 2/3] dt-bindings: timer: sifive,clint: add compatible
 for OpenC906
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Date:   Fri, 02 Dec 2022 14:12:54 +0800
In-Reply-To: <Y4j+Gpptk3NAFBNV@spud>
References: <20221121041757.418645-1-uwu@icenowy.me>
         <20221121041757.418645-3-uwu@icenowy.me>
         <98005150-83a7-5439-0db1-d93d459c3809@linaro.org>
         <b924d37d716fa8b1fd93102b1d51fac221f43d59.camel@icenowy.me>
         <d0f3ce4f-5676-f5e1-f04f-dd069679b2d3@linaro.org>
         <81C2234E-C92D-4F78-8295-7C6DD0A9BBC4@icenowy.me>
         <20221130181330.GA2544489-robh@kernel.org> <Y4j+Gpptk3NAFBNV@spud>
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

=E5=9C=A8 2022-12-01=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 19:18 +0000=EF=BC=
=8CConor Dooley=E5=86=99=E9=81=93=EF=BC=9A
> On Wed, Nov 30, 2022 at 12:13:30PM -0600, Rob Herring wrote:
> > On Tue, Nov 22, 2022 at 03:41:27PM +0800, Icenowy Zheng wrote:
> > >=20
> > >=20
> > > =E4=BA=8E 2022=E5=B9=B411=E6=9C=8822=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=
=8D=883:35:48, Krzysztof Kozlowski
> > > <krzysztof.kozlowski@linaro.org> =E5=86=99=E5=88=B0:
> > > > On 22/11/2022 08:18, Icenowy Zheng wrote:
> > > > > =E5=9C=A8 2022-11-21=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 11:06 +0=
100=EF=BC=8CKrzysztof Kozlowski=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > On 21/11/2022 05:17, Icenowy Zheng wrote:
> > > > > > > T-Head OpenC906 is a open-source-licensed fixed-
> > > > > > > configuration of
> > > > > > > C906,
> > > > > > > which is now public and able to be integrated.
> > > > > > >=20
> > > > > > > Add a compatible for the CLINT shipped as part of
> > > > > > > OpenC906, which
> > > > > > > should
> > > > > > > just be ordinary C9xx CLINT.
> > > > > > >=20
> > > > > > > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > > > > > > ---
> > > > > > > =C2=A0Documentation/devicetree/bindings/timer/sifive,clint.ya=
m
> > > > > > > l | 1 +
> > > > > > > =C2=A01 file changed, 1 insertion(+)
> > > > > > >=20
> > > > > > > diff --git
> > > > > > > a/Documentation/devicetree/bindings/timer/sifive,clint.ya
> > > > > > > ml
> > > > > > > b/Documentation/devicetree/bindings/timer/sifive,clint.ya
> > > > > > > ml
> > > > > > > index aada6957216c..86703e995e31 100644
> > > > > > > ---
> > > > > > > a/Documentation/devicetree/bindings/timer/sifive,clint.ya
> > > > > > > ml
> > > > > > > +++
> > > > > > > b/Documentation/devicetree/bindings/timer/sifive,clint.ya
> > > > > > > ml
> > > > > > > @@ -35,6 +35,7 @@ properties:
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
- const: sifive,clint0
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - items:
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
- enum:
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 - thead,openc906-clint
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 - allwinner,sun20i-d1-clint
> > > > > >=20
> > > > > > Add entries sorted alphabetically. This should be squashed
> > > > > > with
> > > > > > previous
> > > > > > patch.
> > > > >=20
> > > > > I make it a seperated patch because I think it's a
> > > > > questionable
> > > > > approach.
> > > > >=20
> > > > > If you think it's okay, I will just squash it and put it as
> > > > > the second
> > > > > patch in the next iteration, with adding openc906-plic as the
> > > > > first
> > > > > one.
> > > >=20
> > > > What is a questionable approach? Why commit msg is not saying
> > > > this?
> > >=20
> > > Ah I mentioned it in the cover letter. The problem is just I
> > > doubt whether
> > > binding strings for single SoCs are necessary.
> >=20
> > They are.
> >=20
> > Unless all the quirks/bugs/features are somehow guaranteed to be
> > exactly=20
> > the same as other SoCs sharing the same compatible string, or there
> > is=20
> > another mechanism to identify the exact version (e.g. a version=20
> > register).
>=20
> Icenowy,
>=20
> Having thought about this a little - are we not *more* likely to see
> bug/quirk disparity between implementations of the OpenC906 stuff by
> the very nature of being an open-source IP?

It's an open-source edition of a specific version of the commercial IP,
a fixed configuration.

In addition, maybe we can just retrieve the version infomation via a T-
Head custom CPU configuration register, mcpuid. Despite the
implementation of this register is weird -- it contains 7 different
read-only values, with the most significant nibble behaving as an
index.

>=20
> Thanks,
> Conor.
>=20

