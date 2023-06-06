Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923B77241ED
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237099AbjFFMSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236341AbjFFMSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:18:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F49E7E;
        Tue,  6 Jun 2023 05:18:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F6026288C;
        Tue,  6 Jun 2023 12:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F1CC433AE;
        Tue,  6 Jun 2023 12:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686053910;
        bh=XEzEqcGDlUT1sdojeKZQM4B3GW+KdAaXUM6yQRLFgaI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tUtjk4oKRV/PVGyezjjDAEd1VdxfmYzGTL04I4b9lb3pG0I+sD1Ee/fQpYugGlOtr
         NdbDlU5vrkxoclg/xw8J4UlLId1h0OCoMzFV5hxKyBvtKo2pxZdNsgbUrfqoZShw+t
         MSmrOnde6tMAHdwwCXaZVpLSYyrj6a785cKItKG/XvD6IIc1PDsbg78EjbmfnFK5OE
         lhPET+AXe+hPdgFFVhfhFnsSVFd4Ye9taQprozc14LVKQxF6c7sHg87wlAVEYEtD8x
         zibHulqrHyleDBY+fjwp9YgY0/k67ZO75rJ2q6CACGQyw5uYglt0dcAtR0fZYecRRy
         C4G4cZuKlRfOQ==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2b1a3fa2cd2so70999561fa.1;
        Tue, 06 Jun 2023 05:18:30 -0700 (PDT)
X-Gm-Message-State: AC+VfDzzDgX3pSME1ItiHycOgk97tUncG9kn+p1A4+3Jkaa/uOfZgbXT
        G4tQCTD98jdaIQ/5+n+n4IJgIetCQx2kWzbkGYI=
X-Google-Smtp-Source: ACHHUZ5PqJS7uqtk9Zx6gPNHj0NeBhXZQFXA7yNf6odNCQXLViZtfj7JgHczP1gA3PzaGVPck27iP0yf0l0jdj8yRdw=
X-Received: by 2002:a2e:9c8e:0:b0:2ac:8090:630e with SMTP id
 x14-20020a2e9c8e000000b002ac8090630emr1151454lji.28.1686053908149; Tue, 06
 Jun 2023 05:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230606112610.98149-1-franziska.naepelt@gmail.com> <ZH8jO0FO2QJ7eGBV@debian.me>
In-Reply-To: <ZH8jO0FO2QJ7eGBV@debian.me>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 6 Jun 2023 14:18:16 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHqn_Kff94s3zWZD5k5MvJQs-GGkFLC_tLJQLNDJgXHHA@mail.gmail.com>
Message-ID: <CAMj1kXHqn_Kff94s3zWZD5k5MvJQs-GGkFLC_tLJQLNDJgXHHA@mail.gmail.com>
Subject: Re: [PATCH] crypto: md4: Fix checkpatch issues
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Franziska Naepelt <franziska.naepelt@googlemail.com>,
        linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        Franziska Naepelt <franziska.naepelt@gmail.com>,
        Linux SPDX Licenses <linux-spdx@vger.kernel.org>,
        James Morris <jmorris@intercode.com.au>,
        Steve French <sfrench@samba.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jun 2023 at 14:15, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On Tue, Jun 06, 2023 at 01:26:10PM +0200, Franziska Naepelt wrote:
> > The following checkpatch issues have been fixed:
> > - WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> > - ERROR: space required after that ',' (ctx:VxV)
> > - ERROR: space prohibited after that open square bracket '['
> > - WARNING: space prohibited between function name and open parenthesis '('
> > - ERROR: code indent should use tabs where possible
>
> Again, please split up into one patch per fixes, as a patch series.
>

Apart from the SPDX conversion, I think it is fine to fix multiple
different whitespace issues in the same file with one patch. Splitting
that up is just busywork.


> >
> > not fixed:
> > - ERROR: space required after that ',' (ctx:VxV)
> > in lines: 64, 65, 66 have not ben fixed due to readability
>
> Can you clearly explain why do you skip #define ROUNDx macros?
>
> > -/*
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> >   * Cryptographic API.
> >   *
> >   * MD4 Message Digest Algorithm (RFC1320).
>
> What about removing the license boilerplate text below (and thus convert
> to SPDX)? Personally, I prefer having a SPDX conversion series for crypto/
> directory instead.
>
> Thanks.
>
> --
> An old man doll... just what I always wanted! - Clara
