Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269E16E4692
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 13:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjDQLgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 07:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjDQLgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:36:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95CD8A73;
        Mon, 17 Apr 2023 04:35:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16E05611E6;
        Mon, 17 Apr 2023 11:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1774C433D2;
        Mon, 17 Apr 2023 11:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681731271;
        bh=y2/atbVteeg0LDohlIiMva71uhiV24MpeNSZbEAo7YM=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=t1r5ap2QbauIXSYpgSM5GpJiWufEsQ9twdKoELtqiYt2uGD/7zEzVHLj5KMzmF5gt
         GqOk32CZUPkfFUcVjgJVPUAU9ehD+h61wGYNkW9J3DVyOB+pIV6exN8ICZdBjqNBgo
         hSIMAzRE6VwPjdEJ5zF3IZYs1/7Qvb3/tTUri+Jah4tx6zApFlYQ1WH6CgNr5J1BlS
         IO6bzp2OSkfBGd9NVd4Mg1SsXh6819KWpT7mFv8hb6Q8pRVObQJFxm6uYPG8kanzCQ
         OMywhdAlEB+GwbVEogpScrvul/rPtgIumUvb7gZcSr6dw2xiEggIP9xE/li9CjuAB6
         oFVUktxElkJ/w==
Date:   Mon, 17 Apr 2023 12:34:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the drm-misc tree with the mm-stable
 tree
Message-ID: <ec0ed678-ade5-4549-b859-e1c451bf2bf4@sirena.org.uk>
References: <20230414125913.851920-1-broonie@kernel.org>
 <ZDuqut+8BKjMXblJ@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uuEsM8kBwgma7Hr3"
Content-Disposition: inline
In-Reply-To: <ZDuqut+8BKjMXblJ@phenom.ffwll.local>
X-Cookie: Two heads are more numerous than one.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uuEsM8kBwgma7Hr3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 16, 2023 at 09:58:50AM +0200, Daniel Vetter wrote:

> Note there was a ppc compile fail, which is why we pushed the ttm revert.
> That /should/ be fixed now, but would be good if you can confirm?

I don't have any PowerPC toolchains set up - I guess one of the
community builders might have checked?

--uuEsM8kBwgma7Hr3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ9LsEACgkQJNaLcl1U
h9BjAwf/cuSS/9ylDsEF54rC5Sdp/CYr0ozDoobN9zNlOKQ0RZ1xD1KGWyfs2pbk
dgkvLcx9YLxtdOGvTKwBmjX3Lv1mRkCXB9Z8z7BtpkH0avwabqTQX/w0DL/nX1ky
Tb7muuWDtKYEJ2Y++3tzP4gnOxPY+IMYzJJQNHz85nTfWUdZiWGdqAuGYc0u8B8F
gfPYhDvTSIbW7/VzkuEaChWIqrybXgTHbyFfZkZJGRCHFJ6Bt99v+ra8MPsCcDtZ
t4L9Ynce/nqXdqEsDQEGt2HVkNtnUs/ctiM9WWbeSsH/VsBxIbJYlbQ6BqnVQiLf
OoSYL58q1IHD6xl8OSuPcn4Gn2UvFQ==
=O/dY
-----END PGP SIGNATURE-----

--uuEsM8kBwgma7Hr3--
