Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC61A6BF241
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 21:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjCQUSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 16:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjCQUSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 16:18:18 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337574615D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:18:15 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id y184so4662535oiy.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679084294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSMRygJzH6vE62Q2mHcoZV1+MU3Mf7BqCz0sgRtV3Yw=;
        b=g8vlCfiZNtHXNz5dLm2xZ3ScxKdSlL5Q5bZ/mZAdPhO8pg5IFz0ALUWgEXQl97+zMB
         jyOeAcDiX9XrtYNdPvPMcpe0Cd+MfJFkcJaY4V9WgFXZklIo0w1URF3A81OkzA7HjfL1
         8BPyt9ATXw00zGSFPzKZNjJY18EoyWvcFS3mWiN1gJF2ix4hK5AzzLunuYz4xdUgrUCB
         gWrbni56ZpWkNb73E4fSixFnJcRPMojGV7yUtEtYcUKTO1oeYnfqew9DpUK1Jm+XuMbT
         bzJCghUeCYaIR/ugMh8N/iJpWEzibWLlKu/QhCX/bkYhh7T2SOizKeDx9I2q9Dwhwy1b
         Z+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679084294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XSMRygJzH6vE62Q2mHcoZV1+MU3Mf7BqCz0sgRtV3Yw=;
        b=q5pYArVYT18jOUz6+g5lxL+IWnY5g5KoAqKJn4mkN7zHZ8IobLff7SQQAvVF5+MIZe
         p0Mrq1yyjxdzkU3f+7ExDxsElJjOKoy2UZfh6E/D1NsN4oYmTaHY9ofklN5m9Rg5Er9q
         pIpdiPm9eKEXuxm/gkfWFUVhSFp5J1oaw0q7RooMS29t/d3faVBQ/iVt7/iMlSgVEUkM
         6LBGZvPSJT1zX++W8DwRbnCWu6IHQOVsCIhEyjWSAJKLlbxMnMD0f9m7okrFv055GefR
         m6DQVfCZMyrx703li7Oa+clTya3i6plWk5RbWYWvQlbA36c7YJ225vKFV2QX3nk4Ful5
         tXAg==
X-Gm-Message-State: AO0yUKWlm4BTnChuWVEpPISXQDmC4AVuDXWs1VdEKvD8D6j2stwzG/0M
        ck/g503J6kcjyPOiSPWc4TdCxpPnMSFKM92BRqU=
X-Google-Smtp-Source: AK7set/ivwdewzaoPiq9B8mDQNenr6n+DI+0+c4st0V6joQZHeoxSoLrraA4/PTSYQt82J595tpbvC4XvDslpPaIc/U=
X-Received: by 2002:a05:6808:498:b0:384:2b09:45f7 with SMTP id
 z24-20020a056808049800b003842b0945f7mr1592391oid.4.1679084293926; Fri, 17 Mar
 2023 13:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230317081718.2650744-1-lee@kernel.org> <20230317081718.2650744-14-lee@kernel.org>
In-Reply-To: <20230317081718.2650744-14-lee@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 17 Mar 2023 16:18:02 -0400
Message-ID: <CADnq5_PEhRovUNGCTFHNuUswWt1_qz4gy8+8kUJZeyFaKFzuZQ@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxMy8zN10gZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Vjb2RlOiBSZW1vdg==?=
        =?UTF-8?B?ZSB1bnVzZWQgZnVuY3Rpb24g4oCYYW1kZ3B1X3Vjb2RlX3ByaW50X2ltdV9oZHLigJk=?=
To:     Lee Jones <lee@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
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

Applied.  Thanks!

On Fri, Mar 17, 2023 at 4:22=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c:129:6: warning: no previous pr=
ototype for =E2=80=98amdgpu_ucode_print_imu_hdr=E2=80=99 [-Wmissing-prototy=
pes]
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 13 -------------
>  1 file changed, 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ucode.c
> index 380b89114341d..a7bffd24ceaf3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -126,19 +126,6 @@ void amdgpu_ucode_print_gfx_hdr(const struct common_=
firmware_header *hdr)
>         }
>  }
>
> -void amdgpu_ucode_print_imu_hdr(const struct common_firmware_header *hdr=
)
> -{
> -       uint16_t version_major =3D le16_to_cpu(hdr->header_version_major)=
;
> -       uint16_t version_minor =3D le16_to_cpu(hdr->header_version_minor)=
;
> -
> -       DRM_DEBUG("IMU\n");
> -       amdgpu_ucode_print_common_hdr(hdr);
> -
> -       if (version_major !=3D 1) {
> -               DRM_ERROR("Unknown GFX ucode version: %u.%u\n", version_m=
ajor, version_minor);
> -       }
> -}
> -
>  void amdgpu_ucode_print_rlc_hdr(const struct common_firmware_header *hdr=
)
>  {
>         uint16_t version_major =3D le16_to_cpu(hdr->header_version_major)=
;
> --
> 2.40.0.rc1.284.g88254d51c5-goog
>
