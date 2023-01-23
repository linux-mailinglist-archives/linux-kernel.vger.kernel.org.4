Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D786D6774A2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 05:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjAWEYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 23:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjAWEYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 23:24:34 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC971042A;
        Sun, 22 Jan 2023 20:24:32 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P0cSb26g4z4xMx;
        Mon, 23 Jan 2023 15:24:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674447871;
        bh=aOknd4cwWOhwHjQiaT7hKJQTBwiubFOuFhtOHNTpj0Q=;
        h=Date:From:To:Cc:Subject:From;
        b=tmMbyq8n1AbQ7QE8fUQXUoi9W3gBiaJ5ieN7cl/qrYJVeF0xuRMAPXg917kSHtlX7
         NKtRWdAr1RnR00t8OJBTgNMTMw27C40XiS6NBlwYt/1ZH1wggLF7nq72/+zSOw7ZZe
         rEuO3bMXiGex6yKvVRTc+0S1NRxig3TCAeLRLjqjKkGoVE69DcrsShlU8Yh0LeZt5Y
         lpd8JQnW2CRQUlEY0q6/DjlWTSyaL+PPYBnGlFewOOov2GgoH27JnC6W+OVD7GmqN4
         D9451adpTWB8qGaG1UovT7bxwIIpMoFq9jVyGYTWHrf+ugx62zV6sGBUDVAL9g+xVt
         UFz7TgBgilaSQ==
Date:   Mon, 23 Jan 2023 15:24:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?SsOzIMOB?= =?UTF-8?B?Z2lsYQ==?= Bitsch 
        <jgilab@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the usb tree
Message-ID: <20230123152430.3e51fd25@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.UpDW3=XQBMSRKB1Ycyrvh/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.UpDW3=XQBMSRKB1Ycyrvh/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the usb tree, today's linux-next build (htmldocs) produced
this warning:

include/linux/usb/composite.h:510: warning: Function parameter or member 'b=
cd_webusb_version' not described in 'usb_composite_dev'
include/linux/usb/composite.h:510: warning: Function parameter or member 'b=
_webusb_vendor_code' not described in 'usb_composite_dev'
include/linux/usb/composite.h:510: warning: Function parameter or member 'l=
anding_page' not described in 'usb_composite_dev'
include/linux/usb/composite.h:510: warning: Function parameter or member 'u=
se_webusb' not described in 'usb_composite_dev'

Introduced by commit

  93c473948c58 ("usb: gadget: add WebUSB landing page support")

--=20
Cheers,
Stephen Rothwell

--Sig_/.UpDW3=XQBMSRKB1Ycyrvh/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPOC/4ACgkQAVBC80lX
0GxIvQf/aW/3mbASJmrVlYRE5r5zXWRrC4luuQNg9PQu48QW0o8Ngh4WpzICoX7F
/WD/lBt9GXMX7Zez0bm6Y3HrZY0HKTsAhGWq1vhwld99hko0KuIAeUsyjJ9y4aHS
M+CJF8p4z0hCqml7pXrrd88FOKIiXFLsaSSDCIhzpknRtmAPnz2TEeFQAVxEQlV5
yq/L3xgwtSzQor55Y4Ov4nbF4Z4dSQHq8YIfUUzTCVJs9CdE7YQdG/vau53ebjN3
JSDWtTagIlH0iX/QVZ/INWg+lJNgnhGucfvrs8h6wGuSJGKSzsxBh5MXxVcshF7O
Wop2dVjtQYeU7mcYgs4FEVuELRVzrA==
=TEjE
-----END PGP SIGNATURE-----

--Sig_/.UpDW3=XQBMSRKB1Ycyrvh/--
