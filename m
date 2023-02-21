Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8956C69E2A6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 15:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbjBUOuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 09:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjBUOuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 09:50:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27542365E;
        Tue, 21 Feb 2023 06:50:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D947B80DFD;
        Tue, 21 Feb 2023 14:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FBCC433EF;
        Tue, 21 Feb 2023 14:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676991017;
        bh=6Rmm14YsNUOlzop3ry9TteVVt0q20r8lVganoeDtVRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GS3zj5+SNUzEYS51gxnY3MQeic9ALJOdf7wOftKHZ/dMg6Pi2kxsZeCkBZFJrN3lH
         VlVENIBPYM1vkDgwHGquSSLr40hfg2/detwLBQCMeoQSKhdO1YT2KiSOw3OAOoacdW
         ZGfb6JmRFk0Z7sWjQmUh8vO5X08ePylZl0C0A6Dt7Tm908oN6Xkkz0Cf6RInkrnA5E
         srmxUAZILWstOXYV5RSQG7PyekVeshzX42io4u4ZcxYss5GOu7C5po0zrkcjqlrgXc
         1GUugepq/GQw2W6Lj1E7Bvwk66KlZPWO25LRGhqEwRLMPS3h/L9nExVAF+dM6KT/7G
         qtrMYsWL+3qZg==
Date:   Tue, 21 Feb 2023 14:50:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Claudiu.Beznea@microchip.com
Cc:     krzysztof.kozlowski@linaro.org, robh@kernel.org,
        lgirdwood@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        perex@perex.cz, tiwai@suse.com, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] ASoC: dt-bindings: sama7g5-pdmc: add
 microchip,startup-delay-us binding
Message-ID: <Y/TaIELG2HY/zvNJ@sirena.org.uk>
References: <20230217124151.236216-1-claudiu.beznea@microchip.com>
 <20230217124151.236216-3-claudiu.beznea@microchip.com>
 <20230220225601.GA545317-robh@kernel.org>
 <69c4eccd-9d81-ac0b-802a-8e4e0d57589a@microchip.com>
 <cbe2e397-7044-277d-08a8-93010de339ad@linaro.org>
 <d607c1b6-712e-5c8b-8cd6-86673f4b354d@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v1GqRFSqxa3haDVH"
Content-Disposition: inline
In-Reply-To: <d607c1b6-712e-5c8b-8cd6-86673f4b354d@microchip.com>
X-Cookie: MOUNT TAPE U1439 ON B3, NO RING
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v1GqRFSqxa3haDVH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 21, 2023 at 10:52:54AM +0000, Claudiu.Beznea@microchip.com wrote:
> On 21.02.2023 11:23, Krzysztof Kozlowski wrote:

> >> PDMC can work with different kind of microphones, thus different boards
> >> could have different microphones. Depending on microphone type the PDMC
> >> would need to wait longer or shorter period than the default chosen period
> >> to filter unwanted noise. Thus the need of having this specified though
> >> device tree. Would you prefer to have this in commit message?

> > I believe you also had explain it to me, thus as you can see having it
> > in commit msg would spare you two questions...

> Right, I'll add it in the next version.

TBH this is really standard stuff for audio hardware, having to leave
board specific settling delays is very normal.

--v1GqRFSqxa3haDVH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP02h8ACgkQJNaLcl1U
h9DVAwf/c/xfXkzb010seOik1EdUxRwGBKH158yesXV5nUZKs+BBc2sTL/rOEimi
VYP/38OzK7S0/9iPZkoLtPhalZwbiDFwGXOH+eivs3p1+qqg07azQ7Jb0shReSa5
uASjUxZjD0oiBb2CKcm5WAT96uflBqUDFgeKuEXQHKWr9FaoO/sDyUSVdkqKU1u0
zhLMyqpu4LWbbQRRIVzBwMn0IRWk0zlahtiDuSl3cjPeLtygqLmn2Wzcrm4nbJOM
EdYukt1imfPV2edcdMlEEay7hY2EoTUN8OzD0n/qiKJTBu18j9/U5OGIckQXzBA5
Ymc7N2+iwo6xRtz4QBCYRUBpVpIPCA==
=ln4v
-----END PGP SIGNATURE-----

--v1GqRFSqxa3haDVH--
