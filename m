Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F2771199B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 23:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241923AbjEYVz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 17:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjEYVzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 17:55:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4578F1A2;
        Thu, 25 May 2023 14:55:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF16364B4C;
        Thu, 25 May 2023 21:55:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092ADC433EF;
        Thu, 25 May 2023 21:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685051721;
        bh=IgD7xJ1lA+7Cr5PgL3YBlO1IxdEO/OuNhvvPdqnlKxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ss71CwgdAXO3cm4O1DSbwTa1VhUPeCg/3xhmhPBy8sk8F85uXVRXvOIbFNA8YdhWt
         5IL6XMpG0bweXFZThN23VyFcWTHLzi4qyrCHQe46y1rhq4PDgolIU+NuJ5nUzFeEsq
         4AFT6qCAYQah7FaAIxtICAovZMqzHZPUSDABMVbV+qoDplLt2Xh/HXINbos3tGNZt4
         LlnOOMYWaLOEJQieePPRXrUF5nWpE7v3pCp45+DYepfUjtwXw8khDrjHyrR80o0TzS
         XHo+ITROLIRhocrGnHJmLB1J4E90Sq175S+SqmjCnmE14c3xlTtDOl0JBEVc2Jrxi9
         U/JxyK5tLu6SA==
Date:   Thu, 25 May 2023 22:55:16 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: interrupt-controller: sifive,plic: Sort
 compatible values
Message-ID: <20230525-upper-racing-a77b28c675f1@spud>
References: <9cbf54da1ace03d7a45f28230fd99954d8c0d141.1683725029.git.geert+renesas@glider.be>
 <20230518-landless-reoccupy-efd52921a51e@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="S5kQZEC6MB10FqOH"
Content-Disposition: inline
In-Reply-To: <20230518-landless-reoccupy-efd52921a51e@spud>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--S5kQZEC6MB10FqOH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2023 at 10:12:11PM +0100, Conor Dooley wrote:
> On Wed, May 10, 2023 at 03:26:00PM +0200, Geert Uytterhoeven wrote:
> > Restore alphabetical sort order of the supported SiFive-compatible
> > values.
> >=20
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> Palmer has assigned this one to me on the RISC-V patchwork, any objections
> to me taking it via the riscv-dt tree Marc? There's some other patches for
> a new platform that's almost ready touching the file too, so if you don't
> mind I'd like to grab this one.

Given the lack of objections, I've picked it up. Happy to drop again if
that's not okay.

Applied to riscv-dt-for-next, thanks!

[1/1] dt-bindings: timer: sifive,clint: Clean up compatible value section
      https://git.kernel.org/conor/c/1bd2339df1b5

Thanks,
Conor.

--S5kQZEC6MB10FqOH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG/ZRAAKCRB4tDGHoIJi
0uW0AQCfnKCmslrgIr0P1M8dZpov5SsIGUXTSLn6GE0QicZD4AEAn/qXuOQg5tvM
PUXHkTvj3S1bKB5s/qpE1NB2lmE7bQU=
=3WbE
-----END PGP SIGNATURE-----

--S5kQZEC6MB10FqOH--
