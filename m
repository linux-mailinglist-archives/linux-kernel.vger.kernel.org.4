Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C16720119
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 14:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235650AbjFBMGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 08:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbjFBMGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 08:06:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DD99D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 05:06:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0059A64F7D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 12:06:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA05C433D2;
        Fri,  2 Jun 2023 12:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685707568;
        bh=DG4Hx8rhH6cBSg2k6J4JD43Y9BjtzN3oGpFHOVbrEIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V7qKL0yXSc62FBbEiDqTrVrIBnFzQy1QKIV6UTn96klc2bowk4hx6DiA38YuUAYGH
         Dt2+qdlyRXgm2vYtdb4n7+Dw+m6ARuOm8vbRF/JIOSQBr6bcX13LV9z5CfwbJBXYEG
         0+DTNxEJEmD6sldqkB2XPU0GkrbBTZq3JG6we6NWHfmRz0/1Bp+i9Baj309qH+6Nd+
         TyENejTgybFVbS9UCpDiKWYN2m9YmtVpXOBpf4ipEfdc55VEHQgfi6NAKokQFRDhw8
         8EZYoXH5o8E3SfADqNI380TlCcusQGemAGjXQg4xcZfOW0szps0dSUrETLYFyGcNBT
         Yys9ho9sCrwPw==
Date:   Fri, 2 Jun 2023 13:06:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>, kvmarm@lists.linux.dev,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 13/14] arm64/sysreg: Convert TRBTRG_EL1 register to
 automatic generation
Message-ID: <abed5c30-4d17-4dac-a1fc-b855403ef8fb@sirena.org.uk>
References: <20230602062552.565992-1-anshuman.khandual@arm.com>
 <20230602062552.565992-14-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qc7zr7M7KHeoWxPq"
Content-Disposition: inline
In-Reply-To: <20230602062552.565992-14-anshuman.khandual@arm.com>
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


--qc7zr7M7KHeoWxPq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 02, 2023 at 11:55:51AM +0530, Anshuman Khandual wrote:
> This converts TRBTRG_EL1 register to automatic generation without
> causing any functional change.

Reviewed-by: Mark Brown <broonie@kernel.org>

as per DDI0601 2023-03.

--qc7zr7M7KHeoWxPq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR52ykACgkQJNaLcl1U
h9CCWAf+NP/RcWEC+CrbUgylbo7ELl4E15o0UBUCycG7ttVrPGZeqCNDnDuTyTsy
X2JFxZyoZmamcF8selNL4XUXtr89K7xB5PVyCzoQALe9csFTHEUKumNj0gs263Qw
q4pR2ENveb9qmfFeNoq1IcXVfACq39hJE32Ukn5bQkUDPRwGU/vKo/+6dLjQwr++
5FLJFWmDli9ud7+rMDSKusDr0qRCyJGsvf+vaGY6bWCkjut7llOG7D1ZfXmNT8OI
t/Gn3IRmYwTlIUHcL8mhUEzqNHgdTjwQG9AeQwPogDFmRXGEDuVKarVtzeTVRmk3
BoKO8DJjkXPLVh5Qu04vlAVx49RLUw==
=Gpwt
-----END PGP SIGNATURE-----

--qc7zr7M7KHeoWxPq--
