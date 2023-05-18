Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40153708A2D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 23:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjERVKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 17:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjERVKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 17:10:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D7D19B;
        Thu, 18 May 2023 14:10:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A32E61592;
        Thu, 18 May 2023 21:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6D4C433D2;
        Thu, 18 May 2023 21:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684444205;
        bh=rP15fZhlGlpAVtM+tSyZm1fbiu8oJMW5yhdrl6OFl0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EycbRRdHL3BFEwJjyvQ8nbQl3XS3SafOoTIkex5ICB9mTapmGB9zuMqUUVQ0oGnOl
         Ao3F9nAzU2XK6uJ4p0XFNK/l/xck4/86Dhfj4WBc1ac4ba8cIo68SI61itWyo9a3Uw
         N7ShuI+S2hc9t6+zeG2NpOyUPGpYWZlRoUHClE+JyFAFp7bnbq3yzYZXqOhnwzYPIA
         ygvrvwZ5xHKmaYROjzdluN6284y9w4tTvvtnmDGbDVs1yi1ubAMs9NDyDUlp7dRfZe
         1XiWnXyVXYYtlT7Om2XaW+hgyToiJ1r/2vOusV3Osi9SiFIuuEQ3R0yT1foCQrQU5O
         2Ne4zCmJnp7QQ==
Date:   Thu, 18 May 2023 22:10:00 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: timer: sifive,clint: Clean up compatible
 value section
Message-ID: <20230518-radiated-diligent-2eb1d1323037@spud>
References: <40ff1fc7f5220db7d527c57ac4bad16c3945ae08.1683725179.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jHvc5MrDuTemn8os"
Content-Disposition: inline
In-Reply-To: <40ff1fc7f5220db7d527c57ac4bad16c3945ae08.1683725179.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jHvc5MrDuTemn8os
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2023 at 03:27:24PM +0200, Geert Uytterhoeven wrote:
> Replace the sentences in the description listing some supported variants
> by comments on the individual compatible values, to ease future
> maintenance.  While at it, restore alphabetical sort order.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Palmer has assigned this one to me on the RISC-V patchwork, any objections
to me taking it via the riscv-dt tree? There's some other patches for a
new platform thats almost read touching the file too, so (to me) would
probably make sense to take.

Cheers,
Conor.

--jHvc5MrDuTemn8os
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGaUJwAKCRB4tDGHoIJi
0oSuAP9YKg1eEcnZLmdHGNOdQ1OmbMAE5Q2m5ol0cHXmrBQrMQEAzGQl1K7CBDOI
TY5zuOuID+jNVfrW8O6VgSCTElP6iQw=
=YAEs
-----END PGP SIGNATURE-----

--jHvc5MrDuTemn8os--
