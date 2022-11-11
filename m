Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE34625F85
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 17:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbiKKQc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 11:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiKKQc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 11:32:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3A4833BE;
        Fri, 11 Nov 2022 08:32:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29190B8261D;
        Fri, 11 Nov 2022 16:32:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67FFC433D6;
        Fri, 11 Nov 2022 16:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668184342;
        bh=p/hgZ3rU0we6hP1xNAjo5J5GgA5dWBa4Ua+wJnrBtcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HWyh+C2s/UDZ7rwK5cpzxbj/PFRtcNOvk5ZIbNwHEdnSXf6BC/6ZE94yMKNQ9B8DI
         efcq+ig+PgD6JKmOIK4wHtPWf9b1IISEjjJwXDOOZZIkr4HqpWHiGp/O+fY7OOqGkb
         a9862wdfMp23Aujy1GqseZlxlPgswqwf9MeMhFY/vSb+Oiwpw2+O0WmOJ2CYqFCxCh
         6ny3DRBplnJ9YtP/FUyZlK/4MD7/ox48jkUyIYBXcnj5nMcKjFA0I4bDa7sbAWnUCA
         69z4zFjmt0gJA+8uzUgIuXNCUiocIQJ3+Z3YPA9eFLnNz5Q0NxeJjG0C8cC/ej+0iU
         WOei1QLNDLx6g==
Date:   Fri, 11 Nov 2022 16:32:11 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: qcom,wsa883x: Add sound-name-prefix
Message-ID: <Y255C+TGNVJ9fs8A@sirena.org.uk>
References: <20221111091738.34290-1-krzysztof.kozlowski@linaro.org>
 <Y246wC8zEGJp9SmC@sirena.org.uk>
 <29620da4-fda7-eb71-d9de-599e3bbd2de7@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yL7dWziKYiIamsqH"
Content-Disposition: inline
In-Reply-To: <29620da4-fda7-eb71-d9de-599e3bbd2de7@linaro.org>
X-Cookie: Should I do my BOBBIE VINTON medley?
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yL7dWziKYiIamsqH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 11, 2022 at 03:33:10PM +0100, Krzysztof Kozlowski wrote:
> On 11/11/2022 13:06, Mark Brown wrote:
> > On Fri, Nov 11, 2022 at 10:17:38AM +0100, Krzysztof Kozlowski wrote:

> >> For multiple speakers attached, it's useful to give them some name.
> >> Sound core already supports this, so reference name-prefix.yaml.

> > If we need to manually extend the schema like this it should probably be
> > done for all the CODEC devices.

> Several files already do it:

>   git grep name-prefix.yaml

> The trouble for me would be here to identify which devices qualify from
> bindings/sound.... everything having #sound-dai-cells?

Pretty much anything could potentially do it, it's a system level thing
for when the same device gets instantiated multiple times.  It's most
relevant when something creates user visible controls.

--yL7dWziKYiIamsqH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNueQoACgkQJNaLcl1U
h9DiTgf9F5Oet7q8wby5hcHu+I8U1kwyboOcEArroSZEaYzKVe2n1mmtTR0UZcUp
BCLDSI5wI4cGZS1O251ItWJP2OH/YVTob/tqu1Ywt/vupPOTZdHRKkIGsawuqvyn
PVB4MVmLJfwutlN1kUMAQAY8mU/69DBNRngRR5aa3mUBDWv5guex4fpMhMNCfvnT
e/0wPAWtWDmGzZcr/p66siZwyYN8jaU7JZH4Ddn/DHRWxu0uXF5xKRqWV2JCYmGC
M+5rqvZIBovkAnv9MFVDt6cSy7NekJwwkfFcuEsv9FCldXJvPBw6NvRIP2sHbhDa
PXHLb4fI3VkUqbzKdHPU1we7F09XeQ==
=hl+y
-----END PGP SIGNATURE-----

--yL7dWziKYiIamsqH--
