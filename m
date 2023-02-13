Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BD6694603
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjBMMiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjBMMiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:38:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6E01ABE2;
        Mon, 13 Feb 2023 04:38:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1247B811AC;
        Mon, 13 Feb 2023 12:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1122CC4339B;
        Mon, 13 Feb 2023 12:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676291858;
        bh=uBHjrTWQKkfaPwze/tEkM/PBOCV8FGkdpjBjVEqbGic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jiwrzEwrU2PFdlUVdVzzWTVdEqD6IhKKf5TLMYAJgikO90BhA6kETslVbsYVLlE7M
         UkLhfirCj4SLItq8VgwVeIdscYboRy53D2CnkqpQhZXAXBrrloDKk4JMD5NztaBkRC
         aUsC0UPHm2o1PekgC9katxXe+z9TYbAsq/JyH2TLgepyo3LgfzEc02OI/+o/s5LVtL
         YoOgP/uxfGacHbegdtVB6jISNO1Koiqp7vbQ8NE8E86tfHcijsymTDFLUlQ9ajQvPT
         F0pdJBhyKUpANdwuQDsA2Ch/L1HQxYGt6ZAzOft1MYZtNIT3OrEClZfy6Ww5qAOafO
         6SSa53TOqQpTA==
Date:   Mon, 13 Feb 2023 12:37:37 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Janne Grunau <j@jannau.net>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>,
        Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 14/17] dt-bindings: sound: apple,mca: Add t8112-mca
 compatible
Message-ID: <Y+ovEeS5KSkiHHQ1@sirena.org.uk>
References: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
 <20230202-asahi-t8112-dt-v1-14-cb5442d1c229@jannau.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hLckiemEQMgkNtNC"
Content-Disposition: inline
In-Reply-To: <20230202-asahi-t8112-dt-v1-14-cb5442d1c229@jannau.net>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hLckiemEQMgkNtNC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 12, 2023 at 04:41:24PM +0100, Janne Grunau wrote:

> This trivial dt-bindings update should be merged through the asahi-soc
> tree to ensure validation of the Apple M2 (t8112) devicetrees in this
> series.

Given that we're at -rc8 it seems like it would be more sensible
to just merge this now so it's in -rc1, it doesn't seem likely
that everything will get sorted prior to the merge window?

--hLckiemEQMgkNtNC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPqLw0ACgkQJNaLcl1U
h9Cusgf+KHIMbGjZ94f/3Md7bYbHGXWVbYeqzBW/6+lEkfiiRKOh1voFts8mMAgR
mq955EflP3IhKLBUuoGwSSLqT51rnR5O/pkjilihYcqhc4WE/GgOm7AI3kopomWN
FclT/xp6xwg7YIb9J3LcY0CsrpHDyP6xlAdG+Lt2etc++xyp0EA0Hkv+i/QlZDw6
nomffp+VkEKSYZFPh8KAPWs9yz3MKDLgrUFsOwdLYYT6B4eRcT7c6Vq52E91jxY8
TW55W285X2sfvt27ZeWL6kou1HHDoySqBO+mfp/ejw4llMuOWngRjqYKrh+E/JJH
dKHCW35kvUwwnjMsMGTaBK4tfrlC9A==
=h6Bg
-----END PGP SIGNATURE-----

--hLckiemEQMgkNtNC--
