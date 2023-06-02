Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BDD720104
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 13:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbjFBL6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 07:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbjFBL6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:58:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDB81B3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 04:57:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF07964F20
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 11:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE0AC433D2;
        Fri,  2 Jun 2023 11:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685707043;
        bh=CW6KUGEyQ8RyjsLe9sKynqFOLOQJmp6pFcZXkYssw7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O3kk7shx5A/FuG4sKU0IVc6gZ6D4fsGBjom23GV8ETwrnOZHamzH7sXU+5IQRsFej
         zJ4kvzhnbCBeKNZy1gi1FYrKEh9T0QAqJsyj804JHMPPPAahsSBXK52BQQpqVUeEb0
         OyOZgkbYW+2Ifb33SuvwmZMImyYJZtYhfNJuOD9JWQcNemN5SwWLmE+VE63T2u1htT
         JTNAU2emiF3sWwQeREMhEnT11AklOjvztdqC7pj/DxpHhsxORQVNiN/fUwAUZSn/RV
         opd0tt+FPPBjP/6KFQD1wJnHHgm8hMj861O7ggITRJuwPa99ROag5q2YxV55FaZdVT
         lNUvQqMMKYOQQ==
Date:   Fri, 2 Jun 2023 12:57:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>, kvmarm@lists.linux.dev,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 08/14] arm64/sysreg: Convert TRBLIMITR_EL1 register to
 automatic generation
Message-ID: <5269e28f-d6a7-44b5-b8a8-3c2c582b3147@sirena.org.uk>
References: <20230602062552.565992-1-anshuman.khandual@arm.com>
 <20230602062552.565992-9-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eYlucRjyzjK753+U"
Content-Disposition: inline
In-Reply-To: <20230602062552.565992-9-anshuman.khandual@arm.com>
X-Cookie: War is an equal opportunity destroyer.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eYlucRjyzjK753+U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 02, 2023 at 11:55:46AM +0530, Anshuman Khandual wrote:
> This converts TRBLIMITR_EL1 register to automatic generation without
> causing any functional change.

Reviewed-by: Mark Brown <broonie@kernel.org>

--eYlucRjyzjK753+U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR52RwACgkQJNaLcl1U
h9Cplwf/SDDnjZJzQXi8+2k1UL/1yGSZNls14Hgki36+dD3w19yCatFKJ6+Y8J38
6+1QGqDX9c039T77Gf86cGxbnXkrHYJyrzWRvEMcoP97iC/dm/SfUVDFuCJLjB6e
hiePFopFGyEXs54PwIHniotvDhUftC/DVLlA1c1u5/2EI881Ne0hdBzbfVuIM9kR
SuT8GF7lugJ/l7LHkxhNKj1l8HV7vH8DBQsBULBvYNq94PO2zwJesO/OriJc/Sr/
GeO5kkUVfJPagUH7P3jRQspQxQJvV3DM/MeZZZZw864JsONqQbWxMQ5GeK3efJRR
vcM4DAVaeoqwlOFTgwruPfXdqp/pew==
=igQ5
-----END PGP SIGNATURE-----

--eYlucRjyzjK753+U--
