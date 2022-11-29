Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3857D63C2EA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbiK2Ony (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbiK2Onu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:43:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B57355AAA;
        Tue, 29 Nov 2022 06:43:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECE6861778;
        Tue, 29 Nov 2022 14:43:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5A7C433C1;
        Tue, 29 Nov 2022 14:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669733028;
        bh=A4JzwDdzaEvxSZQvWjndFsFATLStcROSPLYAqY3CJ3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B9mKxGFhnbf9lKJX2LzX1bhAXfXxq4kRXT7ZTGhp6j8gXMNCz/Xp3H1+UBYZaTHNM
         s7YFAM08VbroLvBwddxwFPV/Z2IEKSmxRpeJN/n8tTiZYwNQT5pDfmP5ZbudA96hsz
         kMBuXHVibzbrrMJBIwG2ml1Zr4yoTmKMcbhXsRUq/QIkEDLTNw0Fb/abulkjfF3uNi
         zFxCzEBI/U1WeHdt4w2n8vrJDuajV8VdEEGQg+o8O4Mp8rxMTPi1HZ8N71Jxa37F+4
         U0CFQcBqaNiiyCp+y0oHeRfGJdmN9We4nSm7ChJvg6K+bFT4sVEs2P8RGiI6Znc/RG
         KMwK1O81Z15Yg==
Date:   Tue, 29 Nov 2022 14:43:41 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, quic_plai@quicinc.com, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] ASoC: qcom: lpass-sc7180: Add maybe_unused tag for
 system PM ops
Message-ID: <Y4YancXWvYEI+H1O@sirena.org.uk>
References: <1669726428-3140-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DGZE7aNRI3C4ls0o"
Content-Disposition: inline
In-Reply-To: <1669726428-3140-1-git-send-email-quic_srivasam@quicinc.com>
X-Cookie: The devil finds work for idle glands.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DGZE7aNRI3C4ls0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 29, 2022 at 06:23:48PM +0530, Srinivasa Rao Mandadapu wrote:
> Add __maybe_unused tag for system PM ops suspend and resume.
> This is required to fix allmodconfig compilation issue.
> Fixes: c3bf7699747c ("ASoC: qcom: lpass-sc7280: Add system suspend/resume PM ops")

That commit doesn't exist...

--DGZE7aNRI3C4ls0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOGGp0ACgkQJNaLcl1U
h9C7HAf/fSadhhCJnSstdbesNHxGGXznin38OXu/a+Gf2n7GYf0l4BhRVuVlvD0H
y9YdMhn+IQKfNJrxjsbP5C17GvUSThOPfBA/0IgG1KMtiduZbmqdjjo2V8zNVaqt
rfUgJXk7gP023glYJqM/itjXRk0ilIq1Fr3Kx8fHxk8a45Z8eoX/H70GP/q7NaZf
93kXyY/KWk3IvbVbCkwUvNrupcAjRVHczNo3JDCuJCHH7sWcmZc+EJYus/cXMpgj
jYfgvYudVtxjjIiVCC/zpG4XGbvUL5OABfx1xy2ZpgTal2WqRSike7DkL3+VD7DB
955HeYx+vf71gOaTaDvhXs/NpnDFzQ==
=ahx7
-----END PGP SIGNATURE-----

--DGZE7aNRI3C4ls0o--
