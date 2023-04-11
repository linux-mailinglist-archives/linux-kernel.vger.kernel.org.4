Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1C46DD998
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjDKLlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDKLle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:41:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3D335A6;
        Tue, 11 Apr 2023 04:41:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17DBA60CA3;
        Tue, 11 Apr 2023 11:41:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B71CC433D2;
        Tue, 11 Apr 2023 11:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681213292;
        bh=M+aYJc9Iff65DxXoAB8ogDkq4PHM3Fa5/aSta8s9icg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gi+NbAYZ9rDCzpokSpqurcCuT1eq/pzlKgw9oq7XPjjqfjMqSMPCBj7k5Zo3eEOuy
         kclGJkU6NJP7djkxJcJpsKF+/DdSjZftwXxjYqUhC8v5fS1vnjzxs6Cqfr7ec9QZEB
         x6ydgrwOBgE3UFqnesLt/EpqsGwnGLeoz1fDg/yKZ0t1Zd+fA6JfMBVCGftO7/phpp
         Pa4efvaWLRIfwjud8WpmDdG5TEuK6mxYC3NrplqbKXB9OfOsjozdq81qvq3zPJatbg
         9nLuxXxLsz4/YtUMhW1VTicoC7ffzMO7Ebv2wS7K4KjGUW/wf5FaSIA8Jmx7OKUG54
         hy8vPqAIY+4rA==
Date:   Tue, 11 Apr 2023 12:41:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Nikita Shubin <nikita.shubin@maquefel.me>
Subject: Re: [PATCH v2 1/2] dt-bindings: sound: ep93xx: Add I2S description
Message-ID: <10c3c9ab-66f3-4640-9067-94f44072eec0@sirena.org.uk>
References: <20230410222958.2321398-1-alexander.sverdlin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6kOB8EhJhOnUaMkh"
Content-Disposition: inline
In-Reply-To: <20230410222958.2321398-1-alexander.sverdlin@gmail.com>
X-Cookie: Batteries not included.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6kOB8EhJhOnUaMkh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 11, 2023 at 12:29:57AM +0200, Alexander Sverdlin wrote:
> Add device tree bindings for Cirrus Logic EP93xx internal SoCs' I2S
> controller.

Sorry, it was this one that doesn't apply - please check and resend.

--6kOB8EhJhOnUaMkh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ1R2YACgkQJNaLcl1U
h9CsPQf/dGWT4nFxvehjMcRPGeTHx4TX9+eSzAofTCWEtonFqRAoibbGYxQ0Esal
ExlTGyf4U1ctu/uEzfc+wVtjkIYIcxOrvRS7GcDirQBPT4X/XjkVpQ0wZC8AsZ0F
HF76qMLqD3cPcOzEoffbO4QxPAojv+UCjlm6yzTKh1LBnCSHR283kNIN+jR8NG+M
zMW20RC6tUyv0etra8TWQaXxUFO5NkxCDAcerPNaUZCUfth3sJa5LCoj1t8TAuMO
yfduKjN+YArhgpX8QsulTDgtL1wvXZWXle2hww/kXkpJHUFkWIWOteJr2Ffn7U0K
QqG+/1/lF1f1SAohndCVIOXk4FJcAg==
=xaGA
-----END PGP SIGNATURE-----

--6kOB8EhJhOnUaMkh--
