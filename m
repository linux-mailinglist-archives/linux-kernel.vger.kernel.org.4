Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F9C660A66
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 00:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbjAFXtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 18:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbjAFXtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 18:49:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF713C0C9;
        Fri,  6 Jan 2023 15:49:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5C4761D03;
        Fri,  6 Jan 2023 23:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE83C433D2;
        Fri,  6 Jan 2023 23:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673048945;
        bh=Kzq2tlfGPQr0fgmnls2K0N6TO37vkS9PveZIdQUSA5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hvBZEnjTKvt1+MQ/2U0lSDzK9fveRIQcTWkCZdUNJ/bEaOJp9jYeyBqIGkBDhuBaQ
         lT0/Z4D/eycBC24N7aLjvfTkpWGClQ4hbxSf326i/rPJF3Eym920csAswsMipvzMre
         dLBVbvA+ZO8fKKUGNoNqdYuopDTWBLkjdyk5vOBIHS3u/f42APyq69UxcGdZJB00OS
         PGRh1vljtO6oZofqky7mydSqbyzuZOFxNOmzGXo1hFg4juMLRXYsgCivC4bw1JW86H
         VzsEHdr2aJt1spcmTsCu08V4eGZgFDPHwYIWhwYxOZMl2ioQk936m0KFkTz7nKKydb
         qpyC9BOmbfS4w==
Date:   Fri, 6 Jan 2023 23:49:00 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        "open list:ARM/RISC-V/RENESAS ARCHITECTURE" 
        <linux-renesas-soc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v6 6/6] soc: renesas: Kconfig: Select the required
 configs for RZ/Five SoC
Message-ID: <Y7izbPKsN+wn5h+H@spud>
References: <20230106185526.260163-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230106185526.260163-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v1LPmyRPbeBSxE7s"
Content-Disposition: inline
In-Reply-To: <20230106185526.260163-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v1LPmyRPbeBSxE7s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

FWIW:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>


--v1LPmyRPbeBSxE7s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY7izbAAKCRB4tDGHoIJi
0klAAP97oktxsaN4kInuxSaUJvtvvXt/XZX7Qmi6ZoSD7PODwgEAsiM+60J9pPE0
OrQO3VB6rJXbxSaCq1Q5Doo9Iky/0AU=
=2Hi1
-----END PGP SIGNATURE-----

--v1LPmyRPbeBSxE7s--
