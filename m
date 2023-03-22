Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1895D6C4B7A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 14:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjCVNSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 09:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjCVNSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:18:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4C222101;
        Wed, 22 Mar 2023 06:18:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38DC5B81CC0;
        Wed, 22 Mar 2023 13:18:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A6BC433EF;
        Wed, 22 Mar 2023 13:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679491086;
        bh=hMrRm5wqw8FGqGZ9mo++izbTXnBx5U4h7Higcab2oU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eaj/6wKxTScQ0V47wuxZjRMiOHATtbEKUSrK/q4aAqR/EnIT0rfVnQOloA/jj8eCB
         nfPI2clI/9r0QBTTedyOJ13m5WZtcULKEu+iR7FIRdmSef7rDYcY55gAmu6bAJlLpq
         D11/qvArkP72qtMPyCS8a6WqjFAtPJcsAL/hgoqEvezD4Sp2yxRd051vvbI4kcgUNe
         5/8PzCeT/0Fg5u8PZ4mX3IXFsbM8tDbFzPype6647hLWrP/gGaM39UvLAQrPwmN0BN
         tcCyuEf5SWbgBSRZucBGCsyq0l3NHM9LWmoRS7EbX7dre0mZ1xxtsPAlTrbpPD+oQt
         ZZ9UEwn0Jojpw==
Date:   Wed, 22 Mar 2023 13:18:19 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v1 1/1] scripts: merge_config: Fix typo in variable name.
Message-ID: <ZBsAG50+zCe8WFTt@sirena.org.uk>
References: <20230322085106.16629-1-mirsad.todorovac@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vHqnam9MTXhdIPXT"
Content-Disposition: inline
In-Reply-To: <20230322085106.16629-1-mirsad.todorovac@alu.unizg.hr>
X-Cookie: Single tasking: Just Say No.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vHqnam9MTXhdIPXT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 22, 2023 at 09:51:07AM +0100, Mirsad Goran Todorovac wrote:
> ${WARNOVERRIDE} was misspelled as ${WARNOVVERIDE}, which caused a shell
> syntax error in certain paths of the script execution.

Reviewed-by: Mark Brown <broonie@kernel.org>

Sorry about that.

--vHqnam9MTXhdIPXT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQbABoACgkQJNaLcl1U
h9B4IQf8C4jY2voUm638i/dm+HQ7QsuuMCCGDZXffgJlbrefatlr4Ym56ORCSuSz
lSalN7zIEmhXCbG26Zr53LzXIka927vVc2oKatXRMHIKM77zLRdCY1SgPxR2m1+5
RpsWwyuKGsu6/duo2B+HOmOBDz9z8gauOpXzdcsfI3mCTInUNftj5YM1LUd8Zpr8
EDfhaBPqsM0K27e9nMHBLctMBaytDQ37RjImJKDN3I2nbOHbEAgW2V2wEOGadCDX
0f/WFLLqfONg04Qc/ANPyuNzj3J8gxkv2bNvWHRvDSKgqP4ktYFzx62o8dcmdN4h
koih6jU0ehHIyl5Tbn5/SJWr2l8j3w==
=H4af
-----END PGP SIGNATURE-----

--vHqnam9MTXhdIPXT--
