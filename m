Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1983F686849
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 15:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjBAOaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 09:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjBAOaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 09:30:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDBFBB88;
        Wed,  1 Feb 2023 06:30:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5611F617A8;
        Wed,  1 Feb 2023 14:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55FAC433EF;
        Wed,  1 Feb 2023 14:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675261820;
        bh=Q9Wtytfi2PeWaJlpka42nUDsjCXkTPBkoVFcYPe0aM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jWUUnoSOrcDs7AbxytOP3mwWHiViPAQ1Pu6EU1AMz5mA6k3pqsKuiAtYcp5XzWavt
         dlULCz7XJbbSmNFlDoHoQOZ3t3jvxRYVnimlqlUZlzJ1YoFVulcowUUxcu2PhYD/mr
         XFSZECrThRZRsOmGoQdko1GO99Ei7tFvOlhHoVSSA3CW3jkBzTMJ0E2itjhje4kbNd
         UnJxrcxXyAU/zsrAL/Rnu59P9baFNNTRZwfAW0Obad3X7CJmOwIeegr4vhLB8CQ4vb
         KB+ODOWup3r5+nlCS0YJ6ZJSAQKof/GYo+cNG3eegssgLpD9HvZovqyLepzd63US/9
         ZQvvvcji2cQyw==
Date:   Wed, 1 Feb 2023 14:30:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 2/5] drivers: regulator: Add ADI MAX77541/MAX77540
 Regulator Support
Message-ID: <Y9p3dIj+ix0A7SpR@sirena.org.uk>
References: <20230201103534.108136-1-okan.sahin@analog.com>
 <20230201103534.108136-3-okan.sahin@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NT02snU3527Sz9Ui"
Content-Disposition: inline
In-Reply-To: <20230201103534.108136-3-okan.sahin@analog.com>
X-Cookie: Oh no, not again.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NT02snU3527Sz9Ui
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 01, 2023 at 01:35:15PM +0300, Okan Sahin wrote:
> Regulator driver for both MAX77541 and MAX77540.
> The MAX77541 is a high-efficiency step-down converter
> with two 3A switching phases for single-cell Li+ battery
> and 5VDC systems.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

> +	if (max77541->chip->id == MAX77540)
> +		desc = max77540_regulators_desc;
> +	else if (max77541->chip->id == MAX77541)
> +		desc = max77541_regulators_desc;
> +	else
> +		return -EINVAL;

Write this as a switch statement for extensibility.

Otherwise this looks good.

--NT02snU3527Sz9Ui
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPad3QACgkQJNaLcl1U
h9CKNgf/fZN0HpWoWsDMxbHcpSAGQBWShcxYzA09bOSZGfG8Cg5utgvmPiDHn/oq
g6fXKbwOXNonCXsvLxEce83zSK5DxTSuGrgopGcP8lN/mrdQBPP4NpNU7oqk3acT
8ZdIv83u01biVP33Cx3lZWtzn9Zw7Pkt1osUfSy99t0xqaK8IXhaAwwbIH5yVipJ
IB1lEdStcwzUQ6SZ6O/RD8i5La2AgyNBLnzAtBXleBeA22FHFtGLZ7X30/6tM0/U
bxnh9fKiGQQMHkT21XANRzCuSyIDgvEbsLr9Bo0fP646yMYXneXZmWB4yaFbn+Ui
C5yOy79O71LTKRDX4Qefdwta6BWd3Q==
=raWe
-----END PGP SIGNATURE-----

--NT02snU3527Sz9Ui--
