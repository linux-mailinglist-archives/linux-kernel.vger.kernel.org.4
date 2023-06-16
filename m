Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6A07331A5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345479AbjFPMxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345482AbjFPMxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:53:33 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81C635A7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:53:31 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-55b38fc0c70so440710eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686920011; x=1689512011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2DJZHQdpL3IJvZ92o0uwtsAvPZ4lFxeVkbvKVjLF2k=;
        b=G2jhokx/Sp5VaGnIqNNzlNJglrUvkLJZaIecSn9/uufexFl4+Ee3VdCfVXxUa9RPS8
         gkRFKWnnZfbsXDlRtFE8/1fYQPXmebqpe5r1H2UsWSqUSfeUkjabsRXRK6itzy6GcxGk
         5yKcFtFa+DutHhgH0msvkJR62Og7HQldi7IunNtle3MiEd5lMNhfot09q3vbL7yWXLWC
         DdUOm+v1Hdy6j0c/NBcj7uj5ZNipYeZ3LHYWiNAr7gQWXVZyF6kJz8IzeMNIdqG6OZ4i
         fTH0ODq6T02jBO94XZWO0epnPg4RKVDpsSES0AzAFxdTxQzJKtkUffPwf5NNSHJXzHiy
         G5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686920011; x=1689512011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2DJZHQdpL3IJvZ92o0uwtsAvPZ4lFxeVkbvKVjLF2k=;
        b=fRIT0rs/nvUoaVxFp/FD2c+I0pUIq/lVNV8xw5KcPz50Esnp+cqqmc+5/91lCbqkwZ
         y+C0OG8NwEXuARzIlDC3TTtpiC6+0wo9GaUO/S+ww3nLZkQWMVdOH6gDP3uTPa3glJsa
         jyN2Ko1jjALDqLRyk87rfRg6KoTCKywvw7bZtk6u9szzSZsJ69PBTGsj/NjTnC/cgfoV
         lcemSzKNHekGbQROc+YtRC7B+lv0OysOD/U351lUB0SVLzPOgKTozQcrJ6uXVS/GVyiK
         r3XQ3giI4NklCW862C9cNNoe9GMGX6NLATWzy10QSDO2oT297danYy5mWtCtsSKkvpO7
         hmGw==
X-Gm-Message-State: AC+VfDzMuu7AAc0M3uhk1IUZh557JKoXg4ZcJ8TP9RTXsKAA/H7P6xnr
        HgCHsDZDdWifDZvEx0mC12gI3MG4R/nelzsWh7M=
X-Google-Smtp-Source: ACHHUZ5NBPESqSOu9Tlh+n7Ja0S8R1Op1Kj+waIDTv5fiswEzzwvfI2N6skIa+NWpULVJfDnOVfXGXPSNksyloMfkrk=
X-Received: by 2002:a4a:a2c3:0:b0:558:a3c5:86cd with SMTP id
 r3-20020a4aa2c3000000b00558a3c586cdmr1734874ool.6.1686920011040; Fri, 16 Jun
 2023 05:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230616121116.1031336-1-juerg.haefliger@canonical.com>
In-Reply-To: <20230616121116.1031336-1-juerg.haefliger@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 16 Jun 2023 08:53:20 -0400
Message-ID: <CADnq5_Nnr=BO2y3O3_x+sX-93CtY7g52m9DHva7WWqeeO5xqMA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add missing MODULE_FIRMWARE macro
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Bokun.Zhang@amd.com, lijo.lazar@amd.com,
        linux-kernel@vger.kernel.org, YiPeng.Chai@amd.com,
        mario.limonciello@amd.com, Likun.Gao@amd.com, Hawking.Zhang@amd.com
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

On Fri, Jun 16, 2023 at 8:11=E2=80=AFAM Juerg Haefliger
<juerg.haefliger@canonical.com> wrote:
>
> Add the missing MODULE_FIRMWARE macro for "amdgpu/fiji_smc.bin".
>
> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 5c7d40873ee2..1f83a939d641 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -92,6 +92,7 @@ MODULE_FIRMWARE("amdgpu/picasso_gpu_info.bin");
>  MODULE_FIRMWARE("amdgpu/raven2_gpu_info.bin");
>  MODULE_FIRMWARE("amdgpu/arcturus_gpu_info.bin");
>  MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
> +MODULE_FIRMWARE("amdgpu/fiji_smc.bin");

This is already specified in smumgr.c.

Alex

>
>  #define AMDGPU_RESUME_MS               2000
>  #define AMDGPU_MAX_RETRY_LIMIT         2
> --
> 2.37.2
>
