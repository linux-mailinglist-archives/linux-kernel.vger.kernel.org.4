Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185686BEDCB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjCQQOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCQQOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:14:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6EF222D7;
        Fri, 17 Mar 2023 09:14:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7964E60B39;
        Fri, 17 Mar 2023 16:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6E9C433D2;
        Fri, 17 Mar 2023 16:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679069668;
        bh=1pQRqWfj+GpCWMENR8ZnvXT1k2q8gneEQaUYLVxcKh0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gH8CC00x3SphiPOaLuoeGhXzQdR0uzhsyKjVcmB5fV0RDP0iNfw9jLkvyx2ngxPla
         mNr4Nuuz97pJ+J18yb80ju0PbcUpwQ4CiFQi0yuyohQYz0ljBpsQfXOMZWWVUAfTXN
         cIrcJEOqejRGu7BEDnFbAbejdTkKYsJLg1+ATQ59jvwLSitkWtRZuzoadGW2cWakK6
         pIzeSUVTdTqjsvG3PT+cJKmIWig5ycrCmZapyV35Pep4E9cUmTdrhJz7wrqnBSBRUp
         XRVDUqytMSc1DYltbI2/ersLQnZnXnV+T4zMma3sEc3uYszjp3zDy/L5Uh31EVeGJJ
         mgjRV4iwmo4Lg==
Date:   Fri, 17 Mar 2023 16:14:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     zhuyinbo <zhuyinbo@loongson.cn>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: add loongson spi
Message-ID: <76c3a130-0413-4e56-8c97-b3697efd5a9e@sirena.org.uk>
References: <20230317082950.12738-1-zhuyinbo@loongson.cn>
 <20230317082950.12738-2-zhuyinbo@loongson.cn>
 <a736c6db-466a-12e4-8e22-c8dc900978d4@linaro.org>
 <e944732b-9a2d-b6ff-8336-7363788809b9@loongson.cn>
 <7469290a-0671-7d2f-b0ce-cdde2a9e66cc@linaro.org>
 <c904c1ec-9080-0cc0-ae86-7d369d52e818@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TfiaVJaqPd0bQ/Nj"
Content-Disposition: inline
In-Reply-To: <c904c1ec-9080-0cc0-ae86-7d369d52e818@linaro.org>
X-Cookie: Life is like an analogy.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TfiaVJaqPd0bQ/Nj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 17, 2023 at 04:51:48PM +0100, Krzysztof Kozlowski wrote:
> On 17/03/2023 16:51, Krzysztof Kozlowski wrote:

> > minItems: 1 is not correct, so you cannot use incorrect code to suppress
> > some warning. This should be list the clocks or use maxItems: 1, if you
> > have only one clock.

> BTW, as Rob's bot reports, this wasn't even tested... Please test the
> patches before sending them.

If they're managing to see and try to fix warnings they're doing some
kinds of testing, obviously they've missed something you wanted doing
but there's clearly been some testing done.

--TfiaVJaqPd0bQ/Nj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQUkd4ACgkQJNaLcl1U
h9DFmwf/Sh61mkU1K6WOZKGKaJAPZveq9pY5ETorB7xp5gl0mH9Vg+eXzT0aukf3
wBZqOGNZWn2Pb7KkGivb+xSk/XHN3TTu1utVoSO1nY3fBgt2S16xqCM3ckHlagAO
5JEvldusT+YfznSFpLKEiSJYy11bEd3UbfV4Fzla6ETVVRCIIWa3kTvM+bahOdxc
0WIAC4JdpfYd4QpmfCtwvfsp3y2zj5g7Co4HiDLCuD38pTS+WDeEL/oW7oQpIZJc
jlMrCTcfPCmmKjiqyB2qJVR9w0cDeREk8pGCRPnhfUAxlHsdctJTVCxlh/fRC7JH
Z73sF+0nGX9NAiALvZb8bqFx0vJt5A==
=0mEQ
-----END PGP SIGNATURE-----

--TfiaVJaqPd0bQ/Nj--
