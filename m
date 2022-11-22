Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEB46335B3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 08:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiKVHLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 02:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKVHLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 02:11:00 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEC5303E8;
        Mon, 21 Nov 2022 23:10:58 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NGb596zD1z4wgv;
        Tue, 22 Nov 2022 18:10:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669101054;
        bh=nyeF04Knp8y7cOZd9oxlnJ2ullys+K3OaYBYCSqHX+o=;
        h=Date:From:To:Cc:Subject:From;
        b=RYWpskUnIL7J7if9i42J+FfdHBJZrjlmeKG1sF/fMIACNMl2Oqj0TYlwr/avFAba/
         9Sz1S54RcIFyFIDhZUWmiMdwCBJICMkp11Z95KqxvyNi4eA1xRhQrpOjoTwg4l533f
         QWzzFf7GqZ/ORjtWrGLdP6eH4sx422cXkJXg9ImpOhJdrVI3Wj+bGITyXaXYPQZA9p
         QasWCxrXAVjYox+UORF3k9dU7u18X8ReHjzR08rGs3DY37XQDWdrMdhiEgB3zd5c2e
         CsolibZWEd6x8LtcXH55AJilqmNAZTwjJChsAKllYmU/nA8ZbKCaybPjjO29kp5obM
         pgJ6QqLUY7n6A==
Date:   Tue, 22 Nov 2022 18:10:52 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the printk tree
Message-ID: <20221122181052.75618842@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1yT9IZ6fS6S_2bv8RJgdbds";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1yT9IZ6fS6S_2bv8RJgdbds
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the printk tree, today's linux-next build (htmldocs)
produced this warning:

kernel/printk/printk.c:298: warning: Function parameter or member 'cookie' =
not described in 'console_srcu_read_unlock'

Introduced by commit

  8bdbdd7f43cd ("printk: Prepare for SRCU console list protection")

--=20
Cheers,
Stephen Rothwell

--Sig_/1yT9IZ6fS6S_2bv8RJgdbds
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN8dfwACgkQAVBC80lX
0GyqCwgAjyCqG7Kt0qYOCxCg6lPugOzRJjt2otAfGCW7GVuyO8UHCzPARhK1/RwJ
ICvPTvtQejVw6e5wUA3UzqGhwTAourUMQsYFhPb7s82ePx4fwHOVsIRwFf7G3TmT
qjlK270oCnngcX/Cp0/Lgs+OiujipFbAx6ktUywFdRKWUInMlmrFvEy4mLf4hEOo
r+RNMaKG+R4HKTdKJ2lKMcNtqF0FwrG4xtjRZfJBtKvm/oxE1JNResI1JaQVjvzR
uZTax1psJ3lgRm1yEcpuM6jFzWJLrYOeIG+YX+GCltAWCT2k/pX/375QaDemxJLn
BFRRZUEkXPVnJbnfSosjj4S+yNTPHw==
=qS8K
-----END PGP SIGNATURE-----

--Sig_/1yT9IZ6fS6S_2bv8RJgdbds--
