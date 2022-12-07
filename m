Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8EB645821
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 11:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiLGKr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 05:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLGKry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 05:47:54 -0500
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com [136.143.188.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F60824BF1;
        Wed,  7 Dec 2022 02:47:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1670410055; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=mBtk1g3a7Q1rismQYQWGRJkcALrsuKhh4yvLL8CeyRqRdk9enQD2KRoOeJMpeJlrg927BvWeMyyJr5aGsw5VWpi8ji/iq5V6D8sDQp4c6qe8GIlNH7gkf83pwkNf48nU3kCmq8Xn2EQKChN9s6Nsr0Eh3OV+SX4dzaTPCnBgr5Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1670410055; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=1JCTlL48DT3zfL4rO5+nUh4+FmToPbXqE2w5MYGFziQ=; 
        b=I86dJHbw6Gg+WK9G7fEtSjh9xf5/Q5BKzAGMPfh249ALQQn417It3xum7gcsUwamh+NoA2FZ4Exkysnhlzs1/Lu/fIHJHWPHzYMZerRlp9yv9QxvKkX+8cnxlAljDlM3ReDUf5+Pv8JUQcH89xD59w2LoTW9mdO2DUS0L14mEeA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1670410055;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=1JCTlL48DT3zfL4rO5+nUh4+FmToPbXqE2w5MYGFziQ=;
        b=evjAeK9ZnmkLF9u2/Jh/+ayHl4FANQIIndJCGtwgRpNkPApxo2x5OTrg+lI7cW/0
        RX992Lx+SjGoY1R4Xhxp3cVMrBHZ6ycoJLHQQuEODfWgne0mEzLRJqAirLW5lyCh8oB
        1IupoqBpExbx7iZgQXVwSF5DzeoJq1jwvSXgNAIo=
Received: from edelgard.fodlan.icenowy.me (120.85.99.143 [120.85.99.143]) by mx.zohomail.com
        with SMTPS id 1670410054297195.35225821177994; Wed, 7 Dec 2022 02:47:34 -0800 (PST)
Message-ID: <34fe4161718e395f5e9890f9358a25f697af9e24.camel@icenowy.me>
Subject: Re: [PATCH 1/3] dt-bindings: timer: sifive,clint: add comaptibles
 for T-Head's C9xx
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Date:   Wed, 07 Dec 2022 18:47:26 +0800
In-Reply-To: <20221121041757.418645-2-uwu@icenowy.me>
References: <20221121041757.418645-1-uwu@icenowy.me>
         <20221121041757.418645-2-uwu@icenowy.me>
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

=E5=9C=A8 2022-11-21=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 12:17 +0800=EF=BC=
=8CIcenowy Zheng=E5=86=99=E9=81=93=EF=BC=9A
> T-Head C906/C910 CLINT is not compliant to SiFive ones (and even not
> compliant to the newcoming ACLINT spec) because of lack of mtime
> register.
>=20
> Add a compatible string formatted like the C9xx-specific PLIC
> compatible, and do not allow a SiFive one as fallback because they're
> not really compliant.
>=20
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>

Hi, could this patch be picked ASAP? Becuase it will be used then in
further OpenSBI patches to enable proper operation of T-Head timer.

I know the following 2 patches are in doubt and further rework for them
are needed.

> ---
> =C2=A0Documentation/devicetree/bindings/timer/sifive,clint.yaml | 8
> ++++++++
> =C2=A01 file changed, 8 insertions(+)
>=20
> diff --git
> a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> index bbad24165837..aada6957216c 100644
> --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> @@ -20,6 +20,10 @@ description:
> =C2=A0=C2=A0 property of "/cpus" DT node. The "timebase-frequency" DT pro=
perty
> is
> =C2=A0=C2=A0 described in Documentation/devicetree/bindings/riscv/cpus.ya=
ml
> =C2=A0
> +=C2=A0 T-Head C906/C910 CPU cores include an implementation of CLINT too=
,
> however
> +=C2=A0 their implementation lacks a memory-mapped MTIME register, thus
> not
> +=C2=A0 compatible with SiFive ones.
> +
> =C2=A0properties:
> =C2=A0=C2=A0 compatible:
> =C2=A0=C2=A0=C2=A0=C2=A0 oneOf:
> @@ -29,6 +33,10 @@ properties:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 - starfive,jh7100-clint
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 - canaan,k210-clint
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: sif=
ive,clint0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - items:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - enum:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 - allwinner,sun20i-d1-clint
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: thead,c9=
00-clint
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - items:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: sif=
ive,clint0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: ris=
cv,clint0

