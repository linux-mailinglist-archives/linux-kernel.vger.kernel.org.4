Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750B06BF2A0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 21:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjCQUdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 16:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjCQUdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 16:33:19 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B900DE1C90
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:32:57 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-17aeb49429eso6651671fac.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679085176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RfMN7DRIcyqsTtzN8E9y+T6KdTmfa65N2EjbDjm3zY=;
        b=FCW5yVym72MxBW25JQav1TzIabA1cYrb4CyrTIayWtwSGPt0m9OAV/IHKHgXY6qgoQ
         IKtZoU1qsTr10zUsRONDgaRZcNdWQokX39v2ufOerYGbHjuqid7fsnXwccIWtXmeyLrL
         WYJx8euxaY9CEJ6Q8tNGxc7EmFWCIkBunhQfVgx4tNFBQlu/fnx8BdK+dc/A8gk/V50v
         1rIJ5TbaT7vQqzLwNBRgqAMyasbNnmE2TrQlCgqMpquTtrZFgi1gqdMhambWqdFGYjG8
         OfRce4S/DzqVUCZhQXUlkVLrlBLwVrSgr9HRr0koylzLx8FNvsstjXI/LFq5VpUsm8Zh
         yErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679085176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/RfMN7DRIcyqsTtzN8E9y+T6KdTmfa65N2EjbDjm3zY=;
        b=ouFXhUu8cLZBXvxvW4gQ0HzTRhcVBrWrRi5ZVCU8XGQFkODLFCjtdTOkGkJncyHDvu
         i1C6BQ6oj3vsnKp8bPGMfxDusvihi8rNdvg3pjs2cuAAyuh+JdG6Bfe0GScHehke2Blu
         CZEwb/V2EpkEyhIqaBzkekU11CLKPHWRQb0USvn/i1UJKGt+Z41aMa7d8LkURKr+/qXr
         fj+jRT2O8eUhP4NGhwrLk5JPzSLqXycjPfikt4pCffp5ly7jK3DQPjvnO63c70YXM0pD
         bi21BnGlmd4tdrIbNBMuiv5T+heueyme2EubEV57poai9dkcP7KD/C8z3qmDQWlXbWoR
         1h1w==
X-Gm-Message-State: AO0yUKVYh1EoG9QkiXZ4y/fc+ArDQc3HbEIibDSwelwNUv3RguRLJMRY
        A/HHds+ZzkyImP01+s+KaWfYk7epMfzshMQB1XQ=
X-Google-Smtp-Source: AK7set9pwElEd/aUD3iyT/dmmI+xSHtUnpnvu7q5FwEC9FpCXyCDiYObJzPkAJO7vw6nJFli+VEKTOKzZN/kH6PIIXg=
X-Received: by 2002:a05:6871:48c6:b0:17a:a999:e87e with SMTP id
 qf6-20020a05687148c600b0017aa999e87emr337853oab.3.1679085176245; Fri, 17 Mar
 2023 13:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230317081718.2650744-1-lee@kernel.org> <20230317081718.2650744-27-lee@kernel.org>
In-Reply-To: <20230317081718.2650744-27-lee@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 17 Mar 2023 16:32:45 -0400
Message-ID: <CADnq5_OD8o=zEndGqyEPEpgtW9b3xRh=62haLZOfEFMARFRJ6A@mail.gmail.com>
Subject: Re: [PATCH 26/37] drm/amd/display/amdgpu_dm/amdgpu_dm_helpers: Move
 SYNAPTICS_DEVICE_ID into CONFIG_DRM_AMD_DC_DCN ifdef
To:     Lee Jones <lee@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, Leo Li <sunpeng.li@amd.com>,
        David Airlie <airlied@gmail.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Fri, Mar 17, 2023 at 4:23=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.c:48:2=
2: warning: =E2=80=98SYNAPTICS_DEVICE_ID=E2=80=99 defined but not used [-Wu=
nused-const-variable=3D]

CONFIG_DRM_AMD_DC_DCN was recently dropped so this patch is no longer relev=
ant.

Alex


>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index 330ab036c830f..a8904184673f6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -44,9 +44,6 @@
>  #include "dm_helpers.h"
>  #include "ddc_service_types.h"
>
> -/* MST Dock */
> -static const uint8_t SYNAPTICS_DEVICE_ID[] =3D "SYNA";
> -
>  /* dm_helpers_parse_edid_caps
>   *
>   * Parse edid caps
> @@ -703,6 +700,9 @@ static void apply_synaptics_fifo_reset_wa(struct drm_=
dp_aux *aux)
>         DC_LOG_DC("Done apply_synaptics_fifo_reset_wa\n");
>  }
>
> +/* MST Dock */
> +static const uint8_t SYNAPTICS_DEVICE_ID[] =3D "SYNA";
> +
>  static uint8_t write_dsc_enable_synaptics_non_virtual_dpcd_mst(
>                 struct drm_dp_aux *aux,
>                 const struct dc_stream_state *stream,
> --
> 2.40.0.rc1.284.g88254d51c5-goog
>
