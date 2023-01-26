Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F85C67D04D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjAZPeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjAZPd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:33:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3912D1555D;
        Thu, 26 Jan 2023 07:33:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC33EB81E14;
        Thu, 26 Jan 2023 15:33:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122E1C433D2;
        Thu, 26 Jan 2023 15:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674747234;
        bh=NYPRTBRgH3+T+bKZolHRIAsE66fPlc/ZmTUUn3fbQy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QHL1o7CTsYvYsLQyil0FZWHCm5PST3D0N+PEc45yZdvxt5t40Vt90DnBwLDBD5IiQ
         mwUXD6YmQWU7aTJrR9hLpYAX3BKxDfoSOn6YDSBnpIY8pI6uclH7lcLylVZRklIp+h
         uODkxJC6Bnnbjo9KRRh3rC63/H2zr87NYp+v/u0SpeHt3vzJpGv05n9bX4Ocw9zAuu
         KOtz7ymZWVp0HKCVNzmmlqZ/8DxVim66NFeVcBBBmOEJmUdc2GzgJ9TwfZpfHmv6P6
         TlwkCADoffekV+HFDG3arman89JVr9QbRnb9889gkxLZ82i9BAaDnZqPq2quTjO4Bj
         G/9s7d0LIfrbg==
Date:   Thu, 26 Jan 2023 15:33:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     William Zhang <william.zhang@broadcom.com>,
        Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        tomer.yacoby@broadcom.com, kursad.oney@broadcom.com,
        dregan@mail.com, f.fainelli@gmail.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/14] spi: bcm63xx-hsspi: Add prepend mode support
Message-ID: <Y9KdX5MFkKFI2ie3@sirena.org.uk>
References: <20230124221218.341511-1-william.zhang@broadcom.com>
 <20230124221218.341511-11-william.zhang@broadcom.com>
 <CAOiHx=nfKnXwhYKfuQP4KKT-URfAg4jz-8QOh8EP3L=mvc=pUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WcK/yTqIMBb/1oCw"
Content-Disposition: inline
In-Reply-To: <CAOiHx=nfKnXwhYKfuQP4KKT-URfAg4jz-8QOh8EP3L=mvc=pUQ@mail.gmail.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WcK/yTqIMBb/1oCw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 26, 2023 at 04:15:00PM +0100, Jonas Gorski wrote:
> On Tue, 24 Jan 2023 at 23:33, William Zhang <william.zhang@broadcom.com> wrote:
> >
> > Due to the controller limitation to keep the chip select low during the
> > bus idle time between the transfer, a dummy cs workaround was used when
> > this driver was first upstreamed to the kernel.  It basically picks the
> > dummy cs as !actual_cs so typically dummy cs is 1 when most of the case

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.


--WcK/yTqIMBb/1oCw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPSnV4ACgkQJNaLcl1U
h9BB0Qf/cXGSWLvUVl2Z61FCqmMiBXZaH8+QfbXHiYwLT8edFj3IYGwdOqcoo83z
bMTVLnePDxBIjQBW2VFS4UegS9UwZM4dLLKSOh50Ennwfn4fWcalmWnWYELe00AY
WCFu/Ti7R4wu27k+2XjgRBANFozx56kdFEpndNERocrFTzz9Q3kzO/2yQ1JA5aSq
eeV8UIMLDtgpWUJifitLbEneKGmiMyqiU+fuHv759V1uzfyzVAoc1wqGZ3afd1Kj
HSNWRmwSt0TnbbP54fueiNjveeVtBbfdMPdgpgOZlk1ZARK7SMJJv4VvtbI4MYKr
g+FoevI2izHkSb5JDPpGNW59snuOkA==
=ydxe
-----END PGP SIGNATURE-----

--WcK/yTqIMBb/1oCw--
