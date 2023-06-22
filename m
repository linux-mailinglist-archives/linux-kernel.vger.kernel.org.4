Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8E273AC7D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 00:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjFVWbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 18:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjFVWbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 18:31:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3C9195
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 15:30:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC15B618A9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 22:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A264DC433C8;
        Thu, 22 Jun 2023 22:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687473058;
        bh=o2GQvxEc5BpUp1uobg6mA0N6S/AMxodCCAZUHy9rv3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IAJCfDufzQNn/ivwQcKe6WpJWfFm6IrL67dtFzbHyRxVmBK/MZmxySXvhter1OFQj
         rE+PU0ik9gNKEEjyyBZTpujD7DAvmCxLf6UqdADbC9E0DtshpoTBM8gNCj7p6frZ+8
         ST6OuLvM9cD2v0BDKifK1y30/xDdnMcMjkctRY0B7CLvIbwrNXssL/V4znZctPSmTk
         apFHT7ZT/lBuy1bRtBEdQQeRzxQGZBqDhWaw4qNYvcx8fJz6Pj6v1LmQBuveYrEldL
         HyjQqVRzK33Gq0/BiK2NsiOps9YgHpbTda+OK2JUoPMI2iQPIp7mXbnIcEtbFM/Tyd
         uuZCfOtxfK3DA==
Date:   Thu, 22 Jun 2023 23:30:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Syed Saba Kareem <Syed.SabaKareem@amd.com>
Cc:     alsa-devel@alsa-project.org, Vijendar.Mukunda@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        V Sujith Kumar Reddy <vsujithkumar.reddy@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/12] ASoC: amd: acp: add acp i2s master clock
 generation for rembrandt platform
Message-ID: <ZJTLnhlCFhW/s4Vd@finisterre.sirena.org.uk>
References: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
 <20230622152406.3709231-7-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nQi7X9Rprs7bSeTC"
Content-Disposition: inline
In-Reply-To: <20230622152406.3709231-7-Syed.SabaKareem@amd.com>
X-Cookie: I've Been Moved!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nQi7X9Rprs7bSeTC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 22, 2023 at 08:53:44PM +0530, Syed Saba Kareem wrote:
> Add acp i2s master clock generation logic for rembrandt platform.

This doesn't apply against current code, please check and resend.

--nQi7X9Rprs7bSeTC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSUy50ACgkQJNaLcl1U
h9CrIQf/YzqP801ZgPJ9zmTLdD3IDdoFNp8w5tHi7C3z8VNtXZZkbnFZGVAWzlan
MP8yEnoCvBn0ICgC29Ynunspwp68zp5UgfP/scy0bmYuaaaa74ZAl2QUomJfP+8x
IRgfKhpr344++V8vie6k8sAybOx5GbPBvsmzq96mLgUlN/JzUXYhESiZUcblFLrr
1vZb8iYhnvFDzrL4WqpbfwZAyErut78uk1DEZsvBYbL3CsQ4aj3fTjYnV2AsWH85
Agg2eDKuVpeBWrlvOKBr/fvIRmtd1I9Ro3ncAiZnhLvdTkIXkaS09LybqQViY/qI
txlasQmpvJ+3OcqOEFgmT/m2GTaYSQ==
=/2GN
-----END PGP SIGNATURE-----

--nQi7X9Rprs7bSeTC--
