Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B580A5F3DA2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiJDIFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiJDIFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:05:16 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DD41A20B;
        Tue,  4 Oct 2022 01:05:14 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MhVcK5ql2z4x1D;
        Tue,  4 Oct 2022 19:05:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1664870710;
        bh=g/MNZsp39+pLKhhen476XgHXqxPTlWguDNLHOKnvddc=;
        h=Date:From:To:Cc:Subject:From;
        b=MmoW6d37BiXX7wLKSp5xsiRjMciBjHCOumahhDsCK0v1gb6M0938v8l5vGbT3aZf8
         Ev7pKf8YUpqMqJHo2qjvw17YciRcjZbNWRKBK5HqjqVb4mnaYlrrsz6Hmi3CZubFuf
         prEQqDFg7+vPe7HxVxB3NyVj7HjhzC8Ul0mVaTLV/c8ifaMbdtQCC3jBjIddgxnGsm
         42dvIFrq3x3w5p0wbwEqSv1Pp9TAoFpKGsl7qyXrcOsj6A/haY06W5R76Y/iKkRKjc
         hxt3SNomlXploVoqQBHleWIlITz+mmNZSchoBucoMNRMwa8ZJ66YR7a5I278SfrQkb
         XmjgM9c30jLwQ==
Date:   Tue, 4 Oct 2022 19:05:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Adam Bratschi-Kaye <ark.email@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Daniel Xu <dxu@dxuuu.xyz>, Finn Behrens <me@kloenk.de>,
        Gary Guo <gary@garyguo.net>, Jonathan Corbet <corbet@lwn.net>,
        Julian Merkle <me@jvmerkle.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Wei Liu <wei.liu@kernel.org>, Wu XiangCheng <bobwxc@email.cn>,
        Yuki Okushi <jtitor@2k36.org>
Subject: linux-next: manual merge of the rust tree with Linus' tree
Message-ID: <20221004190502.4e7d3348@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1NmPO7j4ZNUD+Yp7Ii8vpju";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1NmPO7j4ZNUD+Yp7Ii8vpju
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rust tree got a conflict in:

  Documentation/index.rst

between commit:

  0c7b4366f1ab ("docs: Rewrite the front page")

from the origin tree and commit:

  d07479b211b7 ("docs: add Rust documentation")

from the rust tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/index.rst
index 85eab6e990ab,00722aa20cd7..000000000000
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@@ -12,84 -18,134 +12,85 @@@ documents into a coherent whole.  Pleas
  documentation are welcome; join the linux-doc list at vger.kernel.org if
  you want to help out.
 =20
 -Licensing documentation
 ------------------------
 +Working with the development community
 +--------------------------------------
 =20
 -The following describes the license of the Linux kernel source code
 -(GPLv2), how to properly mark the license of individual files in the sour=
ce
 -tree, as well as links to the full license text.
 -
 -* :ref:`kernel_licensing`
 -
 -User-oriented documentation
 ----------------------------
 -
 -The following manuals are written for *users* of the kernel =E2=80=94 tho=
se who are
 -trying to get it to work optimally on a given system.
 +The essential guides for interacting with the kernel's development
 +community and getting your work upstream.
 =20
  .. toctree::
 -   :maxdepth: 2
 -
 -   admin-guide/index
 -   kbuild/index
 -
 -Firmware-related documentation
 -------------------------------
 -The following holds information on the kernel's expectations regarding the
 -platform firmwares.
 +   :maxdepth: 1
 =20
 -.. toctree::
 -   :maxdepth: 2
 +   process/development-process
 +   process/submitting-patches
 +   Code of conduct <process/code-of-conduct>
 +   maintainer/index
 +   All development-process docs <process/index>
 =20
 -   firmware-guide/index
 -   devicetree/index
 =20
 -Application-developer documentation
 ------------------------------------
 +Internal API manuals
 +--------------------
 =20
 -The user-space API manual gathers together documents describing aspects of
 -the kernel interface as seen by application developers.
 +Manuals for use by developers working to interface with the rest of the
 +kernel.
 =20
  .. toctree::
 -   :maxdepth: 2
 -
 -   userspace-api/index
 +   :maxdepth: 1
 =20
 +   core-api/index
 +   driver-api/index
 +   subsystem-apis
 +   Locking in the kernel <locking/index>
 =20
 -Introduction to kernel development
 -----------------------------------
 +Development tools and processes
 +-------------------------------
 =20
 -These manuals contain overall information about how to develop the kernel.
 -The kernel community is quite large, with thousands of developers
 -contributing over the course of a year.  As with any large community,
 -knowing how things are done will make the process of getting your changes
 -merged much easier.
 +Various other manuals with useful information for all kernel developers.
 =20
  .. toctree::
 -   :maxdepth: 2
 +   :maxdepth: 1
 =20
 -   process/index
 -   dev-tools/index
 +   process/license-rules
     doc-guide/index
 +   dev-tools/index
 +   dev-tools/testing-overview
     kernel-hacking/index
     trace/index
 -   maintainer/index
     fault-injection/index
     livepatch/index
