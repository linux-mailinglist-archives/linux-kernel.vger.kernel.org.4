Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF8474881A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbjGEPdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbjGEPdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:33:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6731171C;
        Wed,  5 Jul 2023 08:33:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A89B615E9;
        Wed,  5 Jul 2023 15:33:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933E2C433C7;
        Wed,  5 Jul 2023 15:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688571211;
        bh=H4nxcPZ+ExyS0dhzH3wpIKUGFvb6o0coyoC4wq7eDV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S3equ4Eh46rIKbunrT063IKXAta16CtlfRYk/zmvemAukP6KEnqqWpVbQlI6GR3cT
         W7Rar6QOGieqrEiLH4b8qXqLVRk77BbCjTBtiDvJGTssid6bLdKHYU8f1Tr1QTJOwm
         APq7qKx5CtMIjbNb3/Xv5UEmZWJM581v2L5HRCAA42DPS+36eP+hBMj/7Nl0XE0riw
         bIuYi3rnb/3ue18k4oF1k5XIBzqAGgzqyo7yu/duk1yAbR/JkmouCYeIJ6AXE6RPWT
         V2CrTqTyIONP+efkUyt/Bqun9O8uznc730PZW6YPVPoBXpwVIbC0nRGRyklCVzbbkJ
         cZW6nJiR745uw==
Date:   Wed, 5 Jul 2023 16:33:25 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     cuiyunhui@bytedance.com, Ard Biesheuvel <ardb@kernel.org>,
        sunilvl@ventanamicro.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        rminnich@gmail.com, Mark Rutland <mark.rutland@arm.com>,
        lpieralisi@kernel.org, rafael@kernel.org, lenb@kernel.org,
        jdelvare@suse.com, yc.hung@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com
Subject: Re: [PATCH v3 0/4] Obtain SMBIOS and ACPI entry from FFI
Message-ID: <20230705-patio-daringly-7fdb62228bc0@spud>
References: <20230705114251.661-1-cuiyunhui@bytedance.com>
 <mhng-48837062-b9f6-4968-be9e-9d3b352be117@palmer-ri-x1c9>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ihN2fD/aDp+6NAHP"
Content-Disposition: inline
In-Reply-To: <mhng-48837062-b9f6-4968-be9e-9d3b352be117@palmer-ri-x1c9>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ihN2fD/aDp+6NAHP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Wed, Jul 05, 2023 at 07:17:29AM -0700, Palmer Dabbelt wrote:
> On Wed, 05 Jul 2023 04:42:47 PDT (-0700), cuiyunhui@bytedance.com wrote:
> > Here's version 3 of patch series.
> >=20
> > V1: The FFI (FDT FIRMWARE INTERFACE) scheme has reached a
> > consensus with the Maintainers.
> > Please refer to:
> > https://patches.linaro.org/project/linux-acpi/patch/20230426034001.16-1=
-cuiyunhui@bytedance.com/
>=20
> From looking at that thread it seems that the consensus is this is a bad
> idea?  Sorry if I'm just missing something...

"consensus" meaning that Ard told them what he was and was not prepared
to accept in common code, and left the decision on what he was not up to
the RISC-V maintainers.

While this version of the series seems to address some of my general
code comments on the v2 (although I have not yet looked more than skin
deep), there are some outstanding, higher level, questions that were
asked on v2 that do not seem to have been answered satisfactorily yet:

- "So, could you please bring this topic for discussion in on the riscv
  tech-brs mailing list (https://lists.riscv.org/g/tech-brs) and get
  agreement?" Sunil has asked this as RVI specs have an interest in
  cross-os booting contracts. See:
  https://lore.kernel.org/linux-riscv/CAEEQ3wnsedWJYEEg8z+3C_HuCca0nD50NGpC=
dU3scxavrrOucA@mail.gmail.com/

- "I am curious how do you handle EFI memory map dependencies." to
  which the answer was "a memory node in DTS can solve it."
  I don't see anything in this version of the patchset that actually
  reads a DTS node when ACPI is enabled. If I am missing some codepath
  that does this, please let point it out. See:
  https://lore.kernel.org/linux-riscv/CAEEQ3wnsedWJYEEg8z+3C_HuCca0nD50NGpC=
dU3scxavrrOucA@mail.gmail.com/

- "I'm not a big fan of adding yet another interface. Have you considered
  doing something like [1]?" where [1] was:
  https://github.com/tianocore/tianocore.github.io/wiki/UefiPayloadPkg
  The response to this question was "This has been discussed many times
  with Ard, Please refer to <v1>". I don't see how this answers the
  question to be honest & Andrew's follow-up question asking for
  clarification went unanswered:
  https://lore.kernel.org/linux-riscv/20230703-6ac90a2de15f1017bc0ced74@ore=
l/
  Jess, Emil and Bjorn have all also commented about you could load a
  small EFI payload from Coreboot. I don't see any responses to those
  questions.

=E8=BF=90=E8=BE=89=E5=B4=94, please try to address all outstanding comments=
 (and give people
a chance to reply to you) before sending new versions.

Cheers,
Conor.

--ihN2fD/aDp+6NAHP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKWNRQAKCRB4tDGHoIJi
0jgsAP0avqf4EpjVplVilCZJJkOs1o6sMzRck0zp6JDWFqPVaAD/SIEJYiB8uJ1t
GwN1FECYebycKrG4plh7eymFH6fTzgc=
=D5GW
-----END PGP SIGNATURE-----

--ihN2fD/aDp+6NAHP--
