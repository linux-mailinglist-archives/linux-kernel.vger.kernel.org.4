Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5303B68680C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 15:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjBAOPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 09:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbjBAOPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 09:15:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A2E15C8F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 06:15:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DC8F617A9
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 14:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E12C433D2;
        Wed,  1 Feb 2023 14:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675260913;
        bh=tVZL+e4JXqS/iKQBSHjb2s9BsW4luwAvPwKG02RnnWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DwVJjxx6kAQvuGZrqfhGNxOMHAMAzGQaUNKgAaa9EwXLcak4+vMCfU0TC/H83dm9v
         gihD11QEYwoGzp5yQ47EanxbN1OezxN6DoKwEYiPDKPw5vY+vwwYNkNxDg1hrMvcg/
         lJnJfSor1UdDvcubo4yhMG1Gls1MFR7qcQ+RRaHva/wOXIZsbfp5U4dORl8mDeYdYk
         rkzP2+Xs8elWjAFyAMfKuWWH11fFrSjq5LFmj/YS5oE6FPydTOlprQquiIq/RT3pni
         6f0tqM+In7QWkZn3l8ALxvW7M/q/jY8UwMkaj8OYUAV2cXcK6EKM/EsHTfHgn5RG4b
         mNiBvWxoZOt3Q==
Date:   Wed, 1 Feb 2023 14:15:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu,
        kernel-team@android.com
Subject: Re: [PATCH 1/4] KVM: arm64: Provide sanitized SYS_ID_AA64SMFR0_EL1
 to nVHE
Message-ID: <Y9pz6Vrbzt7DEHjK@sirena.org.uk>
References: <20230201103755.1398086-1-qperret@google.com>
 <20230201103755.1398086-2-qperret@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cPqikTl0AtvCkcFQ"
Content-Disposition: inline
In-Reply-To: <20230201103755.1398086-2-qperret@google.com>
X-Cookie: Oh no, not again.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cPqikTl0AtvCkcFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 01, 2023 at 10:37:51AM +0000, Quentin Perret wrote:
> We will need a sanitized copy of SYS_ID_AA64SMFR0_EL1 from the nVHE EL2
> code shortly, so make sure to provide it with a copy.

Acked-by: Mark Brown <broonie@kernel.org>

--cPqikTl0AtvCkcFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPac+gACgkQJNaLcl1U
h9D9Xgf/SW7hnuOuVIGXnPa8yxv2XzCQzl+19rW6iNUPrg/ORqeqQ70BHpg0beK6
42EsK3M9MGlIV7p6yab02/aO/QAU+xRBGBL+AbbauALZoFc0xnHFvm8kgOhpDIIQ
WnzTdVt6Zki6Z0ptBDcG93nQhBmbTLQohbpfjJ12LL8CxPxc5sQdrWUoDsUxtiil
WMY4m/mMOLHEAUKjSLw9uWLliNGVZJmWCfZUMPFt1LUEgGGIVGoGo5xm8w8SP78Z
/1pF+Fhwe4HuUFisgfL1x5HUe7GFxNwkX2Yk1Y1Vcu2giOm/VjiecbZng4E0umoG
YoegBoL0JTA+h6hh1R/lz7osqGqv5w==
=N3Pg
-----END PGP SIGNATURE-----

--cPqikTl0AtvCkcFQ--
