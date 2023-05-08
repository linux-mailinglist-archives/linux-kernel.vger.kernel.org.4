Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0866F9D5B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 03:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjEHBUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 21:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjEHBT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 21:19:59 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CD311DAC;
        Sun,  7 May 2023 18:19:56 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QF3P66MQtz4x2c;
        Mon,  8 May 2023 11:19:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1683508795;
        bh=zaoLH4Poy4dcg0xu3pSMp9YUJqfeCzmaxPNonsmqKsw=;
        h=Date:From:To:Cc:Subject:From;
        b=SErbc2YnnyPBLrag8/AUkKfNxWnQfrO9dJwA60lOzhKGT4lBYmWbIqK8SPHAaO9i9
         3xys2ovuLYGZJiRP/qo4n2Xu2lSEmhc7e9zqMtMb71dlPkXAkHXtEbxa+olSrxvjb0
         bagiTUCYspVq2JgBqx0T+0TG0ZKaNoZrKh95uwk/6cQchAXQog1NSp2J4YeWDQUm8J
         E4LNfyhi+c8ixu3+3YxeOvqRYQpCbCYlnDLbp92UhWc749PKS6cKCENrDQysWUto+h
         mG70xjGDCYGmUCymhmheWuAC5AIBnH82EuaXdixQEpTB2gQrohQA93UYiGGza/UtWW
         zqlscfxPUDZ+g==
Date:   Mon, 8 May 2023 11:19:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nhat Pham <nphamcs@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the mm tree
Message-ID: <20230508111953.40f1e57f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Tc4c_Xnd3ifXhxkjKVK/jt9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Tc4c_Xnd3ifXhxkjKVK/jt9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (powerpc
ppc64_defconfig) produced this warning:

<stdin>:1567:2: warning: #warning syscall cachestat not implemented [-Wcpp]

Introduced by commit

  c36ee88cc47d ("cachestat: implement cachestat syscall")

--=20
Cheers,
Stephen Rothwell

--Sig_/Tc4c_Xnd3ifXhxkjKVK/jt9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRYTjoACgkQAVBC80lX
0Gxu2wgApD6MS/JSydNLi1dpXl3t9kwI7vVLXVDU983Ktd1EOH6TA0o0mMBIgpFD
TCyj/r0wIvpbdfD6Ab/7HXpy+TqV51l0yhgl7sCjm7hYKuGmzjJ1CCETBIa9665f
xZPiEEvhdzE7388jNWcCr0X0eNeS3XXHsw4n7OxXNe+NsUPJdZ4bnst7gmNbcPYM
vgVg1S9yYa+tiLAFaDXzboOczVeTg5L8N1xNs+P3t1kSNIej5Pn8T7tcl6LmUEOO
zthdJDRl9FPkl8ymyqS+eiI0My9a5d4l/GbpNNkjGZWxmviqaLc0ik/3JLNLzXR6
vztWLDIDOzRn7TZzpDqn20vEIsEEeQ==
=99PI
-----END PGP SIGNATURE-----

--Sig_/Tc4c_Xnd3ifXhxkjKVK/jt9--
