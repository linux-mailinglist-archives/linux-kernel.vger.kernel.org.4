Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9794D673999
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjASNLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjASNKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:10:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0291A7ED5C;
        Thu, 19 Jan 2023 05:09:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C7D2611D8;
        Thu, 19 Jan 2023 13:09:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DEFC433D2;
        Thu, 19 Jan 2023 13:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674133747;
        bh=TI7NPqe4OLk3JvAn8248iz8eeAD1+ZGRCDuTYs8oVNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f4HL6anMFkbDT/Jfsi47PhaxFM0gilvwnDMVe9X0IodTk6TwzP7UZDiU83R61bOba
         aDjFF3PrZDeH1ve25z3m1x8Tl+9Rn9RDeLNYZI3An1frNgGJUDVGGD9nOOsM5ApI6S
         4WKW4uAybQ1TYAwTLNFXbeTNZD5XWmcVojb7r+8TpVb/ld2rPfsTY64puZdckqzeD8
         QeSuE9nXDOf+rag4lwKWGmWj5LqIN1rf6HH6k9f4F5/HwqS1FtlYfiz/TEdd/G52jE
         n5IUlFubgEwWkRmxM/2+8RhFeMTt8u9S70E6xP/ITqi/LJr29rB81wfbBZbdISMrFR
         P1hT5bLhMPhpw==
Date:   Thu, 19 Jan 2023 13:09:04 +0000
From:   Mark Brown <broonie@kernel.org>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        kursad.oney@broadcom.com, dregan@mail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/16] spi: bcm63xx-hsspi: Make dummy cs workaround as an
 option
Message-ID: <Y8lA8Fn+MtBZ2eos@sirena.org.uk>
References: <20230106200809.330769-1-william.zhang@broadcom.com>
 <20230106200809.330769-11-william.zhang@broadcom.com>
 <Y8BMiOvbjncXK4RO@sirena.org.uk>
 <6a69a859-d942-3c86-24f1-c041190d20d3@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+HOHWYby/2WJv0X5"
Content-Disposition: inline
In-Reply-To: <6a69a859-d942-3c86-24f1-c041190d20d3@broadcom.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+HOHWYby/2WJv0X5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 18, 2023 at 03:09:39PM -0800, William Zhang wrote:

> So my preferred choice is to use prepend mode as default. In the unlikely
> event that SPI transfers can not be merged for prepend mode, we switch to
> dummy cs workaround mode and force the transfer to run at 25MHz. This make
> sure everything works under the hood automatically and no dts setting is
> required. I can add sysfs knobs to override this behavior and force to use
> either mode just in case. Does this sounds good to you?

I think so.

--+HOHWYby/2WJv0X5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPJQO0ACgkQJNaLcl1U
h9AexAf/Zwwxqp4uWO6uHGszjbqnvxprEwEjqBWFtyGsgf6yhi17sK+tHL+ua0r8
cuv42qXz8HnJenyfEOy3mQfowsqrLCmHlAJa091XM+1mfixJFfhdIzSdvceXT+3b
lMEPNKfUJ8Sc/e8r1CXtnazlAmSZ95ikFNFd8tS32HDJxmjDfY2hXShNpxE7m+gq
XToBrSJdxhfEhi06h/8SANmnKnkQ53miHg4EAY5qWaW+vj+Ioh4m+kkHm5DMSCtL
ltN0MAXdiE5dkmRrG1NH7u217cZ4ybMJipWRXZ5pGBoWG+zJ4SoSy2iCrBpH0uWO
Zd3so8GoCAGOPvIQmof7uxsP2eoCuQ==
=nRir
-----END PGP SIGNATURE-----

--+HOHWYby/2WJv0X5--
