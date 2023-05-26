Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F040D712993
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243851AbjEZPde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjEZPdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:33:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1303FB;
        Fri, 26 May 2023 08:33:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 555E560DBF;
        Fri, 26 May 2023 15:33:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8A9C433EF;
        Fri, 26 May 2023 15:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685115209;
        bh=gzNuCzAzZ7+zw9WNsmNLqxt3L1OmoTULjYdQ2OYFP4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sgDwLxaxdw8ndTrnq7cYzvnxplKmWQVBcBR2fEo5qY669ReLqN9h/QxVv1F1Edhhr
         e8nT/q3GhUm6zRi0PO00vF/JRsIBDfRj+OtZ020Q9jHNdDJZZcAfJ1Uyiofjn8wrf6
         2NcrUHBKS9H1DM1FsS2ODrMCGg3FEAl3VkGGU5NoMw5NIULZgvm+b5Yp5BpUlfu4Yg
         tEusSlcLCVahaLcwsNc5MuJLQhLX6fPC9uCaCQN4ongcQdKSzOwi83ksG/x6hpHnLC
         XaYVsyl/6dMGLN5xhJZxz6SYe8O3b0Cy1wJCgND+4fKC4uusrgrvQUqAZQfvPg174s
         tZeEQTZZQOqcg==
Date:   Fri, 26 May 2023 16:33:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: qspi: cdns,qspi-nor: Add clocks for
 StarFive JH7110 SoC
Message-ID: <87e9ed95-ea57-44c8-85f8-34264b5c6dde@sirena.org.uk>
References: <20230526062529.46747-1-william.qiu@starfivetech.com>
 <20230526062529.46747-2-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k1KNVGTJrGqHtc0k"
Content-Disposition: inline
In-Reply-To: <20230526062529.46747-2-william.qiu@starfivetech.com>
X-Cookie: A Smith & Wesson beats four aces.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k1KNVGTJrGqHtc0k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 26, 2023 at 02:25:27PM +0800, William Qiu wrote:

>      then:
>        properties:
> +        clocks:
> +          maxItems: 3
> +
> +        clock-names:
> +          items:
> +            - const: qspi-ref
> +            - const: qspi-ahb
> +            - const: qspi-apb
> +

Are these really the names that the clocks have in the IP?  It seems
weird that they'd include the IP name in there and not just be ref, ahb
and apb.

--k1KNVGTJrGqHtc0k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRw0UMACgkQJNaLcl1U
h9DBagf9HzZRKBRscmFdDMGNaPloiDN0Kfiy13vOIf3Uk5whgF17nUJKVr81u2Sx
Dyn6MkuiP14JXAI4RtuTWPeIPdTJqbdenQ74rr1p5Taf4cn3XirLkJ6YBjWccsjC
zPwO+qLmb8swT/JzWonBFqiVmeHzJ179GhKWBxPkME1iO89LaFbFAa+mI4LqzYZ9
XbZ4VT4kpdnru//sZG1kq06xxwVzYvJy/FHZKpKxa0ZX5/SAaluYKb/z+Qt4Dtas
4ReA/isOd8wUcjLDIG+yV98pOteXAmQy9BsCUdMLzDnDZYl1WXsZuIaJX4yudBlo
Ih9Vt+8NxZvlVeO0zrn6/jwnIiaJbQ==
=GwnE
-----END PGP SIGNATURE-----

--k1KNVGTJrGqHtc0k--
