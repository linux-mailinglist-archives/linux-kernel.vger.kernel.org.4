Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6B0709F48
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 20:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjESSnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 14:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjESSm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 14:42:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28A7E58;
        Fri, 19 May 2023 11:42:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E85A65A7B;
        Fri, 19 May 2023 18:42:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686C9C433D2;
        Fri, 19 May 2023 18:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684521775;
        bh=mlw58LfZETVkOjEGxc7UmG/44KBVI+gULotE6qPpqGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FA75BAB2ZlcZAsReZOVR93HHw0nnb8z8ihDCr4KMvEXIAdBsVLLTsYS9+uogkQfOm
         X96YagQxA1z6mAqR0CEA1a7Hp9F9zPt0GPgMxkWHgc/jTlwgGeqxM6UxhHV1VH3bGE
         LG9vPNuxrYnSe3NWZhlsskYAcy+CM7jt0nVGou542MIAOGyIGqdm12EodHadiul/+u
         nRtltc9c15EZY8mcQ21WpSIFx5b+7oLlp4GeteUof6rHrGdcEpUvKd4rwt/6NPLMvH
         iVx+nRtlVrG3ND/ylytWPEAyRSEYK3GL+dhYUZ/oB5V4U1UudbskFBfbahpmTzaWUy
         gmi2/JyURbu+A==
Date:   Fri, 19 May 2023 19:42:50 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Walker Chen <walker.chen@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: power: Add power-domain header for
 JH7110
Message-ID: <20230519-irk-dwelled-6a499c482e62@spud>
References: <20230519060202.15296-1-changhuang.liang@starfivetech.com>
 <20230519060202.15296-2-changhuang.liang@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gnSYCpl51AjwmCdQ"
Content-Disposition: inline
In-Reply-To: <20230519060202.15296-2-changhuang.liang@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gnSYCpl51AjwmCdQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 18, 2023 at 11:01:59PM -0700, Changhuang Liang wrote:
> Add power-domain header for JH7110 SoC, it can use to operate dphy
> power.

That is not an accurate description of what you are doing here!
**IF** you resubmit for another reason, please change that wording
to match what you are doing here. Otherwise, I will fix it up on
application.

Thanks,
Conor

--gnSYCpl51AjwmCdQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGfDKgAKCRB4tDGHoIJi
0pu+AP9egx1tjjyQI9+8Xir3ZKULUhK/9wI0WOrT3Sc65ivI+QEAx2ydJ1njiPwX
1Gbao6cA/nAxqQotyW/8etgslEbAOgQ=
=msan
-----END PGP SIGNATURE-----

--gnSYCpl51AjwmCdQ--
