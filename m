Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA356DD17A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 07:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjDKFUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 01:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjDKFT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:19:58 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD0DE7C;
        Mon, 10 Apr 2023 22:19:57 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PwZ0W5fkwz4x1f;
        Tue, 11 Apr 2023 15:19:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1681190395;
        bh=eNF8KHa+IYB0+oxeJ8kq3ER55cfynXxeSbdsH/LH3VQ=;
        h=Date:From:To:Cc:Subject:From;
        b=VNBBx+MOMnEw2dUk+21WcFZDoKDlGR+ic9bqSfPW1OZI2si1WROE0kbByI7KWa/lr
         cgDZjAbQ++OYxZrT+RTnz61lJ049N4MIbNWrvV8cuZwjkWXAls9AjQtSOJR3LejCKq
         m92ncToaTIZNmR7iH21zo0ns10SqX5jftEkt4bm2aYY5acESDj1ajSDi5obbDhrQga
         YuA4IbLxGcsuJqLuTOvOpzl7Ne9dYrSCX6UC6WleDbxiVTpxCkv5MTKn1pys1PEnMf
         Ot9ZrBfuQLR46/10zpZklk/1vhHj5K2KPtjh8ZMYSprbZN/HA02j3lrrdmbTNZyicM
         7hqgIvbhSKpjQ==
Date:   Tue, 11 Apr 2023 15:19:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the vhost tree
Message-ID: <20230411151953.182c6a92@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mLRRBjyF9muSVhiS9AmwSrO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mLRRBjyF9muSVhiS9AmwSrO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the jc_docs tree as a different commit
(but the same patch):

  3a9421482150 ("dma-api-howto: typo fix")

This is commit

  2ca956cf8834 ("dma-api-howto: typo fix")

in the jc_docs tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/mLRRBjyF9muSVhiS9AmwSrO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQ07fkACgkQAVBC80lX
0GztZwgApRkx4coiujkj4ksw9PtDG5onTwPUn8mPsf6ZxA3kfj/E/FyUyMEJk/6Y
8o0PkdmXuUqs0oV09UXt8tp5KaAZAmxjCtbYF1LX2ngxif8GxRRzGS1mT1EW/9/x
99Z6AL7//Y8grNbR5Voa7u48NMTGoxRebfNODGqSUK6D5VoKigmw8Nxl2bmLIfbQ
cvgKnUYCor/sq25JLO/M+CPIHJDy3Vf5ZWIc6qF9CEKXCkzgZZ7A+FQO0IJhOTaw
l4aoiWO63Mr1kMDeD04yQv/Uw1uJJCmHajTuIHBKTd6fW/dFdY4CTSJ0YCqlwaRI
re1lBzfI/4ASeqLWIcQp6+0MdOufTg==
=DqTc
-----END PGP SIGNATURE-----

--Sig_/mLRRBjyF9muSVhiS9AmwSrO--
