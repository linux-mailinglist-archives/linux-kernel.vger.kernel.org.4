Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE2B65752A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 11:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbiL1KKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 05:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbiL1KJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 05:09:42 -0500
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21011144C;
        Wed, 28 Dec 2022 02:08:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1672222100; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=DR7EU7XZmfJBsV2/fzc+7dKvSMdtHaD/bwPhesW4sa4eMih2Y1Ph9CuNLETSurqR8o2Ai6hOwQbyTn+dVXGTxCAmEjcFzH446+Kx80SWfo+VJgw2Hc2Dg39mjyAyzs6lLXkFGOca1Pk+IwAw4sCFetUMl2RL9gpfk1jH9P91ZuI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1672222100; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=6RIh+iAefWxFs9a9psv5C07vlRmV2frNtjn4+K4G0VM=; 
        b=BKs3u9KWDNUajiU+Op2bpOgXKzEeCIjYwETWhAV87+4/RT9u1qFGzgjWW9JQ/Wo2a/bJfd/XaZo0xtNWpHxuUUFfZM9GIb7US8g1ORsYQlC+l8FIAmFvaNvJN/AxPMCT/JinzJ1Wagm/qN15itYSSgINEo9C1Io8cDRrWRq2Lzw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1672222100;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=6RIh+iAefWxFs9a9psv5C07vlRmV2frNtjn4+K4G0VM=;
        b=F8u11A+Qt19bpek999EarlNKxkoaqLgAYN38B8vxF24KC138yn43JyPyf+oG0LGf
        IkDuB71tnIwS34asv4r4AZoW4TJA+AYc3Ns8A45xmR+6YNL20rDeLZFyw55jq9kjkoL
        /B09D9UzudyRmbuS+XujDxBHHuSD+EknYGBfNkcU=
Received: from edelgard.fodlan.icenowy.me (120.85.99.39 [120.85.99.39]) by mx.zohomail.com
        with SMTPS id 1672222099827577.0094574854984; Wed, 28 Dec 2022 02:08:19 -0800 (PST)
Message-ID: <ef20a7dfa027f1a5a24a515e347af10c06a4da85.camel@icenowy.me>
Subject: Re: [PATCH v1 01/11] dt-bindings: usb: Add device id for Genesys
 Logic hub controller
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Anand Moon <linux.amoon@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 28 Dec 2022 18:08:15 +0800
In-Reply-To: <20221228100321.15949-2-linux.amoon@gmail.com>
References: <20221228100321.15949-1-linux.amoon@gmail.com>
         <20221228100321.15949-2-linux.amoon@gmail.com>
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

=E5=9C=A8 2022-12-28=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 10:03 +0000=EF=BC=
=8CAnand Moon=E5=86=99=E9=81=93=EF=BC=9A
> Add usb hub device id for Genesys Logic, Inc. GL852G-OHG Hub USB 2.0
> root hub and Genesys Logic, Inc. GL3523-QFN76 USB 3.1 root hub.
>=20
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> =C2=A0Documentation/devicetree/bindings/usb/genesys,gl850g.yaml | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git
> a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> index a9f831448cca..db009f3ef438 100644
> --- a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> +++ b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> @@ -16,6 +16,8 @@ properties:
> =C2=A0=C2=A0 compatible:
> =C2=A0=C2=A0=C2=A0=C2=A0 enum:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - usb5e3,608
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - genesys,usb5e3,610
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - genesys,usb5e3,620

I don't think genesys, is needed here because usb5e3 means USB VID
0x05e3, which is already linked to Genesys Logic.

In addition, the control logic of these two hubs are needed to be
verified.

And what's the status of the companion hub of the USB3 hub? Is it
really a USB3-only hub, or is its USB2 part just equal to another USB3
hub?

> =C2=A0
> =C2=A0=C2=A0 reg: true
> =C2=A0

