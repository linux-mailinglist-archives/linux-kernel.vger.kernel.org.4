Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691CF720108
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 13:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbjFBL6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 07:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbjFBL6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:58:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CB7E73
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 04:58:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5EF264F44
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 11:58:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77ECC433D2;
        Fri,  2 Jun 2023 11:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685707105;
        bh=Pli+dpEm8XbqDMVH3Q838FRR+WhJt8VVaxKShlXYZz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eDz/0yFT2mHq9wmsAp9vgYoKITJV9iC/Tfvr8QbM+tgJnBk3wed45iCCO9ItFdz/l
         fJSpRwzkFQpOb8Dvhd2qnXyZdA/QlAnyyjw6/5p08H4msqW6Jb4GTY/4CuX8UDJPJo
         mbMThn0QEqxXT/C5GwTfoqZJlG0sGRpGz9fS/1ynLEKCZ1UjvOMlhvXuGHRGE/ENeS
         KJliN5uZyevOLh0JchYyEaxXngitLhdCvtIGFescv4tULxCtRrvQqRtkA10OtTnTb8
         p2dunJ6id/sGfcxnCLlftmSyOwcLyzta+q6ybC6jHaL7QGpLRr1OtT1NIzRW42zHKt
         JjGteoSzgzM2w==
Date:   Fri, 2 Jun 2023 12:58:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>, kvmarm@lists.linux.dev,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 09/14] arm64/sysreg: Convert TRBPTR_EL1 register to
 automatic generation
Message-ID: <0873b03d-1486-45fa-bc0c-cd8da2b7a599@sirena.org.uk>
References: <20230602062552.565992-1-anshuman.khandual@arm.com>
 <20230602062552.565992-10-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j1DfidqfahbgmVW7"
Content-Disposition: inline
In-Reply-To: <20230602062552.565992-10-anshuman.khandual@arm.com>
X-Cookie: War is an equal opportunity destroyer.
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j1DfidqfahbgmVW7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 02, 2023 at 11:55:47AM +0530, Anshuman Khandual wrote:
> This converts TRBPTR_EL1 register to automatic generation without
> causing any functional change.

Reviewed-by: Mark Brown <broonie@kernel.org>

(these reviews are all per DDI0601 2023-03).

--j1DfidqfahbgmVW7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR52VoACgkQJNaLcl1U
h9ApPgf9E4WyohUEmJ6sRrp5jhxxGsAFr3Y6Zl3K1F60YQ8+8A36/buXzqPScDrD
YOQNpXieixEM33OMHm69733GPxtqjIy6djElA9rA3Oixka3ej58tXIC47ihcvUJm
5E3IKTUZ/4o+CAMMxsIgYVbtwTcDj9Mfh0co6uE0cBsmB4iahhFOtbeGMpINCr5n
Ki1biS5HKZofGgSvM4my9tT8BzjYjhI6K2rMy6p+zVAgIWjCV4NArABCHZdiuZnI
YGTYOCU4VJdbwluBduoZKH/+U2Aap5lM8AZwomrHozM3soHUfzCRGO4ucWr2+YsQ
Q7ZPsNbapQdsH7cgDDzmIcStXJIrgg==
=/hlq
-----END PGP SIGNATURE-----

--j1DfidqfahbgmVW7--
