Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931B172FD21
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236083AbjFNLlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235569AbjFNLky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:40:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B01F1BE5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:40:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A50FE63F8F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:40:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE80AC433C0;
        Wed, 14 Jun 2023 11:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686742846;
        bh=yfIpY4rh0PQQJiD3Tj6Aesccar7erUcLnV807RwTXak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uPre9dDTlhW/8CgvW2H2tAoQuj8/TAoxqDoY05niFGGmVtkfZgbAX6r3m82OIgwh+
         eU44hLZrgMwwArqjJLVblSyMRhCypkpjpIfEVPZsLF525jImsbZTLFxfaPXpiEMria
         1WzQM///YZUZNb3zbl/qBIelvRGODNpwG674R5PbhKzY5uBbDuJ1LwUk0hpQuh4gx5
         WfL9wGl0lGj56E36C0D49iIo5v6ouiv2Dt5zftgkmPN40T7uy/Iy1IJI3zQbfiJels
         B1kWn7xtjv6Wm7TwaNX10EyjNuHqgzsYCCp9UCGD6F582ZnoCTMJQQRNM0Q7Asz9vI
         6cN8ShNWtBG2w==
Date:   Wed, 14 Jun 2023 12:40:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>, kvmarm@lists.linux.dev,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 09/14] arm64/sysreg: Convert TRBPTR_EL1 register to
 automatic generation
Message-ID: <636fc512-99a1-487c-9732-f492faf3b385@sirena.org.uk>
References: <20230614065949.146187-1-anshuman.khandual@arm.com>
 <20230614065949.146187-10-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LWGxwLDa8LTrbT3N"
Content-Disposition: inline
In-Reply-To: <20230614065949.146187-10-anshuman.khandual@arm.com>
X-Cookie: At participating locations only.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LWGxwLDa8LTrbT3N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 14, 2023 at 12:29:44PM +0530, Anshuman Khandual wrote:
> This converts TRBPTR_EL1 register to automatic generation without
> causing any functional change.

Reviewed-by: Mark Brown <broonie@kernel.org>

--LWGxwLDa8LTrbT3N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSJpzcACgkQJNaLcl1U
h9Cl3gf/UEqB1zIVm7ftJMn1awglm4kDYVQ9Qp+PLxT/mfSZn1A47FEzRieD012l
x7NqkC0ynqVcfV5zj+PwFvfXy7LbfQZA8DtsYVxIseQ3peKVJtJfwrHw+d509GDD
2EgZSygypiloYIpecqHwnxImy70+5k+kgtXAylPYhY/exYS3EWVibxR0Re5Q4ecM
Wl2sGEkjcfqmKWUDIpEHnAFqAEwGTGM2aYcBDZJ4euswe9vWml4HqiRqOnc/A8J5
AMx9OUx2sD4MRIm/P8jmGvATuFPmFUKLEbHTSVVBDeovRfiVpeA1J3iJsbfhjXEV
PlFGO2IaLOEJpQBMI5yMAJ0qBq292A==
=ufYo
-----END PGP SIGNATURE-----

--LWGxwLDa8LTrbT3N--
