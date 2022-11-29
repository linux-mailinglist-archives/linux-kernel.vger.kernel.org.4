Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEC863BC88
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 10:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbiK2JHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 04:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbiK2JHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 04:07:45 -0500
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF92E15;
        Tue, 29 Nov 2022 01:07:39 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id a17so7515649qvt.9;
        Tue, 29 Nov 2022 01:07:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pRTrs4STHN19HAaWZ6G6ImvhRFTGcXTwtf66lKxgXXI=;
        b=GtOdZts36iebJA8PYmMx1GVhOxv4n7P6T8nROrX/B40iTpR69UEK/HUFZ+Js54/Sdv
         xfbTPUhhJHOob6GO8Jzyiq7tOV8T7hb44Fqev2ty7kK0ojuU14DMLwWysL4kkQOyQ7Ib
         Uk6gYukybiMBgQjOfGRogV1Q6C+6hXPH67bYUdNO8z4xw+o7rmaabqhQLRkG/1RADSmZ
         KLghesI/s7ueArFzP321xzGje8GaBoHT2ndCURsuLm2oIRPtLY2rvbaqNjtIArbgLseQ
         2E0Q7s2SOCVep5gAZnTxHcd08Oh0e+lQG2BxvPUC2ZaEOYAyWzxPWnAOXmw//UeQ1FRu
         rEyg==
X-Gm-Message-State: ANoB5pk16bF13h3EktD0HrIZYs/qZCmbBBG/jYTsPhnPG64Dz+/DcECR
        neg3AyLBA5DBwvWRpPSIhGmOAQ8qIb+u8A==
X-Google-Smtp-Source: AA0mqf5rh86N1EzKg1VnvN+gI0tAXW+F7Y2j/jVCR/5AeIvTWfQ+JUph+GUug7M2jEud3VzF9pAGEw==
X-Received: by 2002:a0c:9067:0:b0:4bb:a664:4165 with SMTP id o94-20020a0c9067000000b004bba6644165mr32920099qvo.84.1669712858661;
        Tue, 29 Nov 2022 01:07:38 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id f20-20020a05620a409400b006e16dcf99c8sm10189399qko.71.2022.11.29.01.07.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 01:07:37 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id d128so16602508ybf.10;
        Tue, 29 Nov 2022 01:07:37 -0800 (PST)
X-Received: by 2002:a25:7408:0:b0:6f2:49a7:38ef with SMTP id
 p8-20020a257408000000b006f249a738efmr20678381ybc.365.1669712857595; Tue, 29
 Nov 2022 01:07:37 -0800 (PST)
MIME-Version: 1.0
References: <20221128105844.315bb58a@canb.auug.org.au>
In-Reply-To: <20221128105844.315bb58a@canb.auug.org.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 29 Nov 2022 10:07:26 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXkDOn+J-Tjd_nDpkAKYXBhHVtNWSrLrkiGjpvYYXJkEg@mail.gmail.com>
Message-ID: <CAMuHMdXkDOn+J-Tjd_nDpkAKYXBhHVtNWSrLrkiGjpvYYXJkEg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the drm tree with Linus' tree
To:     Dave Airlie <airlied@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Stanley.Yang" <Stanley.Yang@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi DRm people,

On Mon, Nov 28, 2022 at 1:02 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Today's linux-next merge of the drm tree got a conflict in:
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>
> between commits:
>
>   3cb93f390453 ("drm/amdgpu: fix use-after-free during gpu recovery")
>   b09d6acba1d9 ("drm/amdgpu: handle gang submit before VMID")
>
> from Linus' tree and commits:
>
>   1b2d5eda5ad7 ("drm/amdgpu: move explicit sync check into the CS")
>   1728baa7e4e6 ("drm/amdgpu: use scheduler dependencies for CS")
>   c5093cddf56b ("drm/amdgpu: drop the fence argument from amdgpu_vmid_grab")
>   940ca22b7ea9 ("drm/amdgpu: drop amdgpu_sync from amdgpu_vmid_grab v2")
>   1b2d5eda5ad7 ("drm/amdgpu: move explicit sync check into the CS")
>   1728baa7e4e6 ("drm/amdgpu: use scheduler dependencies for CS")
>
> from the drm tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Have you considered merging drm-fixes into drm-next, so not everyone
who consumes your trees needs to resolve the same merge conflicts?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
