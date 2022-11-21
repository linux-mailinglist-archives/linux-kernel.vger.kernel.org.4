Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EB3632B06
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiKURar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiKURan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:30:43 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8388C6945
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 09:30:42 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 46-20020a9d0631000000b00666823da25fso7784262otn.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 09:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHlfylBzHyxuRrCu5Gd5N0EZtslgI+tXadFm3xqwgLc=;
        b=GPa1o3Rcj+50tQvouk5qo5D5tCBoi+/yWwLq65jVuXNFSgRxVVPLP5nqeVsdQ6xDAV
         P343mNaxvkG83iWOVgBFwhnPT2mbkyiX4Keu0Xb85YdPLz6NFSpL+FvzA0KimKXYvCpN
         LgO1cT6yHmo9sYb0cVAdj5ARFQvxgRKoZ8dDDdzQOCHxV1DPNSYMztGo7C/38hH1GLai
         ics8varwttrOva3oHYcAj+zFs7bXM7Zlesu7y+79wyUBE2e5Nw1Wj76kDTShCcNk1ySI
         CdS77P8pfZ+V5KynFG0wL7Qlu+XiwI9bXAzKKZccMGNG2QwFjx6j9Vj1EXDcJML7gobH
         8esA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHlfylBzHyxuRrCu5Gd5N0EZtslgI+tXadFm3xqwgLc=;
        b=vFkxRyWTUfQi2lK1XXkCDARVBdBgPVVe24ZBHwg9pS6BgOM8C9dPrgq/zivrpw3hRe
         0n9DNebTgRFj0WSCn70J9GyWnjFBKZSYDNXL6Uvdna0lkJQn1ynvngEKERoVdrmdgdpg
         Mxe0cUE5XZ7ZnmYzdILC8oVqmAp6seVsQO+rFv4VziTATG9INd4VNXWwtzM6zcEABOh5
         FyXIEGf3tkDNhXpZ2HVD4vJ0d7ZjuB9N8QwrmkbcaEPVLQNuVkp642KTBKC7uixdOia7
         2GPYZaevvsEFNExpQBcAVh7ek90b2wMbpQOt4IhoEPkncic+u7gbv/cgKGlyd4dbcZub
         o7YA==
X-Gm-Message-State: ANoB5pmyHGGuvtopnM6fgod4IF+HaMTXGEPlqEr4OMKQJpPAn9SSF77a
        k3AbIgGMrft8ZAuKKIHQ9dMNQw1rTn+hTkOq+l4=
X-Google-Smtp-Source: AA0mqf4Z9t3knMWwkFNeQBsM1hIZgB6MGpcpaCCacZ2HGI+ZYi8fRJk7r1JKsInHmmIXz7YtMp3ZM7SdGnMzAGwSkfQ=
X-Received: by 2002:a9d:628b:0:b0:66c:6afa:5006 with SMTP id
 x11-20020a9d628b000000b0066c6afa5006mr3585319otk.233.1669051842247; Mon, 21
 Nov 2022 09:30:42 -0800 (PST)
MIME-Version: 1.0
References: <20221121130418.53267-1-renzhijie2@huawei.com>
In-Reply-To: <20221121130418.53267-1-renzhijie2@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 21 Nov 2022 12:30:30 -0500
Message-ID: <CADnq5_Mi+dTQOdB0QV+TNSfA+jCbFEfZ1VvRbo2GJ_NB2XKOCg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix unused-function error
To:     Ren Zhijie <renzhijie2@huawei.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@gmail.com, daniel@ffwll.ch, yusongping@huawei.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        weiyongjun1@huawei.com, amd-gfx@lists.freedesktop.org
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

Alex

On Mon, Nov 21, 2022 at 8:09 AM Ren Zhijie <renzhijie2@huawei.com> wrote:
>
> If CONFIG_DRM_AMDGPU=3Dy and CONFIG_DRM_AMD_DC is not set,
> gcc complained about unused-function :
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1705:13: error: =E2=80=98am=
dgpu_discovery_set_sriov_display=E2=80=99 defined but not used [-Werror=3Du=
nused-function]
>  static void amdgpu_discovery_set_sriov_display(struct amdgpu_device *ade=
v)
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>
> To fix this error, use CONFIG_DRM_AMD_DC to wrap
> the definition of amdgpu_discovery_set_sriov_display().
>
> Fixes: 25263da37693 ("drm/amdgpu: rework SR-IOV virtual display handling"=
)
> Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 6b48178455bc..2509341df92d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1702,11 +1702,13 @@ static int amdgpu_discovery_set_smu_ip_blocks(str=
uct amdgpu_device *adev)
>         return 0;
>  }
>
> +#if defined(CONFIG_DRM_AMD_DC)
>  static void amdgpu_discovery_set_sriov_display(struct amdgpu_device *ade=
v)
>  {
>         amdgpu_device_set_sriov_virtual_display(adev);
>         amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
>  }
> +#endif
>
>  static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *=
adev)
>  {
> --
> 2.17.1
>
