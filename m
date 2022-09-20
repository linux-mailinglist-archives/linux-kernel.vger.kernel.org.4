Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9B25BEC81
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 20:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiITSIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 14:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiITSIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 14:08:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6FD5808E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 11:08:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88C9B62128
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 18:08:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78AC6C433C1;
        Tue, 20 Sep 2022 18:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663697297;
        bh=nGyRyyWPdZouzB5RhOpe8C6asPklIRJUmgmC4z6ZMEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZSbOmsCb1ulQvVqCSfO/cK6oywJYZhHeLftps/oWevlT+caosBVy7UBtw4vRGqO9a
         Llm536sZDdYl+FGcCao72yJOaWmisMecj16H7udMXaJYb3QGr2lHwaRt/3jXAxVF3C
         2YGU6JA2GratgGg3Lw6TMe4yziC+LQGcmDtLAVo3SLR7V8AtY6+XTA0Sok3bbxCLd4
         Wmn1GopF6UMYphFHBbN8PTUV0lBV9mhFYmf1hHpN7u5zI6Q4zHM/Fmx4f4oAYXPsn+
         qt4lbUeS6afQhRoD+kwm7wzq+VbXeKFhzoBersbCYXs3K4R2q351K/2iwdjC4WEhqo
         lsfcOMRAM5Mtw==
Date:   Tue, 20 Sep 2022 19:08:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     linux-kernel@vger.kernel.org, Xiaoyan Li <lxy.lixiaoyan@gmail.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Sebastian S <iam@decentr.al>,
        Travis Glenn Hansen <travisghansen@yahoo.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: amd: yc: Add Lenovo Yoga Slim 7 Pro X to quirks
 table
Message-ID: <YyoBjHftjG/ACAuJ@sirena.org.uk>
References: <20220920171320.7776-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pBC45qtXHe6amJlR"
Content-Disposition: inline
In-Reply-To: <20220920171320.7776-1-mario.limonciello@amd.com>
X-Cookie: When all else fails, EAT!!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pBC45qtXHe6amJlR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 20, 2022 at 12:13:20PM -0500, Mario Limonciello wrote:
> Lenovo Yoga Slim 7 Pro X has an ACP DMIC that isn't specified in the
> ASL or existing quirk list.  Add it to the quirk table to let DMIC
> work on these systems.

This doesn't apply against current code, please check and resend.

--pBC45qtXHe6amJlR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMqAYsACgkQJNaLcl1U
h9AAxwf/WSm8pdfnfEKYMeAQnMBAVC0q9xPo59kuidAjXtmRSgN8+bDXNWT0qhLw
drsiLV7ReTO92v7tyAZ2xueCKZPReD2ZJ2jcejK4qa00Fo+7a+mYdxdaclE/2Ips
7fEc/cjReL9T1xp5PqxLokkRvHUR1Ka0NUJB1J+3WLzrx4Vh9aUBcWAa2DNGBDKh
6/ygFRFhPJtvyzUd8yBV5daTnY/imjfWqGPOJRcLAEixRhwWdsfSrLeeRi27whXO
Ie7KbjFjSApftp4LScBvhO9mRNuUJagRuRiBoMn/qiEq3ivUW2BRlisD0faqDGea
h4sZTnDfqrO1LSkOUHlf40VZd/S7bg==
=blfw
-----END PGP SIGNATURE-----

--pBC45qtXHe6amJlR--
