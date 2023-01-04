Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B5465E099
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 00:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjADWz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 17:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjADWzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 17:55:24 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A951DDE9;
        Wed,  4 Jan 2023 14:55:17 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NnQ0q6jLPz4xZ3;
        Thu,  5 Jan 2023 09:55:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1672872913;
        bh=rnuqo9HtbQ52A7TEojKHqGveftd+NFuk6oraCbYg1xA=;
        h=Date:From:To:Cc:Subject:From;
        b=DBQ+GUALz7SXviuOQ2aJFkKGwBvTVQqOQnfaVMdAfiQ7ojhFKMvKGQke5hy70hzo0
         VIab82LMoxxZoF1RHcqDcxDIxkZOQYUl3OHYuhL0I0WJYa9Bj8ZN0f+UYx9JX1Ra4J
         EEJwUghdhmG6EKNY8f09KQbF9UN+YsKQtHkShle3ELorFk2qZoRQc7onC+ysteSu6r
         5UAFdoLV5PQjennqeR+9v3xlx7TuTLXyVQyMf7OeAbCG9N5tM/P1gGC2XRsBSiIels
         0KiJy3BlGFGmZu2TaYhFiOWkzmT0W2cbU9l+qxDhIUfPXNB2hVsf8cC/ENKG22QwS+
         aAQ8nA/waklaA==
Date:   Thu, 5 Jan 2023 09:55:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@lst.de>,
        Daniel Walker <dwalker@fifo99.com>,
        David Miller <davem@davemloft.net>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Felipe Balbi <balbi@kernel.org>, Lee Jones <lee@kernel.org>,
        Ley Foon Tan <lftan@altera.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rich Felker <dalias@libc.org>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     1394 <linux1394-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: old trees removed from linux-next
Message-ID: <20230105095506.69ff567a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Vnoi7NeIrUtXDL8jkbRZhgf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Vnoi7NeIrUtXDL8jkbRZhgf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following trees have been removed form linux-next today as they
have not been updated for more than a year.  If you would like your tree
reinstated, please just let me know.

Each trees is followed by a list of commits in that tree that have not
been merged into Linus Torvald's tree (if any).

Tree			Last commit date
----			----------------
actions			2021-04-01 11:08:21 +0530
amdgpu-fixes		2019-11-06 22:06:23 -0500
cisco			2019-03-17 14:22:26 -0700
folio-iomap		2021-12-21 13:51:08 -0500
gpio-sim		2021-12-05 14:08:22 -0800
i3c-fixes		2021-02-28 16:05:19 -0800
ieee1394		2021-07-05 22:23:15 +0200
init			2020-07-31 08:16:01 +0200
integrity-fixes		2020-05-14 19:55:54 -0400
keystone		2021-08-10 15:52:26 -0700
mfd-fixes		2021-03-23 09:14:12 +0000
nios2			2021-02-19 15:02:09 +0800
pidfd-fixes		2021-04-02 14:11:10 +0200
raspberrypi		2021-12-18 18:53:04 +0100
  b4a213c53eed ("ARM: dts: bcm2711-rpi-400: Fix GPIO expander labels")
sh			2021-10-27 16:56:34 -0400
sparc-next		2020-06-22 09:49:59 -0700
usb-gadget		2021-04-04 14:15:36 -0700
usb-gadget-fixes	2021-04-04 14:15:36 -0700

--=20
Cheers,
Stephen Rothwell

--Sig_/Vnoi7NeIrUtXDL8jkbRZhgf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO2A8oACgkQAVBC80lX
0GxE7gf+IUaDlwqsSVfKAZhV0hLnWHA7DWUfqF2cHde75KUANSsXPa1ujXPGNSYk
jzZ8Uw/jUNlv+jMdevXfO/oyHwu79d4o4Clwn+RPlUHMBuHtXx0KZl/fVaCLD4jP
nCJmCQ+Nu4o28SfTkjhN78zk5trHiFpjAf9tynVbZX3hJKp1gT7Raq6Jw60wwpXv
n7+ye1CaYsA+JVfKP+tG/f8lyORi4ZDfIR2EEk5/gk2Nf1y9WlOQsrdc0ycpzS/i
PcXfRQHEjOSVGJsiiUjoHJIQwyBl8oz5H8m/MEkh5y3p54qN5Wj+ItBxrwbPfbRW
ZAoaqEMTDD1bznYR+Vy3iYiMUcCXGA==
=8ahK
-----END PGP SIGNATURE-----

--Sig_/Vnoi7NeIrUtXDL8jkbRZhgf--
