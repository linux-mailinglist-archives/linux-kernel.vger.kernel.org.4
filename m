Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE43722591
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 14:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbjFEMYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 08:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbjFEMYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:24:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A77A9C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 05:24:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 262FA62343
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:24:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF35C433D2;
        Mon,  5 Jun 2023 12:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685967850;
        bh=3XJ3CX74cEF4Q3nfqZps5CttXlclsjstFcGlPIPxyEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LK1vq9wAGu1rIw7HVwmgO8/4HPXscMR8ynOztaTsRQewzenEddwGbzUNMCEHawBhm
         L6c6c4mKNEx6HjFXDrSYebEf3+lBNvsSUS7HBqrRtC/FSlehigYdAywo/8CJO3RNMn
         QCu0v65m8hzBSDDdHpbvoQfApWRcLGaE0JzGKkXwzacS5MlD4XeiYn26fk/YjXn9u0
         6p7wDrsnnlXhElKftGTyx3/1bUMZu/PwKfgJrthynfyuVR6b+hNvWSukuOHybXv8/w
         0GyDczyLhAi/NVa74vYE+Jg6sKGbfBMPNVcRI/O2JphLhV2Q8wkvDnJs1au24rLh6x
         qcfuiBRAJB4Zw==
Date:   Mon, 5 Jun 2023 13:24:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/2] ASoC: codecs: wsa883x: do not set can_multi_write
 flag
Message-ID: <b3bc0a07-4dcb-4f50-a7b3-91a4a62fac56@sirena.org.uk>
References: <20230523154605.4284-1-srinivas.kandagatla@linaro.org>
 <168492769030.49784.4719862081052299023.b4-ty@kernel.org>
 <ZH2YAmBY-GNKABSB@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ok25a2MEpMxstcGN"
Content-Disposition: inline
In-Reply-To: <ZH2YAmBY-GNKABSB@hovoldconsulting.com>
X-Cookie: Biggest security gap -- an open mouth.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ok25a2MEpMxstcGN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 05, 2023 at 10:08:34AM +0200, Johan Hovold wrote:

> Is it possible to get also these fixes into 6.4 final?

They're already queued for 6.4.

--ok25a2MEpMxstcGN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR90+MACgkQJNaLcl1U
h9BuzQf9E2vipezYFq9x6blmKPb2enncfDAG+fuefll3u6zaRBmvsMSYn+h0w0gI
IuPcXAbCrCOietnX7Xa9A+3hF0RFYiKEjhWQZpNdq5zAOnd2IzSFDIX+AZvzSsop
tszKa+KFjvKLiGUvCnwwpJoNH/urkz+CHoFmY5jX22GXI8zbryYmVc4FIn2nfupk
jGMi3gRxmC1itgyIwjpMe3jCBtFNeDCn0Dxo3nRh2ggRn0aXhMlCFNO4vmxOE0SJ
MlrCHzAn26E4Sumkftlcwn9YlNCaejtYxwR85SW72EUfo7qFm+CpureSmJkXf+W7
BS/JwMuJ0rxJtsmqbmKHBaJJUY3C6Q==
=+bss
-----END PGP SIGNATURE-----

--ok25a2MEpMxstcGN--
