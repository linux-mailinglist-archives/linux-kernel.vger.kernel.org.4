Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261016D581C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 07:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbjDDFnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 01:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjDDFm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 01:42:58 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC215B6;
        Mon,  3 Apr 2023 22:42:57 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PrGrH6njZz4x91;
        Tue,  4 Apr 2023 15:42:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680586976;
        bh=mMvQ96dSAogDYJvyAYX8TyYV4C1KYIk2VCoNZGW3UDY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AMsJNLazpIAYFVP/2i0b+gdGJR1aflCLdHKeAZh/I1jJBTyH3RSNLeXi/2YHudrCx
         jmspQylp+HFY6EUBtPNh3xZxc02UVDE2Chz/evCslmZ4+eBsUKmI5Pq8OVm+ejcA0/
         9d7ocQ01FVuEHdFFJSd4R/HcLEL1Xn/wbww9itVvHXQuHwVsah4/fzflpD6LPZ00gG
         3E84AYALXkSumaqSNvP9mrz2lVEi1R8VYKyC0vjCSA1AIpUpVvCXnS+1BPxiZpxvMw
         9djDtjz2rHLqU0cdsou8UCvfZZ7tWKq/bJfz4MI9ze9hbCpQHfwn5Xc3S6SUNkXqBE
         D33M/i46xuhvQ==
Date:   Tue, 4 Apr 2023 15:42:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the hid tree
Message-ID: <20230404154254.6c3be26b@canb.auug.org.au>
In-Reply-To: <20230404154005.449800c3@canb.auug.org.au>
References: <20230404154005.449800c3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iNJF7NrM=5uhGk5F/bYV4=D";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iNJF7NrM=5uhGk5F/bYV4=D
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 4 Apr 2023 15:40:05 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> After merging the hid tree, today's linux-next build (htmldocs) produced
> this warning:
>=20
> drivers/usb/core/message.c:1939: warning: Function parameter or member 'i=
face' not described in 'usb_set_wireless_status'
> drivers/usb/core/message.c:1939: warning: Excess function parameter 'dev'=
 description in 'usb_set_wireless_status'
>=20
> Introduced by commit
>=20
>   0a4db185f078 ("USB: core: Add API to change the wireless_status")

Also this:

include/linux/usb.h:270: warning: Function parameter or member 'wireless_st=
atus_work' not described in 'usb_interface'

--=20
Cheers,
Stephen Rothwell

--Sig_/iNJF7NrM=5uhGk5F/bYV4=D
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQruN8ACgkQAVBC80lX
0Gyb9QgAkZ8VaaAgLIXsFeW72YWHS9VUaX8Oy0O70SLhe6OqyOtT1ycL37jtunLE
vOgOXOHSuAXEcSHVAgs73aLPTwlJsSYoH6yHfuBxwVhGt1Y0WKKVL2M8uObgCDtx
h+Iwu1PF8DIzDzBMkfK7UZlRUSPtUWG054pAzkhXZKWS/Wjqyqc5CErPk/iAdspR
jQ1OUjFJjXAteZTqB1XGuvfGKXNiolmWlX3ttFZ0h8RtM8hl5uHVpFDRIqT6cti/
leWbTpRhKqF3ILK4tEoCKt4V5KVp1yxUHmqKSsA7jbtwFG1SkjbSvnHfX96OEpqJ
P0J6i5dV95P0mtGXMf9YgDjVYqOO8g==
=qa6j
-----END PGP SIGNATURE-----

--Sig_/iNJF7NrM=5uhGk5F/bYV4=D--
