Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E527322CF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239676AbjFOWcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239126AbjFOWck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:32:40 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A719C26AA;
        Thu, 15 Jun 2023 15:32:39 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qhxr61kfBz4wgH;
        Fri, 16 Jun 2023 08:32:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686868358;
        bh=PyGdkQQgOyuur05vxE/y15aWSMSbUioQwfHotMchTm0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CYWFw+w8kq8bafP5A/KXbG6yYur1gNNvurG2o1gepVzVe0kZgnRruvgwQNQyDQby7
         ZFPC4X6nHNN1N9klfT4TlKDksfD8dkkdtfJjfKN/KytCQIHgWngXRohYg+fPyPLr7C
         i3OsWMbVja97AUsJbVFyaPaH8JHsi1ggGzo+KD4i8iWjy7ueIEX62V/YNfzkZBomT3
         g7Q5h+Oq5+xcnMFSx638imay0W5R2MhbjPMuok5SuGcBPJ1S4YgFM1Q15QlzX8vFm+
         idPcL0T7QOzah1ECbv55h7xzsSxVp7VSIJJhS1cjlFwvQLPHs5yA35jMM5FyhuZTL+
         E65KyL7+Z9+AA==
Date:   Fri, 16 Jun 2023 08:32:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bluetooth tree
Message-ID: <20230616083237.421dff9d@canb.auug.org.au>
In-Reply-To: <20230613130258.73be7f1b@canb.auug.org.au>
References: <20230613130258.73be7f1b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nDN/whgu0AeyjQxDgfTG9sb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nDN/whgu0AeyjQxDgfTG9sb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 13 Jun 2023 13:02:58 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
 After merging the bluetooth tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
>=20
> ERROR: modpost: "pidfd_prepare" [net/bluetooth/bluetooth.ko] undefined!
>=20
> Caused by commit
>=20
>   817efd3cad74 ("Bluetooth: hci_sock: Forward credentials to monitor")
>=20
> I have reverted that commit for today.

I am still reverting that commit.

--=20
Cheers,
Stephen Rothwell

--Sig_/nDN/whgu0AeyjQxDgfTG9sb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSLkYUACgkQAVBC80lX
0Gxn3Af9HPtt3ser5f06P84uXkApAwAgQuqMeeFM/yJRa+stausCNZ60mqp654cB
EjVfsUIzw3yetGNY13R4R9NbU52qCp6tbp/iNGMioBG4veeIAdXMYvsqjoOdM2uD
QiELvmC+CaVPFz6GjQ9Xjkt4llvzMe+xtzAP4mqEzSdJ/gdXg6UsKY/0jorINOJf
7ktbvsN2gmyEth+g0hBb22hFPcHF27qV+VOAIcn0dD7jTLd2metnEGj8C3ZgoRci
eI24zU2aXtQb6neiVl3ODhkjnnrnvjj+IxrDR+a7bsd0XgkGFj/YUa9+kCCJCX7J
MYml3G72pgZSShbzkPf1e66+wyr4QQ==
=MpNV
-----END PGP SIGNATURE-----

--Sig_/nDN/whgu0AeyjQxDgfTG9sb--
