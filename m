Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A15741432
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjF1OsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjF1OsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:48:04 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB87A198D;
        Wed, 28 Jun 2023 07:48:02 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b69a48368fso62653291fa.0;
        Wed, 28 Jun 2023 07:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687963681; x=1690555681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1YW04UU50We/tDixqQJR64b2VyQ7y4Z8YwnYoU/27Y=;
        b=gZdBV6+46sAPCfbZOVNA4lYadj64AT6TE58CoTLMkYIAD0VaV8reG7VDE2Xd+IusnO
         i4hcCprFn3uOSxJB3DiW++DlwlHtxBKYrP5LOfgZ0gR/5FX7IGNpOmKHUTI6y7l3v2rL
         ox/FfGig8cKafWSPor1BR/9aLpm2Aa8nijawte3QW/QUDETMmsvRdtSDVGJl5CZ4YcX3
         ddLHAgWdpfh5C86jpXMrWhDvZ5zQz25IiCh5KjUmIbmj9EEacDiWn9+9ltb1etlDJK9M
         0UzmQYKP83YYqQLOF0F+efp97n+AeVKmpC8+amItdgbgp6LnlN62eqW+Aqoqj5DZElK/
         4BfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687963681; x=1690555681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1YW04UU50We/tDixqQJR64b2VyQ7y4Z8YwnYoU/27Y=;
        b=GjshdAdJlufWYaH1w8suzRiv/75/7tk8UB3q4oIwibJbQfJ5LmMQw/Lw+yWxZ11ocw
         akI0ywn8D3DwSKst0vPjhImb0CMFJbX2y+7pTa8JK6ccn8LI740mL+Mp6iGrbdfEyUI0
         Y/jp9NQjbYtzn8So/bMz9B2hOuymbfYsyHjE6bh04/Mqpce7ALfK27l9DILjgfcizl39
         6VW4nwOs4ExmsjABSw6aZnTqBLq00efdVDlmdSQXPQG8CBWeAjqqKlmKitTMXYt3gK2F
         AT2NCd97tlODl3aTG4C63aL5KYqxbNuYajdcuqhsHu6uGLRbTf2bEyo+4TuaZ7HElfb0
         StEA==
X-Gm-Message-State: AC+VfDxRDnCdigpwksUbma9Gcg9RSqI16rH/4Le6NZceJQ8rooja2yMQ
        hv1fV8GDaWBf9fW2l1o4cbh5n93jlcIv61yj9G/BcUA3
X-Google-Smtp-Source: ACHHUZ4V4luOlVImmSO22TeirzJZI8KUcreJ0Wd+SzXba9EvdhUFQLB7RmaigJsQwmmHiHC1M03C5gJ7uA7tMsIjJkw=
X-Received: by 2002:a2e:97cc:0:b0:2b6:a44d:e255 with SMTP id
 m12-20020a2e97cc000000b002b6a44de255mr5934312ljj.0.1687963680671; Wed, 28 Jun
 2023 07:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230628011439.159678-1-linux@treblig.org> <9343462e-6a4a-ca7b-03b8-4855e5a33b72@talpey.com>
 <ZJw4iLlFWRMq6a3S@gallifrey> <ZJw50e0pvn/IN5Gj@gallifrey> <66391bef-ab6c-7cad-3588-3f0a0dfb7d47@oracle.com>
In-Reply-To: <66391bef-ab6c-7cad-3588-3f0a0dfb7d47@oracle.com>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 28 Jun 2023 09:47:49 -0500
Message-ID: <CAH2r5mvqHSBdNQHm88gu0yhayY+yr6sYq1ou6ekxRVfoOrT=vg@mail.gmail.com>
Subject: Re: [Jfs-discussion] [PATCH 0/3] dedupe smb unicode files
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     "Dr. David Alan Gilbert" <linux@treblig.org>,
        Tom Talpey <tom@talpey.com>, sfrench@samba.org,
        linux-cifs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        linkinjeon@kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Jun 28, 2023 at 9:24=E2=80=AFAM Dave Kleikamp <dave.kleikamp@oracle=
.com> wrote:
>
> On 6/28/23 8:46AM, Dr. David Alan Gilbert wrote:
> > * Dr. David Alan Gilbert (dave@treblig.org) wrote:
> >> * Tom Talpey (tom@talpey.com) wrote:
> >>> On 6/27/2023 9:14 PM, linux@treblig.org wrote:
> >>>> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >>>>
> >>>> The smb client and server code have (mostly) duplicated code
> >>>> for unicode manipulation, in particular upper case handling.
> >>>>
> >>>> Flatten this lot into shared code.
> >>>>
> >>>> There's some code that's slightly different between the two, and
> >>>> I've not attempted to share that - this should be strictly a no
> >>>> behaviour change set.
> >>>>
> >>>> I'd love to also boil out the same code from fs/jfs/ - but that's
> >>>> a thought for another time (and harder since there's no good test
> >>>> for it).
> >>>>
> >>>> Lightly tested with a module and a monolithic build, and just mounti=
ng
> >>>> itself.
> >>>>
> >>>> This dupe was found using PMD:
> >>>>     https://pmd.github.io/pmd/pmd_userdocs_cpd.html
> >>>>
> >>>> Dave
> >>>>
> >>>> Dr. David Alan Gilbert (3):
> >>>>     fs/smb: Remove unicode 'lower' tables
> >>>>     fs/smb: Swing unicode common code from server->common
> >>>>     fs/smb/client: Use common code in client
> >>>>
> >>>>    fs/smb/client/cifs_unicode.c                  |   1 -
> >>>>    fs/smb/client/cifs_unicode.h                  | 313 +------------=
-----
> >>>>    fs/smb/client/cifs_uniupr.h                   | 239 -------------
> >>>>    fs/smb/common/Makefile                        |   1 +
> >>>>    .../uniupr.h =3D> common/cifs_unicode_common.c} | 156 +--------
> >>>>    fs/smb/common/cifs_unicode_common.h           | 279 +++++++++++++=
+++
> >>>
> >>> So far so good, but please drop the "cifs_" prefix from this new file=
's
> >>> name, since its contents apply to later smb dialects as well.
> >>
> >> Sure.
> >
> > Actually, would you be ok with smb_unicode_common ?  The reason is that
> > you end up with a module named unicode_common  that sounds too generic.
>
> A bit off topic, but a question for Steve.
>
> Is there a need for separate modules under fs/smb/common/? Or could the
> makefile do something like:
>
> obj-$(CONFIG_SMBFS) +=3D smb_common.o
>
> smb_common-y :=3D cifs.arc4.o cifs_md4.o smb_unicode.o


Since arc4 and md4 are used more rarely used than smb_unicode (and in
some environments
use of md4 could be forbidden), and also since arc4 and md4 are not
really smb/cifs but crypto,
seems more logical to keep them separate.    There are other things
like quic support
(which is important for smb3.1.1) that will probably be much larger
(even with upcalls) that
could also be distinct modules in fs/smb/common in the future.


--=20
Thanks,

Steve
