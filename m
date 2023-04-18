Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C3B6E6C26
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 20:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjDRSey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 14:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjDRSev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 14:34:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0505FD2;
        Tue, 18 Apr 2023 11:34:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 882CF637F5;
        Tue, 18 Apr 2023 18:34:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074A4C433EF;
        Tue, 18 Apr 2023 18:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681842890;
        bh=SeVwh5A9aJ9SlglUnJ0cjP75eIubcOPUJMDYzYkuyBo=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=aGfvXLlNQ5Yj8NvglyGbv8AVjndyFeloF3Y/mP0BEptNYBuO1xYHSF4XR/yEwVSdT
         0f4MlVcHXMDRK7MBCfqU6ZPuUPNqtk8kR0I6f18LavmMIxoESRnIeYaVtv0RfL94am
         kCEfOC41J6MK71yGTzyjj3OAcRJukqOn3eh7pxtKrwSbULrb65sIQpTth5F0EFK3is
         U+fc7cBNAButisaGA63tg7D1FLmH6OS9YAiCmtsq/6REaCLMZKRWJqf19r7dhi9qTB
         0i7Spx/CZTOW3ON9wEzcZVWC41MhzTpvydld3MRNokbUQRkTcExlnaXfgS7N9FvRfz
         lkqLCYGEhmmww==
Date:   Tue, 18 Apr 2023 19:34:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: linux-next: manual merge of the drm-misc tree with the mm-stable
 tree
Message-ID: <8c90b4db-3075-4275-bea8-01f501b00885@sirena.org.uk>
References: <20230414125913.851920-1-broonie@kernel.org>
 <ZDuqut+8BKjMXblJ@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Dl9k+y2vnho49Hoq"
Content-Disposition: inline
In-Reply-To: <ZDuqut+8BKjMXblJ@phenom.ffwll.local>
X-Cookie: Just to have it is enough.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Dl9k+y2vnho49Hoq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 16, 2023 at 09:58:50AM +0200, Daniel Vetter wrote:

> Note there was a ppc compile fail, which is why we pushed the ttm revert.
> That /should/ be fixed now, but would be good if you can confirm?

According to Nathan (CCed) there's still issues with the interaction
with the PowerPC tree.

--Dl9k+y2vnho49Hoq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ+4sMACgkQJNaLcl1U
h9DGMQf+LkWF7rgQeUihBV3DSNnLDVzuJWjMjb+nORsV1I4ys/Y5fN1hpEOwj0yS
J6a+Xdu8F+CMZEjbUv4U91LShNZPOLRYAJpVxSW5TEpzx4/uE4/jhbGJlvt84vwN
XRzfmUNgbQBmdUnDtsZ1RVVwgR7A1E+b3UeTPs4lqvsZxga6B/cixLMb+xxGaIRF
6AWMfRT4HPCGCBy2I4T0qAHyTx0EG1ABonZ5hMHDmvNjzLhix+mC0lgUAeaVwUli
VHhOqNVDPbuq/R9KPleCY3nWoW1b7AEsG7pobLuEvhiUjzNZMVz7e/5sziGOAR47
Ptgj2bQduqikgcMGLCI+jpthiyxhkA==
=oIM3
-----END PGP SIGNATURE-----

--Dl9k+y2vnho49Hoq--
