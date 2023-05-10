Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6059B6FE1BE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 17:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237626AbjEJPnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 11:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237575AbjEJPnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 11:43:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7789A35B7;
        Wed, 10 May 2023 08:42:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1546D63DCF;
        Wed, 10 May 2023 15:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D092C433EF;
        Wed, 10 May 2023 15:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683733372;
        bh=qnUqwiJXS3T0AYBwpfwJ/sB84/OFu8iJHOIsOMcAIHI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WE0jKDR1WbbMZ27cXQLaATIX6ziNAZe2kV/z0/LgO6coaqwXFu/tsmJlnyBoLudeI
         p15ivUkTo5Zt78mg7di+nB+ZjNQcl/i+exYZEb1McaDAe8Qomli4M431f9ZBUMad1/
         2/q+b9mrS2q3mWwjIRlBf7qPo17EkOp9ntnrsxBa19LnRAbPcAORQQKno4XfvNg52b
         w/Z/DF/IJ9L9PkFTL7Bzm9Ojh8a2sVP5iG2RUEhVLV/Z4SHQDz8OlrpXyjo9YJuQ9X
         WceMZoWlIKYjB8q8/A+VqLdTRMAptvXZsA3fOmU+XaepBBZKaqETP/iDHzRck9tiM4
         XDG9TOHg9NOSg==
Date:   Wed, 10 May 2023 16:42:47 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: interrupt-controller: sifive,plic: Sort
 compatible values
Message-ID: <20230510-underage-shield-f9369c92c135@spud>
References: <9cbf54da1ace03d7a45f28230fd99954d8c0d141.1683725029.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ewFZSlucFhs6AvIs"
Content-Disposition: inline
In-Reply-To: <9cbf54da1ace03d7a45f28230fd99954d8c0d141.1683725029.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ewFZSlucFhs6AvIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 10, 2023 at 03:26:00PM +0200, Geert Uytterhoeven wrote:
> Restore alphabetical sort order of the supported SiFive-compatible
> values.

Whoops, I probably should have noticed this when the StarFive folks
added their entries.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--ewFZSlucFhs6AvIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFu7dwAKCRB4tDGHoIJi
0hoxAP4wuKboCTznTD2qanlFZ9dt8/8BBShJiS0DZim4KBDK4QD+PnQ3YWxVudS3
vyRwpzYgRLIZw8wgxBpO6DxRet77Mg0=
=aHiw
-----END PGP SIGNATURE-----

--ewFZSlucFhs6AvIs--
