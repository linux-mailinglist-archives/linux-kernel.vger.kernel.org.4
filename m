Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF18C72B9DC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjFLIKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjFLIJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:09:58 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3367891
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:09:57 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f6255ad8aeso4681470e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1686557395; x=1689149395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muMBbKlbOgkWCg/h+XMxPqeAhUGmHsuqP1SYaCH/UFY=;
        b=bKzZ5pVjr7z8DX18zLJaYdJEbquvi5GZXOSxjzvXRe9FS/ZRIWuCpe0bkY3Pi7psBt
         3sBoEeXwI2mQVSxBLczOl4LYgjNZUezBhpwWtwmpPjDJfXnNBHuyXOELYWRN8LVsSaLh
         9Yykb4qqRYQVpCqOU+4dg50jZxaEbL+28o5WvtZ4lsIu1RNECljJh1b7OlbLUoyfmuAX
         v/G8qxruf0M4swW9jav14C3An+urjW7RosN/DAmLbWTcruewD9oOuMvts5KizJDF1W1U
         xwRbHhT9HOXz6xRfyT0SSonstvp3DigSqlzuxssdI/WDmSVseCZnnnwNuyxWiqllH2qc
         VzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686557395; x=1689149395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=muMBbKlbOgkWCg/h+XMxPqeAhUGmHsuqP1SYaCH/UFY=;
        b=VWuJ1dOsScQLWqG5bn4fF8FMhJrj3rZ678SUP4V2Fyv4NlGFEiAVDjpzCaU9895XCC
         oCJNSu+Ma2HilNv1WEqNR3Jn1NTWiKmvhS5UgmX90ZUYs7GpP0qS3Fp5Hm1ZejqlRBU9
         yLIsPozSgadeZNG82bWqR/dgvxZMfrIxr/WBppgufOqHbEbUAFzMNFqKyeyIZLhP3ufa
         W1IF9su05PSVLbRS/eJWcshCsEESFNT2SbyRSrsDRu69h1yxaSFDV630R8xrJBm+xFYx
         s93wG984EGSe0BbzkT656qFMPNo0Jq1KQIyt4Ybo8epMeEULnX/aG4/yquhqDlPwhXkx
         assw==
X-Gm-Message-State: AC+VfDy+judj55FuO2/d8mVopXLa8lPnj1UI8ByFi/klhfGrwVYnCAs5
        LZpm2ieFxB0lgpE5YujGzSdk7AAYmrv1VDwM9mbPMFw3sHWoN6AI8sk=
X-Google-Smtp-Source: ACHHUZ7SXgq3JBJs8PX9muZNuGvjPynjHw0jAq/dt4Hqj7hqWMp/CmUtXBq0rbDUvO3pifJPHKZxoWr+KJqLwHYrSa4=
X-Received: by 2002:a7b:c5d9:0:b0:3f8:2777:188 with SMTP id
 n25-20020a7bc5d9000000b003f827770188mr295405wmk.11.1686553085028; Sun, 11 Jun
 2023 23:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_B15C0F1F3105597D0DCE7DADC96C5EB5CF0A@qq.com>
 <20230607-jogging-grudging-70dede86bc53@spud> <CAHVXubggydGfNu3OzcxWXREJbB+G9dmr9sFD7vXhVxbG-N58Pg@mail.gmail.com>
 <20230610-ability-mockup-f6aa71bad6a1@spud> <tencent_06282B9141D32F1D19BE2BB41998E1612607@qq.com>
In-Reply-To: <tencent_06282B9141D32F1D19BE2BB41998E1612607@qq.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Mon, 12 Jun 2023 08:57:52 +0200
Message-ID: <CAHVXubgL8TZydzWogqxNczNkKin=qLp4i6=5d0YVBQdqMtFVjw@mail.gmail.com>
Subject: Re: [PATCH] riscv: reserve DTB before possible memblock allocation
To:     Woody Zhang <woodylab@foxmail.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 11, 2023 at 1:27=E2=80=AFAM Woody Zhang <woodylab@foxmail.com> =
wrote:
>
> On Sat, Jun 10, 2023 at 04:41:17PM +0100, Conor Dooley wrote:
> >On Thu, Jun 08, 2023 at 09:49:44AM +0200, Alexandre Ghiti wrote:
> >> On Wed, Jun 7, 2023 at 8:17=E2=80=AFPM Conor Dooley <conor@kernel.org>=
 wrote:
> >> >
> >> > +CC Alex, you should take a look at this patch.
> >> >
> >> > On Wed, Jun 07, 2023 at 09:35:19PM +0800, Woody Zhang wrote:
> >> > > It's possible that early_init_fdt_scan_reserved_mem() allocates me=
mory
> >> > > from memblock for dynamic reserved memory in `/reserved-memory` no=
de.
> >> > > Any fixed reservation must be done before that to avoid potential
> >> > > conflicts.
> >> > >
> >> > > Reserve the DTB in memblock just after early scanning it.
> >> >
> >> > The rationale makes sense to me, I am just wondering what compelling
> >> > reason there is to move it away from the memblock_reserve()s for the
> >> > initd and vmlinux? Moving it above early_init_fdt_scan_reserved_mem(=
)
> >> > should be the sufficient minimum & would keep things together.
> >
> >> Thanks Conor.
> >>
> >> So the patch looks good to me.
> >>
> >> But I find this fragile:
> >>
> >> - we do not check memblock_reserve() return value to make sure the
> >> reservation really happened (and quickly looking at the code, I'm not
> >> even sure it returns an error if the region was already allocated).
> >> - we have to make sure no memblock allocation happens before setup_boo=
tmem().
> >> - we also have to check that no fixed memblock_reserve() happens after=
.
> >>
> >> The last 2 points may sound natural, but we'll have to take great care
> >> when adding some code around here. I'm working on an "early boot
> >> document" and I'll add something about that, but a runtime thing would
> >> be way better IMO.
> >>
> >> You can add:
> >>
> >> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> >
> >btw Alex/Woody, what is the appropriate Fixes tag here?
>
> In ef69d2559fe9 ("riscv: Move early dtb mapping into the fixmap region"),
> Alex move early_init_fdt_scan_reserved_mem to setup_bootmem() to prevent
> memory allocations before of reservations. But it should not be put befor=
e
> DTB reservation.
>

Yep, that's the culprit, let's add the proper tag:

Fixes: ef69d2559fe9 ("riscv: Move early dtb mapping into the fixmap region"=
)

Thanks!

Alex

>
> Woody
>
