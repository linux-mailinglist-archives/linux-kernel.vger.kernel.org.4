Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11649746098
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 18:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjGCQRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 12:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjGCQRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 12:17:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6842E42;
        Mon,  3 Jul 2023 09:17:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44DF560FB3;
        Mon,  3 Jul 2023 16:17:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8564C433C7;
        Mon,  3 Jul 2023 16:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688401066;
        bh=+Bq3JLFaUMp7p3qi8SQ1dlGHIw95+wCB4rs20s4VRW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hE8PSV7vCPY1sRrahmYRcyhHUDComDD9WUhrexjV8B+2CEmoIVgHKUtxgjOT0t+cB
         X2D5ZJ/N6dcVdlFQc1fHvftckHKLU6+NgQFSIXwXXlM0EnTbxKOyLwAZu5eC4EDEVC
         fjkk88htp6kmNvEFUJAT+fdMBSiZr2y2uZBsi+S5eknytQJMPx6MoyVznJtqJCeO3h
         z6i+3x7civpHfTe52ogtRMod0BGAWsnw0cwuhTcPZ1MKbvC7aO9dc9dozGBWpuaKOe
         2bXp/InTEwdnNqYk9YFgfdGgkD2hJc6M1SS9RIGgNsAKdzq7p5COjmriXueN1cztLA
         jYUHI3mt0YlKw==
Date:   Mon, 3 Jul 2023 17:17:41 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     palmer@dabbelt.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Evan Green <evan@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/11] RISC-V: shunt isa_ext_arr to cpufeature.c
Message-ID: <20230703-bronzing-declared-5d568cb47339@spud>
References: <20230703-repayment-vocalist-e4f3eeac2b2a@wendy>
 <20230703-steadying-skintight-d5b7c108551c@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Lh8iUyMcp5focI2k"
Content-Disposition: inline
In-Reply-To: <20230703-steadying-skintight-d5b7c108551c@wendy>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Lh8iUyMcp5focI2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 03, 2023 at 11:27:56AM +0100, Conor Dooley wrote:
> To facilitate using one struct to define extensions, rather than having
> several, shunt isa_ext_arr to cpufeature.c, where it will be used for
> probing extension presence also.
> As that scope of the array as widened, prefix it with riscv & drop the
> type from the variable name.
>=20
> Since the new array is const, print_isa() needs a wee bit of cleanup to
> avoid complaints about losing the const qualifier.
>=20
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

=46rom v(n-1) that I forgot:
Reviewed-by: Evan Green <evan@rivosinc.com>
https://lore.kernel.org/all/CALs-Hsu5yA7eBPOFQkmd94GR+15wuFkbYbYSg4RubmkdQD=
yi8g@mail.gmail.com/


--Lh8iUyMcp5focI2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKL0pQAKCRB4tDGHoIJi
0qgWAQCn/gTJHGIdLaZp94S5M6Qofeq/lQTJIbQxgUdoPPehwwEA7w1NKhjBffQw
RcGneVD3M9Hz23g411ZhT0AEAUM9ewY=
=h4pX
-----END PGP SIGNATURE-----

--Lh8iUyMcp5focI2k--
