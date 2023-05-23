Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F63970E3F3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237913AbjEWREE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235903AbjEWRED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:04:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6343B5;
        Tue, 23 May 2023 10:04:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F24161462;
        Tue, 23 May 2023 17:04:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B35C433EF;
        Tue, 23 May 2023 17:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684861440;
        bh=1tP2yGAX7ONXZO/ENxQ1XwHW2RgkmzFFGEyJhStYBxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c2qnq0D53iDw89RCjs+JpezZr+ssBzwGyQgAnsS69F9aqCSLi8q2meUUmS9IgGKjW
         qaa7XV+z5oW0LLIqHR1iFBwk2zqXEsSBQNdM+2ReDDwN79YFi5RlHZHdkT6FKzNtQt
         Op+EhCHM0XGLLxB4ele/kaqTifDHVVxKhnQwljJr6LmsOlX563IgnvNhNMKGieBukz
         V6n8SqGOlSz5elSKJ/rw9FjmQlx8pDB6HA2eDpXoElwzaqJxAmsxmur5KK5gBesEwB
         kWlJ4SjU7RHiUuzL45QLMiiRD6xeesROkBNz9GQyLobkPs+mDRxje6k2wtEBVoXOzt
         I23EtExjX1f4w==
Date:   Tue, 23 May 2023 18:03:55 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: xilinx: Remove Rajan, Jolly and Manish
Message-ID: <20230523-oppressed-happily-50a6d0046e3e@spud>
References: <9b252dd71c82593fa6b137eca2174d9ab6e57f7a.1684828606.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7gzcSTFsSYxRBwbM"
Content-Disposition: inline
In-Reply-To: <9b252dd71c82593fa6b137eca2174d9ab6e57f7a.1684828606.git.michal.simek@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7gzcSTFsSYxRBwbM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2023 at 09:56:57AM +0200, Michal Simek wrote:
> Rajan, Jolly and Manish are no longer work for AMD/Xilinx and there is no
> activity from them to continue to maintain bindings that's why remove the=
m.
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--7gzcSTFsSYxRBwbM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGzx+wAKCRB4tDGHoIJi
0sa1AQCjYsEvbrrj+nzjP9+7ogb57qeToZNE2AFu2S7iNM/E+AD9H6qFZ2kFR526
/N7k65buzURkw4bTwA5otwe84iOrZwI=
=oOrn
-----END PGP SIGNATURE-----

--7gzcSTFsSYxRBwbM--
