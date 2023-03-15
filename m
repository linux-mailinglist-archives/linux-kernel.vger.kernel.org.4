Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1CB6BBCD2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjCOS6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjCOS56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:57:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A8ED50D;
        Wed, 15 Mar 2023 11:57:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62706B81EFE;
        Wed, 15 Mar 2023 18:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B02C4339B;
        Wed, 15 Mar 2023 18:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678906675;
        bh=I0UDNiTMp2YFiKPkZl2w3FQBWHX0Z4P3ko4mnfKYiU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CgI2bVMZ4EIKrXRngubGO2dMG8A16X/Dk8/Wkg9p/g0RotfV3jwuIWT/z2k4wIamE
         YMdxhRUVyOmBvtzv/Pw5EDBW2DqHGX2/Dcm7GDiDeZKwcVk/8434hVKzBg8JhQOIrO
         g0cCsi7y8YDlfmA+FE00dWC4PQ+PZNTEEkeGtezKW/QkYZwlm3B1WWFJ3Rvesx1gN5
         SsxZv1mnpun5bpJAf673pXRt+Ds43HWewyqZA1aw1lxLxJBiien9VJTyFbIvhXpNrp
         63eoL1eNcylWi9Ym++QwggKrhjBd1GmGP7zCxP69bzuom8JvFJ34mGfyhnQ7vyLdKg
         PzI5Ih1talEBA==
Date:   Wed, 15 Mar 2023 18:57:51 +0000
From:   Conor Dooley <conor@kernel.org>
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: Re: [RESEND v6 2/2] riscv: dts: starfive: Add syscon node
Message-ID: <a3338a34-11f7-4770-a475-95e1a83f9cc9@spud>
References: <20230315055813.94740-1-william.qiu@starfivetech.com>
 <20230315055813.94740-3-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="032GwhlaTlfyOX8z"
Content-Disposition: inline
In-Reply-To: <20230315055813.94740-3-william.qiu@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--032GwhlaTlfyOX8z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--032GwhlaTlfyOX8z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZBIVLwAKCRB4tDGHoIJi
0mLnAQCc1uls/STlQZJH8Fn8Ps+XS2C92fN2HH/f2T8WT3W6dQD8Ddbp0qYDv6WP
FZ1JLXopXlhGxhijr1hrMW59jr/4+Qk=
=fyIZ
-----END PGP SIGNATURE-----

--032GwhlaTlfyOX8z--
