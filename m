Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E31735E90
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 22:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjFSUee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 16:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjFSUe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 16:34:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60157134;
        Mon, 19 Jun 2023 13:34:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDBFB60EFB;
        Mon, 19 Jun 2023 20:34:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1621CC433C0;
        Mon, 19 Jun 2023 20:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687206864;
        bh=Uhd7KPqHAJ7fEPJLZBi9kE4eOGvyVREjjKmzJs4FuHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WcNaq+QFyE54xFJotQ1yFGnsEnEXw13WvSSoopGIfDOavqy8aGAyzvslKZlqsPzaf
         w+hcSgEh9NTrcmRbBcORRAMW9dsKqdI299yyPwsR/P/BwKbx7XZQn1Dlyvj6ZmdjE9
         vTCWXiaaXJwIPRdeKcYT2fBRZhQYTk3ev8ToT949+3HPeA2LkJkFYl+agSL82CY0ll
         qjCH0VnkZjU8UB2ZNlNpQbf1sUMgHskeA3oQP9B/it+O+D/tt29IDsWgAXAcoBLek9
         2h4DmiDYY83sGfRBd+m9p5H/GtFnodiNCR74bWMFEKkKyLhzdUiEtMtngjW/WgXxU+
         tyb9uka5Nyg5w==
Date:   Mon, 19 Jun 2023 21:34:19 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Piyush Mehta <piyush.mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        balbi@kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.simek@amd.com, git@amd.com
Subject: Re: [PATCH V4] dt-bindings: usb: dwc3: Add interrupt-names property
 support for wakeup interrupt
Message-ID: <20230619-sanitizer-cheese-7bff29bbb000@spud>
References: <20230619105032.2888128-1-piyush.mehta@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y6zibzw02VJH1wyI"
Content-Disposition: inline
In-Reply-To: <20230619105032.2888128-1-piyush.mehta@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y6zibzw02VJH1wyI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 19, 2023 at 04:20:32PM +0530, Piyush Mehta wrote:
> The hibernation feature enabled for Xilinx Versal NET SoC in DWC3 IP.
> As the DWC3 IP supports the hibernation feature, to handle the wakeup
> or hibernation interrupt, add host mode "wakeup" interrupt-names
> optional property in the binding schema to capture remote-wakeup and
> connect/ disconnect event in the hibernation state and increased maxItems
> to 4 for the interrupts and interrupt-names property.
>=20
> We have a dedicated IRQ line specifically for the hibernation feature.
> When the "wakeup" IRQ line is triggered, it initiates a hibernation
> interrupt, causing the system to wake up from the hibernation state.
>=20
> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--y6zibzw02VJH1wyI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJC7ywAKCRB4tDGHoIJi
0o92AQCsZ7cA3TX6rbiOT3ib8RG57qMA4Y8RmT2KSVRKHceKuAEA+fBcmjNBOd8Z
h3RmatmWw+xBZjQxV5/t14rcqluaDQ0=
=w6F2
-----END PGP SIGNATURE-----

--y6zibzw02VJH1wyI--
