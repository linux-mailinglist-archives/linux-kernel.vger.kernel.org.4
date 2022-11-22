Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F29D6335C9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 08:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbiKVHSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 02:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiKVHSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 02:18:47 -0500
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B09B29818;
        Mon, 21 Nov 2022 23:18:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1669101514; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=JJyCwxsJ/i+ixev69VwzYTiV2wuJNJgtT9F6BL9qltFU7wJVa5wR7HW4ZVlJli/gNzaBboU8/Ru7AGRwZKtgKOO0aOTqYxAiF9oFMyEcX/vEFBNzSZyO3NdXyamWzL2Px7hJAPT6Mk+pKb3r8vq5+Gq6dsuUWWgszGu8rCxIf1o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1669101514; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=81+xlIqsl8cG7bxBR3sGfI5lOeqiGbfvoGg16RAnG2s=; 
        b=eguW4huBwt6/N2Z1PQbnRf3Yo91Bt7nQcBQZSRrrFb418mZsL7/yxDCKc1vMJPLQ8Vfe0+3Dy8mAHrbjX+82HY8G83th0xlBJ+TxrkW34AZn9f6ikCJn38m2uq+E/pEVnCFPW3X6SRq1xouUSdcIV7Ne/50OA/TbWf7/JbFKGz8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1669101514;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=81+xlIqsl8cG7bxBR3sGfI5lOeqiGbfvoGg16RAnG2s=;
        b=TKklBAFP9bWoQfIdfM5vWo5gJ/CCV03rQBLVxX9Zoz0Kp3tcs5laeWU5lT709bgu
        bgDlofypXi71ALPVQMbFDSKSwlYa0hrzARem+Dhx9ZIRceQcMxMjcU3CTkNLhDRrEFf
        mNZVrkQ8aiK/1Ozcaoh+8mNLJVKcsAgbTamcx9V8=
Received: from edelgard.fodlan.icenowy.me (112.94.100.29 [112.94.100.29]) by mx.zohomail.com
        with SMTPS id 1669101513524595.8333664570052; Mon, 21 Nov 2022 23:18:33 -0800 (PST)
Message-ID: <b924d37d716fa8b1fd93102b1d51fac221f43d59.camel@icenowy.me>
Subject: Re: [PATCH 2/3] dt-bindings: timer: sifive,clint: add compatible
 for OpenC906
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Date:   Tue, 22 Nov 2022 15:18:28 +0800
In-Reply-To: <98005150-83a7-5439-0db1-d93d459c3809@linaro.org>
References: <20221121041757.418645-1-uwu@icenowy.me>
         <20221121041757.418645-3-uwu@icenowy.me>
         <98005150-83a7-5439-0db1-d93d459c3809@linaro.org>
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

=E5=9C=A8 2022-11-21=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 11:06 +0100=EF=BC=
=8CKrzysztof Kozlowski=E5=86=99=E9=81=93=EF=BC=9A
> On 21/11/2022 05:17, Icenowy Zheng wrote:
> > T-Head OpenC906 is a open-source-licensed fixed-configuration of
> > C906,
> > which is now public and able to be integrated.
> >=20
> > Add a compatible for the CLINT shipped as part of OpenC906, which
> > should
> > just be ordinary C9xx CLINT.
> >=20
> > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > ---
> > =C2=A0Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
> > =C2=A01 file changed, 1 insertion(+)
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > index aada6957216c..86703e995e31 100644
> > --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > @@ -35,6 +35,7 @@ properties:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: s=
ifive,clint0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - items:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - enum:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 - thead,openc906-clint
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 - allwinner,sun20i-d1-clint
>=20
> Add entries sorted alphabetically. This should be squashed with
> previous
> patch.

I make it a seperated patch because I think it's a questionable
approach.

If you think it's okay, I will just squash it and put it as the second
patch in the next iteration, with adding openc906-plic as the first
one.

>=20
> Best regards,
> Krzysztof
>=20

