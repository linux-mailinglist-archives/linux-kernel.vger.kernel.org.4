Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E088677CC9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 14:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjAWNno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 08:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjAWNnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:43:43 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD77C22A37;
        Mon, 23 Jan 2023 05:43:41 -0800 (PST)
Received: (Authenticated sender: didi.debian@cknow.org)
        by mail.gandi.net (Postfix) with ESMTPSA id EC8A8100006;
        Mon, 23 Jan 2023 13:43:38 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        "open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] watchdog: Fix full name of the GPL
Date:   Mon, 23 Jan 2023 14:43:27 +0100
Message-ID: <2281101.Yu7Ql3qPJb@prancing-pony>
Organization: Connecting Knowledge
In-Reply-To: <ad99d227-ce82-319b-6323-b70ac009d0e7@roeck-us.net>
References: <20230122191345.58989-1-didi.debian@cknow.org>
 <ad99d227-ce82-319b-6323-b70ac009d0e7@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1961361.WSzfceE71T";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1961361.WSzfceE71T
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
Subject: Re: [PATCH] watchdog: Fix full name of the GPL
Date: Mon, 23 Jan 2023 14:43:27 +0100
Message-ID: <2281101.Yu7Ql3qPJb@prancing-pony>
Organization: Connecting Knowledge
In-Reply-To: <ad99d227-ce82-319b-6323-b70ac009d0e7@roeck-us.net>
MIME-Version: 1.0

On Sunday, 22 January 2023 20:45:13 CET Guenter Roeck wrote:
> No. The only acceptable change would be to replace the text with the
> SPDX license identifier. However, the code is not specific declaring
> _which_ license is being used (2.0 only or 2.0+ or even 1.0+).
> Given that, the only entity who can change the license text in this
> file would be the license holder (which is presumably why it wasn't
> touched when the SPDX conversion was made).

You are entirely correct and my initial view of it as a spelling issue, was 
wrong. Please disregard the patch.
--nextPart1961361.WSzfceE71T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCY86O/wAKCRDXblvOeH7b
brPSAQDGDCineYMC/SWUOr7iPkc4153C8NXajsSPGJdv8dIv8wD/ccVs7720J0TF
lvv8B1uGOH+jH/RhRcaEoS1IRaK3Lgg=
=dDwY
-----END PGP SIGNATURE-----

--nextPart1961361.WSzfceE71T--



