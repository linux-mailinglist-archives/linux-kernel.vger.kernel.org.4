Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D30664DED
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 22:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjAJVS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 16:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjAJVSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:18:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D486E5F917;
        Tue, 10 Jan 2023 13:18:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C974B819B4;
        Tue, 10 Jan 2023 21:18:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903FAC433D2;
        Tue, 10 Jan 2023 21:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673385525;
        bh=F6Dta+lIazziPPSnOOVzVruJLelAjOop7GvSElPe+nA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rK6MYbLfSmDq9njdip0EHAajOumR21dVMB08eMlKPCjUOVj14x7bDWx7zvcGV4t9m
         +QelqmNLbLLdDB7ZVkp9dcGPqd+d/DvaoROhWsLnFNDDg6lEQhRiiyp9YwaJicG6ao
         CgibIN422m/secbMm5UfGTZbw8tsxb5Nk+4zAvlghendMW4IyMpZyCwFRKjyZGAi5Q
         R/PHFyf4+7PCCZrBXRjiuzbrQkKiqRI9ZldKrjB/FlBLmpm3rDoyDw1fqr4ZG7Hmou
         +sa1Yr1/r3Tr4xQukYyVLznJfl3OQC2Vt2y9ICZpwQq53wKA2+NfbkPit/9N9qVI4U
         kfOvciBqusD8A==
Date:   Tue, 10 Jan 2023 21:18:39 +0000
From:   Mark Brown <broonie@kernel.org>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        kursad.oney@broadcom.com, dregan@mail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/16] spi: bcm63xx-hsspi: Add prepend feature support
Message-ID: <Y73WL3Gwo6w6dJJr@sirena.org.uk>
References: <20230106200809.330769-1-william.zhang@broadcom.com>
 <20230106200809.330769-12-william.zhang@broadcom.com>
 <Y7iaEOBP4TRBoDYy@sirena.org.uk>
 <88534207-6b1c-75c1-26a1-be88a19eeecb@broadcom.com>
 <Y7xrhjhhY3g5DE25@sirena.org.uk>
 <04b740e0-09d1-8c39-4f0e-8f61a74eeb58@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cAnrpT/g6G6pP9kV"
Content-Disposition: inline
In-Reply-To: <04b740e0-09d1-8c39-4f0e-8f61a74eeb58@broadcom.com>
X-Cookie: Live free or die.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cAnrpT/g6G6pP9kV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 09, 2023 at 12:43:53PM -0800, William Zhang wrote:
> On 01/09/2023 11:31 AM, Mark Brown wrote:

> > If this relies on software control of the chip select (which is what I
> > *think* your dummy CS workaround thing is about, the other patch about
> > that is really hard to understand) then I'm confused about what the
> > advantage is?

> Dummy CS workaround is implemented by Jonas when he first upstream the
> driver. It does not work on all the board designs so prepend mode is
> introduced. I have some detail explanation on this in [PATCH 10/16] spi:
> bcm63xx-hsspi: Make dummy cs workaround as an option.

Yes, it is the description in patch 10 that I was having a lot of
trouble following.

> The controller only work in one mode and that's why driver code has some
> dependency between these two modes. The advantage of the premode is it works
> on all hw design however it does not support all types mem_ops operation.
> That is why you see the patch 14 to disable the dual io mem op. But dummy cs
> workaround can support this and in case there is such pattern from non mem
> op spi transaction, dummy cs workaround can be used as long as it does not
> have the board design limitation.   So neither one is perfect but hopefully
> with both options available, we can cover all the cases.

We can't switch modes per message?

> You mentioned there is some existing logic to rewrite messages to match
> driver constraints in the core driver.  I didn't see it when I did a quick
> search on spi.c. I will take a deep look into the file. But if you can point
> me where this logic is so I can be sure that I am looking at the right place
> and will double check if this can be done or not in the core level.  Thanks!

spi_replace_transfers().

--cAnrpT/g6G6pP9kV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO91i4ACgkQJNaLcl1U
h9Bp5wgAheES6BH1dlAtpV0dhgOx4KhENBN+LgjOJv7pMNzIiHCOJFjVozUAyixx
yTTcgIaLBzZjhLp2+cyrGjcNbazsm80lsu/naCQvUEALOfBt8H34yniReRvfh9dw
X1Fn5jNbqYf2ZNYP+y38ICv2aezsuifRHi+izwug2VnBnfxC0IAygqEWJ44kv9IB
/Q+anI7FjpA5Dee1Av2jJLUztJqleyupTHNCUz+QgQeEvFjd9ot6FettZB/HPQY6
EedNrPQsfLLLMTHaIfhykK1zIWodheBQjNUCo2KzAE5gRC3Sax/DFV8n/5r7j1JK
CUMZvrmmpfDgMJElnVUNAoRrUO2dvA==
=iexY
-----END PGP SIGNATURE-----

--cAnrpT/g6G6pP9kV--
