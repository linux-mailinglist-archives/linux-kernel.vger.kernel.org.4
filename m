Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA2E6F24E7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 15:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjD2Nlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 09:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjD2Nlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 09:41:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EC8E51
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 06:41:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EAB360A16
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 13:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C77CC433D2;
        Sat, 29 Apr 2023 13:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682775712;
        bh=EXu6FfEAE8w0PeZ/4bIC/qJzukeBN06i+Cd+ygsFoqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c30rjtUgt1NrwSzSXSWctYjLb2j5JHIiGd5E0eWyb6hksFSL6bBo5QnCiQOksxk8k
         aZrw352o6KVb1OzzB3NLCD45JsbH4Tb6LgowvO4s9H7RoONDXtcw4H9CZiXK/UbVjR
         WruvpqPxIrxMIzBTUKDs+uJr1UvI+Rz9h17R+ejsZlO7GvggkqAo9yh+VDLPIL2cp5
         zjvRLGr5QLJiFyy1ubiTGgSbksfPyQqv4qzeT85tFpG2mFYs5J/1KFsd4o9oWSLp+a
         DiWx67143PHVTCm4I/CdR1nwn8/pL0A9ejEJ0+9IhQ8J8eztq3z/i3dKl8ZEUQnxTo
         MpmF2jxf58FTg==
Date:   Sat, 29 Apr 2023 14:41:46 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Dao Lu <daolu@rivosinc.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/3] RISC-V: Add Zba extension probing
Message-ID: <20230429-frostbite-sterile-21f9b67f7ecc@spud>
References: <20230428190609.3239486-1-evan@rivosinc.com>
 <20230428190609.3239486-2-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LbDMCsnXWTZfnITt"
Content-Disposition: inline
In-Reply-To: <20230428190609.3239486-2-evan@rivosinc.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LbDMCsnXWTZfnITt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--LbDMCsnXWTZfnITt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZE0emgAKCRB4tDGHoIJi
0pL0AP9Xx0RXAm2fso8MPqZC97jTiyA3uEEnwhTbKDD0ndBw4QEA2KNAE8eXCDgI
4+uDnjD5UMm0/2IE2eIGCIBOru/o1gs=
=coJn
-----END PGP SIGNATURE-----

--LbDMCsnXWTZfnITt--
