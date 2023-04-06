Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFB26D9EB1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239866AbjDFRY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238578AbjDFRYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:24:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9545A93CB;
        Thu,  6 Apr 2023 10:23:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E2CF649FE;
        Thu,  6 Apr 2023 17:23:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F426C433EF;
        Thu,  6 Apr 2023 17:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680801797;
        bh=1XQblePlqJo3H7Sy8MyUq6SnEZHPe0tSFVVxIXQ9WEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iW4/VEfhbYQjjy3c+MT6PT8MnS6L9qkuu9dkoWpRoM3YOmS9aPvAuvdc3RARjQoq6
         8LaPy1HTVjlJ5GpGsSgZ9RbXU9N3yYTJvDpb1xdN/E4cfEiwZmJ5PJSD71GxAAHN5C
         egkqBuTFMMswMcmX/1s0mF6NWxwfrqZJdltb2VfebhNwIe9f9tqbC3Z3eKaaI8mNYI
         QTyHOz3A9m0XPtgvUdZ2KAmjq39bKiE0iYqxyfRfDxr3PG2FhfMk1POaU5H+iRuw2z
         b/msAf7rdycX9woPcJlWeo6avyyOIYnST3hct82V4iqTPUpe5PPoYRtdHgwRh1K8HG
         oSbyuVJ9VVtJw==
Date:   Thu, 6 Apr 2023 18:23:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        techsupport@winsystems.com, pdemetrotion@winsystems.com,
        quarium@gmail.com, jhentges@accesio.com, jay.dolan@accesio.com
Subject: Re: [PATCH v6 1/3] regmap: Pass irq_drv_data as a parameter for
 set_type_config()
Message-ID: <50d8ee72-9b5c-4abc-a230-2aeb6eddf03e@sirena.org.uk>
References: <cover.1680708357.git.william.gray@linaro.org>
 <20e15cd3afae80922b7e0577c7741df86b3390c5.1680708357.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nFBsyRgjBTkvSOML"
Content-Disposition: inline
In-Reply-To: <20e15cd3afae80922b7e0577c7741df86b3390c5.1680708357.git.william.gray@linaro.org>
X-Cookie: Man and wife make one fool.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nFBsyRgjBTkvSOML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 05, 2023 at 11:45:42AM -0400, William Breathitt Gray wrote:
> Allow the struct regmap_irq_chip set_type_config() callback to access
> irq_drv_data by passing it as a parameter.

The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:

  Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-set-type-irq-drv-data

for you to fetch changes up to 7697c64b9e4908196f0ae68aa6d423dd40607973:

  regmap: Pass irq_drv_data as a parameter for set_type_config() (2023-04-05 17:19:24 +0100)

----------------------------------------------------------------
regmap: Pass irq_drv_data as a parameter for set_type_config()

Allow callbacks to access irq_drv_data.

----------------------------------------------------------------
William Breathitt Gray (1):
      regmap: Pass irq_drv_data as a parameter for set_type_config()

 drivers/base/regmap/regmap-irq.c | 8 +++++---
 include/linux/regmap.h           | 6 ++++--
 2 files changed, 9 insertions(+), 5 deletions(-)

--nFBsyRgjBTkvSOML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQu//8ACgkQJNaLcl1U
h9DyEAf/Zx82PbstbLTdlPLyzSNpJT43Z40XOLUrv2MP7mLOonzoM5F4Kv8EG6hn
dnHXLjIX0auokQrh/Zhn3TMY483/B6y+mzYl9fGcYVPKX1380IPIxrpjZva9ODkD
zi2+zA2kfJrAa8XNSqmiU+jYZdfFFly+MRuloTBiv+yVQVUtcKrTkCMl+2PQ+Vc8
iazYIR8y67BbnG1NvNLZvi0Yb15JrOgXw7z5bP0zzEfWUlqpcy8oN/9SymNA8N1L
S+QBeKHWbCgxdotWYPbtwaTUoTexjy3NmxVCGJBELm7v36YZTuEduzrHwkpwlvj6
lo/WVt1CQQecKuPmp4qjs4vAnXVCpw==
=EMNU
-----END PGP SIGNATURE-----

--nFBsyRgjBTkvSOML--
