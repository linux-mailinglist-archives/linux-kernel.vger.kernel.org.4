Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC706C6AA2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 15:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjCWOT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 10:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjCWOTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:19:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BC335EF8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 07:19:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 377E1B82145
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 14:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0569CC433EF;
        Thu, 23 Mar 2023 14:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679581143;
        bh=rKJhtcWF5Sbv4BWK06vkFvdXqPI6Oa3L46gyDJuZXFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aHNaIbGLVewvMY2yAbCr24zRc80qFHyHIM+R7ZbSIeHa4G04XXTCTZe9rsepM1W6B
         uuDmVPJtSqWmLJnMhOAG9n/Pv+cj2143cERJG5eApY4oTLy4/DkFZN/6miSFf16sYq
         zu1RwtFzLyy1s5E7zrpNI/uJkH/ic76YpJaC8O7eBqSEnSEFgmap6Ril3f1w2mofLW
         isxk6Y2vjpUGeOr1rOCKfhZh4NpVHMhRV8rX5cQkpn/hFcKC/SEdwbnEeYuHLuy6es
         5vorGNTyvx6XZSS+ajbw3JKOHUsPfp2aGfVOBQaflr4Ut5MZZ95/2F0hS8jlNy4Z3s
         sOT43yztiv1Sg==
Date:   Thu, 23 Mar 2023 14:18:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, vkoul@kernel.org,
        vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com,
        tiwai@suse.de
Subject: Re: [PATCH 04/20] soundwire/ASOC: Intel: update offsets for LunarLake
Message-ID: <ea0ff833-5124-4438-a452-1b281b3fbc5a@sirena.org.uk>
References: <20230323054452.1543233-1-yung-chuan.liao@linux.intel.com>
 <20230323054452.1543233-5-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VNygY43YA50jeNm4"
Content-Disposition: inline
In-Reply-To: <20230323054452.1543233-5-yung-chuan.liao@linux.intel.com>
X-Cookie: A lie in time saves nine.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VNygY43YA50jeNm4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 23, 2023 at 01:44:36PM +0800, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>=20
> The previous settings are not applicable, use a flag to determine what
> the register layout is.

Acked-by: Mark Brown <broonie@kernel.org>

--VNygY43YA50jeNm4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQcX9EACgkQJNaLcl1U
h9BfvAf+NahuxKYi8m2GUOc9HDxl3uBfiiJR25oj2vuLxSmq7ACpD1P92KacpNcx
AYtTP4y8bzoMAKuIxMuJhd7jQaRlYoKYo7gSi1anVoMbljFp95X02iKHaAd0BmfO
4ldvWLpLMMkw8RfNriAa/Z7Yn5fdlvDsXUPTteAMmRjbXE0405GZHNJKeZNYUhdP
TFven2IQ9xBf3fMuUAJfONVamhq5LxYKIFiQruRof9/SZCoPVXxJxWBqOT72VDmD
h3h04V9dp4U7YThmIpflHj4z2BNoBEDp/R+Lo93ZGRX4VTULHcOUJcVgwSxN7BZn
XHTIgj7pQ+r5aqWZvVngf7SkgY1lJA==
=ASuf
-----END PGP SIGNATURE-----

--VNygY43YA50jeNm4--
