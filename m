Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267F3682311
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 04:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjAaD5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 22:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjAaD5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 22:57:01 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC25232521;
        Mon, 30 Jan 2023 19:57:00 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P5WT351bbz4x1h;
        Tue, 31 Jan 2023 14:56:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675137416;
        bh=0ULXQQPxQt5dD1YSuQCXxacGANsv4+XOFGF6aRjY5H0=;
        h=Date:From:To:Cc:Subject:From;
        b=OwEdBaAZb5GKHBwxatk6TNBOZtxNBtpY9C9yS816s6IktOPSzkql0bkPYN2DdOo/i
         p9V9z/IM3y29HYAwDW9zI4IyGR2ymHGo0NOrkM267WsewFd0oZh/4oGM9gpLtpj111
         Y9EcUD246sFGT3C7m8niwkyc94rLvbNi5d4WK46BJ9m/8YR8TW7DW7a1XKiKDUWfN/
         2g+dnOjrUUsN2Fep2aPJG6qmy1W8Rv2giaZbRKc2k0783ognR8z0c2bLV9xmrInmbi
         /ly4UXJ+8+Cp13LikK4LrDn+87/Xc44TgMbi64N8HgGxlRPKiImD4sfoxAtfLpz36I
         SbhlVvhiu6cMQ==
Date:   Tue, 31 Jan 2023 14:56:54 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the mm tree
Message-ID: <20230131145654.768c6149@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gG7OXgly3Ex4=D/K4f0bWgz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gG7OXgly3Ex4=D/K4f0bWgz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the ext3 tree as a different commit
(but the same patch):

  05a4851d2729 ("fs: gracefully handle ->get_block not mapping bh in __mpag=
e_writepage")

This is commit

  7010839ccfd4 ("fs: gracefully handle ->get_block not mapping bh in __mpag=
e_writepage")

in the ext3 tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/gG7OXgly3Ex4=D/K4f0bWgz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPYkYcACgkQAVBC80lX
0GyGjQf/QM1Xy8wzoDxi/axUGqJL+cAshfn9Qte/PjkmhkXXp1267kLyYkMiQWhM
n5izzawz258LteZfywd+204KGhe8NVGXpnh6AIiN5eS9s3kWBM5LGWe5/itHMIah
T7SCz4sdDzRuGE71BfcjRoDSm3BuXrD2g0XfdskORqaUXxsZyaz9Rmxlm90JOPEt
H7itojZ3C8gD+1lvIj1lAoZGkJpeQyIeksqELsjFhaxLSlSHsG6ykEEf9GHTP/1l
ApBNsgThGUkloFVj59IO/UNPeQLJeQlu3AtY9u+9bcUJJxk4Z3LG3gMHLEhGmDNl
o+PdJehNoO4fgkAytOOGqXi1kt1p8w==
=WsHP
-----END PGP SIGNATURE-----

--Sig_/gG7OXgly3Ex4=D/K4f0bWgz--
