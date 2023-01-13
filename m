Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF4666893B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 02:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbjAMBl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 20:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240396AbjAMBlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 20:41:21 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D124140A4;
        Thu, 12 Jan 2023 17:41:00 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NtPJQ6RRdz4xFv;
        Fri, 13 Jan 2023 12:40:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673574055;
        bh=lpKOEgV4Mo4ERibfWKSY7/EL4Tqz0Zcmb5+2SJDrVKI=;
        h=Date:From:To:Cc:Subject:From;
        b=RDABPlVWxenJ0b98yJxov4bP4T3eVTF65YPOL9JHpA1AuuDx/8I5c9d1kKsaBjOsY
         DXkJFAJwsVQ1+vb/YHaLELM8cZR7+rHswOVlN3J8RZfKs2lkpxptszlc8RzJGx0MOz
         lZ5+2qxGj88X8O+/0VJy+PRQnfckNIyRsQ1ynFNHYALCyotCN16utytCvWyA7ssMPu
         26YX8ciDNNspfC2vBS2Uj9MJqm9mHhtgbNapKSavNXA4l7+qHdabC1awafQusJklw6
         rTtGlq+R4DckjB9eYNiYUg5rqBlVaeeedsAmvb077vMKE0mEfeb3Tb0pNIZV99tV+A
         vkyTx41Rmut+w==
Date:   Fri, 13 Jan 2023 12:40:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the tip tree
Message-ID: <20230113124053.5a75633d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MdXEYz7qWe/_HaEBQrBHFji";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MdXEYz7qWe/_HaEBQrBHFji
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the jc_docs tree as a different commit
(but the same patch):

  379af13b31fa ("docs: locking: Discourage from calling disable_irq() in at=
omic")

This is commit

  ac6fadf4aa60 ("docs: kernel-hacking: discourage from calling disable_irq(=
) in atomic")

in the jc_docs tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/MdXEYz7qWe/_HaEBQrBHFji
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPAtqUACgkQAVBC80lX
0GyAGAf8DJmgzgFfl3z3AePPwO9CFj3PLOQpDQFXcY+7zcihe/rhhRgCUX9j6sbz
YDukR7p78RWOvhTECnJbdlk6vVbE7W9IUt1BIf51PfZvd/PUXXv4eSk2oUb1Sztk
VKAZZ5TfunmEJphsBaHYmAOhuBX7cALvf8XBb4hLe5MWei0ti4EWmQZm2El801SQ
JL/ULnB8xn/YHx00MV5ybU7MX8PjIu5ucptaIsyntIOT8KXX+WGpcrUuPB9pac4u
kUF16DBjgTgIT7sBp9nr2z2LNWdSdrrzGesgUgBCLYXv+3oK70fQ38IbsxhenBF2
Chezwjn+kN1jUMg+K75Bn+Pq1pKi9g==
=k7RE
-----END PGP SIGNATURE-----

--Sig_/MdXEYz7qWe/_HaEBQrBHFji--
