Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCE96C3FC5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 02:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjCVBcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 21:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjCVBck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 21:32:40 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26A8521CC;
        Tue, 21 Mar 2023 18:32:38 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ph9vP0SM7z4xDr;
        Wed, 22 Mar 2023 12:32:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679448753;
        bh=aGmO+iqpMn0q7o7y7Q/QL/CoTVrG7PPE332S0Ned9a0=;
        h=Date:From:To:Cc:Subject:From;
        b=IbQM4qu0Y9YpU86KF+1BR0UcTLGyFaxhSM5r7u7wCn8j43GTwi3gYSMS9YYkIM0wr
         9ynxkE0TDHAosR61YL33V7LkQ5AL/sA6aplQBKipjh6QYOII2n+i/ICDDkrYwLJrKN
         UqMXg3/lu1zVP8oGD7x/OGzGPV0WDvKA3SqDWO62dEd3NGP39wunPYfCucUHlNE47C
         BJzBsaBoxOiksywK93eq9seBoOhjMdXGMkQBnxE4tlalRPgLzPnXHGb6u5DVgWubjF
         zBCmOa817HYKuA9sehXvz3P5YQJ/C9xMOSLpcpemh94GNuunfGtBHyropZOwluAD2+
         efgl/VG7Hmqbg==
Date:   Wed, 22 Mar 2023 12:32:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the vhost tree
Message-ID: <20230322123231.2c5cbce5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/B2rhPh0=yG=8e.hhuhC4vAj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/B2rhPh0=yG=8e.hhuhC4vAj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vhost tree, today's linux-next build (htmldocs)
produced this warning:

drivers/virtio/virtio_ring.c:2346: warning: Excess function parameter 'vq' =
description in 'virtqueue_dma_dev'

Introduced by commit

  9225f75b9b80 ("virtio_ring: introduce virtqueue_dma_dev()")

--=20
Cheers,
Stephen Rothwell

--Sig_/B2rhPh0=yG=8e.hhuhC4vAj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQaWrAACgkQAVBC80lX
0Gyi1wgAl7WP8L/jzk6Jc5141okcxC5+viAmwNW0slWObW2NtltugHFS4EZR+SVO
zJXi0pEKUV/bEHbdfJCLuYWqGzeKOX8k8bfS+MHvcFPYuXNu5dLZa4U3SaRb4U4X
j+J9oLs9ZjP3y6Sy+QLk7WU7hCMxXc6LkFMv+V/Y3Brgdq6KaS1nyqaQ7nSDdXrv
cvjVTtaH9iXW+UVt2RT5PO7xhkTBoq4RMGUSm+xX7E1YurjYMD2xrgqq+jV2i51C
UjsJzkNiafXSt9L7r2zLpwshu9IiOnbXmuFYadFgsukfJSVlw2+Qyx8b4a7jBDnn
G9rCgomy7CQpJJC21pNFpQdx764oyQ==
=A8t/
-----END PGP SIGNATURE-----

--Sig_/B2rhPh0=yG=8e.hhuhC4vAj--
