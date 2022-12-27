Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C35656B98
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 15:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbiL0OLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 09:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbiL0OLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 09:11:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605B11B1;
        Tue, 27 Dec 2022 06:11:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAE3B61157;
        Tue, 27 Dec 2022 14:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35E5C433F0;
        Tue, 27 Dec 2022 14:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672150296;
        bh=w1Tt5KpHeU6LrhFDV3MOo7Ka2OTOJdZOMGYD+HubpdU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MMmr8g6crtYz7sD8hp5VXA4d0W4r+qQfith6dYe66hivk1PanPlB8k2INiMFjpziB
         oAL3Rc/zqddnLdjZ8Y7vE1cxxeBjOfHpw8VCiWeFx4RQmfLcQm2IU30imG0SqUiJPQ
         YdiUnzoLNFwQ8nTcuGUozrnsMjEMphQHc8tjPb/32a5crd0tKPb5VcbNhSIN5UxrRA
         Gl9is9ej3XQlw8VUPOU+gTTc5CkQ9EK4km/A9AmWBUBD9Th3RKRGE7GkDz+qxegTJs
         vnTIaa4Zv8kbdnDp+XnezBZKvTDHE8ZeKcb28HR6/t+J0smuj/ZsOKOU7hiGzeA8x7
         0f6c5GSoBEAlQ==
Date:   Tue, 27 Dec 2022 14:11:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, lgirdwood@gmail.com, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Thinh.Nguyen@synopsys.com,
        bgoswami@quicinc.com, tiwai@suse.com, robh+dt@kernel.org,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_jackp@quicinc.com, quic_plai@quicinc.com
Subject: Re: [RFC PATCH 03/14] ASoC: qcom: Add USB backend ASoC driver for Q6
Message-ID: <Y6r9EKn7WU3eWl8e@sirena.org.uk>
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <20221223233200.26089-4-quic_wcheng@quicinc.com>
 <Y6bAQ8hDLkvrvjQQ@kroah.com>
 <Y6rtdy4NPfi/KOqd@sirena.org.uk>
 <Y6r26VfIfpE8zpPY@kroah.com>
 <87r0wl0wso.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MoDs+V7j52bwbfqu"
Content-Disposition: inline
In-Reply-To: <87r0wl0wso.wl-tiwai@suse.de>
X-Cookie: There's only one everything.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MoDs+V7j52bwbfqu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 27, 2022 at 03:02:31PM +0100, Takashi Iwai wrote:
> Greg KH wrote:
> > On Tue, Dec 27, 2022 at 01:04:55PM +0000, Mark Brown wrote:
> > > On Sat, Dec 24, 2022 at 10:02:59AM +0100, Greg KH wrote:

> > > > "be"?  What is that?

> > > Back end.  This is a concept in DPCM which should be reasonably
> > > discoverable to people working on the audio portions of this code.

> > Ok, then how is the reference counting logic handled here?  USB devices
> > can be removed from the system at any point in time...

> The whole picture is fairly complex, and this patch is a part
> belonging to the ASoC machine driver -- that is, it's bound to the
> Qualcomm host, and there can be only one on a system. =20

> OTOH, USB audio devices are still managed by the existing USB audio
> driver as is, and they can be multiple and any devices.  The basic
> idea here is a hijack of the USB data processing in USB audio driver
> with the offloading mechanism by this ASoC driver (only if the
> condition met).

Right.  I haven't even begun to look at the actual code here, just
triaging my inbox, so I've got no thoughts on if things work or not.

--MoDs+V7j52bwbfqu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOq/Q8ACgkQJNaLcl1U
h9AJLwf/TGoSsJdiOtmJ/KDGP2WpqZDVbQqPyJeobJzTd9iQ0WISteeWXhCaQzEP
prsfQuOnpN59pIx92wR1QiQhG1hIfloZm9D0+2GFs6ig70JB/2tR4vrDwyOvpJab
jdL+aAl495L95M2FyBU6iaBTSAkmJTiBro++bgcYRJHtExYiuVM0zSLnHnGXjpY/
Q8VngUTeGebIQnTK/yjDIqCamWLQ1uygyiEexa6irqBZJxAf5E2QXww1573HF1ma
7icaSGlaaDRvIz4f9tKvj7j7y++W8xHSZI/dUvGSQV++tuFVy5BxpysjqNncFT9t
VB0GkLnFBoQ4w00oIOLbYMsqF69weA==
=fyRg
-----END PGP SIGNATURE-----

--MoDs+V7j52bwbfqu--
