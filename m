Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14946742398
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 12:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjF2KBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 06:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjF2J7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 05:59:40 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C50730EC
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 02:58:03 -0700 (PDT)
X-GND-Sasl: didi.debian@cknow.org
X-GND-Sasl: didi.debian@cknow.org
X-GND-Sasl: didi.debian@cknow.org
X-GND-Sasl: didi.debian@cknow.org
X-GND-Sasl: didi.debian@cknow.org
X-GND-Sasl: didi.debian@cknow.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id B380EFF80B;
        Thu, 29 Jun 2023 09:57:59 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org,
        Diederik de Haas <didi.debian@cknow.org>
Subject: checkpatch: diff: LICENSES/null: No such file or directory
Date:   Thu, 29 Jun 2023 11:57:49 +0200
Message-ID: <8238840.T7Z3S40VBb@bagend>
Organization: Connecting Knowledge
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10297417.nUPlyArG6x";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart10297417.nUPlyArG6x
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Subject: checkpatch: diff: LICENSES/null: No such file or directory
Date: Thu, 29 Jun 2023 11:57:49 +0200
Message-ID: <8238840.T7Z3S40VBb@bagend>
Organization: Connecting Knowledge
MIME-Version: 1.0

Hi,

The checkpatch.pl scripts has been a great help in improving the (very bad) 
quality of some code I'm helping with, so thanks for that :-)

But it looks like I found a bug after I added a LICENSES dir and a 
GPL-2.0-only license using the `reuse` tool. When I run this command:
~/dev/kernel.org/linux/scripts/checkpatch.pl --no-tree --file --terse *

in my working tree, I get "diff: LICENSES/null: No such file or directory"
after which it stops processing the rest of the files.

To reproduce:
1) git clone https://git.sr.ht/~diederik/bes2600 -b improve-code-formatting
2) cd bes2600
3) ~/dev/kernel.org/linux/scripts/checkpatch.pl --no-tree --file --terse *

If you then do `git reset HEAD~2 --hard` and run `checkpatch.pl` again, it'll 
finish to completion.

I just did a similar test inside the kernel tree, and got a similar error:
- `scripts/checkpatch.pl --file --terse *`
- result: `diff: arch/null: No such file or directory`

As my LICENSES dir was my first subdirectory, it appears the issue is with 
subdirectories in general?

Cheers,
  Diederik
--nextPart10297417.nUPlyArG6x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZJ1VnQAKCRDXblvOeH7b
bp4yAP4vpUHyOjuVAZxIEAYjw8prdos7AbX0C5q+/dmwpE3kDQD45vnvnw7P7VzZ
IM+eUvaEIL8WgcFLXj+8fb+AQzSwBw==
=RGhl
-----END PGP SIGNATURE-----

--nextPart10297417.nUPlyArG6x--



