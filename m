Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A165F708937
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 22:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjERUMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 16:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjERUMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 16:12:20 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19A810CE
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 13:12:18 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6ab1f0b6abeso2151645a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 13:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684440738; x=1687032738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Saf0zfqm07ePmwqK9Uni3ddlqu/Ais3Oc8azNzsCmaU=;
        b=NuTPx45raB9XoRXKchJ0d6OY/wNzW8Cqnv82qSfn3TnsUYuRWkpoELQOjLVIvgErso
         pMbU4AOOXdCupKcNQm5HNHXqKyfx6i1nNhgNIeTcQ9czZes9f8NMvaq0xr9KaUgziC4I
         YCBt0ED6uw1wmusVVtMAmaF61rd6CnYtrDvinrurN8QRixN51qqgv/s955fhdzMR+F+8
         kNTo73hMITJWI1UtdHsifXw/3Ns5U97hY1o9SgymvdT66tH12LZl1dHJxhnJDh3dF4pI
         kpu/hi7NnsU3y9hcUbb2EiBnTX689XdttOa1h8ugR8JjH5IMOaNuAuZSO1lqHOwg1NKB
         KuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684440738; x=1687032738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Saf0zfqm07ePmwqK9Uni3ddlqu/Ais3Oc8azNzsCmaU=;
        b=jaV7sRlKhI2Z5jqQDiuPkQqpWgssuH5kU7dGhT/OT5pY/d3xdb94OmE+w14cZb+5SA
         cX9ntmX9Y4N9WTgtrgqQwgtcqvhlziu+1ag50NKPgOcGQ++1jBNmqpPA+DQ/DNGYW6Bd
         K2H+mbQX0gPD2A9tWc+bWNy3FJbAXWkvbX7L1c//uirkF1kjbgeXNs8meipmjtB7rCdZ
         62u63UPlQELKFgGLhKxC8lRjZPNY7sUoTd8fx6z4NDHQHuEo0ObSTUznehpew70ejSC5
         4owFeRnc+pSxMxFXRqbKKJdo/ZVrranQjiwWv45V8g40Vp98Kb/pzQWdlWTwXBmYEGzg
         Mz4Q==
X-Gm-Message-State: AC+VfDy7BggCDcqr2H6ZYhBzR73Stu/MvyCmWmG7hiYNYUKC252uxXJR
        yz4CtA2c+lgyosw3xtZJ/PCoBej2Ga/vUe2g0NQ=
X-Google-Smtp-Source: ACHHUZ6jAdZQT7MaeZBAPc1hOum2bkrZ9ZOaKkrXqG4BvsAtpzj+6/tE1JzA6oJxJWJqayseYKopP/RNfDTGCIBRyDY=
X-Received: by 2002:a9d:638a:0:b0:6ad:ed25:3caf with SMTP id
 w10-20020a9d638a000000b006aded253cafmr1940815otk.9.1684440737969; Thu, 18 May
 2023 13:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230509183301.1745462-1-olvaffe@gmail.com> <CAPaKu7TqUt1L-5RUuwEagr2UUs8maOO+FSoS2PEoP9eO1-JJSw@mail.gmail.com>
In-Reply-To: <CAPaKu7TqUt1L-5RUuwEagr2UUs8maOO+FSoS2PEoP9eO1-JJSw@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 18 May 2023 16:12:06 -0400
Message-ID: <CADnq5_OsGqg7CoNVgtgr91a+pyBtJzoUOBXHKmGMcOM9hLFkwQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] amdgpu: validate drm_amdgpu_gem_va addrs for all ops
To:     Chia-I Wu <olvaffe@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, Philip Yang <Philip.Yang@amd.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        amd-gfx@lists.freedesktop.org,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        Mukul Joshi <mukul.joshi@amd.com>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Danijel Slivka <danijel.slivka@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 5:27=E2=80=AFPM Chia-I Wu <olvaffe@gmail.com> wrote=
:
>
> On Tue, May 9, 2023 at 11:33=E2=80=AFAM Chia-I Wu <olvaffe@gmail.com> wro=
te:
> >
> > Extend the address and size validations to AMDGPU_VA_OP_UNMAP and
> > AMDGPU_VA_OP_CLEAR by moving the validations to amdgpu_gem_va_ioctl.
> >
> > Internal users of amdgpu_vm_bo_map are no longer validated but they
> > should be fine.
> >
> > Userspace (radeonsi and radv) seems fine as well.
> Does this series make sense?

I think so, I haven't had a chance to go through this too closely yet,
but amdgpu_vm_bo_map() is used by ROCm as well so we'd need to make
sure that removing the checks in patch 1 wouldn't affect that path as
well.  The changes in patch 2 look good.  Also, these patches are
missing your SOB.

Thanks,

Alex


Alex
