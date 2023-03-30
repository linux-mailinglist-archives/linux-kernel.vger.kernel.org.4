Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F71E6D02B6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjC3LNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjC3LNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:13:35 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9473040DC;
        Thu, 30 Mar 2023 04:13:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EE50FCE2982;
        Thu, 30 Mar 2023 11:13:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385C1C433EF;
        Thu, 30 Mar 2023 11:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680174811;
        bh=ukBEhWrw/ajFJGkVU2++82d/hl2/pJctfu+fiaMHW7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a7LcQIvbyx7HpDMExhi0iZUT+YkyF6a8Ahe17BEHusojPX7S8t7ZhOnRBnYTgF6+3
         d91W6s+c8uv75MVWCsIjmTI8WKR63Ki65wdRLalRWD9Kuxr34MMMdfxd2NoBcy7K05
         TS5JyobUdu8koooM2vi/ffjuEbrVQESlPWeOg1YInAsImoUx7co19tEbRgEayYgUjE
         XyL8QwH0cxRH0Ldxp48VFEQKA2U/vRTV8MgzghQ6Jh2irGTXeZ/KY7KQwAIBdfOY0F
         WWKH8Tv94CrI/MqWMNV/Q6PRQWwCwYfUOsbhWbx3HGdBmnGGZsQ/3sC1LTM8+iydCu
         GBGf3QK/3bHzw==
Date:   Thu, 30 Mar 2023 12:13:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Patrick Lai <quic_plai@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v3 07/10] ASoC: dt-bindings: qcom,lpass-va-macro: Add
 missing NPL clock
Message-ID: <ZCVu11dHay8ktiRl@sirena.org.uk>
References: <20230327132254.147975-1-krzysztof.kozlowski@linaro.org>
 <20230327132254.147975-8-krzysztof.kozlowski@linaro.org>
 <3bb3f40f-39da-2fe6-f5ca-2848a9e5c49b@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IsDYuCYOQLYYOx2V"
Content-Disposition: inline
In-Reply-To: <3bb3f40f-39da-2fe6-f5ca-2848a9e5c49b@linaro.org>
X-Cookie: Single tasking: Just Say No.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IsDYuCYOQLYYOx2V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 30, 2023 at 08:59:12AM +0200, Krzysztof Kozlowski wrote:

> It seems you applied v2, not v3, so this patch is missing and the
> binding needs fixes.

I'd queued v2 already when you sent v3, and you're sending a lot
of serieses right now.

--IsDYuCYOQLYYOx2V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQlbtMACgkQJNaLcl1U
h9AXegf/RDW+9ZdRUx8ufviZmnmZibB7wVYT4S9MOFBHzXu5Xs9hFd60Nl2uhGsi
VloXjO2lGlAuStck5I02NIMUNC1kEP/YExTGWadOY92CggJTGsUxhf4OGPKh5ib4
bDn37PhNH6IRdcH/rNTSyLmzxqWkrPt610U7gdgsLAjB6JYIT2lREX6ZqW3Ssizw
Qvq7IUXtcrs7DFEahV3ipkhBHB+RpZz++k0kWS42IlQo4Ij8pGanusKT5f5gzPoz
rYEEkTmIZWyUzUPkBa22IE7ROpvkyc+dCaYfAyLhBOBBq7TVn6JfQErggPhridD/
/S7VdzM5YXqVgwVHI/1nwAnvoumvNQ==
=NJ5a
-----END PGP SIGNATURE-----

--IsDYuCYOQLYYOx2V--
