Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B36E7118FF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 23:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240673AbjEYVZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 17:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjEYVZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 17:25:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3958A7
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 14:24:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50AFD64B44
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 21:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BA6C433D2;
        Thu, 25 May 2023 21:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685049898;
        bh=sHbl6fw39/hwrmlJz0f1XUrMK4RPjY+BEtvJ1D7Z6J8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CBIGQ+FOoJUn2/25rDk8lCExgXRTLq0H40OZCNiiUWM5LIolvO5nEr54A4jWfHzVv
         O4FogGGrf+pKb8qBGh8PNNRgdny0Eo1IELONCVpi9a4EyROmFCbfC6P7iQC3huj7Tq
         HS/YjjAeaK5Gs4/+aUSHSrqkJPdsCo0V9QVpZPwHt1cixM7JlT1Vg/OAaa8HHpmH9N
         HV4jFxTIH93nHYduCB4Mlf7J9qg97FCWlwq3gISVM6T7wzYz05qH6Lil5swQfbOlk2
         o7SLUs/yLVXQZXBfqj7rWESOmKJPd+Ror6wBWyttlrBAdQ2FqQO9D5EA/CtfsuEwXA
         DPdQ63e1FiZNg==
Date:   Thu, 25 May 2023 22:24:52 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Alexandre Ghiti <alex@ghiti.fr>, robh@kernel.org,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        jeeheng.sia@starfivetech.com, linux-kernel@vger.kernel.org,
        palmer@rivosinc.com, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Song Shuai <suagrfillet@gmail.com>,
        linux-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>
Subject: Re: Bug report: kernel paniced when system hibernates
Message-ID: <20230525-batting-botch-7e03393a2d97@spud>
References: <20230525-postnasal-monopoly-98adb96ffaa1@wendy>
 <CAAhSdy06nQh4H1FP_K_-VF462mhj+F2M=4AV4QSCUGe5XVqX0g@mail.gmail.com>
 <20230525-shrapnel-precut-26500fca4a48@wendy>
 <CAAhSdy3SqeLdAfaojUki=ht21nr4ZUPMkW_t9M6ntQCt6Ds4Nw@mail.gmail.com>
 <20230525-citric-waged-a2f78d27eb0c@wendy>
 <CAOnJCULfC0jmiucLNMeJZwJf4QbGAN6r4B-ubUbP16KVpxrCfA@mail.gmail.com>
 <20230525-flaring-trading-f2bf0713ae26@spud>
 <CAOnJCUK_EgX-En1QNS8yX1WA1nj8w2kpvXMQcvgWuR3dvzEQYw@mail.gmail.com>
 <20230525-desecrate-imposing-d97ab34e06ad@spud>
 <CAOnJCUKfRv68Bh8ue=ZhMGxai9_UEHLpm3553g2c2NXh-RP-TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="giZwDsK7yc/if3gT"
Content-Disposition: inline
In-Reply-To: <CAOnJCUKfRv68Bh8ue=ZhMGxai9_UEHLpm3553g2c2NXh-RP-TQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--giZwDsK7yc/if3gT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2023 at 01:06:04PM -0700, Atish Patra wrote:
> On Thu, May 25, 2023 at 11:39=E2=80=AFAM Conor Dooley <conor@kernel.org> =
wrote:
> >
> > On Thu, May 25, 2023 at 11:37:40AM -0700, Atish Patra wrote:
> >
> > > Any testing of hibernation still needs to revert the patch until we
> > > have the proper fix.
> >
> > "the patch" is what exactly? I assume you don't mean depending on
> > NONPORTABLE, since that is a Kconfig option.
>=20
> Nope. Sorry I meant the commit
>=20
> 3335068 ("riscv: Use PUD/P4D/PGD pages for the linear mapping")

Ah, if your SBI implementation is one of the affected ones, yeah.
If not, you can just set NONPORTABLE :)

--giZwDsK7yc/if3gT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG/SJAAKCRB4tDGHoIJi
0jZOAP9C6VnJh9zSjVcNPKFI5K8sgE4+9cEmsr1nr1WidwGIZAD/bZtFnlwSpd8+
yf6OGQsxALfntjSloQkpjYvxsxhBegE=
=paGv
-----END PGP SIGNATURE-----

--giZwDsK7yc/if3gT--
