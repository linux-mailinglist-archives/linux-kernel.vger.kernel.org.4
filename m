Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B750635D12
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 13:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235935AbiKWMjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 07:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235777AbiKWMja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 07:39:30 -0500
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C4D65850
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 04:39:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1669207143; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=ikEiYeHuptVDuqrf0mTh4ZCwfw+gCxpPKR+0ZP72uK5BCWIbdxOpJ7nJscVwM2M5XHjsG9EUSxja5MyK9RGnWq5BXKlz2H5DlVPphOuecUHSfHIQAOYa/dac5uwPob0gKjFj+faKcyBeuxXjNoNQHEbQ4Or4GAP6VwRNFtv6dvc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1669207143; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=s9PPGCpeJg603JwEoPuSbAcaz9zus2eoJM9ERQFOsvw=; 
        b=e2vxqdbJyy6tbN0/17QWTmp/lnS4USAj1OlF7MUN6tCBcv1/e2mBNjwPwqujZ2ASafClJT3dyvWZC9XlaA2hXBFmaPekNc4NUYNCiClXwK8PJf8ZKD4ft03MSMYSNDXVCXiWdjnJr8CPvDLy5hvwEZg1N3oMZqm7TDL55Sxucjo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1669207143;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=s9PPGCpeJg603JwEoPuSbAcaz9zus2eoJM9ERQFOsvw=;
        b=ZKHhqsxgPF95Y3GJOiZLgVhq+j7w8SfzEzRp30NyXrtjHxe027arWHJDFzQKoUnO
        hpLGJFDf9+5Stiwl3FPOQQ/NjA4ZPUmH2AOlPP5v6KQxcu3nkPWyo56JBbOjiNRKNRy
        HF3QyU+lfXKWbW9PFddxLXx9Erifg94dCkMb7Bdc=
Received: from edelgard.fodlan.icenowy.me (112.94.103.239 [112.94.103.239]) by mx.zohomail.com
        with SMTPS id 1669207140839317.13150239847846; Wed, 23 Nov 2022 04:39:00 -0800 (PST)
Message-ID: <16d01eebc1693916fc74e1e75458d6c0f080cf37.camel@icenowy.me>
Subject: Re: [PATCH] irqchip/sifive-plic: drop quirk for two-cell variant
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Date:   Wed, 23 Nov 2022 20:38:56 +0800
In-Reply-To: <86o7syoq4t.wl-maz@kernel.org>
References: <20221121042026.419383-1-uwu@icenowy.me>
         <86o7syoq4t.wl-maz@kernel.org>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2022-11-22=E6=98=9F=E6=9C=9F=E4=BA=8C=E7=9A=84 17:28 +0000=EF=BC=
=8CMarc Zyngier=E5=86=99=E9=81=93=EF=BC=9A
> On Mon, 21 Nov 2022 04:20:26 +0000,
> Icenowy Zheng <uwu@icenowy.me> wrote:
> >=20
> > As the special handling of edge-triggered interrupts are defined in
> > the
> > PLIC spec, we can assume it's not a quirk, but a feature of the
> > PLIC
> > spec; thus making it a quirk and use quirk-based codepath is not so
> > necessary.
>=20
> It *is* necessary.
>=20
> >=20
> > Move to a #interrupt-cells-based practice which will allow both
> > device
> > trees without interrupt flags and with interrupt flags work for all
> > compatible strings.
>=20
> No. You're tying together two unrelated concepts:
>=20
> - Edges get dropped in some implementations (and only some). You can
> =C2=A0 argue that the architecture allows it, but I see it is an
> =C2=A0 implementation bug.

As the specification allows it, it's not an implementation bug -- and
for those which do not show this problem, it's possible that it's just
all using the same trigger type (e.g. Rocket).

>=20
> - The need for expressing additional information in the interrupt
> =C2=A0 specifier is not necessarily related to the above. Other interrupt
> =C2=A0 controllers use extra cells to encode the interrupt affinity, for
> =C2=A0 example.

I think in these situations, if the interrupt controller does not
contain any special handling for edge interrupts, we can just describe
them as level ones in SW.

>=20
> I want these two things to be kept separate. Otherwise, once we get
> some fancy ACPI support for RISCV (no, please...), we'll have to redo
> the whole thing...
>=20
> > In addition, this addresses a stable version DT binding violation -
> > -
> > Linux v5.19 comes with "thead,c900-plic" with #interrupt-cells
> > defined to
> > be 1 instead of 2, this commit will allow DTs that complies to
> > Linux
> > v5.19 binding work (although no such DT is devliered to the public
> > now).
>=20
> *That* is what should get fixed.

Supporting all stable versions' DT binding is our promise, I think.

>=20
> Thanks,
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0M.
>=20

