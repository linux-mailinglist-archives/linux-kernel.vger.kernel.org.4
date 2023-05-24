Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C2570F3EB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbjEXKPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbjEXKOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:14:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A94139
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 03:14:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D303632FE
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 10:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E532C433EF;
        Wed, 24 May 2023 10:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684923289;
        bh=fAJ/9c94p8jokuPvjpX6AG9SWXwN966uEum3K7/L5Io=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ldjdLCGh1uJ2M+preJPllwAzA6UDUxpQe8I8E1hlH4nW6nl9d4QGUIeCmTMqQIgiM
         CLmDOqEenSAc4r4QZK1oGI0HV7Ct0tml1f3T7LT7B0Kj4QZdgWDPBOi85bRQVze75f
         2CpNRWl/8prOXlR2o0f7Avs8Hk+tv2146Azgq0wEmhyW/MKfUzfDnFDIXWKZgkJZK8
         s6y54Y7AHbsRvGjYwI4a9nciGV42iyf9290zNc04bFFbE0PLzsM2TMW0pjmisztVIf
         eR0MN8ZZizkp3pftej78bPpPX3RLjg3HHVDMXyibFE5BtnJz7WrLuMOmD9hkX9BaO7
         +oVzzJ68zDkgw==
Date:   Wed, 24 May 2023 11:14:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/2] ASoC: codecs: wsa883x: do not set can_multi_write
 flag
Message-ID: <8becb36a-107a-4d92-8279-d4c55edc9076@sirena.org.uk>
References: <20230523154605.4284-1-srinivas.kandagatla@linaro.org>
 <00283665-e44f-457b-b2c9-1acf59d1cbd8@sirena.org.uk>
 <c37b88ae-7f54-3c07-666f-010a5fd84bd1@linaro.org>
 <d94e734c-e816-4b3f-9fb3-a6589063c05a@sirena.org.uk>
 <af7b7d4f-d7ab-b5ef-e639-9a8b13de54ee@linaro.org>
 <c24b2f1c-3b08-492f-954c-c4f10ae5ad81@sirena.org.uk>
 <bdceb6e4-9de8-07ab-502b-c526e97a592d@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U1MramEXXsC4AvQ1"
Content-Disposition: inline
In-Reply-To: <bdceb6e4-9de8-07ab-502b-c526e97a592d@linaro.org>
X-Cookie: You will be divorced within a year.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--U1MramEXXsC4AvQ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 24, 2023 at 11:09:32AM +0100, Srinivas Kandagatla wrote:
> On 24/05/2023 10:48, Mark Brown wrote:

> > > Is write callback used for both Bulk writes and multi-writes?

> > Only multi-write at this point but we probably should consider redoing
> > bulk writes to use it as well.

> By the looks of the code, its other way around.

No, that's not possible.  A bulk write requires a contiguous block of
registers so can be expressed in terms of a multi-write but a write with
discontiguous registers can't be done as a bulk write.

--U1MramEXXsC4AvQ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRt45MACgkQJNaLcl1U
h9B2eQf8DvRiVD+RF/FcRMx48sGR2udjLtdDRSP3D/qN/Ht8RF0lD3oGS9RB7mM2
SZ+/ZLN3kvqUZTrCu345E3N8cZJIsjFS11WmGi+BrNmJy10sUWkD4BS6vN1a+yG6
lHJIs/Gz1F3+bs/QTJK0F2Otd8qnr3F2CoOqsb437m1xuACiwnJKqqdGmuGF6cAc
9IXDbCS2LVUSOhkO6eKxM8IfSC5KHkY4DfxE73gHUykUSjUq5C30iEjTGvjccfn4
FvuzM6t8klOkTbIKNYRw5SDb9r2ilRbz90I+tUEl+ujWP4aFfCWbk/krV9zYaYmL
EDQ+KE7k21XmjWKkf6bu2tAK66CktA==
=WB4b
-----END PGP SIGNATURE-----

--U1MramEXXsC4AvQ1--
