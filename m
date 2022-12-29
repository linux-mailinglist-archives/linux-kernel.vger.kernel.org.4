Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29376659087
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 19:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbiL2SnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 13:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbiL2SnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 13:43:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D97FE1;
        Thu, 29 Dec 2022 10:43:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5EE0CB819F4;
        Thu, 29 Dec 2022 18:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFB5C433D2;
        Thu, 29 Dec 2022 18:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672339392;
        bh=2spZdMfQOsgLpRN6s859fPZ+Jnw2GflP+qVm2+lS8Bc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TPvlpyCUfy7RcalmJQX+vq1mQzNmq2WzDnRZBtdc/AlIOAIv+Ua3c7d8Vpolqc6uF
         K0ID0y59DgFm24mmt0aqVF75kAfkB16dpJD2A2uUq1JIGKH22JbnwOrU5AnLmnRyW6
         YCRCgWoMBkZEr1aBajEcc+sws00QIhdEWPMgIydxhP0FgzhXrRAxcSjKaVx5wEhLEH
         tbopsIBQvVE21lfj6DjcvLfutfzk4xY0mbZpGDMNGQ8P8w20eM9H7pCT0OCGzV92Mn
         uLQrIJBdtlwwXMcaKxml0Xb8ipp8Gch6Jn3IrhaShvhkdkUQ6vCWnkwhrwUX7Kn5t0
         aZaorEPeVVVwg==
Date:   Thu, 29 Dec 2022 18:43:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afd@ti.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] regulator: dt-bindings: qcom,usb-vbus-regulator:
 change node name
Message-ID: <Y63fvNfPrnot+C6a@sirena.org.uk>
References: <20221031173933.936147-1-luca@z3ntu.xyz>
 <12119366.O9o76ZdvQC@g550jk>
 <Y63U+7LnWhixrW6g@sirena.org.uk>
 <12119923.O9o76ZdvQC@g550jk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z3ZeNJ1+njCR1Vg3"
Content-Disposition: inline
In-Reply-To: <12119923.O9o76ZdvQC@g550jk>
X-Cookie: TANSTAAFL
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z3ZeNJ1+njCR1Vg3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 29, 2022 at 07:11:10PM +0100, Luca Weiss wrote:

> The patch was sent end of October, that is two months ago. I don't think =
two=20
> months of waiting is an unreasonable amount of time and is also more than=
 "a=20
> couple of weeks"...

> And as far as I am aware there's no open review comments, which is why I =
did=20
> send the email to ask what the status is so that it can go into 6.3 and I=
 can=20
> remove it from my inbox.

Please read the rest of the mail:

> > directly if something has gone wrong you'll have to resend the patches
> > anyway, so sending again is generally a better approach though there are
> > some other maintainers who like them - if in doubt look at how patches
> > for the subsystem are normally handled.

I can't do anything with your content free ping on patch 2 of
some series...

--z3ZeNJ1+njCR1Vg3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOt37kACgkQJNaLcl1U
h9CwaQf/Z4NxCRl7WrOclDJl3WWzVQPeT7wiH2DeV+tWKgMsx8mLTs7ExoOYSWwI
7XsBswIyl+eQCcmrIqEo3yHsfdkaTasE8RvEOZgQxpNrcEMB8XwUQi4qGh9J6wJ8
120ofRV+I/7I8XqNz1wnLcZ/wbdR/oz1lUV9uTEIvg3i/sl/km/W+sHHUUZ7jX0U
g0+9PPEJI2nlKNS1Y2kIC7lBDApbwPE4ZvQik/cUThphU/sjF19qvokjSGwlLgq8
+DESdP7pNAsLrHDGzdjFeQNXlMBk85kcLW6pxosVlOW336+nEreZzeOX4Hrtqq0w
KgqNp7KiNv1FMk2sxaZzphfbTE70AQ==
=3Ffo
-----END PGP SIGNATURE-----

--z3ZeNJ1+njCR1Vg3--
