Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CB8728B28
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 00:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjFHWfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 18:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjFHWfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 18:35:04 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF005210E;
        Thu,  8 Jun 2023 15:35:03 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QcfD640Xlz4x3y;
        Fri,  9 Jun 2023 08:35:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686263702;
        bh=hW2Wj12x0/5Oy5lCwtoaU+wOXV8HzlR6fMY652h8rP0=;
        h=Date:From:To:Cc:Subject:From;
        b=lYLa6HiKHSjpcc/+22FDJ4XedQlTkYcIi6NYakN/OnCdp46Fd+ClHU/T48Aqx0s2f
         JWKD3i6tGI/TY8muGj4wvTPF7n8ATF22zQMNG414IzNZza/xFIbZFJrp43p+0FiIpN
         zHBx2K9TY9ryDwOwUECjcTf5wsP7aTgClmxkkhfDvXYQEhNFGXWnZa7EhtqcoA12Gt
         S8xHsFKjgwkx275zGSrMc7Ae1XWTrh24yNy3H8RaToEY395Y75zpaQ5f83AME7okMW
         j5d+ZZdr9snF/lioLuV1blnqbpIOcNXANGbJ9XRdXjCjb8XGhwQDOAfd/ApJye5Mdr
         QaJ+aMNoBoYmg==
Date:   Fri, 9 Jun 2023 08:35:01 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Eugenio =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the vhost tree
Message-ID: <20230609083501.12f98e15@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.P9ctSIoFLUXGjxxC/PyL2H";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.P9ctSIoFLUXGjxxC/PyL2H
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  45eaa1bb9e21 ("vdpa_sim: offer VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/.P9ctSIoFLUXGjxxC/PyL2H
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSCV5UACgkQAVBC80lX
0GylnQf/QiPA0MgMZTc670JnSkZKKSlNesp1iBPP45pJh4CnoUom8yri1+rBLFlR
CVtNN5zPxGA8qFWtAQpEOkzVqozRQBZuJabOJL0ukssveu5ahQ/3jYfnl1JufS6H
G3iqLsSYFpKa5F/JQs8nVftaf9FeV+vCTQK9plwWpIN3a2cXIYk2jcFaPVeglzt6
crehD2K8p6isF4aZjdkzuSCOAEJBVg+HX4yobXqPtCmWQAdFwRvB6QFdHfPLtKf5
RV7/mRdk1WEeETnMYnMhQyopbO0y9ItAzlwWm4JEIWAnRpZTd45T5aT1GAYHxzje
CrhX8FLUK1D3/32YVoYkr3DopD1AhA==
=SRi5
-----END PGP SIGNATURE-----

--Sig_/.P9ctSIoFLUXGjxxC/PyL2H--
