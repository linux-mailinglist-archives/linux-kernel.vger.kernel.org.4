Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9556A8E2F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 01:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjCCAeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 19:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCCAeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 19:34:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F04F3A8E;
        Thu,  2 Mar 2023 16:33:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3932861650;
        Fri,  3 Mar 2023 00:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226B3C4339B;
        Fri,  3 Mar 2023 00:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677803517;
        bh=PZRHS2ZDdyUW2dpnwGHL8YvvYRiGH5FDvsJ/j7DwmM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uzSDzBpz4fmFCbf3D1QuAA5mncF/iT7AlnCAoZTPzzGNhp27+T4uKk4/KA/29d6AH
         jZBdTdlj3JWWwgY5NOnDk8eQpPrDqadh4vzzjPIYuhl1sjAL+WCT6NZUHXlNvnGaKa
         rT/xQVNO4Crgsog3RwPmMYlkyOTTjXCvuX9hR5/dOSFjdDazNueZcw9qtC57sIBWxZ
         9BccpcAHYbx+GY2bnb//I8GR4j4jbVutCEh9k5Sdj0HYBbCXVPQbbWwcN+MxNLuvOD
         EDZJJp3NZ7uvzmaPhp4Ueb8mGepRj7+vgXZP24rYw7ZGfgE8Mun91CBpVK/buHDyuD
         1hzS1G8SEfvCw==
Date:   Fri, 3 Mar 2023 00:31:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 13/17] regulator: stm32-pwr: remove MODULE_LICENSE in
 non-modules
Message-ID: <ZAE//jJ0GHvLN1m2@sirena.org.uk>
References: <20230302211759.30135-1-nick.alcock@oracle.com>
 <20230302211759.30135-14-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZDUqYhnMhlBcRxOs"
Content-Disposition: inline
In-Reply-To: <20230302211759.30135-14-nick.alcock@oracle.com>
X-Cookie: Single tasking: Just Say No.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZDUqYhnMhlBcRxOs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 02, 2023 at 09:17:55PM +0000, Nick Alcock wrote:
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro

You've not copied me on the rest of the series so I'm not sure
what's going on with dependencies.  What's the story here?

When sending a patch series it is important to ensure that all
the various maintainers understand what the relationship between
the patches as the expecation is that there will be
interdependencies.  Either copy everyone on the whole series or
at least copy them on the cover letter and explain what's going
on.  If there are no strong interdependencies then it's generally
simplest to just send the patches separately to avoid any
possible confusion.

--ZDUqYhnMhlBcRxOs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQBP/oACgkQJNaLcl1U
h9DY3gf/Ri+5vS1m3/yKzksHQgSn4OR0nHC4qjB5n39Me0giqfbnkLhJvJ3Zs8dd
36YSWsKIE6IszlJcJO097L7r/O6Nb5tct7Gwhw5HJFC7KZ63CbLjl/1mQ2YNc23w
TwCYthOfm4cLjStFjxkTCBZtKuuaI9yqZnYwIX79+hAzPQ16RgUsna9SEYI0LxtK
jPS9KUw0FIBXKmxXvaybwQJFVBHPDwPlHx2+HidUJ4s3zpvzJWlvB9pUc8FkjZoY
MGoy3/CiZnDy/05osLyb4UdmKRlg5+D+8ehNWQWrxGMy6Gdzm+0g2WeRFjkwHopf
+VwWGTp7AlMQIdV9r9yxknKPZzbZiA==
=mlc0
-----END PGP SIGNATURE-----

--ZDUqYhnMhlBcRxOs--
