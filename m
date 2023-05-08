Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255246FB12E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbjEHNRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjEHNRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:17:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC3B31550;
        Mon,  8 May 2023 06:16:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA59060C25;
        Mon,  8 May 2023 13:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9609C433EF;
        Mon,  8 May 2023 13:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683551813;
        bh=R4utE4p7M/FGOlEKuEcHVCRfypcxabbL4ucFlAuJ6Ng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fKd2gOTa4jrv8aDPg/0HEhGJrpoWpGEFWblwpG8gXAom3JGZ/4lmK98r91J4L4qzN
         fy+JT5x7fN+FYJWvmyS+pWgx0paN9NIu2pweN2GpnT0Po1cIEo7gJO6RWEZKL5oTgx
         AGyrzenZOdtJS6o6SsvRZMnNjARtb7btrigm7kLiFSEk7m8vR1LdUahGseWcGbQymp
         hhOhILpaio7f58g+DSB2+M6qQ1ljfGyUiZmmk7gwY/gVH5i/sRHiCm4VcDOW/B360w
         o2Kl20sHepbK/5SPCuyIYxo7RaRtYBY56vTSOl7Qw3K6k/bCNten47ls6awxzy9HLs
         6/lJk9njWQTjQ==
Date:   Mon, 8 May 2023 22:16:50 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Joy Chakraborty <joychakr@google.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, rohitner@google.com
Subject: Re: [PATCH v9 4/5] spi: dw: Add DMA address widths capability check
Message-ID: <ZFj2QraXvNqBRwqM@finisterre.sirena.org.uk>
References: <20230427123314.1997152-1-joychakr@google.com>
 <20230427123314.1997152-5-joychakr@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="srztywi96yxDAX5Z"
Content-Disposition: inline
In-Reply-To: <20230427123314.1997152-5-joychakr@google.com>
X-Cookie: You're using a keyboard!  How quaint!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--srztywi96yxDAX5Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 27, 2023 at 12:33:13PM +0000, Joy Chakraborty wrote:
> Store address width capabilities of DMA controller during init and check
> the same per transfer to make sure the bits/word requirement can be met.
>=20
> Current DW DMA driver requires both tx and rx channel to be configured
> and functional hence a subset of both tx and rx channel address width
> capability is checked with the width requirement(n_bytes) for a
> transfer.

This breaks an x86 allmodconfig build:

/build/stage/linux/drivers/spi/spi-dw-dma.c: In function =E2=80=98dw_spi_dm=
a_caps_init=E2=80=99:
/build/stage/linux/drivers/spi/spi-dw-dma.c:100:1: error: control reaches e=
nd of non-void function [-Werror=3Dreturn-type]
  100 | }
      | ^
cc1: some warnings being treated as errors

--srztywi96yxDAX5Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRY9j8ACgkQJNaLcl1U
h9CmgAf/Y1S/7Ur9OhwH8FO3pfxB5IWmD7SfXUW738hjNQGzCWtM7wCPUI0lOpL9
5QDQR/HDwjHuJfsM+6dZPr/CIqAT8PQKe3DU9tDzcfIbZX2UOGcpO/HJkCDdI4y5
F0uJRNPIZpgjhb/MVa0pBT59Jbud5UDzfXpiSm3lij0LuKDUpW2gxlJ5N+cbDKdP
genA3UeLi9szDRIAxfytoA/8lwYqi42uUiaFGlGAYzoLKrql/TyvuGov3EzJLVuk
cjLHSfcuqEUeW87VMGX6GtMqVRpIPwSB5QJBx+OgoAvKQ4gm4z7CWzPjro+tEuFI
nVOhaIn08Iz+WQWRbfHiLpYfCfUJVg==
=xyvi
-----END PGP SIGNATURE-----

--srztywi96yxDAX5Z--
