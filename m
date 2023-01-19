Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FD7673126
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 06:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjASFYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 00:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjASFYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 00:24:40 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0751A2720;
        Wed, 18 Jan 2023 21:24:38 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ny9zl55CFz4xFv;
        Thu, 19 Jan 2023 16:24:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674105876;
        bh=6nBdNP12YTHnDhZVD+lqgd4S488WUtiIdc8rEpXgK5Q=;
        h=Date:From:To:Cc:Subject:From;
        b=l80paEW3Uliu6RmUo93MJxcfLWpv2VWMZA4Z/jnoxvx5FAMi9XDxOYfr0bV63m+lX
         y+fkKYGbQB4HE0tq7GLP2rmKSFy3THCFFJksBB9HgFfHuILtp9U9TRQYF7i18zKc0n
         wOuocxCISHL28ueub8Gqh6gZ7SVrKvCDtVinJ/2RxjkY03m6HKvXxhSsRZmuefsmEb
         0Sw86yEf+gZz3plzwtrKv62256JbpMbJ9LeUo0PU6FqaGJHN7nwIl0XxJbEhZrf+jE
         rnDgHLKLqszPjgW7hz/XmHmOVufqgnDXnv5BtC2tlSFatyl2Wl+wy/kEkO6qy9AK8U
         QBjxcQJpV8F3Q==
Date:   Thu, 19 Jan 2023 16:24:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the wireless-next tree
Message-ID: <20230119162434.227ff777@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Lc6cW.PKTdwX9SczYaDttPe";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Lc6cW.PKTdwX9SczYaDttPe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the wireless-next tree, today's linux-next build (htmldocs)
produced this warning:

include/net/mac80211.h:1553: warning: Function parameter or member 'eht' no=
t described in 'ieee80211_rx_status'

Introduced by commit

  f66c48af7a11 ("mac80211: support minimal EHT rate reporting on RX")

--=20
Cheers,
Stephen Rothwell

--Sig_/Lc6cW.PKTdwX9SczYaDttPe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPI1BIACgkQAVBC80lX
0GzHYAgAlWGA+UKcUvXnKXfzwDlFUT/7L8E95YnBON/yt9N6oCKJWEUQafV/xL8+
Y3B4yQajraXNWD7av3d1EGY2ViwltMl4kt6wZ86csZuIV9LezGSpa+cqHvHCPC32
YcBFr1P23YM7B4fe4q2f1bWVilsSZN9G46spNqIP8TKgLBx0x2Y2NW5R11RkFOJn
4WKGkG/mP/7YxvQDC80is/pr1Wv5uvXJVMfEie54yMdwhXRpxXKi1yLoaUe9QY1T
cU6Mma8RlhYTvRQGomsYqOvNPyq+fiw8KTMbFTTcHIPaeadFtPPE/ko+9FoQiXPP
AUcjLdp0yfB8CXzKfQendHi18aSZyQ==
=WQvD
-----END PGP SIGNATURE-----

--Sig_/Lc6cW.PKTdwX9SczYaDttPe--
