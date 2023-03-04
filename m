Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6F16AAC4E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 21:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCDUMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 15:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCDUMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 15:12:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BB818157;
        Sat,  4 Mar 2023 12:12:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1127A60A3B;
        Sat,  4 Mar 2023 20:12:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB187C433D2;
        Sat,  4 Mar 2023 20:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677960760;
        bh=lh2zO/N+K/8gqFuO7G82Vx4lZLxCoX2cMJOhzYzwZ0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FQiHuJcefAgrXBRuLlQEyxF2GAJ9TV0inkBwtGDr42z5WoTBFqXP2sJv8GoggRn/Q
         nWWVKAT43TyuBqloAGT71bqjI0bnexQp5y2lcBy0hl1TECfadEKi4g019Dm3YmzRp5
         6EbBxD9R9Sn4fF2W3/x0rLXg+GwoojkyDbP21htNG0+iQCORAOKZOX/ZYJXVI/DZQg
         UICpODjGOz10byXZOLxeg9x3z6oXTwMo01vBQJhiKko0TGIk9yJvn2CL/1ClA5TSDv
         ZMoNGJ+z7faXYfTuP0DESVtBen/5xlVk+TYjq3f16/YaRBvNcyA6CByaeEVbgcEZHz
         MEO4KMnpHqd7Q==
Date:   Sat, 4 Mar 2023 20:12:36 +0000
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
Message-ID: <ZAOmNCVtEIgXYhJ9@sirena.org.uk>
References: <20230302211759.30135-1-nick.alcock@oracle.com>
 <20230302211759.30135-14-nick.alcock@oracle.com>
 <ZAE//jJ0GHvLN1m2@sirena.org.uk>
 <87fsalbsd1.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FF2iHxi4V67JT3nv"
Content-Disposition: inline
In-Reply-To: <87fsalbsd1.fsf@esperi.org.uk>
X-Cookie: Single tasking: Just Say No.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FF2iHxi4V67JT3nv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 03, 2023 at 06:30:02PM +0000, Nick Alcock wrote:
> On 3 Mar 2023, Mark Brown outgrape:

> > on.  If there are no strong interdependencies then it's generally
> > simplest to just send the patches separately to avoid any
> > possible confusion.

> The cover letter was sent to every related mailing list (or at least it
> was for patch series 2 and 5+: scripting problems blocked 3 and 4,
> sorry), which is what the LWN article on big patch series which I'm
> following recommended: <https://lwn.net/Articles/585782/>. I didn't want
> to spam actual maintainers with more info than that, since presumably
> they follow related-according-to-maintainer.pl lists anyway.

> As for copying everyone on a 121-patch monster like this... well, I
> think everyone would have wanted to throttle me, and I'm not sure they'd
> have been wrong.

So given that there's no depenencies between the patches this
seems like a good candidate for not sending as a series in the
first place.

> I don't think anyone has previously suggested making it 121 individual
> patches with no cover letter whatsoever. As it is, those series that
> accidentally went out without cover letters properly Cc:ed confused some
> maintainers because of the lack of the cover letter. My apologies.

It's really quite common for people to just send lots of
individual patches when there's no interdependencies - a lot of
the generated cleanups do that.

> It does seem this is an area where I can't please everyone. Some people
> don't want to be Cc:ed, others want everyone Cc:ed on all of them: some
> people want series, others want individual patches for everyone. I can't
> do both. Sorry about that.

The important thing isn't so much the specific thing as making it
clear what's going on - if you send a series with no information
about the how the series should be handled it's unclear what's
going on.

--FF2iHxi4V67JT3nv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQDpjQACgkQJNaLcl1U
h9BpQAf/cwTCDQoO3DJHbW+V3KN7lXab63nPmzx8YLsOCN08E6dkxqkKu/k3gYfP
zycpsR1Fh/IlAxGnXkl9WxADQv939kf/JB3DOWZYucpIu9WxjNb2993Bh8O3RsWw
Mza2stTJNGeSr5CeOoim/tUHJW57nLz+9JkTgFzvf+bX62WMiBzCoXukhvoO46D5
qMvNkZcqd9Ukt2yacBkopxOJWgSlgBkvZ9rzqZCoCtJCEvReRuDtb+etI9xGwtBO
G/AYa1+jOm/8QvxGlxfBNAPHlOMaC9pTa759pYX+mL1vd6+ffO2WRM7s5ykm9FZj
Q9POomT2hjl0i2SwYXYBVsrva5MbWQ==
=Psnl
-----END PGP SIGNATURE-----

--FF2iHxi4V67JT3nv--
