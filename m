Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE70643BF6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 04:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiLFDqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 22:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiLFDqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 22:46:37 -0500
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com [136.143.188.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579011CB36;
        Mon,  5 Dec 2022 19:46:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1670298379; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=XC1UtjX2LLN1wAhTAqR5lvBlUxFgjtWEMAQyx2b9p6kSpOhiItVdMNXvHaEVpT0HOAAGCS5ZFsAYZi4nwXqy2HRnyWkd1fPL2cS4fjRMrpnICM6+X2KkLS/ksdpUJahre6Ie/NNZTx72s0SA0hoz3BjSWEBQSMqYxsgybbyB7yo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1670298379; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=oesidm6oUL1/85Jw3P7QodTJlckej5INKkfVuimasjg=; 
        b=jihNKGTkRAVr9FFtiB6P2JEC2+wzh8uLH3HGnJ4a7mlpGpQCpg0d/Egp8N07huO3dmEYYIRkaWIN2kKmSn2IM+mF8T5GmsoOri2eMH7zbQyUULA89kEs1tMo6rrt0SZPRXCpggymKpocHu7f/xyNKT2cEwprrVBQuWr0e5dVrKU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1670298379;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=oesidm6oUL1/85Jw3P7QodTJlckej5INKkfVuimasjg=;
        b=OXlSY7t2/CNoPLhrqQlD65eqb8fkTZE/AimZRkiRLKq9/0EPw2FKwzlLwvpz5c+9
        TDMkqiazGAVaS2yt0znyMD2bpTOfwqs5FsO7mEn7482h+hitrGHDEqsbJU+d4Zo8xyR
        Vr+aRXwFjAKmHya2tCfvS/U4YGImhAy0bJVmImVA=
Received: from edelgard.fodlan.icenowy.me (120.85.99.143 [120.85.99.143]) by mx.zohomail.com
        with SMTPS id 1670298376821248.54157344971338; Mon, 5 Dec 2022 19:46:16 -0800 (PST)
Message-ID: <86d822f73f6e61c9f286e800db50e9959aef05a0.camel@icenowy.me>
Subject: Re: [PATCH 2/3] dt-bindings: timer: sifive,clint: add compatible
 for OpenC906
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Conor Dooley <conor@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     Rob Herring <robh@kernel.org>,
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
Date:   Tue, 06 Dec 2022 11:46:11 +0800
In-Reply-To: <B1B2FC9D-D971-435B-A9FD-B092DE726367@kernel.org>
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
         <879345cd8609cddccbf7bcf230923139af320b17.camel@icenowy.me>
         <B1B2FC9D-D971-435B-A9FD-B092DE726367@kernel.org>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2022-12-05=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 16:54 +0000=EF=BC=
=8CConor Dooley=E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
> On 5 December 2022 15:59:44 GMT, Icenowy Zheng <uwu@icenowy.me>
> wrote:
> > =E5=9C=A8 2022-12-05=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 15:05 +0000=EF=
=BC=8CConor Dooley=E5=86=99=E9=81=93=EF=BC=9A
> > > On Mon, Dec 05, 2022 at 07:03:17PM +0800, Icenowy Zheng wrote:
> > > > =E5=9C=A8 2022-12-05=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 10:36 +000=
0=EF=BC=8CConor Dooley=E5=86=99=E9=81=93=EF=BC=9A
> > >=20
> > > > > You lot all know the situation here a lot more than I do...
> > > > > I don't think "letting" people use the bare "thead,c900-foo"
> > > > > makes
> > > > > much
> > > > > sense as it gives us no chance to deal with quirks down the
> > > > > line.
> > > >=20
> > > > Well, after rechecking the manual, I found it possible to
> > > > handle
> > > > quirks
> > > > -- T-Head has a custom "mcpuid" CSR (@ RISC-V CSR 0xFC0), which
> > > > can
> > > > be
> > > > used to retrieve some identification info of the core,
> > > > including
> > > > its
> > > > model ID, version, etc; and the T-Head PLIC/CLINT are part of
> > > > their
> > > > C906 SoC design that there's another "mapbaddr" CSR that could
> > > > be
> > > > used
> > > > to retrieve the base address of them.
> > > >=20
> > > > So I think it okay to just use "thead,c900-clint" here, and
> > > > when
> > > > necessary, try to retrieve mcpuid for dealing with quirks.
> > >=20
> > > I'm not super sure I follow. What's the relevance of "mapbaddr"
> > > here?
> > > We've got a reg property, so I don't think we need "mapbaddr"?
> >=20
> > Yes, it's not relevant to us here, it's only to prove that
> > PLIC/CLINT
> > is part of C906 "Core Complex".
> >=20
> > >=20
> > > For "mcpuid", can you be sure that implementers will not omit
> > > setting
> > > that value to something unique? I'd be happier if we were overly
> > > clear
> > > now rather than have some headaches later. Have I missed
> > > something?
> >=20
> > These values are set by T-Head instead of individual SoC
> > implementers
> > as a CPU CSR, and it's not for uniqueness, but it's for
> > identification
> > of the CPU core revision (thus the PLIC/CLINT that come with it).
>=20
> I really am missing something here that must be obvious to you.
> Let me try and explain where my gap in understanding is.
> If someone takes the open cores & makes a minor tweak in the plic how
> does knowing mcpuid help us identify that that plic is marginally
> different?

No, but my point is that in this situation we shouldn't use C900
compatible at all because it's no longer the vanilla C900 cores.

My assumption is that the same IP cores are the same unless specially
customized.

>=20
> I must have missed something that should be apparent and look like an
> eejit right now!
>=20
> >=20
> > >=20
> > > > > I don't think that using "thead,openc906-clint", "thead,c900-
> > > > > clint"
> > > > > makes all that much sense either, in case someone does
> > > > > something
> > > > > wacky
> > > > > with the open-source version of the core.
> > > > >=20
> > > > > That leaves us with either:
> > > > > "vendor,soc-clint", "thead,openc906-clint", "thead,c900-
> > > > > clint"
> > > > > or:
> > > > > "vendor,soc-clint", "thead,c900-clint"
> > > > > right?
> > > > >=20
> > > > > The first one seems like possibly the better option as you'd
> > > > > kinda
> > > > > expect that, in a perfect word, all of the open-source IP
> > > > > implementations would share quirks etc?
> > >=20
> >=20

