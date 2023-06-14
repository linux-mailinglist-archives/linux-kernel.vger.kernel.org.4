Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929E372FD29
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244061AbjFNLmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244124AbjFNLmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:42:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997CC1FD4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:41:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20C4B63F8D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:41:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1524AC433C0;
        Wed, 14 Jun 2023 11:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686742914;
        bh=34SHgqTu1jxdsPpiePefHJdtLR1ya+90dXTeldFssN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qk1U0q1qRFW3isQJY4w5qWUDYDhiDhBSlEHAPdBTVzCNGtmh3WLyM60+lruxmTeeF
         j3SKMI/a0PCkZzeb627YcMEG5LI2PJ0RTkGY2xAhid+59kvRDtzZBvjILgyqAtJ67Q
         N3hMg/6At0tN0ZB0sIFJ45Bx91Ac7mUIYJ+zLxRrzxpjpJcxo3QJpR2MByrYKPqXF/
         xQiZwajiIx3V13RR0zuTPIouc2bzb+UqB7pAfqNxaqbGtjNa4qWAKbtz+qRN1vlzbX
         Kjn3LIEnlulf9Efkdd1IN3AP7/1DRBIm8tvVZF76na9toAA1L/VYFLa4U4RY3Qn3+S
         0yFpxLK+VvndQ==
Date:   Wed, 14 Jun 2023 12:41:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>, kvmarm@lists.linux.dev,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 10/14] arm64/sysreg: Convert TRBBASER_EL1 register to
 automatic generation
Message-ID: <a4ca1fbd-2e2f-4adf-8d22-8630a9049881@sirena.org.uk>
References: <20230614065949.146187-1-anshuman.khandual@arm.com>
 <20230614065949.146187-11-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TJNgqKk3Jj4tJCxF"
Content-Disposition: inline
In-Reply-To: <20230614065949.146187-11-anshuman.khandual@arm.com>
X-Cookie: At participating locations only.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TJNgqKk3Jj4tJCxF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 14, 2023 at 12:29:45PM +0530, Anshuman Khandual wrote:
> This converts TRBBASER_EL1 register to automatic generation without
> causing any functional change.

Reviewed-by: Mark Brown <broonie@kernel.org>

--TJNgqKk3Jj4tJCxF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSJp3wACgkQJNaLcl1U
h9BfOgf8DKBYu0HITa4h9Zpyah8Uv2VPDwi9LHgNcF9DULrKX8yWiYW/wWF4YOdM
OzJ1LToDlE+++gCeKKBnsFjm84Hd5VkSFHbnykWUHB4/ShTmViQzyCPfZI8RmDGm
icybV/8+SQiW6aLoJ1pY0jDoi4ZCoYc2sNh621u/TweJRjyxwoRVfg/xk43UOxM6
AhUg3YF/e3fnpCOWP8+oFyn/L4tHvKh+t9AuK8dxlH3zwoXtiy6LzRvlgxkDbbBH
oGvlh21IFjBJsLYZrFgNJHc2f8bjgtkICYHRTkO+wOZciovfr8crFx5Pl1znq/oC
Vv1KK8Tt/ZBom1ZpJ3kPt08+Rzq3Ug==
=H/Dq
-----END PGP SIGNATURE-----

--TJNgqKk3Jj4tJCxF--
