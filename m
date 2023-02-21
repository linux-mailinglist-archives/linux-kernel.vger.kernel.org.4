Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568D769E584
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbjBURFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbjBURFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:05:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9942A6E1;
        Tue, 21 Feb 2023 09:04:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9415360F82;
        Tue, 21 Feb 2023 17:04:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911F4C433EF;
        Tue, 21 Feb 2023 17:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676999098;
        bh=hAEQa0Cu32XX4S5t98j4S5gV6lruGeDQSN/4bgvhn/A=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=Ww6WfLdupADK0MXFIBnDSmjGalJXiMhimIkN+R4Rkl1zvQcxVgkl9l6c0/DzjWE/n
         TDhyDNklDu3+5PlyMk98AAFHGbmbMwwSNVSo+/EQ08lSPLGKpeH5rsv0DzsJAa+z8y
         ch+3PaKDBB8al2GFd/mpDBmvuJIuteHClzR3TKr5oIYBL5rsx8ET3NftGmBASbxFsj
         IglR6c560Ivtx+lMiux+/35+/J4m2COluMH0OHby9txUMP9GKvT0iNpCSSetJvoEZS
         X/R04jVPJbBc0rMJV8k336bpWY8+Atc9NAZ6AdoWkalqWbq26D5OqxEeh8c+ynKHlF
         iJjP3bda0I3TA==
Date:   Tue, 21 Feb 2023 17:04:53 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Wolfram Sang <wsa@kernel.org>
Subject: Re: linux-next: manual merge of the spi tree with the i2c tree
Message-ID: <Y/T5tevqPapMy/g6@sirena.org.uk>
References: <20230216113035.3050871a@canb.auug.org.au>
 <CAMuHMdVuudSDrWguMJiHsZ3GJhs+muK566M5GqK2vfMyBeo2pQ@mail.gmail.com>
 <Y/T4BTCCzIWzE1oe@imac101>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KAJzZplwoo3a+Wx5"
Content-Disposition: inline
In-Reply-To: <Y/T4BTCCzIWzE1oe@imac101>
X-Cookie: MOUNT TAPE U1439 ON B3, NO RING
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KAJzZplwoo3a+Wx5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 21, 2023 at 05:57:41PM +0100, Alain Volmat wrote:

> should I update something to avoid this conflict before you push the
> pull request for v6.3 ?

No, it's fine.

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

--KAJzZplwoo3a+Wx5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP0+bQACgkQJNaLcl1U
h9Dwjgf+JImyOC1iwoQTkysyQOyUpH4SoFTff9yxJz8dB6gDovtG4b5qktoSO29W
sx7F8yYiri0iZSccTA+uaO6OpTVZa+Wnna+zN4EgTBoC00uGhWP/Xo7iutX7O1p3
MQ8dYev2imIAH+SfddS67eP11OxfNvV3bLYCwGiWWYJ3bxHDGpBqm44o/vOoy5UD
LLQAYFlgDJdJl0z8w9saRiiCRPDfh1xhyEFc2rMQtu2AulDX5H2+7yKSA44vbLy9
V2ukLqNOXfNTOzkVMZCeKMmJYlY/vc72p+3ndFJqT3J+/XinNVKUJUud1psC6WFF
r4gDQgKjVx4RD9GYJvJ+JkPI3c6M5w==
=gK+/
-----END PGP SIGNATURE-----

--KAJzZplwoo3a+Wx5--
