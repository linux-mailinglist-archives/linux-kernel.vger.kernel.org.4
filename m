Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6996FE49F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 21:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbjEJTvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 15:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjEJTvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 15:51:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814961FEA;
        Wed, 10 May 2023 12:51:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1728863E3E;
        Wed, 10 May 2023 19:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64FFC4339B;
        Wed, 10 May 2023 19:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683748274;
        bh=7bUSAhKpxskdimbeYDKvEahdeeVYQrECQTbrX4qEd/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Od+cSLkONolIsZ/B8afsiOQ3amhPIR6LxmdyzQpLoEyQjCELMe5lj+sm00afrjlhJ
         xMzdFbW0D5gFhmdVtRL9lxnwaTGyDywPZCuwpSY9xogCKLVKohzx6Vk6IJNAuzvCrX
         TWkE8/ymri3fjXWdx9l7owFH/LmmeRWtAM47lyT+sjahuVtdo3T6mpVyXc7NFZ5vkh
         B0W2ak/hLi2YdMJrbKy/HwajAM0nxjxDylSukFymW5sYhe1MqGcHWMZs+sYXYHXH5z
         Tqf/fZ/PfVBAiqICtkwgCpa9H6VhlO3XUxQtKv1xXp5Nen4DSiR4Y9qE1OJlEU6PE7
         GQD+mXohQNdWA==
Date:   Wed, 10 May 2023 20:51:09 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 1/5] dt-bindings: power: Add JH7110 AON PMU support
Message-ID: <20230510-city-scarf-023705d3c96a@spud>
References: <20230510015311.27505-1-changhuang.liang@starfivetech.com>
 <20230510015311.27505-2-changhuang.liang@starfivetech.com>
 <20230510-cloning-clapping-e262f00a94e8@wendy>
 <d80646ae-cf1b-234a-261c-3753f6cc9080@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fQeNr7bxBo25KDoY"
Content-Disposition: inline
In-Reply-To: <d80646ae-cf1b-234a-261c-3753f6cc9080@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fQeNr7bxBo25KDoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2023 at 03:20:14PM +0800, Changhuang Liang wrote:
> On 2023/5/10 15:06, Conor Dooley wrote:
> > On Tue, May 09, 2023 at 06:53:07PM -0700, Changhuang Liang wrote:
> >> +          - starfive,jh7110-pmu
> >> +      - items:
> >> +          - enum:
> >> +              - starfive,jh7110-aon-syscon
> >> +          - const: syscon
> >=20
> > Unfortunately, this is not what was wanted.
> > This syscon, of which power domain control is just one of the things th=
at
> > it can do, should be documented in
> > Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.y=
aml
> > alongside it's brethern "starfive,jh7110-sys-syscon" &
> > "starfive,jh7110-stg-syscon".
> >=20
>=20
> That means that I don't need to modify this original yaml file?=20

Does "this original" mean starfive,jh7100-pmu.yaml?
If so then...

> I just need to move current changes in this patch into=20
> "Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.ya=
ml"?

Correct.
It makes most sense for that binding, as it depends on the pll binding
(because it has a ref: to it), to go through the clock tree in Xingyu's
series.
I'll apply the driver changes once the binding has been applied.

Thanks,
Conor.

--fQeNr7bxBo25KDoY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFv1rQAKCRB4tDGHoIJi
0oYyAQCGubBPJUQ0rlBa+2muFZjPfG28PJMjy3hMLvMv8RYgQQEAmrsHqJXlTeET
FVB5kflykqAdT4t7yknJPIkEyY6uBA8=
=EzDq
-----END PGP SIGNATURE-----

--fQeNr7bxBo25KDoY--
