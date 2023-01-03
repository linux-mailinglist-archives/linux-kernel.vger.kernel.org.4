Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527ED65C550
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbjACRrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238548AbjACRrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:47:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37CBFF1;
        Tue,  3 Jan 2023 09:47:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55316B81061;
        Tue,  3 Jan 2023 17:47:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60C8C433D2;
        Tue,  3 Jan 2023 17:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672768024;
        bh=HpEuUON7T/Taa39AKkC9kQKGM4tGcAYDWm8d6gKhEww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IefW0jsYXRbKMusfop78CLgIBsW6GonX9SslmNu4evz/hKWH3F3FzN/vFEGORhA9g
         50RsL0ANTl9sKyYWjgMTRMA2m3CrDXymK8WS81gNbpIVIs2NkwQMxuHsXGdWJm+AQ0
         +byzDL000f6Je3jALyR9tDx+ELhCH2sU7Q3/foFXNk0qr62xERZcXCZDPtARipKANo
         jYoYw/8dvRHK24p44Be+rSAWGCvWjNZlXk3IbAPJkPg/OE9J1cy4HZRjUd+SDnu/7n
         LQUHh/hjipjMCzy/zziy+HLGM3JsTwxkyN9TiLxQ5Uu/2oTSEBnlxgnjl2CVX49ahQ
         HNOhwW+7kmoIg==
Date:   Tue, 3 Jan 2023 17:46:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Wesley Cheng <quic_wcheng@quicinc.com>,
        srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, lgirdwood@gmail.com, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        Thinh.Nguyen@synopsys.com, bgoswami@quicinc.com, tiwai@suse.com,
        robh+dt@kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
Subject: Re: [RFC PATCH 14/14] ASoC: dt-bindings: Update example for enabling
 USB offload on SM8250
Message-ID: <Y7RqEM+GvBQbmBTb@sirena.org.uk>
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <20221223233200.26089-15-quic_wcheng@quicinc.com>
 <f57d8d44-651e-b51d-dd72-bdf15801958f@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PO3S68PHtAbTyz04"
Content-Disposition: inline
In-Reply-To: <f57d8d44-651e-b51d-dd72-bdf15801958f@linaro.org>
X-Cookie: So many men
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PO3S68PHtAbTyz04
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 26, 2022 at 01:27:21PM +0100, Krzysztof Kozlowski wrote:
> On 24/12/2022 00:32, Wesley Cheng wrote:

> > +            link-name = "USB Playback";
> > +            cpu {
> > +                sound-dai = <&q6afedai USB_RX>;

> Hmm, that makes me wonder if you really tested the bindings before
> sending? If yes, where is the USB_RX defined?

It was added in patch 2, it's in include/dt-bindings.

--PO3S68PHtAbTyz04
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO0ahAACgkQJNaLcl1U
h9AKVQf/fc7Y7J2DCQMq65W+xhq5tWOw1Qchwes0+mWkJqejTVwv6w4CSEKMF2XY
Lod25qJvGe5s/RZXqTFYlJFpL3XpOC/aKU2lMROweZC7uZ5uL33u0WgoIHNcS6eC
mLWEupWXoX0BUYhs2IqmQaScXcAv6A5vyfss0TYYbDUv/0HDJS4hDAI3qE+OPvxH
tcYr+MERsr1SC/UP5kK0mj/KjKziNL7kj3tfAr3cbm6nfNDRm7ZBwcVdUOOYYqmC
lhSRvfVI1sodgqiIwd2SVp6cYTR+M4h7+OTP7gFq2gbq2ZJep6Cwh6OalJXvUFMF
7F1mQP986vnD+xoyCWMU3Dv7uHg+4w==
=aEau
-----END PGP SIGNATURE-----

--PO3S68PHtAbTyz04--
