Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08BD6E2707
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 17:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjDNPan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 11:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjDNPaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:30:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11C3FF02
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 08:30:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D0A961B7F
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 15:29:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5B8C433D2;
        Fri, 14 Apr 2023 15:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681486196;
        bh=Oy7IZNDxb+8PVB8hywDrkI7zMdUitr3Ayz89WzF1QX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kFM8EmCfsJJw9RouzM3gPpsIj3kED9WCbaEvTzfDqL9sUpnrCRRvzemME77DtQjJz
         jQ03UsiCuqK5fXBF/+7o/ki1XH6D9PG2X3cyPWifIg6YPDwPhmUEqA7sNSYc9V+iIi
         T+j4euThusNa+h+4o/dubrs/YuxdtDaLPtUZGC91A3pYflmMJ9vYjc0IFTPpPh14Ab
         tT+dabmBoplKXEr3vOLTG7k2egJjtknbgGzywsKwFuZYTuhgNHDtocRWuKmg65SN9q
         AkUah5w5a24IcoTI034nebWQC9MFLefZeXlvAiVpUyDXN+wFQO+EVxTvK71kXy4UCD
         bCs03OKn2eezg==
Date:   Fri, 14 Apr 2023 16:29:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v1 3/4] ALSA: cs35l41: Fix default regmap values for some
 registers
Message-ID: <bd4dbfdd-74e6-4cb1-bd3d-cafad479c4f9@sirena.org.uk>
References: <20230414152552.574502-1-sbinding@opensource.cirrus.com>
 <20230414152552.574502-4-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6EaOANoT/PHVQQX0"
Content-Disposition: inline
In-Reply-To: <20230414152552.574502-4-sbinding@opensource.cirrus.com>
X-Cookie: One Bell System - it works.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6EaOANoT/PHVQQX0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 14, 2023 at 04:25:51PM +0100, Stefan Binding wrote:
> Several values do not match the defaults of CS35L41, fix them.

Acked-by: Mark Brown <broonie@kernel.org>

or can this just be applied separately?

--6EaOANoT/PHVQQX0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ5cW8ACgkQJNaLcl1U
h9Bcrgf/aqwxlKyZj5mcfULcMCLidR/C2EBHFRwWbp2FHTYko894mSEQVHmdipTI
MjBD/wolT6glCFEolbcSAv7uKxnyXapCd5BHeJU0P665iMh4vBvXjbIvj5KUmLtK
sRoIOyVTWoAwoHyTtRD4fexTQRXtTQJ+uzVueGtilDdeTU/IFdEH7x3rMHKhyMk8
uMGmEWOkjyABUO7tThvCAwKsDoryYeUrd5ExWSbIyCSTC1HMwAlLYMCO8QlveNn0
CHdpF8xfd1U/1fBG8ZRABb6XypUChaCUIXpJ+uP80GYhHsKkHY4hGIb78ykRBObe
Mtb1CC8QElLLcvJZ0BY8xywFRescIQ==
=1T2u
-----END PGP SIGNATURE-----

--6EaOANoT/PHVQQX0--
