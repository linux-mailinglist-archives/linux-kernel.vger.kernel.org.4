Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A675A749AB1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 13:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjGFLdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 07:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjGFLdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:33:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A23AA;
        Thu,  6 Jul 2023 04:33:10 -0700 (PDT)
Received: from [IPv6:2a00:23c8:b70a:ae01:35d0:8e34:613c:c44e] (unknown [IPv6:2a00:23c8:b70a:ae01:35d0:8e34:613c:c44e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B0B466602242;
        Thu,  6 Jul 2023 12:33:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688643188;
        bh=l5+LL5sG+6oNk98vidsTUD1ZT1xF0tRZN4EIfi2Jzz8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KInwh3I9qZsDTaBRQW8F/t2QGDZ/ofjWuirTgSfnjvf1QBmRrbOhTjY3xbvIQSbpX
         Pit1IhOCJ2snhlQMmw0aDhv+7mrD/F8ov/0fLaHolXyNQmXdP1Oz7wjPeNxtDucp9A
         bssu7N7XnEgKC2b/y3ocQaS6HS8MwwCz5W4FdpPBBNo/KxmkXtq3B7u6EBtuDgaCGC
         B+ft4lFfJSpFsvqJkhNQ5BS0KMpucyYCvZjkvObuLrJcpWi1VI2c+QtHWVjutoWLHq
         uetic+AXTYY95fYRBXaW9giOQPHdJAf1A1tr/NgWWHrTnHbldG02pyk9wGhQ8lKBGe
         x/XNpt32UQfGg==
Message-ID: <7fa80568e37cca3b8c4560e033cd2cfc18b2eb27.camel@collabora.com>
Subject: Re: [PATCH v1 3/3] arm64: dts: rockchip: Add Radxa ROCK 4SE
From:   Christopher Obbard <chris.obbard@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-rockchip@lists.infradead.org
Cc:     kernel@collabora.com, Andy Yan <andyshrk@163.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@edgeble.ai>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tianling Shen <cnsztl@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 06 Jul 2023 12:33:06 +0100
In-Reply-To: <b573535b-25f8-8986-3d5d-2e8d4b4c5ca1@linaro.org>
References: <20230705141011.111568-1-chris.obbard@collabora.com>
         <20230705141011.111568-4-chris.obbard@collabora.com>
         <b573535b-25f8-8986-3d5d-2e8d4b4c5ca1@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Wed, 2023-07-05 at 17:53 +0200, Krzysztof Kozlowski wrote:
> On 05/07/2023 16:10, Christopher Obbard wrote:
> > Add board-specific devicetree file for the RK3399T-based Radxa ROCK 4SE
> > board. This board offers similar peripherals in a similar form-factor t=
o
> > the existing ROCK Pi 4B but uses the cost-optimised RK3399T processor
> > (which has different OPP table than the RK3399) and other minimal hardw=
are
> > changes.
> >=20
> > Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
> > ---
> >=20
>=20
>=20
> > +
> > +&sdio0 {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0brcmf: wifi@1 {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0compatible =3D "brcm,bcm4329-fmac";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0reg =3D <1>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0interrupt-parent =3D <&gpio0>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0interrupts =3D <RK_PA3 GPIO_ACTIVE_HIGH>;
>=20
> I just send a patch to fix this in some files, so let's try keep it
> good. Use proper interrupt type, not none.

Thank you for your review. I missed that patch, sent only a few hours befor=
e mine. I will address this in v2.


Cheers!

Chris
