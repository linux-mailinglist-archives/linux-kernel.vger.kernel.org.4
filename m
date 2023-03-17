Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6DB6BF2DA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 21:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjCQUlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 16:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCQUlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 16:41:44 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203322C644
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:41:43 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id w21-20020a9d6755000000b00698853a52c7so3525032otm.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679085702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfgcC/EbPu+ua6yDvUlTRHWlKkZNrCbAkKPEGXwikuI=;
        b=c18Tqa1zOd/o7z4A9WdW9+PmQDslW4G4YvMD30YdaQ7rRmNxBYBzx7KnFkmsc3Rd/X
         f0vhzOXNIY9aPKeWrY61QXH13zoH148CbovgQOK6L0oUZqf6VhmHMqHqksin9BFhnBHl
         eoup//n2VTIZeUa9y1nX8RXHr0cZZwB6/OCel28IRwbyTGgGe+MU5wdZ0isgPLkVLy7w
         RacaW8iW5dPJrW++PFE7EnCieNtPG3BOFsKQcZui23BkZvSWsjbl2OFOCVLLqgIV2Kw4
         zR0J1oQ8SvtoZgb3gxWvarjo50VzMP8m5ymGh4EH0Z4rpy1knvY5hQaCgE3lSqoLPySy
         lh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679085702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfgcC/EbPu+ua6yDvUlTRHWlKkZNrCbAkKPEGXwikuI=;
        b=v7UDspHbjsfP2IrsBJXToEAYd/+5LbGwfzeXSjvYxPR+2mnOZAJlKux+VdHGCud2Br
         oEd+cRX/Ngzt9pQ35FHX0mZsTmeIM8XKpcec/HUWLzqNvvbmZtW8t/CiLoLBfPKSP6hl
         GQXmdoWQD0blolXzK8xjrPwbozNyl3Y98jr7mjUE5FcbYBeAOQiy8ZRcOdL/Ytl4vXWo
         67rFVGBIgIsehIv25ndJn2Ta8WRe495YRkoJi30PRrmXi9ZDk7qq6YD36cXAnaEsNO1t
         RjTwYLBAu9jZz52guY83UX5IcBkHhsjpvlm+3f4TTqW9G9sMWxCCr1Q20on5uySfqpNB
         bgQQ==
X-Gm-Message-State: AO0yUKVMiNnD5YySaWErnidvDi5ZlmpR3ZGmevdum6QPwIyOTEbCTzdo
        GeD4tP3wnA4Id2b+lRP8BtYZhG6FCpRnzdLpJ3w=
X-Google-Smtp-Source: AK7set8CqKuf/ulPOfBWE098fleAs19MAIbLvZv/D7H/MRyW2pFivWOvVXTWk3dGoLA6NMn+GK9iEDRd0TmwQ+gVYcE=
X-Received: by 2002:a9d:4802:0:b0:69a:b32c:9882 with SMTP id
 c2-20020a9d4802000000b0069ab32c9882mr298708otf.3.1679085702531; Fri, 17 Mar
 2023 13:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230317081718.2650744-1-lee@kernel.org> <20230317081718.2650744-33-lee@kernel.org>
In-Reply-To: <20230317081718.2650744-33-lee@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 17 Mar 2023 16:41:30 -0400
Message-ID: <CADnq5_OPSz7mv3MHXY559pe_We45-C+Au4mgSoBEK5bcoaMp+g@mail.gmail.com>
Subject: Re: [PATCH 32/37] drm/amd/display/dc/link/protocols/link_dp_capability:
 Remove unused variable and mark another as __maybe_unused
To:     Lee Jones <lee@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, Leo Li <sunpeng.li@amd.com>,
        David Airlie <airlied@gmail.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Wenjing Liu <wenjing.liu@amd.com>,
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

Applied.  Thanks!

Alex

On Fri, Mar 17, 2023 at 4:23=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> =E2=80=98ds_port=E2=80=99 is clearly not used anywhere and =E2=80=98resul=
t_write_min_hblank=E2=80=99 is
> only utilised when debugging is enabled.  The alternative would be to
> allocate the variable under the same clause as the debugging code, but
> that would become very messy, very quickly.
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_capabili=
ty.c: In function =E2=80=98dp_wa_power_up_0010FA=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_capabili=
ty.c:280:42: warning: variable =E2=80=98ds_port=E2=80=99 set but not used [=
-Wunused-but-set-variable]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_capabili=
ty.c: In function =E2=80=98dpcd_set_source_specific_data=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_capabili=
ty.c:1296:32: warning: variable =E2=80=98result_write_min_hblank=E2=80=99 s=
et but not used [-Wunused-but-set-variable]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Wenjing Liu <wenjing.liu@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  .../gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c  | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capabi=
lity.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> index e9bcb35ae185a..51427f5081642 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> @@ -1284,7 +1284,7 @@ bool dp_overwrite_extended_receiver_cap(struct dc_l=
ink *link)
>  void dpcd_set_source_specific_data(struct dc_link *link)
>  {
>         if (!link->dc->vendor_signature.is_valid) {
> -               enum dc_status result_write_min_hblank =3D DC_NOT_SUPPORT=
ED;
> +               enum dc_status __maybe_unused result_write_min_hblank =3D=
 DC_NOT_SUPPORTED;
>                 struct dpcd_amd_signature amd_signature =3D {0};
>                 struct dpcd_amd_device_id amd_device_id =3D {0};
>
> --
> 2.40.0.rc1.284.g88254d51c5-goog
>
