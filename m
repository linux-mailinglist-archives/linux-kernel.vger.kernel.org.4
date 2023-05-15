Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CE77020F6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 03:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbjEOBI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 21:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjEOBIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 21:08:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25C110E9;
        Sun, 14 May 2023 18:08:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6744C61008;
        Mon, 15 May 2023 01:08:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27439C433D2;
        Mon, 15 May 2023 01:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684112929;
        bh=UFENhqiakD8QEtrxSxXbki36RDciOCSV149yt6dLUlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MqHY9HYLeLXi4X5n8tlA7eZm0k1zWxi6SE24zzL6vY3HeFydLIlXAeZfuxfCQMdBa
         osGgaBJaF8NiHdQc5assWlUveJQw10+sC4S8OWBhynMwo2mxBIy+Msyj0NIcnDvvNo
         5b8/xoJ5n5lQcnI5XXaUJMc0wDG24CSzavQJ7fPOlpSeH9Il55dc4LUGodOXpP55/I
         HjNP2l3t8ohx6pnNvdPpXMbNvFjRG8OCL3Kbc+RHCubIgvOPeWdfo2pA8btRes3QK0
         dRvploNr47/xOMW0g5jhccZMEN3xea4i3rwgcvmVQpGNxagOCMHDtrokcbVqr8F/BA
         xxdBfc0HZjgdQ==
Date:   Mon, 15 May 2023 10:08:41 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Marc Zyngier <maz@kernel.org>, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tglx@linutronix.de, linus.walleij@linaro.org, vkoul@kernel.org,
        lgirdwood@gmail.com, yung-chuan.liao@linux.intel.com,
        sanyog.r.kale@intel.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] irqchip/cs42l43: Add support for the cs42l43 IRQs
Message-ID: <ZGGGGcZNEx7o8GC6@finisterre.sirena.org.uk>
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
 <20230512122838.243002-8-ckeepax@opensource.cirrus.com>
 <86o7mpmvqq.wl-maz@kernel.org>
 <20230512153933.GH68926@ediswmail.ad.cirrus.com>
 <86mt29mt2m.wl-maz@kernel.org>
 <20230512164233.GN68926@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="elVqdTBpOwS6uzdG"
Content-Disposition: inline
In-Reply-To: <20230512164233.GN68926@ediswmail.ad.cirrus.com>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--elVqdTBpOwS6uzdG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 12, 2023 at 04:42:33PM +0000, Charles Keepax wrote:

> I guess if Mark doesn't mind I think the only internal bit of the
> device that uses the IRQs is the CODEC driver so I could move the
> IRQ handling in there, it does seem a little odd to me, but I
> guess I don't have any problems with it.

The obvious (and previously standard) place for it would be the MFD.

--elVqdTBpOwS6uzdG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRhhhgACgkQJNaLcl1U
h9AQBwf/Vl7z7xogRyvrOyQVvmOhb4t1sIM1jgniNv/+CSDFa4/NyBY16e3xpB59
b5NYJGg0YEv4Zo19kQql1gLRJPIaW5AkS+gK7qIFRlAnnx8aJc1MlwrVWZKUmRPY
eoJMOiHSt8WnHU2ib94i8kpDtpzPI5D9nmTnn63wWCiWEv28gu57kGp21j/5zuBi
FssPHGDJIIskV8g7lqRxjNmY/eEy22/afYtGy9yYS9yyqPZCFATQ/998Fo+r11u/
OWS0qAXCzxT+3OKj/nabwTenvVqnwXjCmfdI4Oq83I3Ecf04lVHt+hxk1SLACcdz
vDQ+BpPpUMUg561BpqXtF0Vv5KkdSg==
=ORMJ
-----END PGP SIGNATURE-----

--elVqdTBpOwS6uzdG--
