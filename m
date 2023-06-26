Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DEF73E40A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjFZP7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjFZP7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:59:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BA791;
        Mon, 26 Jun 2023 08:59:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26EBE60EE9;
        Mon, 26 Jun 2023 15:59:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FABC433C0;
        Mon, 26 Jun 2023 15:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687795170;
        bh=IQy0+rnLS6uTBv0EQVvmuZ3y+QP3gsARAmLkqk/b4kE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WChK07gxHxlkUAdHaQUuFSKrcSq/wooKcOZN4Wqo3r/R5VqR9Y5jOOllsGShR0FmV
         rvb7pRAQgTv27O7QSwY9a+xH1eSa5+h7R6IRK+R/KJC+e3jbxn4U0LvI9K+ccniiXJ
         bw2YN8wOjOo5mTQfpaSauX2wyOzESZNHnKmkLRTFglpnRxpLCW/SjAbYnL7cGpaEsA
         OT63iUOndvI02HzYaWOeecNHb5QagjWadjZ75y2gvemNz4JdRxPLJzk050Hx7iNjg9
         P96esRBXLMsJFnV0BKdzBnlSlH72d+5Y5ZYoN106gzSSv2dpOpkLnuTREEpC2OCmI8
         au1letHwjKsWA==
Date:   Mon, 26 Jun 2023 16:59:25 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>, palmer@dabbelt.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Evan Green <evan@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/9] RISC-V: shunt isa_ext_arr to cpufeature.c
Message-ID: <20230626-aged-premiere-5b68eb51d6e1@spud>
References: <20230626-provable-angrily-81760e8c3cc6@wendy>
 <20230626-endowment-crave-d72f9423c5b3@wendy>
 <20230626-79b06f642aa2996098c9353d@orel>
 <20230626-2b8f42ace039368c8e917393@orel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XxbStqRRvISDqh90"
Content-Disposition: inline
In-Reply-To: <20230626-2b8f42ace039368c8e917393@orel>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XxbStqRRvISDqh90
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2023 at 05:44:18PM +0200, Andrew Jones wrote:
> On Mon, Jun 26, 2023 at 05:29:04PM +0200, Andrew Jones wrote:
> > On Mon, Jun 26, 2023 at 12:19:41PM +0100, Conor Dooley wrote:
> ...
> > > +const struct riscv_isa_ext_data riscv_isa_ext[] =3D {
> > > +	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
> > > +	__RISCV_ISA_EXT_DATA(zicboz, RISCV_ISA_EXT_ZICBOZ),
> > > +	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
> > > +	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
> > > +	__RISCV_ISA_EXT_DATA(zifencei, RISCV_ISA_EXT_ZIFENCEI),
> > > +	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
> > > +	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
> > > +	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
> > > +	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
> > > +	__RISCV_ISA_EXT_DATA(zbs, RISCV_ISA_EXT_ZBS),
> > > +	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
> > > +	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
> > > +	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> > > +	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
> > > +	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
> > > +	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
> > > +	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> > > +	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
> >=20
> > I think we can either drop this null entry or drop the count variable
> > below. My preference would be to drop the count variable, and always
> > loop to the null.
>=20
> Eh, never mind, the entry isn't null, it's "". Why do we have that entry
> though? I guess it can be dropped?

It may just be cargo culting? The commit that added this, a9b202606c69
("RISC-V: Improve /proc/cpuinfo output for ISA extensions") [1], added
an empty array other than this element & perhaps it was just not removed
when real entries were added? Symptom of adding a feature without an
actual user (multiletter extension) perhaps?

1 - https://lore.kernel.org/all/20220314203845.832648-1-atishp@rivosinc.com/

--XxbStqRRvISDqh90
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJm13QAKCRB4tDGHoIJi
0pu9AQDZP8p3Xqaor1zTCjruaNDsJup5DON/khS7K0xbZqYG6wEAgFvgKH1mc5D1
E6+fR9GyMlWaoQwnXMURKfrjzO9ahwI=
=MFMy
-----END PGP SIGNATURE-----

--XxbStqRRvISDqh90--
