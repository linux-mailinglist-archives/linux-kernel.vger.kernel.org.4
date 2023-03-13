Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9F96B7932
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjCMNkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjCMNki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:40:38 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F6961888
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 06:40:35 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id p23-20020a05600c1d9700b003ead4835046so7535625wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 06:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678714834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31bIBBam0f6kecXsPhvAYb/shqew87ztMsMZCGP7Fyo=;
        b=a+yJWnElquqYbn/oICWpaQlm3ZZ3bFqIHFfXnnVVEa7PuDT6nvnm5tUmj0B5XQx2J2
         7yIj/RF7qe5wgEcR308v22xh0zJKvU6amW9qlKg2YVHfAyHo234WjE9FS1ebEstAVAhM
         iBuQ62jrO/cN2z55419ssAQRkeKMiy+g8QmEpLd6lJzSOLID0zxrREz/9TGqUGQepiw0
         t0Z3yDIKjGaO7VDgg390oZKuIJa2Kt/7KQdcpd/nBWSXA2zsSTd1Aj8mPN7yBeVO7hLI
         e7Tk04dscKAFXDTceu6VtfIwb2IlUGTwmpE8UIODGS9Zt5QxTPhy8LVEMSz4I+TM2hNZ
         VQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678714834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31bIBBam0f6kecXsPhvAYb/shqew87ztMsMZCGP7Fyo=;
        b=rA2QZi3e2q5+AmdPv0/1s4IPJjLgTaw1xYrZv5bAHsV1S4K6SrlmwWVtLJCX4o42Ww
         OdlSb4DXAfI/MV7PBJwDNfwvpXq6o82PMbPz9e6h20JqfufNhjfuKq/FRkGgD9SVbDZW
         fqlHaxAviEkC2XS3KA1/QA+htLty8a5skiz7xKY35bSQLyat1+2MiqATXfCNL1W81sb9
         DwK9g6DGkakPVu4Oai/AmD7BRieiqrdWX4heufCAcekNbVTKiPOvI1J9nMfvp8YYckAi
         hpwoi725yTj6JvB1Kdb8kqPefHKsa4I5BWd1Bjiu2qYMZp9Ah7TiPVCsYjg6tPHZ0LzV
         Em8A==
X-Gm-Message-State: AO0yUKVcYO/tKjThbgJw1pfrDFOqe/CRIxcbhpymMo7yuNpU/tQuxUi3
        M8LBLa/Gd1FFFLPDl9za0fvNeIM062UHUZNTMCuakZ0Lb5M=
X-Google-Smtp-Source: AK7set9lDqU39yypMAy0cjQ86QYU+3Njby8QG8Rj7JOvcecnYCcaHA2RVLNH73dyVErvidwPxpTbbVV6dFsNZEyZee4=
X-Received: by 2002:a7b:c843:0:b0:3eb:3e75:5db2 with SMTP id
 c3-20020a7bc843000000b003eb3e755db2mr2468540wml.2.1678714834218; Mon, 13 Mar
 2023 06:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <299fbb80-e3ab-3b7c-3491-e85cac107930@intel.com>
 <CAPAsAGyG2_sUfb7aPSPuMatMraDbPCFKxhv2kSDkrV1XxQ8_bw@mail.gmail.com> <20230313094127.3cqsnmngbdegbe6o@blackpad>
In-Reply-To: <20230313094127.3cqsnmngbdegbe6o@blackpad>
From:   Andrey Ryabinin <ryabinin.a.a@gmail.com>
Date:   Mon, 13 Mar 2023 14:40:33 +0100
Message-ID: <CAPAsAGzYSi_mCy64rFH=o+m8eT-A9ffttsFO9Wx94=nsj+Q8Jg@mail.gmail.com>
Subject: Re: KASLR vs. KASAN on x86
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 10:41=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.c=
om> wrote:
>
> On Wed, Mar 08, 2023 at 06:24:05PM +0100, Andrey Ryabinin <ryabinin.a.a@g=
mail.com> wrote:
> > So the vmemmap_base and probably some part of vmalloc could easily end
> > up in KASAN shadow.
>
> Would it help to (conditionally) reduce vaddr_end to the beginning of
> KASAN shadow memory?
> (I'm not that familiar with KASAN, so IOW, would KASAN handle
> randomized: linear mapping (__PAGE_OFFSET), vmalloc (VMALLOC_START) and
> vmemmap (VMEMMAP_START) in that smaller range.)
>

Yes, with the vaddr_end =3D KASAN_SHADOW_START  it should work,
 kaslr_memory_enabled() can be removed in favor of just the kaslr_enabled()

> Thanks,
> Michal
