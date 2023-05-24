Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D6670FB30
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 18:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237873AbjEXQBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 12:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237811AbjEXQAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 12:00:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B4B1708
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 09:00:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F712617B0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:59:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C36C433D2;
        Wed, 24 May 2023 15:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684943974;
        bh=5372x0NwtP9OuIkf3bXPiuvz3HjwcgvBpj2LWuqXpl8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NImesrJ+ptmRyEad7hwasI002O4sWYW+CbD1X9oK5s7FyN8O3MOIQrJ7I+9kHtfnj
         jAVdE0C3chkYsPmnll030YFAn+P6q/8tyTlBuMvFLhTT1I/l47MxPq4ZCeI1kcLJ8z
         Icl+LQTkpvXylwgIK82PYpyKo/WehzjcyTL62wmJcLvQQqv7xBz1rjdKvsCJ0gJiMp
         Lu8SdOtM+8ZjIPK9mavF1ywA5bJ7lwTvMAfJcf3s52kX+Gsc/pKTiAVWaD3E3i+njL
         lvgxFqQQ4ooSJGktcKuv6nMPn5/xnB/FfdY2SAbHvla4oK1Yq4bWXh/KDWBFMhNHvh
         cdAjToE+LRcCA==
Date:   Wed, 24 May 2023 16:59:28 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Anup Patel <anup@brainfault.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Song Shuai <suagrfillet@gmail.com>, robh@kernel.org,
        Andrew Jones <ajones@ventanamicro.com>, palmer@rivosinc.com,
        jeeheng.sia@starfivetech.com, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sunil V L <sunilvl@ventanamicro.com>
Subject: Re: Bug report: kernel paniced when system hibernates
Message-ID: <20230524-rocker-uphill-0cfdab27a3f4@spud>
References: <CAAYs2=gQvkhTeioMmqRDVGjdtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com>
 <CAHVXubgse4Lw7ucg52FkQW4c=QrNo56BXsRZ_nkCHAAPxUXUig@mail.gmail.com>
 <CAHVXubj92O_dwGShOJgrYezqk2pA2NtFyhNFbAPyhn7=PztK6Q@mail.gmail.com>
 <20230517-preacher-primer-f41020b3376a@wendy>
 <CAHVXubhMLgb54_7zV2yFuGPoMKCkUXwozHbDvghc7kQqNLK-JA@mail.gmail.com>
 <CAAhSdy3tKAk1xjinwnSWan0ivdDapcLvSb+hGNynPFZMUsoB9A@mail.gmail.com>
 <fe8d716c-fb4f-1f3f-6c69-de1d8b9fb6af@ghiti.fr>
 <CAK9=C2X1BjZCHfYM33pZQtavu7yRqxwsypWL5OWj79bJrnDMQg@mail.gmail.com>
 <20230524-wasp-charm-fe5c5478957a@spud>
 <CAHVXubjhti9reD8oCh3Jm97tvFdUGi9ShYnm0NhQU4ZYVgU6HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fpr9FumDr9m9Nw35"
Content-Disposition: inline
In-Reply-To: <CAHVXubjhti9reD8oCh3Jm97tvFdUGi9ShYnm0NhQU4ZYVgU6HA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fpr9FumDr9m9Nw35
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2023 at 03:57:20PM +0200, Alexandre Ghiti wrote:
> The reserved memory regions are *currently* not specified to be no-map
> and that since v0.8: the culprit is commit 6966ad0abe70
> ("platform/lib: Allow the OS to map the regions that are protected by
> PMP").
>=20
> So to make sure we are on the same page:
>=20
> - from 0.1 to 0.7 =3D> reserved memory regions were marked as no-map
> - starting from 0.8 =3D> reserved memory regions are *not* marked as
> no-map anymore
>=20
> Hope that's clear!

Yes it was helpful - thanks.

--fpr9FumDr9m9Nw35
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG40YAAKCRB4tDGHoIJi
0h12AQDRekzfK51Hw9OBc1W5MAlPSn5sT0eZA/blzdGjhlJVvQD/TyuBHKkjWtVC
NayJSPKdj8ioC9UTvr0eodxsCuo40Qs=
=pEnp
-----END PGP SIGNATURE-----

--fpr9FumDr9m9Nw35--
