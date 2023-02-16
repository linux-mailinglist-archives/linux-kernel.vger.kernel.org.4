Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE526999E1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 17:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjBPQXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 11:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjBPQXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 11:23:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7111F20D23
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 08:23:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC724B828E3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 16:23:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28273C433EF;
        Thu, 16 Feb 2023 16:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676564582;
        bh=vkIDRo1FtU4bdhqJCU8/sKrR9uWhJNwYm0CALFCj3VE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UiSLNcmLeLUN5WOChgq4bE6fCx33leWZzSPX9W9B4P5HZmsn2BsVOESz+DKNBEGFP
         qlaYjTB/fPX3+YsS1G+6Hw/9t9AEpUvluE3OqUoWRGzcyjpcv+0Bmm4HoyVly+18Xo
         M5Wtm6RDpt2pMISesyWuq9DxLkJwNKbdJOmlViCDOXVmY7FXxypiMldYdBPJyVT+4E
         Z2KQugdYCbosc8rQqTzrbUrbGhqOdWih00WZNk1QAsBVryNi51b+oma45jCQXcakB3
         c+48UkoFaqhkwPhPbuxH2QTedoIZMZw/ZDMoxcZxB53QCWPGedq5sn+fBj0mf+hdG9
         0Twh6tYHtnf1g==
Date:   Thu, 16 Feb 2023 16:22:59 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kristina Martsenko <kristina.martsenko@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] arm64: mops: detect and enable FEAT_MOPS
Message-ID: <Y+5YY7RtNYZKTiNn@sirena.org.uk>
References: <20230216160012.272345-1-kristina.martsenko@arm.com>
 <20230216160012.272345-10-kristina.martsenko@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iebF125Yz+Y6P7Q8"
Content-Disposition: inline
In-Reply-To: <20230216160012.272345-10-kristina.martsenko@arm.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iebF125Yz+Y6P7Q8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2023 at 04:00:11PM +0000, Kristina Martsenko wrote:

> The Arm v8.8/9.3 FEAT_MOPS feature provides new instructions that
> perform a memory copy or set. Wire up the cpufeature code to detect the
> presence of FEAT_MOPS and enable it.
>=20
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> ---
>  Documentation/arm64/cpu-feature-registers.rst |  2 ++
>  Documentation/arm64/elf_hwcaps.rst            |  3 +++
>  arch/arm64/include/asm/hwcap.h                |  1 +
>  arch/arm64/include/uapi/asm/hwcap.h           |  1 +
>  arch/arm64/kernel/cpufeature.c                | 19 +++++++++++++++++++
>  arch/arm64/kernel/cpuinfo.c                   |  1 +
>  arch/arm64/tools/cpucaps                      |  1 +
>  7 files changed, 28 insertions(+)

Please also add this to the hwcaps selftest.

--iebF125Yz+Y6P7Q8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPuWGIACgkQJNaLcl1U
h9ChWAf/dwfCz3sdklcf13AUvRi8cnyD9UEYYPEfOSFVtz5/fo3doRUwwauL4hkN
gBKhXLqsl+byDLExSGhh0gxtfYwRrJjTh4PlNC/3l5p5wzVixNV5pRJFz00pfksM
fF3fdUD5J99sQbarL0x9RxHT+roEGNm+nvbRrWzMGq9Jnw6jRZ+OUq7nZAon+yib
0d+hoHmsd/lD2LrNkbpId1GvaLV1h6OW0bH0xH4QxV/O8Imdcbmj1nkbfazk6GD/
HnRdMXSj2aM5mlDEq3fjeRdbbnAT9xBOYhOUOEoklhuJJ3oDKjAVOWRWejq/bmcM
ltgZXxXVW2W4MgHfxq/GxyDe39bnkQ==
=kNhl
-----END PGP SIGNATURE-----

--iebF125Yz+Y6P7Q8--
