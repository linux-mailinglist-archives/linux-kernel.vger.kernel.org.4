Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E998E70C1F9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjEVPJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjEVPJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:09:00 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6A4CA
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:08:59 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-55254414406so1685247eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684768139; x=1687360139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zEQv3FIbNS1PaTN4avSONv8aFWRzp4oZp63VmdRfIQ=;
        b=APxy0p2J1/Z9SeVZDSFJRP7VppH2mbN9g1a/A+OCaoF1awvld8+JcU3RndpAbDoGvw
         rlWlQcqxw5nbtDVdCMt0IPNiavwuDHKx37xbTu8bs4Zn+SIE0eWt4OnKpGPCyyhgDppn
         X+gs3+Kc/G+uNygq8Sc/vu6h5PKVXKcD6QzTmkc2DpANpfixnQn2+IMXhrwu5Dic+vyQ
         hv/4oPqypp/Jvww2ra1CRNWOHmvPB0/T6MM4DaLrXS+Ku6uqh7eMTeWZfgJ/HPwYsNJV
         fTn3aKfUqH/A0eWJZcVoXfMpjIvSnqRz2mR6EDbXmM5XqrVUDcdUMbXSMhbhj9B+gGyM
         1EqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684768139; x=1687360139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zEQv3FIbNS1PaTN4avSONv8aFWRzp4oZp63VmdRfIQ=;
        b=Z2GnuNbbUphftFXZBI63epIc0I31Bywdjb7L8+AR/lE9+z9BVrVU0uxLsch6Dvv7yg
         4g5l7bsAp6KfinH5kOxUYyDBOpnSnoav6sWjXhqmz4aq9llut2kmGZAJnMbyLAGqmaeN
         wjuMo/webIjQNbtJ7zqUgf8tgljY0tBMfdEkDtkGoNEJkcZM3DrW2Z0jDYTSJMZoMT/8
         xNaZzIjJvxkmkkGapGFZy18cP6GE0qYYWHO4M/DltmK5rsRR6FIMMYt+l8p6VH1FxHci
         Q78RweYqC5t/NHur38F4Jee9N/labwY+NNAZtupWukWtdA1wXFf4c5L4gDeMzWmADJaS
         X4kQ==
X-Gm-Message-State: AC+VfDyYq67cOnl8T+mivqZct/lKWKMiwrNeK350c3zL8RknRWlpRXq+
        XhMhdUI2o6Q73rtxl8YP6tdp5kZB/UVWgKA7VC0=
X-Google-Smtp-Source: ACHHUZ4ExIpEUZerP6mCCiZ9lUpYbGZ/+E9RYgK/eNnvHmmMatIIjmZ0rZ09JHcdKkuRDXO7nEzde1gvbpvsjleXhGs=
X-Received: by 2002:a4a:924d:0:b0:552:4bca:a9df with SMTP id
 g13-20020a4a924d000000b005524bcaa9dfmr5154196ooh.3.1684768138804; Mon, 22 May
 2023 08:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230522115047.1169839-1-arnd@kernel.org> <20230522115047.1169839-5-arnd@kernel.org>
In-Reply-To: <20230522115047.1169839-5-arnd@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 22 May 2023 11:08:47 -0400
Message-ID: <CADnq5_Mg1BZ9PKHNtFdk4F2Ny7rQo8Tr2PA93MF-yF811d7EwA@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm/amdgpu: fix acpi build warnings
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lijo Lazar <lijo.lazar@amd.com>, Le Ma <le.ma@amd.com>,
        Tim Huang <tim.huang@amd.com>,
        Jingyu Wang <jingyuwang_vip@163.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bokun Zhang <Bokun.Zhang@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>
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

Applied the series.  Thanks!

Alex

On Mon, May 22, 2023 at 7:51=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Two newly introduced functions are in the global namespace but have no pr=
ototypes
> or callers outside of amdgpu_acpi.c, another function is static but only =
has
> a caller inside of an #ifdef:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:902:13: error: no previous proto=
type for 'amdgpu_acpi_get_node_id' [-Werror=3Dmissing-prototypes]
> drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:928:30: error: no previous proto=
type for 'amdgpu_acpi_get_dev' [-Werror=3Dmissing-prototypes]
> drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:860:33: error: 'amdgpu_acpi_get_=
numa_info' defined but not used [-Werror=3Dunused-function]
>
> Avoid the warnings by marking all of them static and ensuring that the co=
mpiler is
> able to see the callsites.
>
> Fixes: c34db97b8217 ("drm/amdgpu: Add API to get numa information of XCC"=
)
> Fixes: 1f6f659d06e1 ("drm/amdgpu: Store additional numa node information"=
)
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_acpi.c
> index 873532c4adbe..1dbcd0e62478 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -899,13 +899,15 @@ static struct amdgpu_numa_info *amdgpu_acpi_get_num=
a_info(uint32_t pxm)
>   *
>   * Returns ACPI STATUS OK with Node ID on success or the corresponding f=
ailure reason
>   */
> -acpi_status amdgpu_acpi_get_node_id(acpi_handle handle,
> +static acpi_status amdgpu_acpi_get_node_id(acpi_handle handle,
>                                     struct amdgpu_numa_info **numa_info)
>  {
> -#ifdef CONFIG_ACPI_NUMA
>         u64 pxm;
>         acpi_status status;
>
> +       if (!IS_ENABLED(CONFIG_ACPI_NUMA))
> +               return_ACPI_STATUS(AE_NOT_EXIST);
> +
>         if (!numa_info)
>                 return_ACPI_STATUS(AE_ERROR);
>
> @@ -920,12 +922,9 @@ acpi_status amdgpu_acpi_get_node_id(acpi_handle hand=
le,
>                 return_ACPI_STATUS(AE_ERROR);
>
>         return_ACPI_STATUS(AE_OK);
> -#else
> -       return_ACPI_STATUS(AE_NOT_EXIST);
> -#endif
>  }
>
> -struct amdgpu_acpi_dev_info *amdgpu_acpi_get_dev(u16 bdf)
> +static struct amdgpu_acpi_dev_info *amdgpu_acpi_get_dev(u16 bdf)
>  {
>         struct amdgpu_acpi_dev_info *acpi_dev;
>
> --
> 2.39.2
>
