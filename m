Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F0860673B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJTRpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 13:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJTRp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:45:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA8F12E0DA;
        Thu, 20 Oct 2022 10:45:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8ACF4B828A1;
        Thu, 20 Oct 2022 17:45:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B120C433C1;
        Thu, 20 Oct 2022 17:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666287925;
        bh=Wxd8zJno+3ZHnaGq1vK+hAEtkF9HD4ris0HULbuTLnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SOlLQt4lpiUf6pVrXlyN6i1kII5WV0TdJrMMK9pswSgtcUpzxGhzZ5yNyckagVPkT
         hcNL5Nhl99OmIaoM3Ng+m8wy8CDRXNOHksU5JnNQ4fqXxkiDc1C655WaoRxBnoQBwQ
         lLEKkzyWWmvZcWAIFSw21hNRG0cqUglCgQLsIEwEYJ4LMNC9wOBYTpX9HIK24cHdEO
         EWotK5UhNvJQU36nbv29s/AQTsWa+x07KGXrA4lgBqHrIHy865QhQm95pVVQ1yyvCe
         w5kv4iT/b8w90lP6LdUXt27v5E8X/Cn4WzDmi/jUuW1CK5FqBWhfVyoLuK4SHcYXU+
         3n/gCLoTZfmkA==
Date:   Thu, 20 Oct 2022 18:45:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v1 3/6] spi: pxa2xx: Remove no more needed PCI ID table
Message-ID: <Y1GJL8/YfeoUy8wB@sirena.org.uk>
References: <Y06RCxzwrPZwIETp@sirena.org.uk>
 <Y1ASXFOuc2uGXOlV@smile.fi.intel.com>
 <Y1AczgwCEQO2gvQ2@sirena.org.uk>
 <Y1F0z5aP3MsqnMan@smile.fi.intel.com>
 <Y1F2a6CR+9sY66Zz@sirena.org.uk>
 <Y1F6YRzRS2DR+cKL@smile.fi.intel.com>
 <Y1F+Pw52nN195qDO@sirena.org.uk>
 <Y1F/aVEYn3GIVEN2@smile.fi.intel.com>
 <Y1GEqa07/b25utui@sirena.org.uk>
 <Y1GIVy8l4vKsUYLr@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yO0F5pEFivJdFD3y"
Content-Disposition: inline
In-Reply-To: <Y1GIVy8l4vKsUYLr@smile.fi.intel.com>
X-Cookie: Today is what happened to yesterday.
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yO0F5pEFivJdFD3y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 20, 2022 at 08:41:43PM +0300, Andy Shevchenko wrote:

> Okay, would it work for you if we check the named resource and only if it's
> found take a property? In such case we can guarantee (AFAICS) that the 3rd
> parties (like unknown firmware) won't mess up with the driver.

Not sure I quite get what you're proposing here but I *think* so,
assuming you mean checking the values if the property is present (and
error out if the property isn't there at all and you're instantiating
via a MFD rather than direct PCI/DT binding I guess)?

--yO0F5pEFivJdFD3y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNRiS8ACgkQJNaLcl1U
h9Ct6Qf/ZQbBEeangZ/pEKCawtmrPfAJwTJ/ADKPH6OAt6nfiUegKmjZWgH28Hss
j+uhOIpGwYTfTmNA31fNYvtSAKTfI0DWfwHFiCTGHqZnE2Z3rR4KddepMZnl3pvo
jL95yDw8xjkbqxOZEnuN/RE7Tmht0+I7XTJ5Bn70wldguYMbUsJririMrNNh7I2Y
wNfdQ6SDD6b3UaJEIlN6X8qn+p4CBczGXp5aa18FI0EZtg1pZbNvH1AitTOChKxl
YLYS+iaVPxjocCp+Tl/sLn92Jmp/yfoOi8G7gQFW/zeCbk7os8IQKhJlnuQEdHAY
SfhyE5iH/QDNf88/+5W/s79SOZSysw==
=p7Nf
-----END PGP SIGNATURE-----

--yO0F5pEFivJdFD3y--
