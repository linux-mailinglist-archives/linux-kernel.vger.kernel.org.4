Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6674470FA1B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 17:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbjEXP3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 11:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbjEXP3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 11:29:00 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2389DF5
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:28:57 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-396140d25e0so271143b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684942136; x=1687534136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5MQz4tRtkG+kSAOx+7cDjXH3GlxLpEVvkOR0cGeMbw=;
        b=CKW2NTF6Voh4yCMud+Z9KU6wa2a3nyRCotPLtem283S8sHvDjQcHT8DaACbLBM34AB
         u3Do1boA3IpAoWMFpuzvdgS406jmI7Gej8+CnrWPYcBCurgHrRJzkx7sqncgq9bHmKB9
         o6vbxenD89yepUE3ZFj4jVSPRzcQ183xWtQoK5l2JX/0MmGB1JprLbMteiV8n5yVmooc
         rZsLu83MzpBxB77Y541sBwI/27VJtN3TROQZU4bnllY/D4n61J8+2IgSI3VbL2hwizf/
         +ddvxDb9hMA9t8K8n+rs5514YlPd+9kHqjfrraBu8Gjs+R824mt/1Zy5b9btLL5Q/3jN
         k9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684942136; x=1687534136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5MQz4tRtkG+kSAOx+7cDjXH3GlxLpEVvkOR0cGeMbw=;
        b=N9SROZa1opAgDLhPmq7t+HQqAwVyXXuroYl2NHb4rtACE0wtuZC8WaI+woxIocQrIz
         1WaIh5VlvdlEDXseWykK+r6bHSiaNRdXQEfz+IukKMhTgjajHeJCJO69pbUIxvPs03Pw
         O+ZU2MZMF+DhMj3S9f0Lui8UiVgam/uu6MVNZlM0v//WDGiemAbZP0kywul2t6eKrF+Q
         sNnzchJZvjtcKxtkoGNyYzcHdrzFcjvVq6JwGpX6BOzi1t2ipWx/AfYNL/6TslL4fcVk
         DHRn7y6GtgotNgnESVcN4zpcOKdqS5DjDNTDo1rXK4sE0wSQi5YBbuupMZyIKTDJmR65
         sGEg==
X-Gm-Message-State: AC+VfDzB4nS2z5cow5fpf+m4e5XGU56vXWjkOVX/Mp37Ure7g57r0dKP
        15oZFQdx/jDQjihOS6i8J2++MCjUii5jRibye8Ef8bki
X-Google-Smtp-Source: ACHHUZ7uw0PRxGdf3aDPz7JxHgbvzaWS6kWcooJnGWj444daIvvFiBZAFV48kI0dDl2rfNgYCiGCMryqK5Uhs2taraU=
X-Received: by 2002:aca:3cd6:0:b0:392:31fe:cd19 with SMTP id
 j205-20020aca3cd6000000b0039231fecd19mr10464992oia.0.1684942136452; Wed, 24
 May 2023 08:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <646e2c58.170a0220.4f979.2ba7@mx.google.com>
In-Reply-To: <646e2c58.170a0220.4f979.2ba7@mx.google.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 24 May 2023 11:28:45 -0400
Message-ID: <CADnq5_N7W8_c6tcFDkEEM_shXr0GJV+YJfJ8y4YC=2ufRHRX5g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Enable GCVM_CONTEXT1_CNTL after page table
 addr is set.
To:     ghostfly233 <ghostfly23333@gmail.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, daniel@ffwll.ch, airlied@gmail.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
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

On Wed, May 24, 2023 at 11:25=E2=80=AFAM ghostfly233 <ghostfly23333@gmail.c=
om> wrote:
>
> In gfxhub_v2_1_setup_vmid_config(), the GCVM_CONTEXT1_CNTL reg is
> enabled before related GCVM_CONTEXT1_PAGE_TABLE_START_ADDR and
> GCVM_CONTEXT1_PAGE_TABLE_END_ADDR regs are written, which may
> cause undefined behavior.
>
> This patch enable GCVM_CONNTEXT1_CNTL after page table addresses are set,
> so that it can ensure no undefined behavior will happen.

Please update all of the gfxhub and mmhub files with this change.

Alex

>
> Signed-off-by: Zibin Liu <ghostfly23333@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/a=
md/amdgpu/gfxhub_v2_1.c
> index 4aacbbec31e2..791afc8e9e85 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> @@ -297,7 +297,7 @@ static void gfxhub_v2_1_setup_vmid_config(struct amdg=
pu_device *adev)
>
>         for (i =3D 0; i <=3D 14; i++) {
>                 tmp =3D RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL, =
i);
> -               tmp =3D REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CON=
TEXT, 1);
> +               tmp =3D REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CON=
TEXT, 0);
>                 tmp =3D REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE=
_DEPTH,
>                                     adev->vm_manager.num_level);
>                 tmp =3D REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
> @@ -333,6 +333,9 @@ static void gfxhub_v2_1_setup_vmid_config(struct amdg=
pu_device *adev)
>                 WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_END=
_ADDR_HI32,
>                                     i * hub->ctx_addr_distance,
>                                     upper_32_bits(adev->vm_manager.max_pf=
n - 1));
> +               tmp =3D REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CON=
TEXT, 1);
> +               WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL,
> +                                   i * hub->ctx_distance, tmp);
>         }
>
>         hub->vm_cntx_cntl =3D tmp;
> --
> 2.34.1
>
