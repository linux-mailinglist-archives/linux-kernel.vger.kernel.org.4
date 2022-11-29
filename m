Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491F363C00C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 13:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbiK2M3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 07:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiK2M3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:29:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187515D6B7;
        Tue, 29 Nov 2022 04:29:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0872B815E0;
        Tue, 29 Nov 2022 12:29:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121CAC433D7;
        Tue, 29 Nov 2022 12:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669724988;
        bh=5/zWs23/mnNl4PE9sJrMpmtkRckoGhnJBGPeass5SAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SShJla8Y8GuOg69pR8pSutZ8q2WkNT7VOMyMNuVD7PlyX1YDY0THvOaL0tE9etnvv
         meJ/WCvJW/iTlq9e4IDFVxw41R8bxvXnkFNLfB9To//bODdcH34O/vrUxLguIyeKdA
         VQO8PgAcuNNCprkMWKtST7kLILYESrK0q4ZshOb1dOaQDm2lKWuz7DE2TYPyw0lmVQ
         4oRb3zaZZUhKeut7Br0o9vE7EOgMUiQX4m831RHfE2UBRIvc0WdyAGgko8trD1aI60
         UKxriGLQKatXdYTFa9lctuucRSMhm4KYJc6hJbgfLYoDfgULGpI1h1iEefSXJ0Pt2Y
         4f2L4xA7CIFvQ==
Date:   Tue, 29 Nov 2022 12:29:41 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, quic_plai@quicinc.com, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: qcom: lpass-sc7280: Add system suspend/resume
 PM ops
Message-ID: <Y4X7NSrvuKCb+eHr@sirena.org.uk>
References: <1669724411-14840-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nk9KEKTYlNAwdPwy"
Content-Disposition: inline
In-Reply-To: <1669724411-14840-1-git-send-email-quic_srivasam@quicinc.com>
X-Cookie: An apple a day makes 365 apples a year.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nk9KEKTYlNAwdPwy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 29, 2022 at 05:50:11PM +0530, Srinivasa Rao Mandadapu wrote:
> Update lpass sc7280 platform driver with PM ops, such as
> system supend and resume callbacks.
> This update is required to disable clocks during supend and
> avoid XO shutdown issue.

This doesn't apply against current code, please check and resend.

--nk9KEKTYlNAwdPwy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOF+zQACgkQJNaLcl1U
h9AKHwf+NgNP4dQ8gsJFECdo50AJJbF5NXrLqkT8an+WcFY9FZWolfTEfn8cmd+q
yL1z182glbD0QnPWCpQK95miBGDu7D96ETOD3wZ7/bKHUiOSDj6a0SfHDZuPZrnd
Gv7YDHd99C4/BmtoWtKFnitVq5poMPALkxrukGkuAMxBJqkjBLbnJZ5q8CXZrUXG
ztFc6lS9PYtDan5WEAxfpflXHCAuLy/5y0DVuhxutdQdSLWOZBYRGR6uqzTwf/NA
XfKKbPSUV8KTQfWGoyNAVxDFiudi7BkZUU2+egj7tsKfDW9TfSrw1ARZraXsHamK
I+02cFMnwVzLIPiPQtDHzvmgMGNMZg==
=4Dou
-----END PGP SIGNATURE-----

--nk9KEKTYlNAwdPwy--
