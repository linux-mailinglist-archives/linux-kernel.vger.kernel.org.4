Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4965BC173
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 04:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiISCkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 22:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiISCkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 22:40:41 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0211813F9F;
        Sun, 18 Sep 2022 19:40:39 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MW86s0jknz4xGd;
        Mon, 19 Sep 2022 12:40:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663555237;
        bh=oqM1Iop0qBiZRTpt1ctCYhp660GpfeXccHUIESChuoE=;
        h=Date:From:To:Cc:Subject:From;
        b=FQ3/bH7CwxN3PLA3MXf/4MLsB36uLCjqTVLd0scjzYfSGG/ANIhj/gsk3mqqBwRNK
         LKmyWwvm6Z//c0ozoBK4MEArlkfkFgHZKpfzE92qDh+3HHwTmcNO3sZu14SfADbDlk
         joKGcQhYzgYaE7nenBrv6XF8AzN7EY7Iwp1NS0Qyg6GVMErb/F0cXMJF7RW4D0mjD5
         EddsZOlZKtaWCuC2IYsKDqQYETQGNF78kGr37A0gYYy5jQ/pToXssUgQjUa43ApKeM
         6G+vDpgcgEDJnWtOxdK2kEqx0zENSND5nFsYQNIqt/oEnKemalW5ygrvWLLZ5YqrDk
         gfw1bK8eTtKFg==
Date:   Mon, 19 Sep 2022 12:40:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the libata tree
Message-ID: <20220919124034.58670a27@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ovRtO6db6pokbcv97..JAN8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ovRtO6db6pokbcv97..JAN8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the libata tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

drivers/ata/ahci_st.c: In function 'st_ahci_probe':
drivers/ata/ahci_st.c:147:24: warning: unused variable 'dev' [-Wunused-vari=
able]
  147 |         struct device *dev =3D &pdev->dev;
      |                        ^~~

Introduced by commit

  3f74cd046fbe ("ata: libahci_platform: Parse ports-implemented property in=
 resources getter")

--=20
Cheers,
Stephen Rothwell

--Sig_/ovRtO6db6pokbcv97..JAN8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMn1qIACgkQAVBC80lX
0Gxeugf+Mx2Ru8slkdT+s2hOUcKeCHXOGYfpnkVv18IT7fAxOnlWLE8HLRHGzaHf
9xvXEQqHkO27WedYGVvv/CN2YUNqKwl/C1KMQkD5HmTqFJm9oH070d4fTJxTlJhD
bvjYXETN7oDJGlbvijkt0JCc8sHy4r9AuyGRmSaemae6WxxvFkqvq/UJSgLd9t2o
xpb3V8vOy2azTGdOVoFML5P1uPXmt/wsnyZ/8rl2jwTFliXyEVNc3yLNg9d+JUO9
D5z6S2mPHeCr1BnurWzpthDEBT6nhkTSkPRwC+0fzQFUDA8c4snGjcT2r0Umzj8b
/7hWvhDqJlQkhqbXhU8TZxWxlwsLeQ==
=mIR1
-----END PGP SIGNATURE-----

--Sig_/ovRtO6db6pokbcv97..JAN8--
