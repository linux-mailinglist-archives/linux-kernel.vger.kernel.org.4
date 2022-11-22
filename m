Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61443633C28
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 13:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbiKVMMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 07:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbiKVML6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:11:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FD34909A;
        Tue, 22 Nov 2022 04:11:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 927CFB81A2B;
        Tue, 22 Nov 2022 12:11:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0CAC433D6;
        Tue, 22 Nov 2022 12:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669119115;
        bh=/z2qc1uI3NebpB+3mdpORi9OgnUkruCxcihYdbzhGfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LCSLPsPV1TsmwjswLnlBTU41wJkwd41DU8kdtiaYBnVJv634uH9MOk0NoA76eC+oi
         U+46gP8aiYGvbh662QqZpD3JKN5vslPYicfa2JdHCc/Xe8+8i1xExPBi4+D5PL+Qgg
         r/aatccaQB9XqeQ7zIcWRIifspD1wk2xkDbdia71FlCG5GB2F6tAQwnvATm/Wqp6Ix
         Uju7+L5Ei4rvBK0k4elikJeTwLpDrPNV96uxJnkKYuDLgh6f+UDLNLivieY6GYG+7W
         +MmQylF8N2Rhbhm8KAeOcBCyqtzNcKtvF4XX56z0p7ktYsk67LO1Y3uyJZG7Z8uAFI
         PCCM3MfhUGTjQ==
Date:   Tue, 22 Nov 2022 12:11:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jerome Neanne <jerome.neanne@baylibre.com>,
        Andrew Davis <afd@ti.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] dt-bindings: Move fixed string node names under
 'properties'
Message-ID: <Y3y8hTosK8UNTL7K@sirena.org.uk>
References: <20221118223708.1721134-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lDjTxj1SUPsxEEKH"
Content-Disposition: inline
In-Reply-To: <20221118223708.1721134-1-robh@kernel.org>
X-Cookie: That's what she said.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lDjTxj1SUPsxEEKH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 18, 2022 at 04:37:07PM -0600, Rob Herring wrote:
> Fixed string node names should be under 'properties' rather than
> 'patternProperties'. Additionally, without beginning and end of line
> anchors, any prefix or suffix is allowed on the specified node name.
> These cases don't appear to want a prefix or suffix, so move them under
> 'properties'.

Acked-by: Mark Brown <broonie@kernel.org>

--lDjTxj1SUPsxEEKH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN8vIQACgkQJNaLcl1U
h9Ae0Qf/emE9/oA+dPnGHlis/IeySfRJD4RM1Am+LSJBAqwrpx85Z6Q2H2bURwJQ
ZWw+Q234RANSgC5arbh8/luVB0Z0UYs21FfnyBefSZvA5FlW1JHt+jpHcM6f9fdS
vB8r+afbJpNRpfQG3OUg9uIcugKdi3uie/TGzzILDNa9OvJ+FHZG6m5RrPO31xMQ
S4CYuu/MJFRq92V7Ra2SOxHjAn+p3kjXzCizHBdcia0DQRdRGORVZPzBqVpSGxhb
QEaiE7P+yYW9oQy8sVIb/ChjUMjY4w3SJr/+IAIhrpxV4DtueO7Gc+rP47PsHDoA
I13D2nJht2ZuzW11fCfbkTnuYTY0HA==
=4gKN
-----END PGP SIGNATURE-----

--lDjTxj1SUPsxEEKH--
