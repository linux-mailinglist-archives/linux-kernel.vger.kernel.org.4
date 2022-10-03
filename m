Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03D05F2F8A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 13:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJCLXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 07:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiJCLXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 07:23:44 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBAB4BA5A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 04:23:38 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id D3FDF2013A8;
        Mon,  3 Oct 2022 11:23:33 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 5C02580967; Mon,  3 Oct 2022 13:22:22 +0200 (CEST)
Date:   Mon, 3 Oct 2022 13:22:22 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] PCMCIA odd cleanups and fixes for v6.1
Message-ID: <YzrF7i/lva5JRpxK@owl.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="H8ikQpzvYyWcmwOM"
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H8ikQpzvYyWcmwOM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

a few PCMCIA changes since commit dc164f4fb00a0abebdfff132f8bc7291a28f5401:

  Merge tag 'for-linus-6.0-rc7' of git://git.kernel.org/pub/scm/linux/kerne=
l/git/uml/linux (2022-09-21 10:14:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux tags/pcmcia-6.1

for you to fetch changes up to 15e74c6c1ce2d388e967f32cdaa83ca034fa6452:

  pcmcia: remove AT91RM9200 Compact Flash driver (2022-09-27 08:12:16 +0200)

In contrast to the last pull request, this one employs a signed tag;
hopefully with everything in order.

----------------------------------------------------------------
PCMCIA odd cleanups and fixes for v6.1

Remove the obsolete VR41XX and AT91RM9200 Compact Flash drivers, and
fix some minor coding issues (__init/__exit annotations, unused
variable).

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

----------------------------------------------------------------
Dominik Brodowski (1):
      pcmcia: remove AT91RM9200 Compact Flash driver

Souptick Joarder (HPE) (1):
      pcmcia: Removed unused variable control.

Thomas Bogendoerfer (1):
      pcmcia: remove VR41XX PCMCIA driver

Uwe Kleine-K=F6nig (1):
      pcmcia: sa1100: Make sa11x0_drv_pcmcia_legacy_remove() return void

Xiu Jianfeng (1):
      pcmcia: Add __init/__exit annotations to module init/exit funcs

ruanjinjie (1):
      pcmcia: at91_cf: make mc static

 drivers/pcmcia/Kconfig          |  13 -
 drivers/pcmcia/Makefile         |   2 -
 drivers/pcmcia/at91_cf.c        | 407 ----------------------
 drivers/pcmcia/i82092.c         |   4 +-
 drivers/pcmcia/omap_cf.c        |   4 +-
 drivers/pcmcia/sa1100_generic.c |  10 +-
 drivers/pcmcia/vrc4171_card.c   | 745 ------------------------------------=
----
 7 files changed, 8 insertions(+), 1177 deletions(-)
 delete mode 100644 drivers/pcmcia/at91_cf.c
 delete mode 100644 drivers/pcmcia/vrc4171_card.c

--H8ikQpzvYyWcmwOM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEmgXaWKgmjrvkPhLCmpdgiUyNow0FAmM6xe4ACgkQmpdgiUyN
ow0DLhAAsS57vPHlzkh9IMmKoafdpM07DlbFhj+GQPSX68tKOrvrkNveEpkRYGL+
IEz6Ndmqjsf+N1sYgaGwUuYkmvjiy18X99SwAJYq9iYq24Hqetz9MtkAQ6zEOgKH
719uP+THNvixQAc/hNrSK333IMCqnQ+uQ2B2jhiQIa3AN9I3ayxWDneQd9rXBgge
topiGvseTtVk7rS4kgW7JKzbponM1EDrfuHoa8nfWPaEILBTDAJSlMg2EhlIEDxD
oyWnP9hlP/vv6vD+U6CJx1LJWtYyyIkkG9Ag/FGCFWAQLjDFnowQqbL/lq/LkzH8
imtLHPfZgSPbQwP9t6bkzkVE3mguTcHApJz71R0aYhV2D8QtDL2BOYDh5QlwxZYd
i6my1ISK8G/4bb03J7WuzpzstOKcM6YHgD4CeROV93nDwdZyLhWfvy2dZIL5brDn
pEPUIqyx94CQAc9QMZY+1oLjDMWbhzuk2I3AKHnCT9DJsqF/vWUonpqSA4G5lhBS
x43qpjCBYaFUiZtfw7sdzbrsbCRYZHAULxxBZP3gDdDW2Jpm1AO5nnGzCWG7UEIj
Wr6FzLdBRzw3+y7D5GR88eFaSjiLlcxJXnDJ9k1QzQfGprOyT2CavcwsbA1pooZs
scBRpwYYUDMAoitRYitc3NZZi30QV0b4EqO+6zqKeEJ8qO15Cr0=
=cFDj
-----END PGP SIGNATURE-----

--H8ikQpzvYyWcmwOM--
