Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672366E7969
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjDSMKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbjDSMKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:10:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D562526A8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 05:10:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E7DB63E56
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 12:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51155C433EF;
        Wed, 19 Apr 2023 12:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681906244;
        bh=zXn7zJCUIG3ulu/Ol1+5Z/t1V/9CZ+gFKm/NZrXca8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fAl9F0b4N1Q/ALgKd++p4qmPo4uTpbJixPN/iSsdI2nRaczZkA/z26SGrvqLrQIJp
         EjtTMAoyO4b5BudvKLtUPXapdCrChXu0WiC77LsyKvjM1gDjtkL+sKKbr7Ry2bDwPa
         G3lIMXhSTvy0pTEpG/FqDKc0wMR3/2hlQzwgzWZWAiC6+CzWfDJxCHBNyibHqiyfsW
         eNACV1vNw1iTt9jrp9gHCjd6LKdlYCdfXJ3Os8Vh+DNDNZ/fDFv2ISgyPda+sfi/6p
         /lsSfEVVwBCtR7ugWI13LfL/jUmIyqWE+mjEjUHzjhiheOfWZT3J2jOTPCtoOiPynI
         XzUvXqMK8dm3A==
Date:   Wed, 19 Apr 2023 13:10:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     kuninori.morimoto.gx@renesas.com, shengjiu.wang@gmail.com,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-imx@nxp.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "ASoC: fsl: remove unnecessary dai_link->platform"
Message-ID: <536ac75b-9a04-4f01-b62b-a5ba94847603@sirena.org.uk>
References: <1681900158-17428-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Svnkl6ntiFrJF6sJ"
Content-Disposition: inline
In-Reply-To: <1681900158-17428-1-git-send-email-shengjiu.wang@nxp.com>
X-Cookie: This is your fortune.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Svnkl6ntiFrJF6sJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 19, 2023 at 06:29:18PM +0800, Shengjiu Wang wrote:
> This reverts commit 33683cbf49b5412061cb1e4c876063fdef86def4.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--Svnkl6ntiFrJF6sJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ/2jgACgkQJNaLcl1U
h9CvjAf+LMbQGyVZrjxwg2HmcbPI6CtACi2AKIxQckmP0FDevBjQG3Lrbs9uSIk9
EDhu08RXTZk9d5HT5c3iesNsESZPdoi9s/I5MNLXJ3qYSGO1F6twOD36u+MrpD1Y
e8HzFNtOKxOK0dCPNilpAdaJ0eXiiOU5XEsVaF1FVqWNts0gPpFTfI4t9o+i4YAW
WbPTf2TFZG4XtUmUJp6L7mUE/8Ng54+L/LSAMicX7D/DPZC10R+INJQCO8UgFsbs
EI00Rv7l3+ZhdBVLKa9i91jgZjDcMi8pzsgJ8gunLr7bD4b9vXCqayznWkMOC1p6
na9sDJqTXr57S3mm2kSQi78Y/sJD4w==
=TMjV
-----END PGP SIGNATURE-----

--Svnkl6ntiFrJF6sJ--
