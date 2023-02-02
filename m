Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7B66872D9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 02:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjBBBMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 20:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBBBMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 20:12:34 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6853976B;
        Wed,  1 Feb 2023 17:12:32 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P6gkL6FZgz4xwq;
        Thu,  2 Feb 2023 12:12:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675300347;
        bh=f4jtAoycbEKkLXFV8AanQm+p36DtWGJ2pozvxXintoU=;
        h=Date:From:To:Cc:Subject:From;
        b=JvlCoOqwMVzrq747hLsulTzN87FaW3R4vFAX1yjVzTDbZsKhrtBaIwimu8VWPmprG
         HkfS4tEeW4NARhryC7b29vA89pNgtlksDwVSm8/6000t87QRSYVlIBP+Xe/UgJU2a4
         g/jkQ+6pSHS1nrEIFRocrNFlNrnGdNAVpQDyCE8yyRsdq92qx+Ua43JW6BceWo9qUY
         dr/7Vrr3sJKdCI89TxCvQmg94fRgw0mziNJW1Dws6p920cd2sFORXzrD18n+7vN8Qj
         TTC7nxqIviw+6rx+KmzjSzZahi0C5/XIQPGdwdHiaVJHOQMGG4JGEBulwfghWXyd+b
         sjHYWnWYbHv7w==
Date:   Thu, 2 Feb 2023 12:12:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Sudeep Holla <sudeep.holla@arm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the driver-core tree
Message-ID: <20230202121224.54425afd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ha7iRubpBYB_kTG.RTCHW2i";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ha7iRubpBYB_kTG.RTCHW2i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the scmi tree as different commits
(but the same patches):

  ecaef469920f ("cacheinfo: Initialize variables in fetch_cache_info()")
  d931b83e62b1 ("cacheinfo: Make default acpi_get_cache_info() return an er=
ror")
  921e672dee91 ("cacheinfo: Remove unused check in init_cache_level()")

They are commits

  7646b6682b41 ("cacheinfo: Initialize variables in fetch_cache_info()")
  2ebcd557e000 ("cacheinfo: Make default acpi_get_cache_info() return an er=
ror")
  b73679f891d8 ("cacheinfo: Remove unused check in init_cache_level()")

in the scmi tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/ha7iRubpBYB_kTG.RTCHW2i
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPbDfgACgkQAVBC80lX
0GyGKAf+MIIlNrLrcNpRoturf52xA6n7PWIKnvQKCIQHoQXMgRR5PUoim2J7k7tn
esqOL0vGVIaoYvkWXDAiL+P81wETWTaLkJpP48OVnwJ/Q6fldhTD8MGuppKtCGmX
TvscLJad9/PlBX4XSSiJ+dltCvOkAZmTx8PJL0WOo/BQYHNH2BAdWwBDFbp3jc1s
n7Keo85kmgjfuwS39A2zpa1490B9fgGD5U7gxwb2Z5gSckLOkRCFQ6y+2qHnxiY1
hRvDBT9Sursm3lcQE8YSQvqYiMHFIY0AF42OACKZR+2vhyzENcxIWxVB9SqpisVx
ELSCyJQTEzvtf5j6AWO6nJGtjt/4jQ==
=gHQb
-----END PGP SIGNATURE-----

--Sig_/ha7iRubpBYB_kTG.RTCHW2i--
