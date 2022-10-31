Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9C5613A9E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbiJaPqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbiJaPqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:46:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39ABF12624;
        Mon, 31 Oct 2022 08:45:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2AC9612B9;
        Mon, 31 Oct 2022 15:45:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EA6C433D6;
        Mon, 31 Oct 2022 15:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667231140;
        bh=Gfx5xqDBJQm6OTzVGDzkuc7YFMXL+R2QMUfRfaHarw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C2ol+s/GsL7TPDoteDrQ1RWKAz7R8D9cY/k3aRxCdTKvWQldeEQvLdHQPa8bsl2PW
         5Z64chqinjQHYuqxCy3mfh13IJs5vElXHtAbtKlmAQ7s+9sWg4ZK+Zm5hB9hBJc7+M
         srYacHx165jh6KsdX4ur1sQJ6nanQ2GvYHPnDGt0sHbIM3Gkkr/YMtFc7vpU5+M8fS
         vb7P54kOuKLl0sD9IioyCEHrfpB6zv1CnS9NDxW1sXpTmyf2YZP8ihgBSQanHj6hbx
         AXUje3G837j2VHJ92gKvRwVMkZ/txQrn51quak/Q2hGZBk9/kjiiiCtN18+bSFZkl+
         UrgA97jg31V/A==
Date:   Mon, 31 Oct 2022 15:45:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Naresh Solanki <naresh.solanki@9elements.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH 2/3] dt-bindings: regulator: Add regulator-output bindingg
Message-ID: <Y1/tnic0qc/Ll/5u@sirena.org.uk>
References: <20220925220319.12572-1-zev@bewilderbeest.net>
 <20220925220319.12572-3-zev@bewilderbeest.net>
 <20220929210714.GA2684335-robh@kernel.org>
 <YzYNt+IQRomycRLs@hatter.bewilderbeest.net>
 <Y1rRCq9Kdd2zPPkw@hatter.bewilderbeest.net>
 <ee37b5a1-5afc-71b3-f777-add295d9ce17@linaro.org>
 <Y1tWpikPogEtV0+x@hatter.bewilderbeest.net>
 <Y1v6migO2PNV4ksW@sirena.org.uk>
 <Y1wxMk2x25AeRwLr@hatter.bewilderbeest.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HdNa3smXV1x+Yg8k"
Content-Disposition: inline
In-Reply-To: <Y1wxMk2x25AeRwLr@hatter.bewilderbeest.net>
X-Cookie: Sign here without admitting guilt.
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HdNa3smXV1x+Yg8k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 28, 2022 at 12:44:50PM -0700, Zev Weiss wrote:
> On Fri, Oct 28, 2022 at 08:51:54AM PDT, Mark Brown wrote:

> > We don't turn things off on reboot?  We don't do anything in particular
> > on reboot...

> Okay, perhaps not on reboot specifically, but the userspace-consumer driver
> has a regulator_bulk_disable() in its .remove function, so it would be
> triggered at least by a module unload (which is sort of why I ended up with
> the "when software relinquishes control" wording in the patch).  If we're
> going to continue with the plan of using that driver for this functionality
> (which seems overall quite reasonable to me), we need a way to express that
> that must not happen on this hardware.

Ah, that would be the test driver not intended to be used in production
then...  That shouldn't be a blocker for the DT binding, and if there's
a different compatible string for this application then we can either
make the userspace consumer do something different based on that
compatible string or have a new driver which does something more
sensible and perhaps has a better userspace ABI.  Either way so long as
we can tell the thing being described is a BMC output from the DT
binding I think we can leave it up to the OS to do something constructive
with that rather than trying to control the specific behaviour in the
binding.

--HdNa3smXV1x+Yg8k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNf7Z0ACgkQJNaLcl1U
h9BkFgf9FKsGGxWuC5iXQlHFiyi14CZmY17XgUIeryMt5FgoDqOVqrzpmW1eyubx
OYeSw4HIYHNJbaad3hPryk75jFUsKsfm7Zt1JSssh2t1w8S+SBET9Gm8PRXWYo4D
A8ONEz9bbWPUbP9obqEvlFN+fWBGyehb7c2/JN2kElFu8iN+NoR+yiMsMKlvwV7y
AWY5AT6u8aOyuYtW3lHfiGK4zGCFatnAqDvC48NfN09naLGBAE7CvARC8I6vw91p
hloaMc6YxMK2jtMsWLtwlLi+Z4P9BArYv4Y2Xi9x5bPFQw/q7e02fh6A76XvBaRF
bOlyuze5LAJQhttKvmKlIl9ls82INg==
=aRAV
-----END PGP SIGNATURE-----

--HdNa3smXV1x+Yg8k--
