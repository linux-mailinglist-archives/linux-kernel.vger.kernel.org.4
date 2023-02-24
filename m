Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016FF6A243A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 23:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjBXWWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 17:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjBXWWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 17:22:53 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFB25FCC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 14:22:52 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id bh19-20020a056830381300b00690bf2011b2so467275otb.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 14:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COTKnz3NDXQkTb5s1rNI0BDpJQEcrg3Di9N4FPTfkD0=;
        b=S2WHFice5SRbwNioZEUAnv+lIpdslXuf+frDoeMKE2GsmIdBbdOtWDzXcFdvobAeud
         R05NTghNNhrf7fTfmwfSSqstVcnKwoYe28vFND63hu6Tvz3N4O+nDeuHd+DjpdArHzK3
         S3PS8UgVRfZ9VWz/S/iYOB6eHtnb8ZdfLHflrFPRy3P4Ptzl02OcKgj/HQRzjCby6ElX
         bFQdVFFGBZfi0DHf1lyGRgG6uGA/OQNrE6eoV5DHPJ9GCwfXReAQCVEC8RB4N5zT5/lo
         LIUgpYcrzsPjh667ms5fNEVdaczRjNZ0P/EiIW6qoa69lR941gj4JwBvvJnYBhxCBXhw
         ad5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=COTKnz3NDXQkTb5s1rNI0BDpJQEcrg3Di9N4FPTfkD0=;
        b=TRQHdPJUL8UU+jg3dwgv3FlfBrEELjBOOjpy4mmwcnZFXNBzYi7AI6GFbUjV4SnmWX
         cvrJ1f7p//YR610OZSwqbUak7NDS8ePxKe2W+vYBElDSyIt3mnmbYU8lwkRUITC0df4f
         3hugSVFswuOiZTlzuQIMmDXB0smLhuvv/IsVzHzi1eN3ha0Ta9+vfxHMa+rbajTpfT4L
         HVpP0HomjlnBftJvy3/KZm5RCtF+oTfvb62ptQUG66T+TdKNXyoj4NXGS/kOFU6HvB10
         xgzbTPAbrsSXgLXTW+DtwgbZXiDdAZ5uitj7rDmxk5dnzyxuAWF9wBHhVwGU8CFjodVu
         QGSQ==
X-Gm-Message-State: AO0yUKVFORrB5hMyeBwMCCQz5Q0HixB7G1SbXWQNrZ6nTVf7K+oV7vlw
        SF9SzeXW3cWC0vmfHhzXx9CwWrM3uoKweI7fxME=
X-Google-Smtp-Source: AK7set/+ubJ5v7+JgV57rVBdMg0E7ct0udKSunoaM79gd40zlVQwF5/UTq+gjgShgCFtxf15n7T/FkmztyI5SPFFnAQ=
X-Received: by 2002:a9d:7019:0:b0:68b:e3b2:8ca7 with SMTP id
 k25-20020a9d7019000000b0068be3b28ca7mr2193511otj.6.1677277371537; Fri, 24 Feb
 2023 14:22:51 -0800 (PST)
MIME-Version: 1.0
References: <20230224164519.2757173-1-trix@redhat.com>
In-Reply-To: <20230224164519.2757173-1-trix@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 24 Feb 2023 17:22:40 -0500
Message-ID: <CADnq5_MNxZn+LEOg0L_0+zmMZ52qGCQi-KfMmuD_vSwt8rqJbQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove unused variable ring
To:     Tom Rix <trix@redhat.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        ruijing.dong@amd.com, Jane.Jian@amd.com, James.Zhu@amd.com,
        tao.zhou1@amd.com, sonny.jiang@amd.com, leo.liu@amd.com,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

On Fri, Feb 24, 2023 at 11:45 AM Tom Rix <trix@redhat.com> wrote:
>
> building with gcc and W=3D1 reports
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c:81:29: error: variable
>   =E2=80=98ring=E2=80=99 set but not used [-Werror=3Dunused-but-set-varia=
ble]
>    81 |         struct amdgpu_ring *ring;
>       |                             ^~~~
>
> ring is not used so remove it.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0.c
> index 213b43670f23..023a1fffa6a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -78,12 +78,10 @@ static void vcn_v4_0_set_ras_funcs(struct amdgpu_devi=
ce *adev);
>  static int vcn_v4_0_early_init(void *handle)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -       struct amdgpu_ring *ring;
>
>         if (amdgpu_sriov_vf(adev)) {
>                 adev->vcn.harvest_config =3D VCN_HARVEST_MMSCH;
>                 for (int i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -                       ring =3D &adev->vcn.inst[i].ring_enc[0];
>                         if (amdgpu_vcn_is_disabled_vcn(adev, VCN_ENCODE_R=
ING, i)) {
>                                 adev->vcn.harvest_config |=3D 1 << i;
>                                 dev_info(adev->dev, "VCN%d is disabled by=
 hypervisor\n", i);
> --
> 2.27.0
>
