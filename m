Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A8F60128F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 17:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbiJQPOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 11:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiJQPOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 11:14:40 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE3611828
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 08:14:36 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-131dda37dddso13659146fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 08:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C0k/V94Hup9eBfg7SuZ2cCUb+ul85Fg6mc4OEJdv/0o=;
        b=IEovFP95JMex4zXL1DQ0svc0+EUKLExxkV+mGn9ZeW8ZmD+uPQk3KCWXdbi6usPiQQ
         hJwGqTiC0WcrQpvRXgjpclgnewXMVIWQC9bfvtBE0PDRO7d5LODnBzg+KwjT29k5T/zA
         H3r1ZtTOh0iNS9fKJJ+VBpDOsuFTFPfa1lwh4TnCoXFR1JdCRQ6q6fAr44drW9gYwaQW
         Gjr9QGr/M2/fJJjfzl+Jn9SECz7IxlODUjQKiuajPnSrDJ1BUJv0bu51QElJzP1Zjaok
         Jgd+8lx0onVelr7PUXSRnVy1cbGdOZT8S/giqPPaIHa6AN114Kum2v80fKztL5tqbVFM
         1UMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C0k/V94Hup9eBfg7SuZ2cCUb+ul85Fg6mc4OEJdv/0o=;
        b=VM13A2hM/9i5HBZEDAFF3kW1Cdpo/06b+lqDML05FQqFeShPLDODkXHK2wjfBNBsai
         Xwkbkx9CBB6cu2OmM3bueqkvR8nYU+NDm8OeVQCp4rj+7rPbDX1fMCW9MQ3SH3vaPn7J
         9MLK6hvgpUFXd0rwsK1fXAaTDAY3d3CAM5ofqk2qU7ZRoazqfraRd5QiPdJJIrWcYI/D
         KPHTKKObeLaWRhNKA4o6IWVNK1V58yARqsuRcRggRBd5QoGRY+Yvgr+Svym+LApw0w/j
         J3ic9l0fCZYSNd1qA9NliTRncn+Vay8I+ok4IR4nNQz9yuQHFOmgruz4uRiFn9a6mHY0
         prnw==
X-Gm-Message-State: ACrzQf1osrcrb33ycglUt+ddUp7Uits46uSfaimxbUtYD0ZR9kPxkZT7
        dAg7Ycro4bcEMdApBsPjxUA4U0UcE3SNPDtZqf+4D08r
X-Google-Smtp-Source: AMsMyM4pTI888ntuHyVZaruicFUJcVFq9AyzsZI2hRj+fKOygSc1PA8aUQ27gw/7RbbP5lHotTjyLcWG9kyjTxWFX6k=
X-Received: by 2002:a05:6870:a7a4:b0:136:7c39:979e with SMTP id
 x36-20020a056870a7a400b001367c39979emr6111763oao.96.1666019675897; Mon, 17
 Oct 2022 08:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <20221017090352.117843-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20221017090352.117843-1-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 17 Oct 2022 11:14:24 -0400
Message-ID: <CADnq5_PFgg=JhCzii=798zXmfjtatCWhWbYuMhDBctkmW6cY8g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Remove the unused function amdgpu_ucode_print_imu_hdr()
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     alexander.deucher@amd.com, Xinhui.Pan@amd.com,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, christian.koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 5:04 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> The function amdgpu_ucode_print_imu_hdr() is defined in the amdgpu_ucode.c
> file, but not called elsewhere, so delete this unused function.
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c:129:6: warning: no previous prototype for function 'amdgpu_ucode_print_imu_hdr'.
>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2416
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 13 -------------
>  1 file changed, 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index dd0bc649a57d..148cc2d475c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -126,19 +126,6 @@ void amdgpu_ucode_print_gfx_hdr(const struct common_firmware_header *hdr)
>         }
>  }
>
> -void amdgpu_ucode_print_imu_hdr(const struct common_firmware_header *hdr)
> -{
> -       uint16_t version_major = le16_to_cpu(hdr->header_version_major);
> -       uint16_t version_minor = le16_to_cpu(hdr->header_version_minor);
> -
> -       DRM_DEBUG("IMU\n");
> -       amdgpu_ucode_print_common_hdr(hdr);
> -
> -       if (version_major != 1) {
> -               DRM_ERROR("Unknown GFX ucode version: %u.%u\n", version_major, version_minor);
> -       }
> -}
> -
>  void amdgpu_ucode_print_rlc_hdr(const struct common_firmware_header *hdr)
>  {
>         uint16_t version_major = le16_to_cpu(hdr->header_version_major);
> --
> 2.20.1.7.g153144c
>
