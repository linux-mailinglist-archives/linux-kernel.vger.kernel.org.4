Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BF46E514D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjDQT53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjDQT51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:57:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E96C9;
        Mon, 17 Apr 2023 12:57:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B172C629D8;
        Mon, 17 Apr 2023 19:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8488AC433EF;
        Mon, 17 Apr 2023 19:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681761445;
        bh=HWzhW9GFVj6fWYcp46oHtAj7lXsg45I4Azq04EeNl0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LmNR5s5mjY9NpnKdIIC/WCVFDZ5tbLXD8/eJDCbk+mxK1hkG22/IFU9eU6PdREZn0
         WLpR3QaPM5CgJzgidX9S48mVuRMeqtkrKUkPCMw+ZUXKe5lJJEgS85bmcByDXxPNAU
         tqCjxrJ59H4zfBhqPe2pwkgXDepguV3in2S+IJ26XxPce+ev0yYmgWS1l0U+1Qu0/f
         TnyjUhC206sreCN8XslM+GTxFzMbO2ClSR4dok0vq6PdqY+tpA9UhK6p5eg6YynyOB
         gYInd7ylhjU+nOY9l+1C2pH0CXTP2f4jiHQK3/d31pkpCW4fn2iN3zdlaQ73Nwm7VT
         C0hvfirFuZWYg==
Date:   Mon, 17 Apr 2023 20:57:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Danila Tikhonov <danila@jiaxyga.com>
Subject: Re: [RESEND PATCH 2/2] regulator: dt-bindings: qcom,rpmh: Combine
 PM6150L and PM8150L if-then
Message-ID: <1d3c99f5-12d5-4a7e-9098-32fc601b0837@sirena.org.uk>
References: <20230327080626.24200-1-krzysztof.kozlowski@linaro.org>
 <20230327080626.24200-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="E44s44jAOtoWp166"
Content-Disposition: inline
In-Reply-To: <20230327080626.24200-2-krzysztof.kozlowski@linaro.org>
X-Cookie: Fats Loves Madelyn.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E44s44jAOtoWp166
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 27, 2023 at 10:06:26AM +0200, Krzysztof Kozlowski wrote:
> The supplies for PM6150L and PM8150L are the same, so they can be part
> of one if-then block, for smaller code.

This doesn't apply against current code, please check and resend.

--E44s44jAOtoWp166
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ9pJ0ACgkQJNaLcl1U
h9DsnggAgHjmkii2xZvIYCdy5E9xEyAeS4Ip4+UCvrAsVqlZn2zLZ2fXzGK0/2xS
m6PwyyaH7UE8/Hliv7ema3EoheRvOkEzeENTy1goa42WNTM0YvSi31Y9Q56CtS2c
u5B1IRJo3ePmXeIRdEUFj/sovwM1KNx+7w+y7K8G2oQJd/kdbvwT1YNcDLnIpE63
uXkLLJkfjO38uDnnG3VGjApz/QqcL9XYHa+e7ZSSQPlU71hvDsqiYSryZChgj8TB
cGAJHgZTo4AwxRORX6kzm1WtP/RvhUHaBE4J+abxNVMJvbrh0vnsIF8UP6JJG1HM
6JyuNrkV8mzP4MNhj6DDw+MTRl0biA==
=k1UD
-----END PGP SIGNATURE-----

--E44s44jAOtoWp166--
