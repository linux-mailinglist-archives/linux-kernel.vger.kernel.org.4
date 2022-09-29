Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139D35EEE85
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbiI2HJz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Sep 2022 03:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbiI2HJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:09:47 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB03830545;
        Thu, 29 Sep 2022 00:09:43 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id a20so271612qtw.10;
        Thu, 29 Sep 2022 00:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+onjZYpK5e42V87Cg6u2hPN7v8i5Lvm6t/wPM+ZKj08=;
        b=29vxYleK6PCwc3BklBoJWeqbod6zqfnv1ceN5pB2UKMBs5zrt1sp3cPWjlHaI00NX0
         bn0CgfU932OpR5uNwGOzAv9Qk54wCVUCrLDgGjUAlnPDOGFWQUdhNWJRCCJbb9Q9oQOH
         GJ9h/pwhMLnK2W9kQkp8mB1ENmmlh7TYUtIxpOZzeDIfQI27fFStAa3jnz1Qvl2dNh68
         lDqamynLPt8CWkNSedYT2lDW2bmXaQnnUtoPdtPv9U8zyjPK4naY3g081u4J+AdyQZ7S
         Fo6ZPePeB3Df5FbdRw9PumkK8FD29Kukltkl9Lfj81BpgMI4/flU7eTamZS2r9MOyAv4
         jU4A==
X-Gm-Message-State: ACrzQf32GTcV/nWT4jd9n73UVPW2ZxuakfY6IbqlRR35AH+w4H1zralN
        5wEU5uvY9B8zJAdXlQ7vE3wU//ditvIo2A==
X-Google-Smtp-Source: AMsMyM7svHStwq8HLhuGnY2Vkz3ATGwqqh4aj8xY/vHtPbhS7p4fGhZqvaV4OCmTYHKnMjdBn0XrYw==
X-Received: by 2002:a05:622a:1051:b0:35c:eb36:d61 with SMTP id f17-20020a05622a105100b0035ceb360d61mr1219214qte.582.1664435382549;
        Thu, 29 Sep 2022 00:09:42 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id f8-20020a05620a280800b006b929a56a2bsm5132148qkp.3.2022.09.29.00.09.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 00:09:42 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-352ffac3941so5699407b3.6;
        Thu, 29 Sep 2022 00:09:41 -0700 (PDT)
X-Received: by 2002:a81:9c49:0:b0:34a:de:97b8 with SMTP id n9-20020a819c49000000b0034a00de97b8mr1733022ywa.384.1664435381696;
 Thu, 29 Sep 2022 00:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220928192605.247546-1-broonie@kernel.org> <68689c5b-327f-65df-0d34-a7e1a851f568@infradead.org>
In-Reply-To: <68689c5b-327f-65df-0d34-a7e1a851f568@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 29 Sep 2022 09:09:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWrQabb_LoCPfbdWo9D11+4kxSjQeBStpjvckvuXuBMNQ@mail.gmail.com>
Message-ID: <CAMuHMdWrQabb_LoCPfbdWo9D11+4kxSjQeBStpjvckvuXuBMNQ@mail.gmail.com>
Subject: Re: linux-next: Tree for Sep 28 (drivers/gpu/drm/msm/msm_gem_shrinker.c)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     broonie@kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 8:10 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 9/28/22 12:26, broonie@kernel.org wrote:
> > Changes since 20220927:
> >
>
> on x86_64:
>
> ../drivers/gpu/drm/msm/msm_gem_shrinker.c: In function ‘can_block’:
> ../drivers/gpu/drm/msm/msm_gem_shrinker.c:29:28: error: ‘__GFP_ATOMIC’ undeclared (first use in this function); did you mean ‘GFP_ATOMIC’?
>    29 |         if (sc->gfp_mask & __GFP_ATOMIC)
>       |                            ^~~~~~~~~~~~
>       |                            GFP_ATOMIC

Also on m68k, as reported by noreply@ellerman.id.au

I have bisected it to commit 1ccea29f90329e35 ("Merge branch
'mm-everything' of
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm"), but I didn't
see immediately what caused it.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
