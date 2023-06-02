Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324CF720115
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 14:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbjFBMFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 08:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjFBMFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 08:05:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4251F1A8
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 05:05:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DF99616A8
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 12:05:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE94C433EF;
        Fri,  2 Jun 2023 12:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685707520;
        bh=up4fDEXdALuY+rpP+uRCpHKNiFvX8SI/VQPNNWMb0fw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QdUSZi8OxS4wLRgLR33AQZX5/y7b3G48SRO3BWVjxI2bdM+3bj+ziO17wq9z/Znrh
         3JhnQLFVcjh02HvifU5awDg//1HviQYD5xXMuBH23VGWc6buNT9OtYjJ04X+9ceq6h
         GDs7m1INIYlmZT9PUnOPMp5czgAaKwlieX52N4c9J06JLhkJvmCYTD09F/QyqesK6Z
         lG+XJHVZ+KJUchddyGIK7htgrdgcTUtknAiJMUTHR5lyQKTWg6yC00bmGllS1Lghb7
         FzA6B0m60Ib4wSEJd7ldZxxniO6jRNlypMEtigOPff2OVDhfpBEk9Yh1LRb9EYEFpc
         dibhjqiNKTDRg==
Date:   Fri, 2 Jun 2023 13:05:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>, kvmarm@lists.linux.dev,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 12/14] arm64/sysreg: Convert TRBMAR_EL1 register to
 automatic generation
Message-ID: <8a352dec-9655-4e7c-ba35-1c48e154bc71@sirena.org.uk>
References: <20230602062552.565992-1-anshuman.khandual@arm.com>
 <20230602062552.565992-13-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8M5OxuIqfoPiZ46q"
Content-Disposition: inline
In-Reply-To: <20230602062552.565992-13-anshuman.khandual@arm.com>
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


--8M5OxuIqfoPiZ46q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 02, 2023 at 11:55:50AM +0530, Anshuman Khandual wrote:

> +Sysreg	TRBMAR_EL1	3	0	9	11	4
> +Res0	63:12
> +Field	11:10	PAS
> +Field	9:8	SH
> +Field	7:0	Attr
> +EndSysreg

PAS and SH look like they should be enums, Attr is a bit more complex so
Field is probably a good fit there.  Adding the enum information could
be done incrementally though so:

Reviewed-by: Mark Brown <broonie@kernel.org>

--8M5OxuIqfoPiZ46q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR52voACgkQJNaLcl1U
h9DeyAf8DMRfz+QJkdq/rhImQy6hP5af+QCrOyzOHCie8CFe3pZqv9GhUMgYjmZh
4nICqhn/HpopBQSGTzoW6qd0/HsjkjjT8WkJZ8gPzBtPM3VAPTHVe0jBgZ5UwCpC
mA46bIqFIgHJp/PW0lB+9P7t/lZ9qGwX+BqLA6ZYrYF7CjHcnEE9HytVSdi87mee
SopLtN874R6dWaMkjoXAbGU8xZ5edIgUoyQa69IX2AoN/MKFcqTbYm/GUh6PdwmC
Iq6RPTm1U6s/jI0D2AYVXaC8XDEKr/DXe8JhVXkkdHlvCDsWKb7HqXm9YOf9ZsVR
ij1fcvPznkRrsziyLVRiJHgbCSoLdg==
=U8Uy
-----END PGP SIGNATURE-----

--8M5OxuIqfoPiZ46q--
