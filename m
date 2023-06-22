Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D12739414
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 02:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjFVAsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 20:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjFVAsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 20:48:15 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B591713;
        Wed, 21 Jun 2023 17:48:13 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QmhYl09ndz4wjF;
        Thu, 22 Jun 2023 10:48:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687394891;
        bh=/A+a6b6wStZD7DVXioWHEOlHI+OVMhNuuqsmWOvTMkU=;
        h=Date:From:To:Cc:Subject:From;
        b=nJj2qsaIWFocn/2ylDPR6pYaDWaMyM2rp924XQlg5xkXYbtQKWODkHhSa85EuvrUL
         jc+7TuDJdCvl5Zo8aPoN/md2lV7s6i+6IrjJ8I0Z5c03NLPgJXhBkvCI/QJJBVVheM
         GmsWHQWip0v9aGXWorDU6olgHZcFbPT6UI6L7RFxww5r5hZOeI4VY2jptmSRkhxlhs
         uTEuynUO3vSrvpDJFB+AGtvazbbJutC2HKLso6kRnv1vCfVKPjokAJNaWC8OPqNUhz
         4qQ1cC27V3I0l6TBandxFdJBEqTmEpmomlZNb/djprRxO7MZk0p7b2rYW6CMhDOh7q
         iaL56Hqj5ILIQ==
Date:   Thu, 22 Jun 2023 10:48:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the arm-soc tree
Message-ID: <20230622104810.30055fb1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/W7HhDb3.GYqYJDa/LPzIQi=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/W7HhDb3.GYqYJDa/LPzIQi=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the arm-soc tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

arch/arm/boot/dts/marvell/armada-390-db.dts:84.10-106.4: Warning (spi_bus_r=
eg): /soc/spi@10680/flash@1: SPI bus unit address format error, expected "0"

I am not sure why this has only shown up now.

--=20
Cheers,
Stephen Rothwell

--Sig_/W7HhDb3.GYqYJDa/LPzIQi=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSTmkoACgkQAVBC80lX
0GzfzQgAoGzIEoGYv3ciWAnqWhNQlwPfzPJxGZbKtlty6aJ0D7W39OsOuBdmVqzY
H/AX6/oINOBRvR9ZIQEgtAz3bciM8gyOoe4Es/7VyDSfTLTwiiPNp85rpSf8XFPv
aOLIVHYZeafPT80B9qhk52QTWr3ZDt7CuIsu1ONIwg8mH7qAvs4wWUhYtITFYYIt
MXf9EwoKLYJxk1pB6L3y1kZdWpUqawge8JB6SnSuFceuw6wvAtPiOXDH3gAYIxoW
PzKgbdLw6/rkFPVtG5zvDvTCqKJDUKXKR8YjiRczOcDV66JLvF/uY+FyScvwO06G
LEEGBGL9WjW79BkbXRF6vdY9F5bcLw==
=8ik5
-----END PGP SIGNATURE-----

--Sig_/W7HhDb3.GYqYJDa/LPzIQi=--
