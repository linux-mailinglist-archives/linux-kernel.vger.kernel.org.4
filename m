Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AEE741366
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjF1OFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjF1OEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:04:15 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D0B3AA4;
        Wed, 28 Jun 2023 07:02:56 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b69f958ef3so59151791fa.1;
        Wed, 28 Jun 2023 07:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687960974; x=1690552974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9++kyskAcuLSTCdvz4cuOcuwZ+7nEt7UgMySKIzNZkY=;
        b=bZSr1gisAoHvMUzOjN2iYx4JPE9w+BVuk/wojslN7pMzeSLYX85uI+M/+vom43bFT2
         c5uSzw0Q/mB5FjHmHh1ClZA4aiB/96Ez8s7t0bdFsLLDlvN7TR7NTkqBne+p9VwW6IRu
         DK9Wd5tgF2foEFCdPNvr4zcn7JHEW8ChgEhWMdMnkJQjK7bd7Onh3k+O362NwEPUJmcW
         jVHWq19UY3FVruPHq/L9UhM52jWwcnlWY8qQ7KLHPF2hZogrCmfLYwDHmMXkfJy9Nha8
         FtFV6c9ZcEMN40q03KAof6TNPxw5e4Nf7ldmgD7eldle0DhWgpTsJwB/q5w6R4qCpjcJ
         +PuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687960974; x=1690552974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9++kyskAcuLSTCdvz4cuOcuwZ+7nEt7UgMySKIzNZkY=;
        b=XzMD3SJVUXK3LbTJ0AVwHApGwJCGcUpGEuCyouAj7dvZHN9ftVME81RbiHVohXEZ6q
         74zROhhJ6BmX7ndxj559HNk/xutLe5/1w+ZPVSxLw3tEsRamUwPIdW3lsNgR3P7bFq42
         DjwHJa9IVxgY9d3gP2R5bznZ3MX/Yr6+pFusdmoyXAqK/bIlNnLlctReNG9rZ+mw95PK
         00+/vEXGTOmsWsqxPxPU9XXoM5sG9lKhJh9MMQQHbhbPgyEQ12+diQe13yI/L1ZFQqNZ
         Uj83rS0pcaqlBuIK1EpytCfzIXHQeralkGx25Lo3bYb/43t67/hWACqcSErQ6udRTk24
         8Ulw==
X-Gm-Message-State: AC+VfDy7GRosYv4a/hjbLSwMd4/Z/Tm0rcqCS0Nw1lk9ttucWh/mygNI
        Zi2agjAUX9H+135e1tX5/3nxzIc5ujnZLSlEgjIXFvXX
X-Google-Smtp-Source: ACHHUZ68oLVhXjotD3TU0EQBJWaKIPvJRdeVR/ctTiw1P3PXSMIZdlXmsFqY8H46WolZHg3+MW+co0zo2yZ7DRMflXk=
X-Received: by 2002:a2e:854e:0:b0:2b5:80c9:9806 with SMTP id
 u14-20020a2e854e000000b002b580c99806mr15449461ljj.6.1687960973954; Wed, 28
 Jun 2023 07:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230628011439.159678-1-linux@treblig.org> <9343462e-6a4a-ca7b-03b8-4855e5a33b72@talpey.com>
 <ZJw4iLlFWRMq6a3S@gallifrey> <ZJw50e0pvn/IN5Gj@gallifrey>
In-Reply-To: <ZJw50e0pvn/IN5Gj@gallifrey>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 28 Jun 2023 09:02:42 -0500
Message-ID: <CAH2r5muALCzCujwMZQFpWMtwvv97ZykP-1Wkf3PF4ybkgYNhGw@mail.gmail.com>
Subject: Re: [PATCH 0/3] dedupe smb unicode files
To:     "Dr. David Alan Gilbert" <linux@treblig.org>
Cc:     Tom Talpey <tom@talpey.com>, sfrench@samba.org,
        linkinjeon@kernel.org, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 8:56=E2=80=AFAM Dr. David Alan Gilbert
<linux@treblig.org> wrote:
>
> * Dr. David Alan Gilbert (dave@treblig.org) wrote:
> > * Tom Talpey (tom@talpey.com) wrote:
> > > On 6/27/2023 9:14 PM, linux@treblig.org wrote:
> > > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > >
> > > > The smb client and server code have (mostly) duplicated code
> > > > for unicode manipulation, in particular upper case handling.
> > > >
> > > > Flatten this lot into shared code.
> > > >
> > > > There's some code that's slightly different between the two, and
> > > > I've not attempted to share that - this should be strictly a no
> > > > behaviour change set.
> > > >
> > > > I'd love to also boil out the same code from fs/jfs/ - but that's
> > > > a thought for another time (and harder since there's no good test
> > > > for it).
> > > >
> > > > Lightly tested with a module and a monolithic build, and just mount=
ing
> > > > itself.
> > > >
> > > > This dupe was found using PMD:
> > > >    https://pmd.github.io/pmd/pmd_userdocs_cpd.html
> > > >
> > > > Dave
> > > >
> > > > Dr. David Alan Gilbert (3):
> > > >    fs/smb: Remove unicode 'lower' tables
> > > >    fs/smb: Swing unicode common code from server->common
> > > >    fs/smb/client: Use common code in client
> > > >
> > > >   fs/smb/client/cifs_unicode.c                  |   1 -
> > > >   fs/smb/client/cifs_unicode.h                  | 313 +------------=
-----
> > > >   fs/smb/client/cifs_uniupr.h                   | 239 -------------
> > > >   fs/smb/common/Makefile                        |   1 +
> > > >   .../uniupr.h =3D> common/cifs_unicode_common.c} | 156 +--------
> > > >   fs/smb/common/cifs_unicode_common.h           | 279 +++++++++++++=
+++
> > >
> > > So far so good, but please drop the "cifs_" prefix from this new file=
's
> > > name, since its contents apply to later smb dialects as well.
> >
> > Sure.
>
> Actually, would you be ok with smb_unicode_common ?  The reason is that
> you end up with a module named unicode_common  that sounds too generic.

Since it is already in the smb/common directory, seems easier to name them:
smb/common/unicode.c
or smb/common/smb_unicode.c

--=20
Thanks,

Steve
