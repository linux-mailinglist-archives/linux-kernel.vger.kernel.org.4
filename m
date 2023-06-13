Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D920A72ED6D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjFMU5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjFMU5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:57:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277401713;
        Tue, 13 Jun 2023 13:57:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B099C63ADB;
        Tue, 13 Jun 2023 20:57:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C154C433C0;
        Tue, 13 Jun 2023 20:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686689867;
        bh=16rG3Y0vOlpHVgnmwY42ppaSUcT2KRuT590yu9eCc0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EQUWBXsi0EP8QFDoW1PhOPTaNCzUaa2ygBgSHBdDJakb+67u6JKik08mC/OIv4IkZ
         fM/D2m710nuqtuEOeGtfpDDUT2E11TRRGLqeO/VaEmnXnq8kpr0FLePxmFcF+tcD7N
         ZSqj8Ke0Om6QowL4BxL/qmLt1SPlRymOoCvkLBO425Yn7g70EqAoDRGmfzfqNKPfZN
         uwv3P/7H+q2GyuoGt8jhrP0TRp1qks825yCdM8PDD7fn4FN2ljl+nwyBLhJamx00KY
         pEz7y4aP8iGZsQ/iaVsiiQbYHlVn4tfUXSDAUb+8c6qxv9EJF0A6ttxoNYDVuu5Qja
         q/Z+8pz1DQXhg==
Date:   Tue, 13 Jun 2023 21:57:42 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        Neeraj Kale <neeraj.sanjaykale@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: bluetooth: nxp: Add missing type for
 "fw-init-baudrate"
Message-ID: <20230613-underfed-divinity-6b0736a99845@spud>
References: <20230613200929.2822137-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gTLLYxVJbP1O93MX"
Content-Disposition: inline
In-Reply-To: <20230613200929.2822137-1-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gTLLYxVJbP1O93MX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2023 at 02:09:29PM -0600, Rob Herring wrote:
> "fw-init-baudrate" is missing a type, add it. While we're here, define the
> default value with a schema rather than freeform text.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--gTLLYxVJbP1O93MX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIjYRgAKCRB4tDGHoIJi
0irFAQCaXswTCJpW35F1LAkKLWwzD5HgwW1DCUp81fSoIGrZogEA6eyHcuhFLmsy
j5XMZ+mgGcqayNc3lJcyVY47JCgfPgI=
=RTuu
-----END PGP SIGNATURE-----

--gTLLYxVJbP1O93MX--
