Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A35366B4C2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 00:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjAOXXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 18:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjAOXXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 18:23:06 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA03310E1;
        Sun, 15 Jan 2023 15:23:05 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NwB5z20PVz4xN4;
        Mon, 16 Jan 2023 10:23:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673824984;
        bh=UKyYbDuy6lwgDo4/hfthUCZgTrX2zb1kXSvWINxqPCI=;
        h=Date:From:To:Cc:Subject:From;
        b=Fmyt+WauuJtgRmS8Ymv0Xu84QBddi+rW04+3hZ26Ue87jM54tW0jNj2AtR7AvWs5u
         XvWle05u9xPxUMcsm+WCDaLYpKUqUH0avhFsoGQFMRyD6g4x+nPw0WlyVvjkgbNKB2
         DYSbudbCW8QazU5hff9pnq/T1Y2XlhQ6CH5aPaTbAV97jjXWHlXvaXbaMJaFOjaYtJ
         +RwkqhU7YOnkKre48osB6/H/LDPTet+e9LEThykJwZLDjaOe5UNEG8LJsDaHxJIhcq
         r0WgPOt5Ra/ALLFfgBmCuNoftNGhFuUihXYkE5l6c8mTsab0MGcHI6TyfMug6oUuDa
         SSyF38zIjbMew==
Date:   Mon, 16 Jan 2023 10:23:01 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the printk tree
Message-ID: <20230116102301.66ccb248@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/y7X5PhoTd84xpw4a3MImU1h";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/y7X5PhoTd84xpw4a3MImU1h
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the printk tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: modpost: "console_srcu_read_lock_is_held" [drivers/tty/serial/kgdboc=
.ko] undefined!

Caused by commit

  75ffddf01347 ("tty: serial: kgdboc: fix mutex locking order for configure=
_kgdboc()")

I have used the printk tree from next-20230113 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/y7X5PhoTd84xpw4a3MImU1h
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPEitYACgkQAVBC80lX
0GwXzwf8C7Otp0/XxQOoG1KCwaDcYcvX9WArcQ27kpChAUlAm6MXf5A18Atsr5fS
8GykckYzC107zuOd2j0QPBN7CSDmqJUKTq76lwbAlpWeK3zSOaneYbSOrEVM1Rb6
T2khUjUuwoGV5dvbb7PEzNsYDsPmDToOOiqhvZ6zK8SYFMyZUfzweNvDQL+WW2Wa
FX4PjEWgRFjnmCVtj6SHPCOPOi8YY2IobczSQ5BLOVHIBIVqCE0vjcEEFv39NOjB
sMcj0I+LNTV4YHggrbb3U/Iyharbr00RQWth+xIaQB/sn0brL+MXuOx6ATPZ7smx
ONowLfHexV8tqPXztKPy4T6hlOkT4w==
=p19v
-----END PGP SIGNATURE-----

--Sig_/y7X5PhoTd84xpw4a3MImU1h--
