Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1294E6E50B3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjDQTQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjDQTP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:15:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F99940E1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:15:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 170F36208F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 19:15:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75103C433D2;
        Mon, 17 Apr 2023 19:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681758957;
        bh=3pjer+RGMILMz18g1Tf5vlj2E6yHnERNJKjfP9RlMZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P71Uwm3OV9bNItKXU+tAYmFshPVvY4lQzMfChiVKoKQbqxnxcEbNn6amFMSanMuaL
         HGgGWtX0E2oEKL1POmtRWv0crAZDTtyk3OtHm9LPwSL3I3PIx1kCqU9LstG0t22PSC
         zp0eFMcUz0c6vAWXenaBoOLcR6ig5XGTetQtvDLGRpH/0g2tmQdbb/xWCrUUy5khCT
         3z4okM/GsAc1JEHVYLeFVhfpR62k1tz2GbLjLOT4KEIOsdaE2Nuv/rD9/kdm6M77tx
         jlg0JZjAYKt5bLmZMdgGwN7yMSwCV9Bzvh+c16WueNqQZRbS2wEjdGtAHQBh1XT1C4
         fk7gnZ3f+5GhQ==
Date:   Mon, 17 Apr 2023 20:15:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Liliang Ye <yll@hust.edu.cn>
Cc:     Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        hust-os-kernel-patches@googlegroups.com,
        Dan Carpenter <error27@gmail.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: fsl_mqs: call pm_runtime_disable() on error
 path
Message-ID: <591e902d-afb9-4b2b-baa0-910b6d74e4e7@sirena.org.uk>
References: <20230403152737.17671-1-yll@hust.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9F6xcT18d9sN4CTo"
Content-Disposition: inline
In-Reply-To: <20230403152737.17671-1-yll@hust.edu.cn>
X-Cookie: I'm having an emotional outburst!!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9F6xcT18d9sN4CTo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 03, 2023 at 11:27:37PM +0800, Liliang Ye wrote:
> pm_runtime_disable was missed in cleanup operation, which corresponds to
> the earlier call to pm_runtime_enable.

This doesn't apply against current code, please check and resend.

--9F6xcT18d9sN4CTo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ9muYACgkQJNaLcl1U
h9BMUAf+PnW18wz6sGANQlExJIeon2TwYOrrp9RHa2hkx65i/UJjI36L50t3jcg9
vZngy/COz43Es/GqsNfNBntqHgL66yH332vDc/17NXKRpf0jYb7oR6UO5D7WQPCt
cb/+PO4zE7sPIwDuOlemNGL8iqnV9ya6oXDPYJfmU0njYGJVClEkw9Th8iqu7dOA
dUOmGg6/Bdop+lAzX3S0W3EcocCHqHAJT3fXXcbttqLeP01KC4DOCnik29oBmMAp
t6lHdlgrDglj/HCq1u7LsZmoQG8GEtg1mdo43qNx3m1glwm3XehOmSZNh7G55qL6
BiL4K4amqeutEfx/23OAKiY3T2tuoA==
=Hr0m
-----END PGP SIGNATURE-----

--9F6xcT18d9sN4CTo--
