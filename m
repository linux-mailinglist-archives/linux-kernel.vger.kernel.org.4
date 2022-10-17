Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7328B601491
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiJQRRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiJQRRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:17:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BAB6E89D;
        Mon, 17 Oct 2022 10:17:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2093DB819D1;
        Mon, 17 Oct 2022 17:17:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D35C433C1;
        Mon, 17 Oct 2022 17:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666027061;
        bh=z2RQhpL9FUPteZDb0jA+7mnSGiEwMAvl6fHKoEXqwTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WKrRcCHj4UivOp2LFBqnN3mFHPhhcxJKMBcwVRosfy+VxCIx7OTjz9dH1IYufA4ly
         jHzbhXigYKMxEKRnyyQEiGoidncXhwAxWs17OWJDuMt7zoFqZQ97+pZtcXOswnMUME
         0SRhc8k6w3POjMA4qto5SNR0vT5Z6lYN49Iqs0Hz3Jrx/tPuw7oxvfkM1CmdPy9uz/
         w3tmtSdo+d7nEssvvA/XqJGCUw/ALkMgE4A9dL2R1woOS0A7L4wo/ii0uaLT1RvgBf
         tT6wgVp1WSrYOrqE48N0km7jd4KgrPTmU+2V4gsLnk6rjnNUdJpMNDmk5rQ3PFrabB
         Tw8t655HVgKuQ==
Date:   Mon, 17 Oct 2022 18:17:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v1 2/6] spi: pxa2xx: Respect Intel SSP type given by a
 property
Message-ID: <Y02OMNAFrKLWUtiO@sirena.org.uk>
References: <20221017171243.57078-1-andriy.shevchenko@linux.intel.com>
 <20221017171243.57078-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3ZJssUnveSht0LUP"
Content-Disposition: inline
In-Reply-To: <20221017171243.57078-2-andriy.shevchenko@linux.intel.com>
X-Cookie: Real Users hate Real Programmers.
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3ZJssUnveSht0LUP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 17, 2022 at 08:12:39PM +0300, Andy Shevchenko wrote:

> Allow to set the Intel SSP type by reading the property.

> +	/* Always try to read property */
> +	device_property_read_u32(&pdev->dev, "intel,spi-pxa2xx-type", &value);
> +

What is the advantage of pushing this into firmware?

--3ZJssUnveSht0LUP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNNjjAACgkQJNaLcl1U
h9CHyAf9G/nqfY9tao3dRp84AnqFvEDyGnkR4tSoQUTNVQSCg+pgUdyFRunHMLCF
+eoi9VXricKAhts2Mvdci3p74fsvrJZDyE9I78pDs6I/GMwlRvB21BqBtL2vJzjd
bZaSoX/BFg2QjEUtwMGrXGmPsb/14JSUbPUomKgjT2gupxV/pcjj0TODmfjfIL/7
uZm5Ocn2JvvfJmBso2XY0eDHck8e9hS9G3vqK+4lj2BNTSk8uob8/a8Ju1ZHfm8o
yCtRVmf+3/kAf5cCzlAjDxwrsJ6MaRhv+eNzTRymvfoXcdLrVeAaO9b83lgBN5GU
tQtq1w/TofHKffbrFvuM4ulg5dribw==
=MOJU
-----END PGP SIGNATURE-----

--3ZJssUnveSht0LUP--
