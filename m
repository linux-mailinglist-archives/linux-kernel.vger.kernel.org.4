Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0445A601C90
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiJQWoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiJQWoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:44:04 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D4875FF7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 15:44:03 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 129so11727762pgc.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 15:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8T9R90NQr0Cus17IiTSAkyfNN/tN1vR67SiHbRuEPI=;
        b=U2N8UnthPtqfKpR8N9pAjr8gPmCblQJD92zioxeGUg0fl8+yjDCMjfD6zMOO/0v3VZ
         v4e9j8lUGszk1F0sxLkQ1OLHVl692mVKtG+ONjc5J+2LAGvNad8zGpHHoG3QbbBjEEQw
         w6YGf71fhPQdZJ7aZy20CV0WoLdzeROnm/DDfxK04pOIJo83y76ALsWC4HXBeDsIPvmR
         sfktx0UYQbYqFXpVHqqW2GNVE95VDn73P2ptaFUqJfoZKiEfCk8Nrps91kIv7yV5gxYL
         v0SheJdFEL+/OB0gq+pqO8tCN/vkB3IdkSuiWIA2RC3KGLXyeaXaUgWXtqWhPHTX/h1o
         stjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8T9R90NQr0Cus17IiTSAkyfNN/tN1vR67SiHbRuEPI=;
        b=h3jA61zttG9O0vIfA9ZlsjKT3QoSLFSE/DYogTSejUXM/3gkXqwv/luCkpbAurnxpD
         MKhBLoqWvrGUKOcHFCAzQ/XN6DR3kxoAP+taNaxdFyLobUhlb6Bz2jXA31RIOO8iiip3
         ySbaSQRwr9uEcDX2Hly5coV+rpxTiZ0WJ2pCJdZEcqWk2NwJ36Dd2R3NTZLbpTF2ju/0
         WuMeCiIUJpmj/gQwkU2c1le3nUgmezjB0AW6d2qdrM1dftCPgWasUPN7w43D7v9HpbNi
         cI1oryc8Tu2fwKwM4vIU4UZZim97fZvbKtPrWc/F07tILhMkXo1233cXgag8A+0LJ0fY
         pUUg==
X-Gm-Message-State: ACrzQf2KWwXS1hTaFyBAUXUzQJmHvC7+PbhWH9yxu20lMLfOBGBkNDk2
        35GcA0PvVics7Ob7PDQfYYo+6S1Q3idm4vmps/M0ECk1C+anO4NI
X-Google-Smtp-Source: AMsMyM79IeYRrUMTY0HLvtqCc2++5ANt+Zj8uvyOpxR0fR1UjDNuT8HK9/IMJyA2Zo8fWIUbzS5QGag+bo/+rF4c3Cw=
X-Received: by 2002:a63:fd4f:0:b0:45f:d7ef:9f94 with SMTP id
 m15-20020a63fd4f000000b0045fd7ef9f94mr35647pgj.137.1666046642898; Mon, 17 Oct
 2022 15:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsNVp=R5zC9B3PXWJ5nddtt3gkRzDsAsRKvhXq7exGjSAg@mail.gmail.com>
 <f3bc34e1-0eaf-84ef-486e-b7759e60b792@amd.com> <CABXGCsOD+tDdFcM37NP_1nS9eLym7qC=jUQy3iqYkc1m2iQgxw@mail.gmail.com>
 <0d5f66d8-9852-b6a9-0e27-9eb9e736d698@amd.com> <CABXGCsPi68Lyvg+6UjTK2aJm6PVBs83YJuP6x68mcrzAQgpuZg@mail.gmail.com>
 <eef04fc4-741d-606c-c2c6-f054e4e3fffd@amd.com> <CABXGCsNNwEjo_dvWJL7GLULBPy+RmwsC9ObpowR_M1nQ3fKt3g@mail.gmail.com>
 <4d0cbb79-4955-a3ed-4aa2-7f6cdaa00481@gmail.com> <CABXGCsP19VFRgTx5yGn68iCK3NxPxi_b9MTq=AmHtFPv9xR5sA@mail.gmail.com>
 <675a2d33-b286-d1d0-e4e7-05d6516026c0@gmail.com> <CABXGCsOqrB5zPFCeLw-VQjePikwDq4EKFQGc9hbOb5f7tGLDgg@mail.gmail.com>
 <8e54ec49-09da-f345-35cd-430712f5a6ad@gmail.com>
In-Reply-To: <8e54ec49-09da-f345-35cd-430712f5a6ad@gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Tue, 18 Oct 2022 03:43:51 +0500
Message-ID: <CABXGCsPXcG4BUDr8AtmtWHZh7kTw6pFsSedhxiEcuej5S0oJ7Q@mail.gmail.com>
Subject: Re: [Bug][5.18-rc0] Between commits ed4643521e6a and 34af78c4e616,
 appears warning "WARNING: CPU: 31 PID: 51848 at drivers/dma-buf/dma-fence-array.c:191
 dma_fence_array_create+0x101/0x120" and some games stopped working.
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
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

On Wed, May 11, 2022 at 5:01 PM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
>
> We have implemented a workaround, but still don't know the exact root cau=
se.
>
> If anybody wants to look into this it would be rather helpful to be able
> to reproduce the issue.
>
> Regards,
> Christian.

I see that issue was returned after this commit
dd80d9c8eecac8c516da5b240d01a35660ba6cb6 is the first bad commit
commit dd80d9c8eecac8c516da5b240d01a35660ba6cb6
Author: Christian K=C3=B6nig <christian.koenig@amd.com>
Date:   Thu Jul 14 10:23:38 2022 +0200

    drm/amdgpu: revert "partial revert "remove ctx->lock" v2"

    This reverts commit 94f4c4965e5513ba624488f4b601d6b385635aec.

    We found that the bo_list is missing a protection for its list entries.
    Since that is fixed now this workaround can be removed again.

    Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
    Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  | 21 ++++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 -
 3 files changed, 6 insertions(+), 18 deletions(-)

The games Forza Horizon 4 and Cyberpunk 2077 again hangs at start.


--=20
Best Regards,
Mike Gavrilov.
