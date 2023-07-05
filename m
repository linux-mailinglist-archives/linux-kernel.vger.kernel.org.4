Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74788748381
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 13:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjGELwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 07:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjGELwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 07:52:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389FE1706;
        Wed,  5 Jul 2023 04:52:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C25B661510;
        Wed,  5 Jul 2023 11:52:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22C0C433C8;
        Wed,  5 Jul 2023 11:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688557930;
        bh=B0MLw/sxHoIbXTRVaxfjrRiweFfcz3oBF68pY3IxPtU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YeYNhZsYykFlOgVLi4szIeNKiHwswHkxej09OjjKRXeFTB8hHCYxiFFs9V9xCN7f0
         ew0afQAD0zGy46+/ZOIY9OUNtC2q54pLJegUQPz8IaNvVaCTT5AI4bKR7B2lD2Ik4w
         MArVNAxJaszFCZlnKLWCc+7qRqk0x45fk4Ret94u+txARBrIN8PnsgKaCF4W4PkXA5
         oHGinUssGUnPBnvT1//iD7UnNJP4i8h3dCtouadlbxiNXp9LdbfqSbW+v9/5LUrcY+
         xSGLUZaz8gloM0hKTBK+sp1DLQS6vDc9a0GNqEKYuXxfHTy1Swg13zKKRcvkbjCJbY
         JzIIzQTmkfubg==
Date:   Wed, 5 Jul 2023 12:52:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     like@awinic.com, lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        liweilei@awinic.com, liangdong@awinic.com, yijiangtao@awinic.com
Subject: Re: [PATCH V1 1/1] regulator: Add awinic,aw3750x.yaml
Message-ID: <17ad855b-3a3b-4dba-9a64-a1a683b3b905@sirena.org.uk>
References: <20230705081942.2608531-1-like@awinic.com>
 <20230705081942.2608531-2-like@awinic.com>
 <2923201f-8bf4-a55d-a033-28ae5e569466@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O0KcrTpa93VAbXP/"
Content-Disposition: inline
In-Reply-To: <2923201f-8bf4-a55d-a033-28ae5e569466@linaro.org>
X-Cookie: Don't feed the bats tonight.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--O0KcrTpa93VAbXP/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 05, 2023 at 11:20:16AM +0200, Krzysztof Kozlowski wrote:
> On 05/07/2023 10:19, like@awinic.com wrote:
> > From: Ke Li <like@awinic.com>

> > +properties:
> > +  compatible:
> > +    const: awinic,aw3750x_led

> I don't understand why there is _led suffix. Isn't this regulator? Can
> it be anything else?

Boost regulators are almost always used to drive LEDs for things like
backlights.

--O0KcrTpa93VAbXP/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSlWWMACgkQJNaLcl1U
h9AMlgf/RdUDoujLpgv1G5u99eZWNCJ4Ystqq8fMJbnuQi+Mw7nqEC9vPvHFzLN+
yMYnFFFOKcOzEqBKg5Q2cEZoLzw01YVzREz9Ih+U7ilypJonPJObwNinjdynPOj2
AKR3CNiZgTMgYrs0IoAV0ioOMEEJywiQLX+lDNsX3G2PG2unJCuEJSSwuvebo7uK
xkUdTCtQQA8Q2ibP/VjuviXZ4lo11+pU+cHjtmIvc0iAhnoKasKEuR63h9/CgOiG
y33s5fegxQUkjDHjzlZ52cdSLEsYzKoIXEWSKDymD6v37twoibGHQYgHv7d5taxm
gwzLamSpxPvVTypRLCfvpbsYHX/dhQ==
=sAT1
-----END PGP SIGNATURE-----

--O0KcrTpa93VAbXP/--
