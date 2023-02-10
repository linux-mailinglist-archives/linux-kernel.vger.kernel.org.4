Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D7A691F59
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 13:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjBJMyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 07:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjBJMyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 07:54:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78356CC68;
        Fri, 10 Feb 2023 04:54:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55FB7B824F8;
        Fri, 10 Feb 2023 12:54:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C472C433EF;
        Fri, 10 Feb 2023 12:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676033640;
        bh=Du2ZKc2SD8ZEuWZsYr57fBOFhcnDr6EcpR4q2D36XKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VUZVtlYlvJfCLKDiyaboSA8PYsrgD6aOEf0MqrOqPnEpAplY7kspbS5Q85h09hhVw
         GoAwZA/rR3/ZtW204dyyLNZ5NmOtRuzPUldNsBuEjww8Qywc/a9QAKUixpKCwavwd5
         UI1y4zktGYu6cZNAM0MLrtQPYQ1VLxJXZudE9axpyH7+NOS2G8rlHsxV467dvLF5DP
         S8CHnh+SneZn+bIBGwKFyy21swzylWkpdCW/mfa4nhNBZeOmF7emMn8aNaAbuJ4vhQ
         TBFX/l3ut+h27jrpxAlVkRuF/ppsPpaaNxMyCqjradqtPst0BLdpP9nFzm0L9eOufl
         eK3BwDPOzibdg==
Date:   Fri, 10 Feb 2023 12:53:54 +0000
From:   Mark Brown <broonie@kernel.org>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        f.fainelli@gmail.com, dregan@mail.com, joel.peshkin@broadcom.com,
        dan.beygelman@broadcom.com, anand.gore@broadcom.com,
        kursad.oney@broadcom.com, tomer.yacoby@broadcom.com,
        jonas.gorski@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/15] spi: bcm63xx-hsspi: driver and doc updates
Message-ID: <Y+Y+Yq1zab9gZV/x@sirena.org.uk>
References: <20230209200246.141520-1-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l9DIe4HKawK7ZnJy"
Content-Disposition: inline
In-Reply-To: <20230209200246.141520-1-william.zhang@broadcom.com>
X-Cookie: Brain fried -- Core dumped
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l9DIe4HKawK7ZnJy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 09, 2023 at 12:02:31PM -0800, William Zhang wrote:
> This patch series include the accumulative updates and fixes for the
> driver from Broadcom. It also added a new driver for the updated SPI
> controller found in the new BCMBCA SoC. The device tree document is
> converted to yaml format and updated accordingly.

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--l9DIe4HKawK7ZnJy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPmPmEACgkQJNaLcl1U
h9Cdmwf+KbbBnAO2y+kpg7mhf1IH84cGJ36v7XrE2+Lg8O4CpuiC0mds+TigLqVb
tRMdqwo9ClRhlxfnzdvUVGJOA7MnnXkOCknRzr3/DFrxObJJAj7Cv+44eMcgxDLu
XXhaf6xLhJtvvYmUW6HC3/c3cREY/WKbfk+SjzslTlT77S7hPu9mGseLhBgNJg7K
83gsZtaP6F97e5YfE+68bOvj5dvx1p/UQAY8uNGvYcTKfsWCSBgzkuFJnm7n5Ges
lVeppGNTf0Ugl3c2eV9JU7mS4HJzPozXK8BLfVQkfDEkqruyOmb4cELkz58wiTXW
R4Lf8GilCRoBf4tK7NUXDWkJVdxNyw==
=5u0R
-----END PGP SIGNATURE-----

--l9DIe4HKawK7ZnJy--
