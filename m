Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC4767893D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 22:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjAWVJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 16:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjAWVJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 16:09:02 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED4226A8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 13:09:01 -0800 (PST)
Received: (Authenticated sender: didi.debian@cknow.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 165F140006;
        Mon, 23 Jan 2023 21:08:57 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Diederik de Haas <didi.debian@cknow.org>
Subject: Re: [PATCH] pcmcia: soc_common: Fix full name of the GPL
Date:   Mon, 23 Jan 2023 22:08:56 +0100
Message-ID: <16790560.7jOyYqUiGk@prancing-pony>
Organization: Connecting Knowledge
In-Reply-To: <20230122183607.56277-1-didi.debian@cknow.org>
References: <20230122183607.56277-1-didi.debian@cknow.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3519562.muEIU1276t";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3519562.muEIU1276t
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
Subject: Re: [PATCH] pcmcia: soc_common: Fix full name of the GPL
Date: Mon, 23 Jan 2023 22:08:56 +0100
Message-ID: <16790560.7jOyYqUiGk@prancing-pony>
Organization: Connecting Knowledge
In-Reply-To: <20230122183607.56277-1-didi.debian@cknow.org>
References: <20230122183607.56277-1-didi.debian@cknow.org>
MIME-Version: 1.0

On Sunday, 22 January 2023 19:36:06 CET Diederik de Haas wrote:
>      Alternatively, the contents of this file may be used under the
> -    terms of the GNU Public License version 2 (the "GPL"), in which
> -    case the provisions of the GPL are applicable instead of the
> +    terms of the GNU General Public License version 2 (the "GPL"), in
> +    which case the provisions of the GPL are applicable instead of the

I was wrong in suggestion this change, so please disregard.

It would not be a spelling fix as originally intended, but a license change.
I highly doubt that I'm authorized to do that.

Apologies for the trouble,

Diederik
--nextPart3519562.muEIU1276t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCY873aAAKCRDXblvOeH7b
bhcjAQCy7M/7tI1eSBWyVII+ZZ2seE5h+eEcFfZSLjVl//cNwAD9Gu/FaMRhFUBd
mPQrehXShfkwQdpwNLLcLWhHS7aQXQ0=
=HYdQ
-----END PGP SIGNATURE-----

--nextPart3519562.muEIU1276t--



