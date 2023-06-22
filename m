Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9CC73A2E6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjFVOTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjFVOTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:19:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BDB10F0;
        Thu, 22 Jun 2023 07:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687443585; x=1718979585;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NeSR1vNwipiW/2D8gk01qgwm4EJAmEnPTQtu9D6YhEY=;
  b=AkNlk7M6TN0V++xS+dsz3glPmVwUA8Qnu9J96GnxcG6mgZLMUPEFnzIX
   O2EEsPe0BxpZaGzXJ+22BAzdt4zAHHD9zcd4urlpKy0zMos0XG3oyZbP6
   EpT9uMIr9j7zs6nWRIthSh4TOcbbz/UTXqLGFGSpVlfUf33CD+DODKWpa
   7NrK7McLsYR53SYjc2ZfXw4MeACMyVjmOrVkxseVfyJEJQc/XWsDKdf+M
   EGAB4audbhRE/TX1qZ0/8sETXBGkEcekLO60yQqnxIJulTzoT/TgWRYJz
   oWRV0J2bwxprUxecVkLYBUxEp1yE+GCR7K67zWin7guLVYKQ7hyEq3Qcr
   w==;
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="asc'?scan'208";a="231605811"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jun 2023 07:19:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 22 Jun 2023 07:19:44 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 22 Jun 2023 07:19:42 -0700
Date:   Thu, 22 Jun 2023 15:19:14 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
CC:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Song Shuai <songshuaishuai@tinylab.org>,
        <linux-doc@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>
Subject: Re: [PATCH v2 2/3] Documentation: riscv: Add early boot document
Message-ID: <20230622-ensnare-catnap-1d1183111387@wendy>
References: <20230621072234.9900-1-alexghiti@rivosinc.com>
 <20230621072234.9900-2-alexghiti@rivosinc.com>
 <20230621-attempt-unstirred-567b0352176a@wendy>
 <CAHVXubhJXUODDnfRJAzAKcutMvz_amP3wAf+4QBKxXzcd_r7Yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9ZbHIYccJ4yhuuFy"
Content-Disposition: inline
In-Reply-To: <CAHVXubhJXUODDnfRJAzAKcutMvz_amP3wAf+4QBKxXzcd_r7Yg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--9ZbHIYccJ4yhuuFy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 02:26:02PM +0200, Alexandre Ghiti wrote:
> On Wed, Jun 21, 2023 at 2:15=E2=80=AFPM Conor Dooley <conor.dooley@microc=
hip.com> wrote:
> >
> > Hey Alex,
> >
> > On Wed, Jun 21, 2023 at 09:22:33AM +0200, Alexandre Ghiti wrote:
> > > This document describes the constraints and requirements of the early
> > > boot process in a RISC-V kernel.
> >
> > Thanks a lot for writing this & implementing the feedback :)
> > I had one or two minor comments about rather long sentences, but there's
>=20
> Arf, sorry, which one? So that I can fix that in case of a v3.

> > little point I think in respinning for that, so I have ignored them.

Nah, not worth the effort ;)

> > Other than that, didn't spot anything new on this second reading.
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> >
> > Cheers,
> > Conor.

--9ZbHIYccJ4yhuuFy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJRYYgAKCRB4tDGHoIJi
0sOtAP4pFW6UOJGC/EkvVCkSSQbfq8gdLRnDTGVDOZ4wEJhvjAD/bXQ665m1ulNR
kjSwM6etTh4yJbDKoTALymORyEIu+w4=
=c0MV
-----END PGP SIGNATURE-----

--9ZbHIYccJ4yhuuFy--
