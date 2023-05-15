Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99676703564
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243292AbjEOQ6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243283AbjEOQ61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:58:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C2E76B4;
        Mon, 15 May 2023 09:58:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EF3062A44;
        Mon, 15 May 2023 16:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A470BC433EF;
        Mon, 15 May 2023 16:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684169903;
        bh=6BQOnnLnMvzGvxFLqtdRHmW64RX2LYl5ly/0PZlbWY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uFA00hLTT5BbFjhLbVztbrAoZT+hr5ViQyB6ttyIf7aUbfStvozk22/i/6bAcrdg6
         cOXaJ8HN8AS5wkECfmYsjWqmoELp8BIhmyltHys4ngMw16sKLauCO1xeq6HGGsmKex
         MSFSCp/eBwuFj3PmRoQhrC8YGmxw1IpVxS7uJ7f0ARLSzo7SskAoZFowQyVUderMAU
         Dk2qPGrvwwB/IAXx9WENV3imzu5pacDz3Bm1apJ4YRz3/V3UjLuXwWPq2nduKPSx0h
         gt2sERrWqrHBakuTYxNmDdQjBKrceNd+4Hvn+9hOLBvMPHAtXatfbl/wTGIVwPd/Qk
         4ptkXcYrwi4eA==
Date:   Mon, 15 May 2023 17:58:17 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v3 03/10] dt-bindings: serial: add documentation for
 Bouffalolab UART Driver
Message-ID: <20230515-florist-perky-f26b996f2179@spud>
References: <20230514165651.2199-1-jszhang@kernel.org>
 <20230514165651.2199-4-jszhang@kernel.org>
 <20230514-bust-slam-10c7b9cbe455@spud>
 <ZGFuikzSsP81/d23@xhacker>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YTtL81Hy5mMcU1A7"
Content-Disposition: inline
In-Reply-To: <ZGFuikzSsP81/d23@xhacker>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YTtL81Hy5mMcU1A7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2023 at 07:28:10AM +0800, Jisheng Zhang wrote:
> On Sun, May 14, 2023 at 07:17:27PM +0100, Conor Dooley wrote:
> > On Mon, May 15, 2023 at 12:56:44AM +0800, Jisheng Zhang wrote:
> >=20
> > > +$id: http://devicetree.org/schemas/serial/bouffalolab,uart.yaml#
> >=20
> > $id: relative path/filename doesn't match actual path or filename
> >         expected: http://devicetree.org/schemas/serial/bouffalolab,bl80=
8-uart.yaml#
> >=20
> > Please test the bindings before submission - even dtbs_check catches
> > that one!
>=20
> Aha, I knew the reason. I did run dt_binding_check and dtbs_check,
> but then I read one of comments in v2 which suggests the renaming,
> that's to say the dtbs_check is done before the renmaing. Sorry for
> confusion

No worries.
Serial aisde, rest of the series looks grand to me, perhaps you want to
resubmit the serial bits separately & I'll grab the riscv bits once the
serial side is sorted out?

--YTtL81Hy5mMcU1A7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGJkqQAKCRB4tDGHoIJi
0jbsAQDmdx3opFq95JKgP8MHlcdz0QcdrvfeH/2ZDILcK+oWWAD/YaBNfF32rw1t
yXQ9e/DkpxyDG+ftGg6vVGK3FORScA8=
=PWZq
-----END PGP SIGNATURE-----

--YTtL81Hy5mMcU1A7--
