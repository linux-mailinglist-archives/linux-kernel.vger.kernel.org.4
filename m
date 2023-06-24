Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F84A73CA13
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 11:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbjFXJZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 05:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbjFXJZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 05:25:39 -0400
X-Greylist: delayed 2067 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 24 Jun 2023 02:25:28 PDT
Received: from bues.ch (bues.ch [IPv6:2a01:138:9005::1:4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE082133
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 02:25:28 -0700 (PDT)
Received: by bues.ch with esmtpsa (Exim 4.94.2)
        (envelope-from <m@bues.ch>)
        id 1qCyyj-000E9e-Oc; Sat, 24 Jun 2023 10:50:44 +0200
Date:   Sat, 24 Jun 2023 10:50:23 +0200
From:   Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@kernel.org>, sardonimous@hotmail.com
Subject: Re: After kernel 6.3.7 or 6.3.8 b43 driver fails
Message-ID: <20230624105023.146d99e0@barney>
In-Reply-To: <27829c69-515c-36a6-4beb-3210225f8936@gmail.com>
References: <27829c69-515c-36a6-4beb-3210225f8936@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Z8OpuQ9cy1/jd8BhC4DCwVQ";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Z8OpuQ9cy1/jd8BhC4DCwVQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 24 Jun 2023 08:44:15 +0700
Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> > I suspect change introduced when addressing a compiler warning
> > cased the error.
> >=20
> > https://patchwork.kernel.org/project/linux-wireless/patch/2023051618344=
2.536589-1-arnd%40kernel.org/


I doubt it.
This patch affects the device initialization code. But the crash is in
the transmit path.
Can you please double check by manually reverting the patch?

--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/Z8OpuQ9cy1/jd8BhC4DCwVQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmSWrk8ACgkQ9TK+HZCN
iw7o+g/+L1zZKck52gaqBWL0RCy/d0c3DsVDsSvj4Cx4Ueu03xpyJAPUhGrzZ5ul
ZGNXu1p1GpfG81lMm/ONuUQgUo8WwXKvVQs8MJkmNAHX+cwzCZ3McyB1JQWrRhV6
zJVcIXl+RmwRr+EtzH5UWuha0VnXj2ygYWmafGQg7BSK7NvzDOWwzqYj3iZdTHlT
GbnFeM+lurbH9rbgSZsC9bXMvTxwABZREuzxzfakF3wATGUFuYoQyoq62/wey7gV
jNkX9PiD/sciVWsLvEri7B+wPfXDQRbj5Og2D07peJ+wZmC1AaR+To5zbAaAEcVh
jcM05dtnHIbFnoLq4CIrmJljNQHRzxsJjdhPflTcWkm+1fVJ2zucZQyWHs6rZ5ru
FjcOjfeK6v9gs0vLF+zGjpuPhIHSJqeRjgPWsRRil4ZbYRbG5WThLvs5AOMwDBRV
6+98COLGkrLqLrkc9iZCbONCW6RnDTdBuVNjaAOi+RVlwTCUM4CdO7APgAjdEd2S
wbfNQ9j2M8ox+pt5byr8c3/xFQOmOG4XoDRYgPai+k7apnAYX1KN09lWo45dxMQp
Zj9HKebrBj+C+v4AYrhDYp6v/wlNi/AZ7GDfI3cXxIvgWWNt3D7tQ21zT6jl9B1S
OOKtUdc55au+byw60JSnN+qFm6za7beCoxuDuQRHLSbgMHQjeok=
=LxCG
-----END PGP SIGNATURE-----

--Sig_/Z8OpuQ9cy1/jd8BhC4DCwVQ--
