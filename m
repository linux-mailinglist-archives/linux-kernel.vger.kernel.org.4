Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269887222B1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 11:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjFEJy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 05:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjFEJy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 05:54:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AD1F9;
        Mon,  5 Jun 2023 02:54:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C8AE6101C;
        Mon,  5 Jun 2023 09:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1332DC433D2;
        Mon,  5 Jun 2023 09:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685958893;
        bh=Ry2SkmA+K00RMMRxzGwH6nLi2ayMp2/LpHhS6bn9nV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=toHpX+gklKJh1L5yc2c/GTNVoNN+0VS1HrIpySdQra3F3OzY8AJ6Xor8gOOt6uxoX
         VZg5XtlZ+nEjaHNz9MgW7ZIBgcuZy/7+tibEQtNanNrxtZg+jyYTdMmFrfys1GvU1M
         J9HIqPU3Fg2PLyA64MUSbFEGMPPNH0YfSTISRbmvCWIT5e6eefeylQt1ojeVGhSgIG
         vzA9hAqoqVhytIL8oLgK5KG+b3o6C7R7uk5DgljkKUtBYcJ1kDNqsrPrDcg9Gp9+fR
         74shnODvYY4j2YyxCWzrly366sni8imCjoWiqkaiB7bD3gYHalmUBd7J2+Yg50EF3p
         9SStQpDrE699g==
Date:   Mon, 5 Jun 2023 10:54:47 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Mason Huo <mason.huo@starfivetech.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shengyu Qu <wiagn233@outlook.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 0/3] Add JH7110 cpufreq support
Message-ID: <20230605-strive-caddie-e570c6c4f958@spud>
References: <20230421031431.23010-1-mason.huo@starfivetech.com>
 <457c35b5-aec4-1147-673f-947052b5f944@starfivetech.com>
 <20230505-gusty-corset-e451d947c10d@wendy>
 <c5bde0d92d514250a21120ed33e0f6b2@EXMBX067.cuchost.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PLgiS43f5xmwF/2A"
Content-Disposition: inline
In-Reply-To: <c5bde0d92d514250a21120ed33e0f6b2@EXMBX067.cuchost.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PLgiS43f5xmwF/2A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 05, 2023 at 09:36:51AM +0000, Mason Huo wrote:
> > On Fri, May 05, 2023 at 09:38:38AM +0800, Mason Huo wrote:

> >> Thanks for your review, and is there any comments about these v3 patch=
es?
>=20
> > Firstly there appears to have been some mess-up with the driver/bindings
> > for 1/3, so I am waiting to see if the binding gets reverted before
> > doing anything and secondly it's the merge window so I can't do anything
> > about 3/3 until next week.

> Could you help to check if this patch can be moved on?

The dependencies are in, I guess when I went checking through things on
patchwork after the merge window I spotted some issue & didn't reply to
the patch. So sorry about that.

The issue that I must've spotted is that patch 1/3 doesn't pass
dtbs_check:

arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.2a.dtb: pmic@3=
6: 'interrupts' is a required property
        From schema: Documentation/devicetree/bindings/mfd/x-powers,axp152.=
yaml
arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.2a.dtb: pmic@3=
6: '#interrupt-cells' is a required property
        From schema: Documentation/devicetree/bindings/mfd/x-powers,axp152.=
yaml
arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.2a.dtb: pmic@3=
6: 'interrupt-controller' is a required property
        From schema: Documentation/devicetree/bindings/mfd/x-powers,axp152.=
yaml
arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.3b.dtb: pmic@3=
6: 'interrupts' is a required property
        From schema: Documentation/devicetree/bindings/mfd/x-powers,axp152.=
yaml
arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.3b.dtb: pmic@3=
6: '#interrupt-cells' is a required property
        From schema: Documentation/devicetree/bindings/mfd/x-powers,axp152.=
yaml
arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.3b.dtb: pmic@3=
6: 'interrupt-controller' is a required property
        From schema: Documentation/devicetree/bindings/mfd/x-powers,axp152.=
yaml

Could you please fix that up & resend the 2 unapplied patches?

Cheers,
Conor.

--PLgiS43f5xmwF/2A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZH2w5wAKCRB4tDGHoIJi
0pk3AP98k50f8b6t8gc+CLxz5l794W8A1lozutZce8eNutCddwD/ZWLXNAoLg/aP
o8umGak3dTZZlLPTKRbxJal+Dq/i+AU=
=vA5j
-----END PGP SIGNATURE-----

--PLgiS43f5xmwF/2A--
