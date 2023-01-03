Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14F165C547
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbjACRob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjACRo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:44:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EB52A5;
        Tue,  3 Jan 2023 09:44:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC29AB81037;
        Tue,  3 Jan 2023 17:44:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D47C433D2;
        Tue,  3 Jan 2023 17:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672767864;
        bh=LckIA+Gz2HvlJFTUCOOcP66kxq0hG8yz1WKdpVjE/xw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rLEnW9wGp3Z6Q59S+JwrZph3YhZJJVqowPqSQECJuDE53pVqR/Sj0YqQz83zB2pUZ
         ZbkfXfocDWExQhS3inMdUczLRARUe1uRPhv1pTUPdSRnG8TsIAUtUywxr3sr4YHHlw
         lyxc4zcrcw9ngl/94/71H4KNflC5V3CAQIWzX9D+SXYgLoQgLiCtHHyUxMQf5VRkg+
         +U+1wOq7+laGbKtBvXTanpclz8SXgPneLrrqey3/x/j26PvxByRzmp9y321SFi5dz4
         WO5Xt28gURXGYgIhhCFMgvTjhUDWKbDu+Ub6HuavuP8YYAIPK/THmyS1asBEZ+2lNC
         fMf8njjTLVF9w==
Date:   Tue, 3 Jan 2023 17:44:17 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, lgirdwood@gmail.com, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        Thinh.Nguyen@synopsys.com, bgoswami@quicinc.com, tiwai@suse.com,
        robh+dt@kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
Subject: Re: [RFC PATCH 12/14] sound: soc: qcom: qusb6: Ensure PCM format is
 supported by USB audio device
Message-ID: <Y7RpcfWG5yrd6J3X@sirena.org.uk>
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <20221223233200.26089-13-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hij50yuqfbUKxTCY"
Content-Disposition: inline
In-Reply-To: <20221223233200.26089-13-quic_wcheng@quicinc.com>
X-Cookie: So many men
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hij50yuqfbUKxTCY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 23, 2022 at 03:31:58PM -0800, Wesley Cheng wrote:

> Check for if the PCM format is supported during the hw_params callback.  If
> the profile is not supported then the userspace ALSA entity will receive an
> error, and can take further action.

Ideally we'd wire up constraints for this but that gets complicated with
DPCM so it's probably disproportionate effort.  Otherwise other than the
subject lines not using ASoC on this and the previous change I don't
have any issues that other people didn't raise, but then most of the
complication is in the USB bits.

--hij50yuqfbUKxTCY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO0aXAACgkQJNaLcl1U
h9D1xQf+LwgGcwM55I9NHiwQ3ebZ4m7VhjDLgWvKR107h7Duq8GctdogaoB5LvTP
O9xWQH1QhvotKZf1j+Wn0NoYxROayG9QPwht4tIGzQmAhgq72kfiSZ6IiETIW+IP
K58dG61EXGWBLniqpXQNpxnqL1XeW9wHfSwuVOqN1Or0XoOCyjGupDURXP4Uau6z
AJ5cGhqW3cd2xobybkD7asnAvDniZokvV0sreSFRYy4a/vNm4cVe5WRhibUh+S7K
K7akWpFDvsOAobbQvGkEkeCvltQMkZxYbtm6av1vQBI6j7kQ5WXw9G72a2AX8VbR
I8ILJBI6jfDXIjH8Fnc/L23TEnwfPw==
=p0V6
-----END PGP SIGNATURE-----

--hij50yuqfbUKxTCY--
