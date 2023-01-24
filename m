Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EA767A5A2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbjAXWYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjAXWYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:24:21 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66843EFE1;
        Tue, 24 Jan 2023 14:24:19 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P1hN14GxWz4wgv;
        Wed, 25 Jan 2023 09:24:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674599058;
        bh=thiO001uEAnek1cPOnLCaHD53JS+1vVxqUaQBGQim5k=;
        h=Date:From:To:Cc:Subject:From;
        b=YItLGZsl6aMBB+hzY8yTHA2LmNawKsPdxrAoiBXU4FSiEDGac8Sqp6WgF2axBPIQ5
         vCJPG25Xywfzogh01tzXCqAuAiAM+JThjIMOCtTzbKKILcJILWzrRtOzvrMghwDlL1
         coPzWNzI4eCR59oO4TJs1nx1lbWja/7tGysc0wOC1ew9vBxiLqZIuR9y9K6z6fPQJy
         eizSZ0T6ep0HklS9iHA3wCP6dTN/9F+VfBUp8feSXXWYQrPMqlC6bfNOS8BW6RRTVk
         POjNWgqVL63Jy15SPzIIOtgLXNUhJGx149NTNCX9Ppna/aplcHqHNI7s1I0s43YXXv
         HAGReWdvPxo/g==
Date:   Wed, 25 Jan 2023 09:24:16 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Mario Kicherer <dev@kicherer.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the hwmon-staging tree
Message-ID: <20230125092416.44a98d6b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mn4PukFlLhjfeJFnB2trQ+t";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mn4PukFlLhjfeJFnB2trQ+t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the hwmon-staging tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/hwmon/mc34vr500: struct of_device_id is 200 bytes.  The last of 1 i=
s:
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x6e 0x78 0x70 0x2c 0x6d 0x63 0x33 0x34 0x76 0x72 0x35 =
0x30 0x30 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 =
0x00 0x00 0x00 0x00 0x00=20
FATAL: modpost: drivers/hwmon/mc34vr500: struct of_device_id is not termina=
ted with a NULL entry!

Caused by commit

  d4a6ae044045 ("hwmon: add initial NXP MC34VR500 PMIC monitoring support")

I have used the hwmon-staging tree from next-20230124 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/mn4PukFlLhjfeJFnB2trQ+t
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPQWpAACgkQAVBC80lX
0GxvAQf/ex+K1LlLNKjEPT82XKDS49mMIwMO7zNv08TfzVIHyxUelVza81rzTByx
1Mz3z59pwNNTJO1aSkAc2uMhNBl0I9G444G5b8hpiOBTBA0JRDz7UrWbzBt4yx6G
sCKSc6QvsrS8b5ooCwMoZ7KCqr5B1B94fW1l1VGTz6B+BAby+74wLH7I7kAImyN/
JuGDaWCgW3hWDefk7yCICCBulbxeCknK40PhzkW76DIrbW32rEwjHt4TGylBxJRs
nzxSRFvsDDXKlIMhHdsnQUULmUUlYZQ7S1RB0BisUynmjzJjJrLhJeHv1gVnAA4b
OlfvlglHZcaQCSNoFwpXH+sz5kScEg==
=/ogj
-----END PGP SIGNATURE-----

--Sig_/mn4PukFlLhjfeJFnB2trQ+t--