+    rust/index
 =20
 =20
 -Kernel API documentation
 -------------------------
 +User-oriented documentation
 +---------------------------
 =20
 -These books get into the details of how specific kernel subsystems work
 -from the point of view of a kernel developer.  Much of the information he=
re
 -is taken directly from the kernel source, with supplemental material added
 -as needed (or at least as we managed to add it =E2=80=94 probably *not* a=
ll that is
 -needed).
 +The following manuals are written for *users* of the kernel =E2=80=94 tho=
se who are
 +trying to get it to work optimally on a given system and application
 +developers seeking information on the kernel's user-space APIs.
 =20
  .. toctree::
 -   :maxdepth: 2
 +   :maxdepth: 1
 =20
 -   driver-api/index
 -   core-api/index
 -   locking/index
 -   accounting/index
 -   block/index
 -   cdrom/index
 -   cpu-freq/index
 -   fb/index
 -   fpga/index
 -   hid/index
 -   i2c/index
 -   iio/index
 -   isdn/index
 -   infiniband/index
 -   leds/index
 -   netlabel/index
 -   networking/index
 -   pcmcia/index
 -   power/index
 -   target/index
 -   timers/index
 -   spi/index
 -   w1/index
 -   watchdog/index
 -   virt/index
 -   input/index
 -   hwmon/index
 -   gpu/index
 -   security/index
 -   sound/index
 -   crypto/index
 -   filesystems/index
 -   mm/index
 -   bpf/index
 -   usb/index
 -   PCI/index
 -   scsi/index
 -   misc-devices/index
 -   scheduler/index
 -   mhi/index
 -   peci/index
 -
 -Architecture-agnostic documentation
 ------------------------------------
 +   admin-guide/index
 +   The kernel build system <kbuild/index>
 +   admin-guide/reporting-issues.rst
 +   User-space tools <tools/index>
 +   userspace-api/index
 +
 +See also: the `Linux man pages <https://www.kernel.org/doc/man-pages/>`_,
 +which are kept separately from the kernel's own documentation.
 +
 +Firmware-related documentation
 +------------------------------
 +The following holds information on the kernel's expectations regarding the
 +platform firmwares.
 =20
  .. toctree::
 -   :maxdepth: 2
 +   :maxdepth: 1
 +
 +   firmware-guide/index
 +   devicetree/index
 =20
 -   asm-annotations
 =20
  Architecture-specific documentation
  -----------------------------------

--Sig_/1NmPO7j4ZNUD+Yp7Ii8vpju
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM76S4ACgkQAVBC80lX
0Gxf3Qf+Pf1PnHvYy3iP1OlaInlUU2D0kZfFlruv0SZWGTaLJUMQe/NPVQdekTD3
tI+S/gwd9yp4Skii+EwZiPb7woDPdHDkc5hY1JA1PIb8EHqAPvvSM/J00J6xNhka
JKO4IA+32YQeF7Stc3XEwkfXLA8LDpi3w4+Un6Cuq0eNiKeGyxulAHjygMdFyBDO
zpGYwfzRq+nj9q/UtGCYQy12nVja9vDO4LZFIcvgHbCrz61oawXP5p7N/oq6E1tq
Aw3VOcAy1bZXROElg8p0/PTu92oEvZ5xbGjkMdqWVL4qNz0HBtYm8Omh2hPAWtEJ
9vg2YKsfLW8SwL8JW9vmDGtuHkgVzg==
=burp
-----END PGP SIGNATURE-----

--Sig_/1NmPO7j4ZNUD+Yp7Ii8vpju--
