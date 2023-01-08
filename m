Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515346612F0
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 02:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjAHBwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 20:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjAHBwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 20:52:20 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4FED44;
        Sat,  7 Jan 2023 17:52:17 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NqKnl6l4Kz4xND;
        Sun,  8 Jan 2023 12:52:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673142732;
        bh=T5uEKpoCTrKRPB+aFMQNCJS5mshS0phU/iIzgdeGttE=;
        h=Date:From:To:Cc:Subject:From;
        b=C1MEQkmCCO1+8siH9BXKRjQ2K/aUaFE8y0pm0xAPRy0dwjBs/1r/PHDWmdPZLe8eN
         Nek9HTelvevy5ZUviNAupqj7lzoKBW6Pee3loVtvK3RCCqW4+xUGg+u2MQh885K8Nv
         os0xA12gpr1vSUFpZCx81rdYJY0nMFr1txMCMkxOSYqaH83p0N3T2hFa8qX9E51VmU
         5y9pbu8x8kfzCVosvKUfGaQ6G3pRKHk/WJy9rUEVBQTjz+gQGQ/a2gO6PIGp40rzVa
         VGzF5tSz8dW2zFDCv+EPLs9vDWpXeZbuPDZynBAjX5VElYnXw0UUEiH7BSTlR4gKP2
         EYr5AivRqDENw==
Date:   Sun, 8 Jan 2023 12:51:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jan Kara <jack@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the ext3 tree
Message-ID: <20230108125156.30578c00@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yFJvQNP9JlskX_SLzDr6pHS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yFJvQNP9JlskX_SLzDr6pHS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different commits
(but the same patches):

  ae9e9c7ff062 ("udf: Fix extension of the last extent in the file")
  6d5ab7c2f7cf ("udf: initialize newblock to 0")

--=20
Cheers,
Stephen Rothwell

--Sig_/yFJvQNP9JlskX_SLzDr6pHS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO6IbwACgkQAVBC80lX
0GxO0gf/SDZUt2IuObQaBCvxicZakpXt+53PBRVYdr3BcOZvK1VYM9t3nKjTdQ4c
ki8yLH43x7wl3N5Woe+zlVX6PMFQMCha92HBVwOsJ8dyfVegeBKU5WHUhkICDDS9
IHjjw1Y7IwPeTXh4GmDTUH00vNR+FcJPm9e/K5wAIHJXo6TeZw0fidoCq17H4er5
Nc9eJfcwZtxXrlAlKyiQyvl8r3IOybEFEds5HB0kVYd6GKxbSqagkp5GwjbXFXEJ
OOBpv5YVMD6HnKMfhojU5yFOaIxe+LkJHbOJ97LAorXjcLEvIfqJJmpjM5f75F2d
13D5DjdVkyOEM6b/xuR9w9qUXzvObA==
=OW+p
-----END PGP SIGNATURE-----

--Sig_/yFJvQNP9JlskX_SLzDr6pHS--
