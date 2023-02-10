Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DD36928A8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 21:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbjBJUtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 15:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbjBJUtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 15:49:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055E27E8FF
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 12:49:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83B7FB825B0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 20:49:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA98EC433D2;
        Fri, 10 Feb 2023 20:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676062155;
        bh=lRiMPFXGCxxHfvEprvD7rl8Ge72em7F8Silvbxh3Zv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FzPkzMREpwNdBFq6kjDjFbb/rpVzMqi01fZdzhrOMcpeIWtqKEOTzqFjO2SSua1Fj
         JlzCXKq4DhyjgllHuPK/9F6vIv2t47Llpr34IVVHTmehmMQYzfs3j4G8wRJgUIZKqQ
         cxCN+Jvc0QYG2mJ9CMRi6W1yztLkPAh+deNmb6a5kzSb5DWM20qJPTvwIFmBK0wyez
         vICSXceKjBBVF3LioKttBprAxCZjvJqMbkf3vR1WSlKUEACNsP8YfOFiWMzA8dR+KT
         w1nrO8TA+ps0N6SC7dMJejiyu4DxK9TYUSC4MrYfAmvzdrv9SEWmaDd5at3cN61lHd
         s0eY4XEuneBkA==
Date:   Fri, 10 Feb 2023 20:49:11 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@rivosinc.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, christoph.muellner@vrull.eu,
        ajones@ventanamicro.com, Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH 0/2] Small fixups for the Zbb string functions
Message-ID: <Y+atx6E2k8Ao33Zz@spud>
References: <20230208225328.1636017-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="32ZMuNoFzgWULh6N"
Content-Disposition: inline
In-Reply-To: <20230208225328.1636017-1-heiko@sntech.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--32ZMuNoFzgWULh6N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 08, 2023 at 11:53:26PM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
>=20
> I didn't manage to address Andrews comments on v5 [0] in time
> before the series got applied, so here are two addon comments
> that hopefully do his comments justice now.

Running this on my jh7110 at the moment, so I suppose this is:
Tested-by: Conor Dooley <conor.dooley@microchip.com>

;)

--32ZMuNoFzgWULh6N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+atxwAKCRB4tDGHoIJi
0p99AQCHEYZigKbW/tlGmuhFQJtP+9mZoMq49445+eapSuNZQQD/cKQlmFN4/fW/
eIcZy4RDLs4zCzGX2knUyYT5QYRhJg4=
=F6lY
-----END PGP SIGNATURE-----

--32ZMuNoFzgWULh6N--
