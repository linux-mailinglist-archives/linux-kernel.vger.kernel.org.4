Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250A964CCB9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 15:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238723AbiLNOzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 09:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238510AbiLNOzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 09:55:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B655291
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 06:55:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCC3461AED
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 14:55:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D06EC433EF;
        Wed, 14 Dec 2022 14:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671029735;
        bh=aIUcjrJWe/6VmRdzbrNHy/Um1b3+Ap5nYjNpcz68YL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nhl8mHS31fNXTMyQ8ogmJdLMpsCqlNgnkJQqSSydv/p+ybPcYFhDkLPMpqbb+q8Cs
         /eELwqr/DLYbNISJPVqCHuE/18y0dYVWDQTn0W/aOb06Lx4ItwaxPj5oeplz4iBgIS
         ITqVeh35ra3Did8HNBSuga4e5m2RZ7SKpJ01oaxKIU3GAZjyBwXhFqzAVSilmyiyWi
         sip1Y1Xk03RU+VM6QDs/wKL3avAGu7EDPTdhu46SqytN8R7NljaZuWuD4F+9Ll1RuQ
         Ro6TbvM/xKQJRflWCHMedDl9uL4S6wQ+lbXOp0o8P0hEBhhkXVIDrZEYrf07M3F/vp
         zglhhGdeEBrLA==
Date:   Wed, 14 Dec 2022 14:55:29 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        oleg@redhat.com, catalin.marinas@arm.com, will@kernel.org,
        wanghaibin.wang@huawei.com, zhouquan65@huawei.com,
        sundongxu3@huawei.com
Subject: Re: [PATCH] arm64: ptrace: Use ARM64_SME to guard the SME register
 enumerations
Message-ID: <Y5nj4WmHNUCSaDMZ@sirena.org.uk>
References: <20221214135943.379-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BQNb7uFIp4syjj72"
Content-Disposition: inline
In-Reply-To: <20221214135943.379-1-yuzenghui@huawei.com>
X-Cookie: I disagree with unanimity.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BQNb7uFIp4syjj72
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 14, 2022 at 09:59:43PM +0800, Zenghui Yu wrote:
> We currently guard REGSET_{SSVE, ZA} using ARM64_SVE for no good reason.
> Both enumerations would be pointless without ARM64_SME and create two emp=
ty
> entries in aarch64_regsets[] which would then become part of a process's
> native regset view (they should be ignored though).
>=20
> Switch to use ARM64_SME instead.

Reviewed-by: Mark Brown <broonie@kernel.org>

--BQNb7uFIp4syjj72
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOZ4+AACgkQJNaLcl1U
h9AHugf8CQA2r2CrjsV36di5ZaKR8pSFVsOrEianE/2KcHDA2BlWDR73Q23W/wRR
idVbYoj+TB6BqMt+DWKwxgBWkNG0IFDf6MBOouQBKyHR1vUVypg7bWVwbcbw2yQA
8YsnXtbCn4QYzXo2C5wQFhZCx7t2+LlsdGixZGAR1bzrADXRPMVOOtRfVgC1HvUU
vUGlj0Y8XGpUBACrMQ98aYXmYBq/Y5FELEDHIVi4+X1R1GTAGyzbggSsF1vYAp+4
6ZHxOJmyiNAERCwILkT9Q4kCvf7O8AfUvcPMcgCQHaEPA9uFCWchSQ5dzzeDm5/u
wsyWRqSVjisM0YrPVEn6Ip6X51DUGA==
=svIo
-----END PGP SIGNATURE-----

--BQNb7uFIp4syjj72--
