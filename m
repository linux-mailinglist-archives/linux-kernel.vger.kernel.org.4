Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F023622C72
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 14:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiKINeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 08:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiKINeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 08:34:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35645252BF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 05:34:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3F07B81E6E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 13:34:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9CEC433C1;
        Wed,  9 Nov 2022 13:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668000842;
        bh=iLOLzZH3lZ0qvtTlUeIyrFI4l/lH4TDEVH11XOog/eE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=omUyaOtEQPiBhzHY1L9VpnHLIuaVkl0eYg9QuoErXUGMd2VUn0mOwLqybB9km4gvd
         rqJmvCfhlTtwp4/s9hNOzyXErsnghwrNr8wY0DoAk3d+902p1IEeBF7SoP0DJIEvk3
         13IbKN562xfCr/xkoX/7c9jFUlRXseeoTkUx00AaAQJP6iSl6GUpjNXknwRpGMAJrm
         i3zVBOS2PraWOAC5F3q6rlHBIBg+D/HUhYwceoEL0vkE5MnrE/nx8LPEShMo7wDq5D
         T+fJiE0kcX/MrnjUBJOLBg7ZGhsElu+u+jCaUH2PZ0cwFjWnAA+OE9UaFiHtTU46nm
         cDmPqvckggbcg==
Date:   Wed, 9 Nov 2022 13:33:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Joey Gouly <joey.gouly@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lennart Poettering <lennart@poettering.net>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Topi Miettinen <toiwoton@gmail.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-abi-devel@lists.sourceforge.net, nd@arm.com, shuah@kernel.org
Subject: Re: [PATCH v1 2/2] kselftest: vm: add tests for
 memory-deny-write-execute
Message-ID: <Y2usQ6HjvwDEisCY@sirena.org.uk>
References: <20221026150457.36957-1-joey.gouly@arm.com>
 <20221026150457.36957-3-joey.gouly@arm.com>
 <Y1wLVsg8VN26xI7j@sirena.org.uk>
 <20221108173303.GA53007@e124191.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PkmQYXH0bfQF8a57"
Content-Disposition: inline
In-Reply-To: <20221108173303.GA53007@e124191.cambridge.arm.com>
X-Cookie: Sign here without admitting guilt.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PkmQYXH0bfQF8a57
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 08, 2022 at 05:33:03PM +0000, Joey Gouly wrote:
> On Fri, Oct 28, 2022 at 06:03:18PM +0100, Mark Brown wrote:
> > On Wed, Oct 26, 2022 at 04:04:57PM +0100, Joey Gouly wrote:

> > > +#ifdef __aarch64__
> > > +#define PROT_BTI      0x10            /* BTI guarded page */
> > > +#endif

> > We should get this from the kernel headers shouldn't we?  We generally
> > rely on things getting pulled in from there rather than locally
> > defining.

> I believe the mman.h included is from the toolchain, not the kernel's uapi headers.
> The toolchain I was using didn't have PROT_BTI defined in its mman.h

I'd expect that whatever we're doing in the build process ought to be
overriding the default headers provided by the toolchain, that's kind of
the point here...

--PkmQYXH0bfQF8a57
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNrrEIACgkQJNaLcl1U
h9Dd2Qf+JstBgiUB9xskBNs/qV0yCbAwDcm1yxj1hcr7EBTB6UpqUs0dFMDc7viS
tGVkyALj5WpqjA7o5D8zc+LMhA5cYPNZwNwuXm0DBcHp51LrlC9REsBLihDvOLDh
S+wOnXfoajkP5Ujt2yRcwPufZ7tQ5z/SZJcy9LhffgLy/fC9cYiYviLakrw1P3Ua
6nm3muwCUaXteqgQHzduoJe7DXTOmROICv1r6yHSIwLHMIELEFAA89rHgIwpGqH/
UvqiB/v35R63DufGRHFedDk01tG5ZGe7wm7P9+1jlDVSECMJGI4l2MZyfn/iEekW
+FVctvLpNpeb4nlV98EwvIx+OtnM+Q==
=hO+N
-----END PGP SIGNATURE-----

--PkmQYXH0bfQF8a57--
