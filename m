Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFE16B07E9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjCHNFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjCHNFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:05:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38391C222B;
        Wed,  8 Mar 2023 05:03:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3FBF6179C;
        Wed,  8 Mar 2023 13:02:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCAEBC433D2;
        Wed,  8 Mar 2023 13:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678280556;
        bh=x8A3q/wxd5DEV+ev4toYHG9IDX85FAj/ubBlRoLj+rw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VxQ78ea6I+OuV9L5hG5wgl8/LJYQDWgQhOsJViyJXBhzWDpaR6gkV/K0R5Lkt1+5P
         93MtM8ZGLHlgG7jSBo4khLN3SOPOzsTQRW9WFri/rQ7+y+tc1FNgG5OdLhQc19hqJN
         pCRtOXufu1/Bznv1fGpLpW28NeQo82hUmJrvH7KPSh/51iIVe/HRsXzGTMZBqVvi9H
         3hJSg0LnQ6BDajF0cZ1gybgn50iTEHglNtGdPt0rKOaKoZfWWtxRBevtdEbrS0n1Yc
         gRjUy8s0SEZENKmK7CTUIL5xTBs69RFrOBales9TfwTILFUQNrCKTf9NbXgMwuWENq
         u40bB2B8KKyoQ==
Date:   Wed, 8 Mar 2023 13:02:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 7/8] dt-bindings: sound: nvidia,tegra-audio: add
 MAX9808x CODEC
Message-ID: <8c24e719-2ca8-4571-8d00-cc9d488d56ff@sirena.org.uk>
References: <20230308073502.5421-1-clamor95@gmail.com>
 <20230308073502.5421-8-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ay+UYMHLXfir5e0/"
Content-Disposition: inline
In-Reply-To: <20230308073502.5421-8-clamor95@gmail.com>
X-Cookie: Minnie Mouse is a slow maze learner.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ay+UYMHLXfir5e0/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 08, 2023 at 09:35:01AM +0200, Svyatoslav Ryhel wrote:
> Add dt-binding for MAX9808x CODEC.

This is adding a binding for a machine driver with these CODECs, not for
the CODEC itself.

--ay+UYMHLXfir5e0/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQIh2MACgkQJNaLcl1U
h9AnoQf+OpV1EbiGz6lefDAsEzUwcmFrYAkvKbhMSSQJK/tnDVX90PQPmPiL73dE
rVZ5+RmaRPRtj4jism7vnVrgpzF5YBSwOWNc8+cDLOR7tqqDxg2E/p6qMjiBemvi
kCWcaCb6PzRmkLSYdPBcqivC9gmbvD5eoMvrfMZkgmVXFbRoOIe2sdOpaTocmtgH
RQM6W1nKzKs1ApPEqoIw9cX601szP8lT9oCT7Zu0f2yhYXm/olE8c5yshCMBEPWx
dzLdZc/Rlq/5VUlrSHjdbRFNlzp7uQndVw1dP2LQot144rUnWea7YNTl2vzibRmn
lOX5dskV+Eob2wbmJ2AKPCO/QBeo8g==
=lQWu
-----END PGP SIGNATURE-----

--ay+UYMHLXfir5e0/--
