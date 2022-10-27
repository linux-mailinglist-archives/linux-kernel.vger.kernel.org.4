Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BDD6105EA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 00:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbiJ0WtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 18:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbiJ0Ws7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 18:48:59 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF84B44AB;
        Thu, 27 Oct 2022 15:48:55 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mz17P2d9kz4wgr;
        Fri, 28 Oct 2022 09:48:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666910930;
        bh=8I9suYjvm0/gjSj88Itrh+YEVeaA3Y6GK6uQANsUn/k=;
        h=Date:From:To:Cc:Subject:From;
        b=HDhZWID6MVqEPB9hI6AYtYDgqesPnUo3K5WbNxoEQ3wbcQJcWKXv8BEn1qbQpJAlz
         Vc5vkn5gj6TiMBzfsZNnk4VOOE/jUuAPxthaNNUmxRkNzOKKoxmjsX6/VXH+yuqjy3
         4rtTWoN2FJl3WMJ+nNdJU4UV6vKMYrGpR3RqbdjZdKVNwseWJhhS2rVL4kVmkx+a1h
         DFAlSianui0tWqpF9zIpJ1IiB6704ESgRi5rl+bVsbvjtE7RqQn+d00rZvL2B0+OJi
         AeGXoGAjAaIxBIU/3dLZZs9tA0eht6q4vSWMnDs7RPnHbseqZ4YzJR750+hK/RCjtM
         ZeEOaiEFNdYFg==
Date:   Fri, 28 Oct 2022 07:53:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>,
        Christian Brauner <christian@brauner.io>,
        Seth Forshee <sforshee@kernel.org>
Cc:     "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the btrfs tree with the vfs-idmapping
 tree
Message-ID: <20221028075314.0ad17cff@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HwFYBDVuTVI__YhC7Z1nrNB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HwFYBDVuTVI__YhC7Z1nrNB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the btrfs tree got a conflict in:

  fs/btrfs/ctree.h

between commit:

  138060ba92b3 ("fs: pass dentry to set acl method")

from the vfs-idmapping tree and commit:

  6ef78f46e652 ("btrfs: move acl prototypes into acl.h")

from the btrfs tree.

I fixed it up (I used the latter version of this file and applied the
following merge fix patch) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 28 Oct 2022 09:44:23 +1100
Subject: [PATCH] btrfs: for up for "fs: pass dentry to set acl method"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/btrfs/acl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/acl.h b/fs/btrfs/acl.h
index 45197b4f73bf..39bd36e6eeb7 100644
--- a/fs/btrfs/acl.h
+++ b/fs/btrfs/acl.h
@@ -6,7 +6,7 @@
 #ifdef CONFIG_BTRFS_FS_POSIX_ACL
=20
 struct posix_acl *btrfs_get_acl(struct inode *inode, int type, bool rcu);
-int btrfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+int btrfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		  struct posix_acl *acl, int type);
 int __btrfs_set_acl(struct btrfs_trans_handle *trans, struct inode *inode,
 		    struct posix_acl *acl, int type);
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/HwFYBDVuTVI__YhC7Z1nrNB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNa77oACgkQAVBC80lX
0GxykAf/bTlKdeso+oxlBDiS3hBR7VaXUpYaW4tzan10lqsw/eMzyipmlp64/jg4
wxNsBm0ef6HvFkdIqDTDKmvSnYRCgSYoK5t5NMitoG6VfCljkqzBCqswQT2nUQ7v
OVqy8/ylLqWWJdZMQaPc6+U/YFyJEMnuf4YQSGsuFLTVigMXPcP/XlUumY9yg+56
7PNjwM83vf5zCpAjfbuUMkArSacBm/93kIpaKhoAG2Ph05mYoLVoPYWfMUgaCfjH
06zlRJyqUQeQL4KxQz4fqkHBSAkyUUDGx8LqiqEaXc87EsMomvkfOjC35B4lM6bp
Wx2B2whAODkcRTt+bXYm8+yY9c4n7A==
=Ciwy
-----END PGP SIGNATURE-----

--Sig_/HwFYBDVuTVI__YhC7Z1nrNB--
