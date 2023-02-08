Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402EF68F877
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 20:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjBHT6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 14:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjBHT6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 14:58:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95C11E1F6;
        Wed,  8 Feb 2023 11:58:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71500617DA;
        Wed,  8 Feb 2023 19:58:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0675AC433D2;
        Wed,  8 Feb 2023 19:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675886292;
        bh=tRNavg/LIgAKd9vbMfES3i4G6zF8q2JGPv+1iHnxfQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qija1YocLLtQPH8kUkvQhotXNzK3awUCRJunJ8vd86FGg27ObcRv/J7PcMjnnGpj5
         rq3So6bWDFgV0t1ZR6CJuu2aszapZ7lmU6c2RkFLsJNkszP1H8Jsap1zGd/x/WbB88
         uB7d1HF9YFZEG7Q+O4XW1vta4/4UVxticd8sKzO+70pgUCndg5VrP3NL5u1NgF36hO
         VX2k7R4vj2k1MY+9I4AKxt00e1n2LaR8zugbDTRR0RF509rxQLjLeVNqYX7oY9Utsj
         Jpj7p4P86qsFxFrLaCAMvxETSDnjdHcgyV4B0gsTVgxnQhLzdwk96R9y2DP8bEKa3V
         ifStorPxWnSww==
Date:   Wed, 8 Feb 2023 19:58:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        - <patches@opensource.cirrus.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: wlf,wm8994: Convert to dtschema
Message-ID: <Y+P+z8bpo9sBNOkU@sirena.org.uk>
References: <20230208172552.404324-1-krzysztof.kozlowski@linaro.org>
 <Y+PeR4EFfcVDbUfV@sirena.org.uk>
 <51e8e157-3f60-1731-a8ca-4a678c8eafd6@linaro.org>
 <Y+PlUtAmbl5TJq6z@sirena.org.uk>
 <c876f40a-2db5-eb50-9706-3147671ec4c5@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yWn+MXqavpBjLzGe"
Content-Disposition: inline
In-Reply-To: <c876f40a-2db5-eb50-9706-3147671ec4c5@linaro.org>
X-Cookie: Walk softly and carry a megawatt laser.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yWn+MXqavpBjLzGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 08, 2023 at 08:37:22PM +0100, Krzysztof Kozlowski wrote:
> On 08/02/2023 19:09, Mark Brown wrote:

> >>> Are you *sure* they are grounded and not supplied from the LDOs?

> >> That's what I have on schematics (attached), if I got it right.

> > You'll notice that they've got decoupling caps on rather than being
> > grounded - there's an internal connection to the LDO output so if the
> > LDOs are in use that's all that's required, while if the LDOs are not in
> > use for some reason then an external supply is connected there.

> Yes, indeed, not grounded. I'll rephrase the commit. I also found few

Strictly the supplies are mandatory, it's just that the code was written
such that the default configuration is that they'll be provided by the
internal LDOs, with the DT having carried that on.

--yWn+MXqavpBjLzGe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPj/s4ACgkQJNaLcl1U
h9BAbQf/fp2AzGnjgsAH67/NkCsxNZ7u/dBsQQzFc/jiy6YbG9swrncmAaXJbmzJ
DrXF49254VlCMpmQSM8V5k5sg7FdyWO0CFHQTj5i+vo5rccEjzuzw5c3WCqajpZt
Lbm+MFPCClCVyhm9Dvwk7Bs2asMdN2nhOc1fxPuMDYD7c/BDODYocjSSftFBhyy0
qFfUceF/MB/Cu6uGxpy5qA/9V2p4ih15WWgcWTs8ge6pUmWtkBVkOC7PfsaeUvVS
yWRW5FEn084Xp/Z9+ho+xID0yR4REtUI6qqOpHpY3N9+3TzSoPIzMd8QFIHiSk0E
wghAP39kdIgw47T8MCme16e6MbGgUw==
=P8zq
-----END PGP SIGNATURE-----

--yWn+MXqavpBjLzGe--
