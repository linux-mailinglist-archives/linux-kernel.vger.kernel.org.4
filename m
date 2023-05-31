Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EB97174AA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 06:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbjEaEDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 00:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbjEaEDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 00:03:23 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C9B129;
        Tue, 30 May 2023 21:03:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QWFwp0plXz4x1N;
        Wed, 31 May 2023 14:03:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1685505786;
        bh=yjotNQExuzX+Lp+iEvAEdXkADrZcZc8kesbV8psOJMo=;
        h=Date:From:To:Cc:Subject:From;
        b=XN2ZefiqAAP2NW4SQdk5GKuJ467Bka/tc5co8OPnPdy6F0mA2cufuIJECzwx1reda
         de0vgk90Fkp6s56B4P/P6GSoJ79oYP0iQfPILn5lyHqxjez3kg3GCho4MpYsoKgLP5
         1VE79Xza8kCyprujdJSCNwD//pPmVTIosa9oMM1UuwsaqCbtmm+k1RqkpelbP8u/at
         ko8BIWHh8fcDZukpw1UptgdMHJiMM8VfyBv5ROy45vspnAy9b4gPtkYlEOSLxY0Czj
         s1b8IUk1i2ZysbxtwVCKAEl4NGKGMwQObgEACE3OxN5S5qhY4joBzfjgY1eLzai0Ry
         gTZfzl8qjHg3g==
Date:   Wed, 31 May 2023 13:53:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the ieee1394 tree
Message-ID: <20230531135306.43613a59@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2L4SglYfePw+cZE_FIvo9WQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2L4SglYfePw+cZE_FIvo9WQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the ieee1394 tree, today's linux-next build (htmldocs)
produced this warning:

include/uapi/linux/firewire-cdev.h:164: warning: Function parameter or memb=
er 'padding' not described in 'fw_cdev_event_response2'
include/uapi/linux/firewire-cdev.h:293: warning: Function parameter or memb=
er 'padding' not described in 'fw_cdev_event_request3'

Introduced by commits

  7c22d4a92bb2 ("firewire: cdev: add new event to notify request subaction =
with time stamp")
  fc2b52cf2e0e ("firewire: cdev: add new event to notify response subaction=
 with time stamp")

--=20
Cheers,
Stephen Rothwell

--Sig_/2L4SglYfePw+cZE_FIvo9WQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR2xKIACgkQAVBC80lX
0GwHPggAmMhZdvpJup+aP6ZAhls/hIGu0VrSDg5YLL9LiakmfQ+Jsmr+LzTdzdjf
zErqL9FLO5Z+DP6YWKmDRA+caf0QPqaMh5EQMomgWOo/rWkAQWtpbINIkE9QieHW
3SCqDf1g6K3CcN/L+7kj+a6IpmkMvdHEMzwHyYoKvBjv51qnqWVAX9wM2ZS2Io6w
aInUR8E2qpWv9UVP5B7dBDfLxJ5LVnkGdo1gaeQ0ZqGq2mxdYIIZ6HHyYy1HF21G
Qv6Arakn2eD2W3sDynlh5WNr5m77iRCwM3Elb+afCpR5nHij40soMVzRTNbvcO5X
sUzLmbPixP3iNZtcDCxil3Jlbyt5Bg==
=5Kmr
-----END PGP SIGNATURE-----

--Sig_/2L4SglYfePw+cZE_FIvo9WQ--
