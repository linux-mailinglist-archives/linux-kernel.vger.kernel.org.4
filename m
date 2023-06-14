Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B9872FD35
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbjFNLn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244259AbjFNLnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:43:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323D11BF6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:43:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCA3C64132
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:43:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE389C433C8;
        Wed, 14 Jun 2023 11:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686742994;
        bh=8+ZSyL926RSr7iwgYNZxbnljuVjwLelqD9gaHrmdKBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TaLd6nYVCjassv6ZulnfrVG/E9Qr3yaxQvRQ6v0SX9nHqifECRsq7fdtvBoadcYBn
         mKKAMf/eXwu7pqgv8oma1jusy6fKm7y/rd915GRqdJWzIP+Kayjrp2W60Zv60lvkjI
         sMZ2C5yee/dekoBR/gwe4fgdveGiGUSA+KMDcQtH1LQ4INmZMpJeSc5ZO3HkKBqGdj
         udrp1+OI+kBuXgOpApM+r7nNrrZ4L2c2NW6soLxHoLDorIYlVFMxlYie/Q1Tuhja95
         j3kNwh4DRltw67lYQVcUm7HlV5pqlTtMNGbEsse1p9GadW30GZHODcC1srk/Hx/Hx7
         v21snPU6Shu3g==
Date:   Wed, 14 Jun 2023 12:43:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>, kvmarm@lists.linux.dev,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 11/14] arm64/sysreg: Convert TRBSR_EL1 register to
 automatic generation
Message-ID: <9c124cce-1676-4fb7-a7f2-055161bff086@sirena.org.uk>
References: <20230614065949.146187-1-anshuman.khandual@arm.com>
 <20230614065949.146187-12-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2/UGhSH1lq5V8kv9"
Content-Disposition: inline
In-Reply-To: <20230614065949.146187-12-anshuman.khandual@arm.com>
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


--2/UGhSH1lq5V8kv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 14, 2023 at 12:29:46PM +0530, Anshuman Khandual wrote:
> This converts TRBSR_EL1 register to automatic generation without
> causing any functional change.

Reviewed-by: Mark Brown <broonie@kernel.org>

vs DDI 0601 2023-03.

--2/UGhSH1lq5V8kv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSJp8wACgkQJNaLcl1U
h9BoRgf/cEU43Hye3J6D3gAIZ3JFMeZq3NXP5SIdRcUMdIR21mDklnCycF0o5zUS
bXNp5w0zPPA4f1aAzNRmy8bdy67mlVGle1ViItZodxo5NtoQWmzOcXY5F2KhKZU0
dDjeAVtoAP3NqZhFZcJ6xeEJ+eyEj6jKUP/J/xosXd9hkInSr7hX5OF9j/wXvlwO
skowwNKPFBekYfkw5a22DGpeyKY+JVkW/ym5vXJcasau7HSlSTFW+kVqiF4vcGMc
UrYbPNFLy43HZ/6iTIuWEgnXvwyngn+EgOnqtu+cWjon8XfNdN/HEi7aaMRmVRpb
XgFDx8+C74FsfjMPGDVDARUUJ/ILNA==
=ZlUX
-----END PGP SIGNATURE-----

--2/UGhSH1lq5V8kv9--
