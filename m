Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32AA4709BA9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 17:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjESPvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 11:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjESPu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 11:50:58 -0400
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8971B0;
        Fri, 19 May 2023 08:50:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1684511425; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=HZGWV3mkCVvIKzG0tWLtxWXq4bBqBQX+cQVxtsi23GQjHcgDVx9TwuGD+rixUFsaANFBzKIBNxOdqXskHKqVrtkJsCnubadgXRJm1pz9XyeS3ND6zsHMkuJ1vIDgRIyeVMGeF8J152alQYVNe1UWMEANbVPOrfrIfp2Jc0as+zA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1684511425; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=gs+hOAo8YT0FiIn+tQqctT5867aD0k3Rps6XhweMFhk=; 
        b=aK68H8m12N0Wbo7nBfsSsMzYRehGSjcxEkM9NUIsFz5ccKleQx8AAotyh5UKd6AFHMgIRrYyuvSD4r7FwGj/xA/FmtnCixYpl/jfL5oadLbLu9lkPy8AzV1irKyahL/1CgXStBUIROpn2MYktb0wbTXvrzvziMdFerp0ANVHQzY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1684511425;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=gs+hOAo8YT0FiIn+tQqctT5867aD0k3Rps6XhweMFhk=;
        b=HOUKlDNpR8O12UrWm1nucXKKGG2G8CAHsxoiLRM5a/GHnntl+f+cHygj+3j2H8e+
        mOpMiUfDVIM4x425ty+z8xsXXV0x+xta2Xwm1BonK9B9ya3xR8wljdZ/ekTEtYuwe+l
        jKq9EmiQJ5Qh5LPQyXt8lGUg+OFqG1DpDGTDh0Mw=
Received: from edelgard.fodlan.icenowy.me (120.85.98.248 [120.85.98.248]) by mx.zohomail.com
        with SMTPS id 1684511422475801.3864897939635; Fri, 19 May 2023 08:50:22 -0700 (PDT)
Message-ID: <122af5271507d77b495ef4b69f3aef4449cc0381.camel@icenowy.me>
Subject: Re: [PATCH v2 3/9] dt-bindings: riscv: Add T-HEAD TH1520 board
 compatibles
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Conor Dooley <conor@kernel.org>, Jisheng Zhang <jszhang@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Yangtao Li <frank.li@vivo.com>,
        Wei Fu <wefu@redhat.com>
Date:   Fri, 19 May 2023 23:50:15 +0800
In-Reply-To: <20230518-estate-scoff-c009f19aad5a@spud>
References: <20230518184541.2627-1-jszhang@kernel.org>
         <20230518184541.2627-4-jszhang@kernel.org>
         <20230518-estate-scoff-c009f19aad5a@spud>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2023-05-18=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 20:40 +0100=EF=BC=
=8CConor Dooley=E5=86=99=E9=81=93=EF=BC=9A
> On Fri, May 19, 2023 at 02:45:35AM +0800, Jisheng Zhang wrote:
> > Several SoMs and boards are available that feature the T-HEAD
> > TH1520
> > SoC. Document the compatible strings.
> >=20
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> > =C2=A0.../devicetree/bindings/riscv/thead.yaml=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 29
> > +++++++++++++++++++
> > =C2=A01 file changed, 29 insertions(+)
> > =C2=A0create mode 100644
> > Documentation/devicetree/bindings/riscv/thead.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/riscv/thead.yaml
> > b/Documentation/devicetree/bindings/riscv/thead.yaml
> > new file mode 100644
> > index 000000000000..e62f6821372e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/riscv/thead.yaml
> > @@ -0,0 +1,29 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/riscv/thead.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: T-HEAD SoC-based boards
> > +
> > +maintainers:
> > +=C2=A0 - Jisheng Zhang <jszhang@kernel.org>
> > +
> > +description:
> > +=C2=A0 T-HEAD SoC-based boards
> > +
> > +properties:
> > +=C2=A0 $nodename:
> > +=C2=A0=C2=A0=C2=A0 const: '/'
> > +=C2=A0 compatible:
> > +=C2=A0=C2=A0=C2=A0 oneOf:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Sipeed Lichee Pi 4A boar=
d for the Sipeed
> > Lichee Module 4A
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - enum:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 - sipeed,lichee-pi-4a
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: sipeed=
,lichee-module-4a
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: thead,=
th1520
>=20
> Same here re: other SoMs I guess. Probably more interest in creating
> them here though!
>=20
> I heard on the grapevine that the boards people have now are perhaps
> not
> the same as the design that they're going to ship in the main
> production
> run?

There really was an early EVB that is not public, but the EVB is called
LM4A EVB instead of LP4A.

The Lichee Pi 4A board here is the production run one.

> Do you know if there is a more detailed part number for the boards,
> just
> in case there are some software-visible changes?
>=20
> Thanks,
> Conor.

