Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D49A65C5AC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238518AbjACSFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238673AbjACSEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:04:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D05E13D01;
        Tue,  3 Jan 2023 10:04:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23C83B8104D;
        Tue,  3 Jan 2023 18:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC04CC433EF;
        Tue,  3 Jan 2023 18:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672769080;
        bh=ZR7IIxT/ZnYnuHfeakuNO7Lp/ohQpSt0ghu2SgfR1ds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KE/NYrzv+S4HklSm3cK8xlkV9GQXl4GW/rAzLQbeoTYg5oBP2RlWUFH3tzDaVxyMF
         mg8CmhnaAqcvdEYt1pe/KU5/hZXgLO31XLizgutcxPFA5Ljnm65leJEOQSM3FTHsPp
         GZeEmoYZKAuBkqWGNCrMMCcEwCoeW8jVLMmsn/zriTN0+Zx8VMGDFPbO0WRiizN2+i
         SB0emxaWIAP4q3QHr3N7UYfsae2zQVmuBy+q62EmfAqV039gZ2x1SaeHJ2LS0wbbbg
         e360qUYRHURT8bTUPwHoivTbjcjZxyqQg7e0yY5xO4g5UBTMjSOvsOlGGj6XFekxCV
         8H2Y/lVCwZAwQ==
Date:   Tue, 3 Jan 2023 18:04:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, rcsekar@samsung.com,
        aswani.reddy@samsung.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 1/5] ASoC: dt-bindings: Add FSD I2S controller bindings
Message-ID: <Y7RuMmvNnAx+oyyl@sirena.org.uk>
References: <20230103045613.100309-1-p.rajanbabu@samsung.com>
 <CGME20230103045651epcas5p417960d84f4aa934b0ae1a150ee5fee08@epcas5p4.samsung.com>
 <20230103045613.100309-2-p.rajanbabu@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JqE9RGShcf/zQD+W"
Content-Disposition: inline
In-Reply-To: <20230103045613.100309-2-p.rajanbabu@samsung.com>
X-Cookie: So many men
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JqE9RGShcf/zQD+W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 03, 2023 at 10:26:09AM +0530, Padmanabhan Rajanbabu wrote:

> +
> +      tesla,fsd-i2s: with all the available features of Exynos7 I2S,
> +      supporting only stereo channel playback and capture.

The driver claims that 7.1 is also supported.

--JqE9RGShcf/zQD+W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO0bjEACgkQJNaLcl1U
h9CQlQf/fBI3mqSLK07/+r+4uheckUiQK5tcJh+cUiIlkwg8BznPvJ9zoZ0QYkEv
r+4pS/ovtdqPcQbdGQrE4jdLiAaGp4LDTPESERoY2Y1/0KMErrPxxbEOML6PhjZ+
7LFPnq8fh/HHh4IGHsYKLD2jwZtphXHLzEKcLlczp6YaubvXESw9G0XOMFSc589N
+wSAxOqV9GX7kq9uQnzr4lS4/FwdqXG4kCW4QEHSg8aqjilG7Ogm7WwhIgGzDj9W
OwptqgijpkK+sMF0DmitVPdYRAURrsLSP81LoEM3tgbPkeS5FyIljOtGcgynpuSI
jOyQHgIlRYZ4A9F9+Wcd6tV2K8kjsg==
=Li2U
-----END PGP SIGNATURE-----

--JqE9RGShcf/zQD+W--
