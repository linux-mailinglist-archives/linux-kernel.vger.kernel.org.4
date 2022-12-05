Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88E2642C65
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbiLEQAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiLEQAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:00:11 -0500
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com [136.143.188.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFF817047;
        Mon,  5 Dec 2022 08:00:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1670255995; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=X7jn62/jMmkCOkK8ufWo0TMcd7RRQ7I9K7spYpLbdiOsmgvJmT1B6e3WyLi2EDUTeQskiuns5dIiA7X6gukJE5+tQGArrA/SsxJZBF71byI+/ojLJE6kgRJKyUffW19+ezDRE2rRI/IXg/i0LGdvx/v1aKLEFcJ97Etx0pdEfVI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1670255995; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=0jeaGZv0Hzfrv7zLGvcbO/z3eedPimr2SDOTRFy+Dug=; 
        b=AshApFAwZWnxA/hs0EyF5hJe9b/vhgHB2PCKcVN+VLhpXKr6Irx6uIOVqcu3rf0kuTcHs0dy1zcVzfLZdBFmyluxxj50b7kBLmejSfbQGclbTkQeSd51TPqgYYBGyxHr2FMeCOduww/2ye0I9f4hdwzN/Nh5mAGbijJS4O1q8tw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1670255995;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=0jeaGZv0Hzfrv7zLGvcbO/z3eedPimr2SDOTRFy+Dug=;
        b=HsVtg30HP1bgTr/VwFkPcUOGhzTVVu1cQK71xcZm/3/VHcW5QampWsuleBa27Yl2
        WYDJH5Efmi1FNDq6ODJoeDX53NQkpZmP/PHqdT71UHUrp/qhKN9gomD16Kl351x+wB2
        Nm5Rcm9fN491Sz7diMbSQaVJawn6iWG70/WmYPz8=
Received: from edelgard.fodlan.icenowy.me (120.85.99.143 [120.85.99.143]) by mx.zohomail.com
        with SMTPS id 1670255993421842.6596337900735; Mon, 5 Dec 2022 07:59:53 -0800 (PST)
Message-ID: <879345cd8609cddccbf7bcf230923139af320b17.camel@icenowy.me>
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
Date:   Mon, 05 Dec 2022 23:59:44 +0800
In-Reply-To: <Y44IoC765yztZ6VF@wendy>
References: <20221121041757.418645-3-uwu@icenowy.me>
         <98005150-83a7-5439-0db1-d93d459c3809@linaro.org>
         <b924d37d716fa8b1fd93102b1d51fac221f43d59.camel@icenowy.me>
         <d0f3ce4f-5676-f5e1-f04f-dd069679b2d3@linaro.org>
         <81C2234E-C92D-4F78-8295-7C6DD0A9BBC4@icenowy.me>
         <20221130181330.GA2544489-robh@kernel.org> <Y4j+Gpptk3NAFBNV@spud>
         <4ad56fa249a30167844abcedac53d198606511d8.camel@icenowy.me>
         <Y43Jt3YOSbFyh954@wendy>
         <75a3ef9a175b16c46b57b2829ecbe4f97737de8a.camel@icenowy.me>
         <Y44IoC765yztZ6VF@wendy>
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

=E5=9C=A8 2022-12-05=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 15:05 +0000=EF=BC=
=8CConor Dooley=E5=86=99=E9=81=93=EF=BC=9A
> On Mon, Dec 05, 2022 at 07:03:17PM +0800, Icenowy Zheng wrote:
> > =E5=9C=A8 2022-12-05=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 10:36 +0000=EF=
=BC=8CConor Dooley=E5=86=99=E9=81=93=EF=BC=9A
>=20
> > > You lot all know the situation here a lot more than I do...
> > > I don't think "letting" people use the bare "thead,c900-foo"
> > > makes
> > > much
> > > sense as it gives us no chance to deal with quirks down the line.
> >=20
> > Well, after rechecking the manual, I found it possible to handle
> > quirks
> > -- T-Head has a custom "mcpuid" CSR (@ RISC-V CSR 0xFC0), which can
> > be
> > used to retrieve some identification info of the core, including
> > its
> > model ID, version, etc; and the T-Head PLIC/CLINT are part of their
> > C906 SoC design that there's another "mapbaddr" CSR that could be
> > used
> > to retrieve the base address of them.
> >=20
> > So I think it okay to just use "thead,c900-clint" here, and when
> > necessary, try to retrieve mcpuid for dealing with quirks.
>=20
> I'm not super sure I follow. What's the relevance of "mapbaddr" here?
> We've got a reg property, so I don't think we need "mapbaddr"?

Yes, it's not relevant to us here, it's only to prove that PLIC/CLINT
is part of C906 "Core Complex".

>=20
> For "mcpuid", can you be sure that implementers will not omit setting
> that value to something unique? I'd be happier if we were overly
> clear
> now rather than have some headaches later. Have I missed something?

These values are set by T-Head instead of individual SoC implementers
as a CPU CSR, and it's not for uniqueness, but it's for identification
of the CPU core revision (thus the PLIC/CLINT that come with it).

>=20
> > > I don't think that using "thead,openc906-clint", "thead,c900-
> > > clint"
> > > makes all that much sense either, in case someone does something
> > > wacky
> > > with the open-source version of the core.
> > >=20
> > > That leaves us with either:
> > > "vendor,soc-clint", "thead,openc906-clint", "thead,c900-clint"
> > > or:
> > > "vendor,soc-clint", "thead,c900-clint"
> > > right?
> > >=20
> > > The first one seems like possibly the better option as you'd
> > > kinda
> > > expect that, in a perfect word, all of the open-source IP
> > > implementations would share quirks etc?
>=20

