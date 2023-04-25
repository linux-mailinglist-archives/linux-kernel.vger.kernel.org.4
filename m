Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5D26EE6C2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 19:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbjDYRdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 13:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234607AbjDYRdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 13:33:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0837AAD;
        Tue, 25 Apr 2023 10:33:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 699F361009;
        Tue, 25 Apr 2023 17:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D622AC433EF;
        Tue, 25 Apr 2023 17:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682443989;
        bh=mcnUcuZCsp42gOl0koyvCmjFpEs0zWYiqO16h08PCjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aMVYvKWDZ4NCuDhOb1y5atMlF1Y0M9iCVAWPsMGKAJrdFeuPJ0gC1F2uxB8nbcSiz
         dqR13DU+eu0L58BuFuDvnHdjpiAMtLSxQIEGYN3h+2WiiU61WQgz07AD7Q2qVt0eJt
         jP94kH2s2qdtjDbjOWXmYaGpSR/ZKSc8Ye4mmFBbuM8QO6Q+8zhcY+FtLBXC019Msb
         j7t4LVSoq62WmLyVDQiFcw4t4Cl0YSbwQopnBQ4f0WFe41aHswhlDQBh5goRQR91Rd
         rlYvFzwXMr/AxCKV2fIgOAtWmIFeNMxsLjSXq2D1cBTjvfZ2mrD4MRvEESRk9mcVvR
         uys9mkE0bMcMA==
Date:   Tue, 25 Apr 2023 18:33:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/4] dt-bindings: sound: Add simple-iio-aux
Message-ID: <7682a443-7ae2-4bc2-9581-304c7e72942d@sirena.org.uk>
References: <20230421124122.324820-1-herve.codina@bootlin.com>
 <20230421124122.324820-2-herve.codina@bootlin.com>
 <20230425173029.GA1967523-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QVyLAfDfdBkSU7kb"
Content-Disposition: inline
In-Reply-To: <20230425173029.GA1967523-robh@kernel.org>
X-Cookie: The meek don't want it.
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QVyLAfDfdBkSU7kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 25, 2023 at 12:30:29PM -0500, Rob Herring wrote:
> On Fri, Apr 21, 2023 at 02:41:19PM +0200, Herve Codina wrote:

> > +    aux {
> > +        compatible = "simple-iio-aux";
> > +        io-channels = <&iio 0>, <&iio 1>, <&iio 2>, <&iio 3>;
> > +        io-channel-names = "CH0", "CH1", "CH2", "CH3";

> Not really useful names. Do you have a real example?

I fear those might be real names for channels on an IIO device...

--QVyLAfDfdBkSU7kb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRIDs4ACgkQJNaLcl1U
h9B3TAf/cTeNpl+HMeW2P0Vb5nstfBc6zxXBQOKy5lEeUHK8Gl78nKrJyAGI1j2A
XfAyeEhz4pNgn/xIQ/8bV41cnTMawrGJeZiNiq/+3ns2u2V+2XkUPBv6R1B5i629
xI2lyb4p5VlnX6sRCzcvnXFyl1aT71+Rw9xOAjuJB+l8Y6k86eHVlV9bDIM2w6/3
TrJtACmWndoZhtS9PK86WA9WYrMnjBflNG6KmeeKxDHl0k/PsCvbpijSZBb6e3QO
zg8BcfitzHMyCcmTt643bGufvXRarx+y2OdU2glNckGHXPSeCmXHCU/jUNgnLwqW
d2OEVBQZOmA3Btwz9T+eAUuggPGb6A==
=ax2u
-----END PGP SIGNATURE-----

--QVyLAfDfdBkSU7kb--
