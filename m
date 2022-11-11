Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA88625A3F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 13:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbiKKMHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 07:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbiKKMGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 07:06:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FA583B8A;
        Fri, 11 Nov 2022 04:06:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 995B4B825D2;
        Fri, 11 Nov 2022 12:06:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A108C433D6;
        Fri, 11 Nov 2022 12:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668168391;
        bh=Gn4LvE+gx8Rx+slzeOMcx1mv1gCVWfnMcM0vY/o8S3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XRszRJtecPe+gjrCiPdOdwf65kR+1xmgcioWKZFrpMHAfHXbkvEvbs07Vm1I+Juc8
         IJwuN2+X6fu/GSSS8gQKKsWeCjgF5VS41UN8V4LVPcvzQPmySTDAl7x2P6Dnr1wmgd
         hj+1/9WgwLEbmiT8pbuWJRDW6H0/jhOR25ezA2fvaOqX8qdEBF9n3qJZ+cofsTRH4m
         6KHJqQ55Da41fCGKNbYCQtImsyJ6xzFHJ8NGbk0fE+uh4/sdZi5SYfd7Wm8O2oHJpe
         XghyqZAq+G/KB2SJ4fNzNMr8meCcoB/CsCKA6SkPFJAUDnDHFUVOqUWgmFweG9192Y
         H+3JHeNTA4j0A==
Date:   Fri, 11 Nov 2022 12:06:24 +0000
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
Message-ID: <Y246wC8zEGJp9SmC@sirena.org.uk>
References: <20221111091738.34290-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EFmww+5b01DXaZ+W"
Content-Disposition: inline
In-Reply-To: <20221111091738.34290-1-krzysztof.kozlowski@linaro.org>
X-Cookie: Should I do my BOBBIE VINTON medley?
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EFmww+5b01DXaZ+W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 11, 2022 at 10:17:38AM +0100, Krzysztof Kozlowski wrote:

> For multiple speakers attached, it's useful to give them some name.
> Sound core already supports this, so reference name-prefix.yaml.

If we need to manually extend the schema like this it should probably be
done for all the CODEC devices.

--EFmww+5b01DXaZ+W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNuOr8ACgkQJNaLcl1U
h9DGiwf/fZ7jw/Q4mz/4pgYUjRUhOS6l78Wnnz7FzW8zik92s2e0N8q9DNs6YOJe
pJNlVLVUhtSLyzYE9XQoTLjfnVKfLHFVCsZuwHgxncwLbdYetaRrpQlTdOgbbAqL
qrqD6QxNf9nkjafDSCpOPdMJLUOaV0jz7oVY3vdJTWgN16OosMr/KuW15ZNwmsjG
A+AlqT7G75ffl/JmImjep/krhp32zkdFpQzq+Q5Wbx2UTxJz6R4w7sB1Y7NZZ6dt
VPUGF3oCgOlwN3phFsMk3ijI1SfUVTo4dvnbqjefdClVrfm/SFtt0fLWRmKW59Ut
G7C6ARmprB4wHeEZYHBxvGo1ygYHCA==
=1awU
-----END PGP SIGNATURE-----

--EFmww+5b01DXaZ+W--
