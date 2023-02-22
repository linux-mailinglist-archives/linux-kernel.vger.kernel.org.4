Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A3069FA6B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 18:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjBVRuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 12:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjBVRux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 12:50:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E746A3E603
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 09:50:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99E30B81642
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 17:50:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982CAC433EF;
        Wed, 22 Feb 2023 17:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677088250;
        bh=FvBZlk5mLwt+3ZRB8wFA7Mqvo/pBgXd+Dx6oCZwiodg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hc4AAxyGuVXpg/cMlQgTfjOFgua1wMI5un/77VgoWj/3yxku2JBCZ+Gtsn2J5Bmzq
         1RtuB1WX5EcE1EEX+9Xtj1Sr52l3KIFcznLAsMbWMtHn3Z5owNeyi0yhFDFYO5Abwz
         /9uZC4RFtQqrB1c3xUppjq4qS0BWp5HAJeO2qypWv9/7bJQ46y2WN3TszCfC92w6lT
         qyFoaO4ZEpfM9rI5mCEfjmGsV+Cjle7+n9lQjcKreRd0F+xP1UFL4bP3loo6/MYBgz
         jyWOPMKv28uTSWG6Rg2Sn9/A5E1DwAsjuq8F9cTorj2YmCARs4ky4XxhpfIwBS4kPE
         JTmPJj+pbEOYQ==
Date:   Wed, 22 Feb 2023 17:50:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Luca Weiss <luca.weiss@fairphone.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v1 3/4] regulator: core: Probe regulator devices
Message-ID: <Y/ZV9J1SMwtRUa3N@sirena.org.uk>
References: <20230218083252.2044423-1-saravanak@google.com>
 <20230218083252.2044423-4-saravanak@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oaqtWT+m8q2hxjGF"
Content-Disposition: inline
In-Reply-To: <20230218083252.2044423-4-saravanak@google.com>
X-Cookie: My LESLIE GORE record is BROKEN ...
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oaqtWT+m8q2hxjGF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 18, 2023 at 12:32:50AM -0800, Saravana Kannan wrote:
> Since devices added to a bus can be probed, add a stub probe function
> for regulator devices.

Why?

> +static int regulator_drv_probe(struct device *dev)
> +{
> +	return 0;
> +}

This is just an empty function - why do we need it?  Looking at
call_driver_probe() it doesn't appear to be required.

--oaqtWT+m8q2hxjGF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP2VfMACgkQJNaLcl1U
h9A60wgAgtYECdMobWhmOMVZ/b/QfG31wv8XC1tppiCLSMXP0MEVEyGGTTWn1sbZ
G+yj8t579X552zBW3V43DlfHQMzousTpicJh68jcsQthPPHiKi8vGLY/4EoME2dT
aWqKVKJUhMld0Roz4uVHiHHGNS9YwM0/WCMAwBOZ+PvtD/tUgvbYAVEoidBRvmxB
s19HIYTuCpSzdY2Q87KgaIrp6+wi+X9luiAUufxBwiHtCFMJhmCyVfZnD1KeHoS5
3zrJgTlrLuHZj0la3yUeIrl/DaBhGVAjKqCAYE66EQ113FGDWCzYqc0a3HEGFEJz
io8l6SG7pnMaGaDWZpKIic722Og+NA==
=rXOX
-----END PGP SIGNATURE-----

--oaqtWT+m8q2hxjGF--
