Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31CC7136FE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 00:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjE0W2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 18:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjE0W2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 18:28:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A51CD9;
        Sat, 27 May 2023 15:28:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8E6160AEB;
        Sat, 27 May 2023 22:28:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EDB6C433EF;
        Sat, 27 May 2023 22:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685226522;
        bh=Z2O5C9Svtqxfeuj/Ig7smseKnRDG3COEKjIFlgAvORw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tjigD7plN66/N54X+ccNpS4NBdJeXQEQxolq84ed3EzQhAJJP7nb14kiliC2y9sqc
         xEdIaQKSuhI8zrdr9uTPlHNC9b8C+duOHDrEG6PtAMWjP5luwtH+Ots6C43Uuwlwua
         zxFkm0vUOS25OVeip21REgGmNUmVOhSSuGuTm15YPdYRs4vILqkLDuGMd1IgGx3w0d
         WvYh7hRdTSNQjiq371JND3kDrlWIuk27t7PVB8iEGMMQdP8babzJjYMPVH66Xrikzg
         +jKwmcM/bzKYrquBO/BYbjpxsueyFBs63ltNTQYNJZHtQQr/nvOSec5jAeymaIMHVD
         clUINabNkPLNA==
Date:   Sat, 27 May 2023 23:28:35 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: power: reset: bcm21664-resetmgr: convert to
 YAML
Message-ID: <20230527-playset-varnish-8248dc96354e@spud>
References: <20230527141222.GA5048@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="V+XsR5tIkO9vhrFX"
Content-Disposition: inline
In-Reply-To: <20230527141222.GA5048@standask-GA-A55M-S2HP>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--V+XsR5tIkO9vhrFX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 27, 2023 at 04:12:22PM +0200, Stanislav Jakubek wrote:
> Convert Broadcom Kona family reset manager bindings to DT schema.
>=20
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--V+XsR5tIkO9vhrFX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHKEEwAKCRB4tDGHoIJi
0pEoAQD9BkwfXq8VtzmiYGmhbVvMsNmnEoye2XagMmxoO6Dc+AD+L82VQ73kE8N2
ZMiwg4VbJ8bVn7WuljuR1UfBK0xT9A4=
=YwqY
-----END PGP SIGNATURE-----

--V+XsR5tIkO9vhrFX--
