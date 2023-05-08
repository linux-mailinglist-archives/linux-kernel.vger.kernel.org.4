Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9226FB33D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbjEHOtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbjEHOtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:49:03 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C2F72A6;
        Mon,  8 May 2023 07:48:56 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1929818d7faso31929077fac.0;
        Mon, 08 May 2023 07:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683557335; x=1686149335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04DgYL9ZmEKaOVbUM4T7mAu34s7OhOg8hMlDmx91xxc=;
        b=kYnsHzNbR1qG49sGNL1PXh2+Zlj+RgCIFyEXKDff56OhszMSee14AKlklmCWAScd9Q
         zDRxPh0O5sQhykgRgzyBKJ/34sn8gDAAZnsYK+/6q1mn4TY8bMcQlg/Lvm8LZLy3+R7r
         sMYljHaVKy3B39wEtUVFYdhIhKfhvOKXG1KpE3xqE5BN38AFGodiMZ3o74hkkv448irY
         piLnoEnf6l/zg/uEYgnZfp6bC+fF8yLbFMOBpFBzecculsyj2gEMsRanL04l/ySbLldj
         7i7atqVlypl5Pqo2sKoptt8NoeRwWUzpXdubYghD+cAWPvVeJAXrOnQ2qiIogfn8wsww
         0pVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683557335; x=1686149335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04DgYL9ZmEKaOVbUM4T7mAu34s7OhOg8hMlDmx91xxc=;
        b=UlS/J7pbnIRKkAxSZLwNTYrvrt/UEwlXlkf15xTpKzo6EubUV7RggjQfF4zy9Pe/Uz
         uTlipVhT9S1CT1RH1VAnA9zPV+sxSjz6cLEeSGIkEsLfdEIh9zijwgLBoehLcmQauBa1
         b3/1f4DlBZoh1SuqYiGuLpn8b4cCe/nlZiVMqQR3HyaZym1YqU1AulHxF4WB/20p5nmQ
         6hO2EDEUcp5iYpMfO9jDmoKdXpTzmD743so0b4w4bWgX/ogYk3SpoHyxyJVEBktibxA+
         3WdvSWIO6uhuIJ7dP/Mvp4k/QtewtLhXleGbS/TTBIdWW9LSimPGOT6nDztPSu4LsRbH
         Tf7g==
X-Gm-Message-State: AC+VfDz9hiCb2+VRdM/8R1X7wIG4ZUVPVrWQ2/Afg5I/1Ufgy6kocVi4
        vCK9Glh1NWDOR3CnYoC/JyxU6hPmfFSIgAUArhs=
X-Google-Smtp-Source: ACHHUZ5uFtaaZR1vMZ02+lkLzojO4L4M4UVAAAwwix4mKnkizhVuz2ka1KhN5RWUbkjK0YLdJfR0IvFX1S/fG8H60ys=
X-Received: by 2002:aca:df03:0:b0:38c:2c79:37e with SMTP id
 w3-20020acadf03000000b0038c2c79037emr7844626oig.20.1683557335416; Mon, 08 May
 2023 07:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230506081043.73456-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20230506081043.73456-1-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 8 May 2023 10:48:43 -0400
Message-ID: <CADnq5_PCdwi_d_gPjH0uBngHanzzC1nk8vfTRMO=ZrP6dSVY2Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Remove the unused variable golden_settings_gc_9_4_3
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     alexander.deucher@amd.com, Xinhui.Pan@amd.com,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        sumit.semwal@linaro.org, linaro-mm-sig@lists.linaro.org,
        dri-devel@lists.freedesktop.org, christian.koenig@amd.com,
        linux-media@vger.kernel.org
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

Applied.  Thanks!

On Sat, May 6, 2023 at 4:11=E2=80=AFAM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Variable golden_settings_gc_9_4_3 is not effectively used, so delete it.
>
> drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:48:38: warning: =E2=80=98golden_s=
ettings_gc_9_4_3=E2=80=99 defined but not used.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D4877
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index 312491455382..74be46d382f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -45,10 +45,6 @@ MODULE_FIRMWARE("amdgpu/gc_9_4_3_rlc.bin");
>  #define GFX9_MEC_HPD_SIZE 4096
>  #define RLCG_UCODE_LOADING_START_ADDRESS 0x00002000L
>
> -static const struct soc15_reg_golden golden_settings_gc_9_4_3[] =3D {
> -
> -};
> -
>  static void gfx_v9_4_3_set_ring_funcs(struct amdgpu_device *adev);
>  static void gfx_v9_4_3_set_irq_funcs(struct amdgpu_device *adev);
>  static void gfx_v9_4_3_set_gds_init(struct amdgpu_device *adev);
> --
> 2.20.1.7.g153144c
>
