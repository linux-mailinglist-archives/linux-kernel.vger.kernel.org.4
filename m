Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD44E6DCE1C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 01:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjDJXa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 19:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjDJXau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 19:30:50 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE3E26BB;
        Mon, 10 Apr 2023 16:30:44 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PwQFV2GPbz4xGK;
        Tue, 11 Apr 2023 09:30:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1681169438;
        bh=eQ323mptkFKVmTqHoJ4N9twQjxrIVz7CEBRJFQnHJQY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ew0fo6VRWyKYAefRtXRU9R/72EXNo1WwR8QX1mRgOyUWf9YxQG8QJvxTEdyg3COif
         1el9qdXr42Fjy5CH3alGR/Oi2fQZTFhhdleymPo4qNPMMs821rwpKrPbBrKNv5mzwt
         gRDMNGvgBpMPPmXhAJ11Vt7SJDdfl9RCK0la8B/YxXlvKsocokBbx9LNnY7QsW1183
         2Lw/Mc0skO/SctMRV0kURphagCLNZXKBqryCd/+Ta0Qjhpvfqbw5c7ITxvaiTwJ6i6
         1lEBY/2EMrqCkxQlM5sx8HuBmvlVDUY4dvm1GDqR8EKfUXOqWauu5Z7zQkRau2Jxvd
         Hm8LSBi4c6vxQ==
Date:   Tue, 11 Apr 2023 09:24:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mediatek tree
Message-ID: <20230411092412.5a9e20e5@canb.auug.org.au>
In-Reply-To: <20230403175220.5b946b60@canb.auug.org.au>
References: <20230403175220.5b946b60@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ys2kOWQkUtiSP_m96f97eCM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ys2kOWQkUtiSP_m96f97eCM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 3 Apr 2023 17:52:20 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> After merging the mediatek tree, today's linux-next build (arm64
> defconfig) failed like this:
>=20
> Error: arch/arm64/boot/dts/mediatek/mt6795.dtsi:647.21-22 syntax error
> FATAL ERROR: Unable to parse input tree
>=20
> Maybe caused by commit
>=20
>   a7c7f1fe2fde ("arm64: dts: mediatek: mt6795: Add MMSYS node for multime=
dia clocks")
>=20
> but I don't know how.
>=20
> I have reverted that commit (and the following 2) for today.

Ping?

--=20
Cheers,
Stephen Rothwell

--Sig_/Ys2kOWQkUtiSP_m96f97eCM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQ0mpwACgkQAVBC80lX
0GyZtAf/RNDD4gSTNwW778o05h6XJn7z8xHdHW1LB9H1kemjMBCsM8N0BhYr9B5K
Yvwg6pnLmOuvLPQsXWXh7p7C2lwIt9SUnsY9Go+wv5aWoU4y3hf+5BKtPxQCV1od
UntAzzTpAieoKUf+vzr1R3QF14fdgPDrwXMKCveKzaX4nSAM1MPcvodp0UjoK5RG
/2V2ckT6BooFvj6XlV8XhTEil/c8kScPCv5wyaIykbYrLdl+Sb0wK6hAGyPeiFj8
YpUR06u0pnihY5GCHPDgg45yZbT9N0QE40XE7VMLbKuzZ0vtmiMkUPpxZSAPTxaW
aFuyEMcv6PPtYTIxrCOz6x4u3VAqdQ==
=UHQ8
-----END PGP SIGNATURE-----

--Sig_/Ys2kOWQkUtiSP_m96f97eCM--
