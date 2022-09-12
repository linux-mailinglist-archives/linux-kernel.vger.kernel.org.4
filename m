Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30B15B5CC0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiILOyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiILOyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:54:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334FC2717;
        Mon, 12 Sep 2022 07:54:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99EF861240;
        Mon, 12 Sep 2022 14:54:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D95C433D6;
        Mon, 12 Sep 2022 14:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662994477;
        bh=3uuqNEjtwj9t+tcq27DDc+DWOJcCwy9OGBZFyr/myFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N/7Zs7c+lC9mCsemc5NAkbMDne0+DcE4floWtGDgQ6EefyspVLAazqI1ffJ/UoMG0
         xfF6vZ7p6hewTN4UeGxvjob2+BNkqGxO/ROGKxLz8RS/AawXDGWCCKvtovgh7yp3uG
         hkUSS6eD423V1vXOaWQn8Rx3y8raTIXHVLV6XylXn0Tqd1EHW0TRc0z6nayAsizZa2
         XaMU702inopCl39xKrvsgdqtOy2JeQbBQLXNShHK4pLwxU8pOi9se8vAeGPq54UCPE
         4iKgR7qweXpXCOzDW/emcqiBzwOmRuiebEorUmLMA96HI98RpM5BT1wNpWVyGULTKw
         OCC5gNi0JXXVA==
Date:   Mon, 12 Sep 2022 15:54:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/14] ASoC/qcom/arm64: Qualcomm ADSP DTS and binding
 fixes
Message-ID: <Yx9IKU4+SjQJGuP1@sirena.org.uk>
References: <20220908091946.44800-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JAb9sFBGi317spRE"
Content-Disposition: inline
In-Reply-To: <20220908091946.44800-1-krzysztof.kozlowski@linaro.org>
X-Cookie: One FISHWICH coming up!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JAb9sFBGi317spRE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 08, 2022 at 11:19:32AM +0200, Krzysztof Kozlowski wrote:

> Dependencies/merging
> ====================
> 1. The DTS patches are independent.
> 2. The binding patches should come together, because of context changes. Could
>    be one of: Qualcomm SoC, ASoC or DT tree.

I'm happy to pick them up if people are happy with that, they
look to be mostly ASoC changes?

--JAb9sFBGi317spRE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMfSCQACgkQJNaLcl1U
h9A71Qf/a5WfyJOVip+yc/Zeg9kIJStxG1iQ6GhnfRrxVsecZzinCisPxAU8DZHd
8JP49FMCy0PemGJooFErG0YVQDakpZ1+UDC9nbsTw49pL2BRwRwUqFpyfnlk+13T
vuEzg9AiuFDDhzn1bZ8TLNRbav4ZWMy2E21doyo90Kwrhw7NnUDYKjDFWs1QBHzV
bElJ+W9x/jcnN+0SFlYQ6j3+uQc4lJ3wK3/FORvbVDh4jbXrs5hYR6AGCEMwZ3eu
Aql7tGimMDsNe7K7fB+IcALMcJxTuLQjNHoxJ3rVg3xMjBJNxbCtJA6ue7zpky9c
CzUjMQrJL/dfdKpidaSAVhFRdALcPA==
=xtE/
-----END PGP SIGNATURE-----

--JAb9sFBGi317spRE--
