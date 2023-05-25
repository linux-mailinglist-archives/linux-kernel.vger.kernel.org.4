Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7435711994
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 23:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241503AbjEYVyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 17:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjEYVx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 17:53:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF90912C;
        Thu, 25 May 2023 14:53:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B23464B85;
        Thu, 25 May 2023 21:53:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FED8C433D2;
        Thu, 25 May 2023 21:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685051637;
        bh=gVTxJsQwsIf8+mM11Da4eHfeqmZHWo3HCP592A+RyWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TG8cQJttC7Fi6tepY7WR6mFizDK7/YFBKsIhEbU5TI1J6J800V3wcm7h8hmTzl/0f
         1+D41sTM4Er00d+/NV435iYYp5UiIixyNmcsS+cdrgLZL4F0FnsDNitgemeC0yjaLa
         sqg8rRuMpHOBgtsaGnF7Pr3CmnN4tGUt//KYHXMTAiKPVOavbgfMSH3YqzkSeah85o
         I38e/wMMT67ySy1XCcEoxreFn69/S9xOAxp+vbCML3jpUk8fmWu/dp2P+r/23Uz65U
         VQ8J9wEPFEj0wNTnDHUH878yEoyPFFiGyAQl/hX9/w4BCesCrEkfjoKpi9cBHqToTw
         JAYoLt0yyKIBw==
Date:   Thu, 25 May 2023 22:53:52 +0100
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
Message-ID: <20230525-confined-swimmer-ac26871dc424@spud>
References: <40ff1fc7f5220db7d527c57ac4bad16c3945ae08.1683725179.git.geert+renesas@glider.be>
 <20230518-radiated-diligent-2eb1d1323037@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FUJhqpkh0YXZ673r"
Content-Disposition: inline
In-Reply-To: <20230518-radiated-diligent-2eb1d1323037@spud>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FUJhqpkh0YXZ673r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2023 at 10:10:00PM +0100, Conor Dooley wrote:
> On Wed, May 10, 2023 at 03:27:24PM +0200, Geert Uytterhoeven wrote:
> > Replace the sentences in the description listing some supported variants
> > by comments on the individual compatible values, to ease future
> > maintenance.  While at it, restore alphabetical sort order.
> >=20
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> Palmer has assigned this one to me on the RISC-V patchwork, any objections
> to me taking it via the riscv-dt tree? There's some other patches for a
> new platform thats almost read touching the file too, so (to me) would
> probably make sense to take.

Given the silence, I've picked it up. Scream and I can drop it again :)

Applied to riscv-dt-for-next, thanks!

[1/1] dt-bindings: timer: sifive,clint: Clean up compatible value section
      https://git.kernel.org/conor/c/1bd2339df1b5

Thanks,
Conor

--FUJhqpkh0YXZ673r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG/Y8AAKCRB4tDGHoIJi
0jqLAP0XDdSN6q73gVlptwD0sdH2ijo2bMlK1J8s7stO9a3b5wD+OMo+5aYHBUl+
gmDUGCSNim+iF6qG4mhv2HLcSEDQaAo=
=W+TV
-----END PGP SIGNATURE-----

--FUJhqpkh0YXZ673r--
