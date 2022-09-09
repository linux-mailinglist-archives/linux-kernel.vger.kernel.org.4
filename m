Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2B35B3F00
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 20:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiIISrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 14:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiIISrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 14:47:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC36130842;
        Fri,  9 Sep 2022 11:47:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C078C620B7;
        Fri,  9 Sep 2022 18:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D79EC433C1;
        Fri,  9 Sep 2022 18:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662749265;
        bh=KQAifQugDA8mdZXeKVOC1h5AUP6dZ+XfBsejVtQVVyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cgis6XqH+8A4x2sfm5RGxquGi/ap8JDpYGVGSK8HwEdDNx9f5uJzm9g44eIHLEtXb
         R187VsPfk5yB/JsY5GwlNxySWc4RTCwZVw0feIPS4QQ1GhXcfYpgGS885Bqy5kaRL9
         avZjnCAVL9s6dAmPYNaoX/y44661Bmk05HgfmWNf6w0v0Y1K1macnFc8tCxGzLk2NZ
         Coh25f8O/4jRgf/a2IP7k7vp+X8jFEhscUUP0am97p9Fy1xWzsYV77DLii59RlxTCR
         zIT0JQgHHROtYIFeIYrWFBIrOFofnUerphTtiUFgOsUf0dMPEv7elJPm7Ac23xEY7O
         DC7lp/fo/BKTQ==
Date:   Fri, 9 Sep 2022 19:47:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Astrid Rost <astrid.rost@axis.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        kernel@axis.com,
        alsa-devel-mejlinglistan <alsa-devel@alsa-project.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: sound: ts3a227e: add control of debounce
 times
Message-ID: <YxuKS7S3/aHtDNMq@sirena.org.uk>
References: <20220907135827.16209-1-astrid.rost@axis.com>
 <2b81d814-f47a-e548-83dc-b1e38857e8ce@linaro.org>
 <Yxn9o1MVMPnFO3PM@sirena.org.uk>
 <ac2bcca1-6997-2d17-b1d6-a5e81ced2613@linaro.org>
 <9a72bd22-9298-65ce-a894-540f98745a7e@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Jqed1H5o0jXqkowM"
Content-Disposition: inline
In-Reply-To: <9a72bd22-9298-65ce-a894-540f98745a7e@linaro.org>
X-Cookie: FORTH IF HONK THEN
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Jqed1H5o0jXqkowM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 09, 2022 at 10:21:30AM +0200, Krzysztof Kozlowski wrote:

> It's more than one property and many other patch submitters were using
> this reason as well. As a result, few TXT bindings grew from 5 to 10
> properties within one year and there was still no conversion to YAML.

> I understand your concerns however I have stronger motivation to do the
> conversion, than for accepting new features.

For me the metric is proportionality - the amount of extra effort we're
forcing people to go through should bear some relationship to the change
they're trying to make.  We can't very well complain that people don't
upstream things if when they try to do so they have to jump through some
tangentially related hoops relating to the existing code in order to get
anything done.  We can and should *ask* people to do additional cleanups
or whatever but creating requirements that dramatically expand the scope
of work someone's having to do are a lot of stop energy.

--Jqed1H5o0jXqkowM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMbiksACgkQJNaLcl1U
h9A7Wgf/ZgdTJKiEDmpaLKTPfTfTsjf1KAym2sQrtDKauo+M6AOHc0PWCDgjnRC1
04Oi9yEs/3/WdJVIqImjQQEfzEfPH3SLekj4cwKGu1KM4Otog62IqZT2Ms3ZhMRR
TOBSy0lNibBQmrDehFTTrYusFwZI+Zri5JBpcEksWu7swxM/BKkteB75Xm0uKZo/
k80IIhTEaY6SBQ+3k/6cgvVJAFIRo1MFkdlOKboL7sZTKKVTE4F4P0Pdr+FlfGel
mYysNGLILSi4Awk9RaeSyiIcZmNSaW6OlOdaH1rFT3dl0Qx8Co7JGjm0SGkwO9uY
e6JJht7Nnigw5VzTrwNoX8w19iRlng==
=tvQB
-----END PGP SIGNATURE-----

--Jqed1H5o0jXqkowM--
