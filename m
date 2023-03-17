Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE836BE9CF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 14:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjCQNEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 09:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjCQNEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 09:04:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C0F62B42
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 06:04:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CC55B825AE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:04:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318F9C4339B;
        Fri, 17 Mar 2023 13:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679058269;
        bh=wfvs/Hwe2A9fHFhyTgyScM7v44oGnMPVNiZsqJkhDEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i7G3K5kZ7ZkatPOl4Y4nmPZEPh96SSC6+85TpgiDZggrWse53GhrBRkSN0my8I42y
         MFbGrAR0qVitkZH4mB/KRxvrzCPrz7xXKh7PZblXapqp9Fem6KjXmVIUn0iC1ka1jM
         n+UEfaO2BMlPiI2lyLaOfm5c49TQ+pUOF8qtVeRAcEPmHg2gwDF7AAgqGGtaZ+FIJ2
         gVBVQrhp3LxtJSVKTLVd05TcpHwd9XS51oDzS532LKmyuCULvjnxz8gCVqgK7YPAp+
         iKEU1VsR42wyTksYVi+CDonILttewNQtroLveoFVzIRd6joHd0DzvSeMOi9ZUu22iB
         xqVqITzEyuT7Q==
Date:   Fri, 17 Mar 2023 13:04:24 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dongxu Sun <sundongxu3@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wanghaibin.wang@huawei.com
Subject: Re: [PATCH 4/4] arm64/sme: Fix some comments of ARM SME
Message-ID: <8234616f-ce86-48c5-aeb1-d41fe5c40a9c@sirena.org.uk>
References: <20230317124915.1263-1-sundongxu3@huawei.com>
 <20230317124915.1263-5-sundongxu3@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZyU0paPqrUctRqG6"
Content-Disposition: inline
In-Reply-To: <20230317124915.1263-5-sundongxu3@huawei.com>
X-Cookie: Life is like an analogy.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZyU0paPqrUctRqG6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 17, 2023 at 08:49:15PM +0800, Dongxu Sun wrote:
> When TIF_SME is clear, fpsimd_restore_current_state will disable
> SME trap during ret_to_user, then SME access trap is impossible
> in userspace, not SVE.

Reviewed-by: Mark Brown <broonie@kernel.org>

--ZyU0paPqrUctRqG6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQUZVgACgkQJNaLcl1U
h9Cg3gf/QAxjwqa3xLNh31DcNu+SDjmYJHmj7aGl+ouarhTmlOG7wJms5dcP4u1r
Y0cCX+UzI+UC7ECH0GyRaEAck2t2Cf38XySCVCVoexx3LObJmHCEbN2sdOyKRs9U
2qqvUvXpmSOtIQCl3jmMdk2NNxTBcF4FXCd8ccvuVN2A4Fbl76hu5l0H92hlV0qK
gU9jNCsYED9Q067GrFkzpf6+rFVNEnOPyv6LdlW1QoJRqzwG8bR3IC3eDTm8GVuo
X6MIm4lPn/nA1EIEfMUSBDafYDOMTNukNEVAV4K6jihfzw/qeSbePK4GvmD6nLP9
Ob/PElrZR5sVGt6ROeXEIm6uUIusMQ==
=pePG
-----END PGP SIGNATURE-----

--ZyU0paPqrUctRqG6--
