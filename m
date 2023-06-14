Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6105C72FD45
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244252AbjFNLpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244172AbjFNLpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:45:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11CC10D5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:45:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 227E463F8D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:45:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24378C433C0;
        Wed, 14 Jun 2023 11:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686743150;
        bh=RnYUYlyseQWe6kP6NkFrayfM25rEhRPBxhVqsJcyjXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q+gQTP4iSjBsGZCwnog4aQwiSTZR5h9yTG+rTdD2EqvsfsmcL5ItbziHcC/0fqVB9
         FSsO9CDZ7l2FMFHXa4HxKvowoFxPbcU7AQAnd0Qgq0FJb1DUzR7ukXyU3JSovP+oJL
         nxP/EwAKh5keL8sN3w1lAhFvfaR8bkzd0HkrgxZlHqagRDVuwh8jbj8tDt8wWF8h9n
         LV1T+s+Xi1QPZEh0edDxxNMByoVNtcWzDKcwsPUhK61DsBPJ+/Z1QMYjbiT5+d/QiD
         aU416k5EsBx9wJE4H9+CewJHF2o8ihzUgAPFuRnROHrOoOn3vzqNEbJbL1Hoz+TpuA
         9uNP2kQm2xG+A==
Date:   Wed, 14 Jun 2023 12:45:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>, kvmarm@lists.linux.dev,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 14/14] arm64/sysreg: Convert TRBIDR_EL1 register to
 automatic generation
Message-ID: <1b11779b-fda6-4542-86e6-b3680b0797d7@sirena.org.uk>
References: <20230614065949.146187-1-anshuman.khandual@arm.com>
 <20230614065949.146187-15-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s0Bh6Ya3IA1ZXxZP"
Content-Disposition: inline
In-Reply-To: <20230614065949.146187-15-anshuman.khandual@arm.com>
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


--s0Bh6Ya3IA1ZXxZP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 14, 2023 at 12:29:49PM +0530, Anshuman Khandual wrote:
> This converts TRBIDR_EL1 register to automatic generation without
> causing any functional change.

Reviewed-by: Mark Brown <broonie@kernel.org>

--s0Bh6Ya3IA1ZXxZP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSJqGgACgkQJNaLcl1U
h9AMiQf/dhEyCHXQn9f0aYQEEXv9tph7vPyq4K6kLVyUwBcwzy+J1Ro9UjUz/EeZ
1eWPHFRfgVn/5nAdCoGj95bsdXUMhTAiKwmRg1++OnIjoUwJODMu5YcBWXxPeEhB
0LFSGi4/cuHxYDqqrCGsew6F6+HC4Lr34Eh6m47KH/ZS0wGlcYDdfqGH+WxwYfKr
EgBo5LOp2rHKxmdamAkkBKQV+MsFLfDIqS/qiMU90UiJwqnYBBMw1xgd3GTb9y5e
nb5oN+e8Uwf/q+I0klxE8urD+HYqILrTksdr9Un2UDN1Tmrf1ctGzLpZ04mDbGnm
CRjUb93TBXjpMHAPVV3GDXuxJaJk9g==
=mnQ0
-----END PGP SIGNATURE-----

--s0Bh6Ya3IA1ZXxZP--
