Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247FE7227C5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbjFENpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbjFENpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:45:49 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13589F9;
        Mon,  5 Jun 2023 06:45:47 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6af7d6f6f41so3669340a34.1;
        Mon, 05 Jun 2023 06:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685972746; x=1688564746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPs0adEpndJHNRLp7agfpNYHW4E6pd8wz99dF6+STMo=;
        b=raB5+Pn6u6HH5njQu+0OVF0GBgtqdhY/7mhsOgRm6iibx1qeCLI5EQiJk99nmUDvKS
         O5BY9HmVe2L73f4rdHS0nLOMP/vX9hSKdZiRhVMguJm60vteFSXwZhmhxh2cS2bBY5l/
         2rGtdSc35S0ZPHgBTyQ2JyG9klg+ygM8tnC1gSZOzs0u9bi3TEE73hoiDQiKYwhp3ghq
         gtwBJQJHhj1EdnuUwXR4UIYDEdqwVAQtHp7KxVIgjB77EzgXgQwu3xcrvP6o32HuWOPs
         croT2pn2wCCIe52juC3rPejkcaT4+fPLIj/+pv4pjGkh53w0QemVAG+4nxja67s6eliq
         7+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685972746; x=1688564746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XPs0adEpndJHNRLp7agfpNYHW4E6pd8wz99dF6+STMo=;
        b=L6Tb/8B8PyLZP7KBYNr8XHuFNdESHOeJPQZ2QnbVvrHAGpPNq4VtKfaEaDKoK8KX4O
         MMk1p1PwMvbl1m6CcYBJCINmb6qwrjZBC3WPPrf/Fz6Og2dBJfl2cliCgqf8s6nl1Ks9
         5jmxAU9/DEEtqcv5BT5dfsYlw1ZP25lvJpGei+Y1/WgCNIS6fFQTPViycndaHnpXX9Pa
         VtzWiRgbCR6T+O+baTYNWRVQ4uq2UEezXYkx8tXcK0oCB2zL8JrWWGBI5Vtck2ajCBAY
         0xlfDSgPtMHQTYig7ItMycfgcFFyphD1zM+6wqXVso9YcPxYJssuvv82Ax21Mjklv6ai
         eCpQ==
X-Gm-Message-State: AC+VfDzCRroLcqN3aZ42HYgkQJZ1YMS8lD0k9d2Epe/y0OwF77x9BT0Q
        x7g2WKCEt1ZiKd3Sxo5UkLkKvqkDcrF+bN+IxnFH1jO4EF0=
X-Google-Smtp-Source: ACHHUZ4i/r3xqUFlXEHK9dRxIo6CpfVx+9RtElJGklcaW3PlpSdl1bjwhJ/+C/5+08kBi90Zt0Bbsm/ZdsCFZeRxD/Q=
X-Received: by 2002:a05:6830:1b66:b0:6b1:6859:b8fe with SMTP id
 d6-20020a0568301b6600b006b16859b8femr3675480ote.0.1685972746180; Mon, 05 Jun
 2023 06:45:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230531030945.4109453-1-quic_bjorande@quicinc.com> <20230531030945.4109453-2-quic_bjorande@quicinc.com>
In-Reply-To: <20230531030945.4109453-2-quic_bjorande@quicinc.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 5 Jun 2023 06:45:35 -0700
Message-ID: <CAF6AEGvZng7-Q0156H1xwLU88rp1C48vbiEbcTuO4gDz2ENQHw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] drm/msm/adreno: Add Adreno A690 support
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, johan@kernel.org, mani@kernel.org,
        Steev Klimaszewski <steev@kali.org>
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

On Tue, May 30, 2023 at 8:09=E2=80=AFPM Bjorn Andersson
<quic_bjorande@quicinc.com> wrote:
>
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>
> Introduce support for the Adreno A690, found in Qualcomm SC8280XP.
>
> Tested-by: Steev Klimaszewski <steev@kali.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>
> Changes since v2:
> - None
>
> Changes since v1:
> - Moved a690 to adreno_is_a660_family(), which simplifies hw_init() and
>   ensured that pdc_in_aop got set.
> - Dropped dynamic lookup in cmd-db. Will look into posting this
>   separately.
>
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c      | 113 ++++++++++++++++++++-
>  drivers/gpu/drm/msm/adreno/a6xx_hfi.c      |  33 ++++++
>  drivers/gpu/drm/msm/adreno/adreno_device.c |  14 +++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  11 +-
>  4 files changed, 166 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.c
> index 9fb214f150dd..cabc8f9a12d7 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -588,6 +588,63 @@ const struct adreno_reglist a660_hwcg[] =3D {
>         {},
>  };
>
> +const struct adreno_reglist a690_hwcg[] =3D {
> +       {REG_A6XX_RBBM_CLOCK_CNTL_SP0, 0x02222222},
> +       {REG_A6XX_RBBM_CLOCK_CNTL2_SP0, 0x02222220},
> +       {REG_A6XX_RBBM_CLOCK_DELAY_SP0, 0x00000080},
> +       {REG_A6XX_RBBM_CLOCK_HYST_SP0, 0x0000F3CF},
> +       {REG_A6XX_RBBM_CLOCK_CNTL_TP0, 0x22222222},
> +       {REG_A6XX_RBBM_CLOCK_CNTL2_TP0, 0x22222222},
> +       {REG_A6XX_RBBM_CLOCK_CNTL3_TP0, 0x22222222},
> +       {REG_A6XX_RBBM_CLOCK_CNTL4_TP0, 0x00022222},
> +       {REG_A6XX_RBBM_CLOCK_DELAY_TP0, 0x11111111},
> +       {REG_A6XX_RBBM_CLOCK_DELAY2_TP0, 0x11111111},
> +       {REG_A6XX_RBBM_CLOCK_DELAY3_TP0, 0x11111111},
> +       {REG_A6XX_RBBM_CLOCK_DELAY4_TP0, 0x00011111},
> +       {REG_A6XX_RBBM_CLOCK_HYST_TP0, 0x77777777},
> +       {REG_A6XX_RBBM_CLOCK_HYST2_TP0, 0x77777777},
> +       {REG_A6XX_RBBM_CLOCK_HYST3_TP0, 0x77777777},
> +       {REG_A6XX_RBBM_CLOCK_HYST4_TP0, 0x00077777},
> +       {REG_A6XX_RBBM_CLOCK_CNTL_RB0, 0x22222222},
> +       {REG_A6XX_RBBM_CLOCK_CNTL2_RB0, 0x01002222},
> +       {REG_A6XX_RBBM_CLOCK_CNTL_CCU0, 0x00002220},
> +       {REG_A6XX_RBBM_CLOCK_HYST_RB_CCU0, 0x00040F00},
> +       {REG_A6XX_RBBM_CLOCK_CNTL_RAC, 0x25222022},
> +       {REG_A6XX_RBBM_CLOCK_CNTL2_RAC, 0x00005555},
> +       {REG_A6XX_RBBM_CLOCK_DELAY_RAC, 0x00000011},
> +       {REG_A6XX_RBBM_CLOCK_HYST_RAC, 0x00445044},
> +       {REG_A6XX_RBBM_CLOCK_CNTL_TSE_RAS_RBBM, 0x04222222},
> +       {REG_A6XX_RBBM_CLOCK_MODE_VFD, 0x00002222},
> +       {REG_A6XX_RBBM_CLOCK_MODE_GPC, 0x00222222},
> +       {REG_A6XX_RBBM_CLOCK_DELAY_HLSQ_2, 0x00000002},
> +       {REG_A6XX_RBBM_CLOCK_MODE_HLSQ, 0x00002222},
> +       {REG_A6XX_RBBM_CLOCK_DELAY_TSE_RAS_RBBM, 0x00004000},
> +       {REG_A6XX_RBBM_CLOCK_DELAY_VFD, 0x00002222},
> +       {REG_A6XX_RBBM_CLOCK_DELAY_GPC, 0x00000200},
> +       {REG_A6XX_RBBM_CLOCK_DELAY_HLSQ, 0x00000000},
> +       {REG_A6XX_RBBM_CLOCK_HYST_TSE_RAS_RBBM, 0x00000000},
> +       {REG_A6XX_RBBM_CLOCK_HYST_VFD, 0x00000000},
> +       {REG_A6XX_RBBM_CLOCK_HYST_GPC, 0x04104004},
> +       {REG_A6XX_RBBM_CLOCK_HYST_HLSQ, 0x00000000},
> +       {REG_A6XX_RBBM_CLOCK_CNTL_TEX_FCHE, 0x00000222},
> +       {REG_A6XX_RBBM_CLOCK_DELAY_TEX_FCHE, 0x00000111},
> +       {REG_A6XX_RBBM_CLOCK_HYST_TEX_FCHE, 0x00000000},
> +       {REG_A6XX_RBBM_CLOCK_CNTL_UCHE, 0x22222222},
> +       {REG_A6XX_RBBM_CLOCK_HYST_UCHE, 0x00000004},
> +       {REG_A6XX_RBBM_CLOCK_DELAY_UCHE, 0x00000002},
> +       {REG_A6XX_RBBM_CLOCK_CNTL, 0x8AA8AA82},
> +       {REG_A6XX_RBBM_ISDB_CNT, 0x00000182},
> +       {REG_A6XX_RBBM_RAC_THRESHOLD_CNT, 0x00000000},
> +       {REG_A6XX_RBBM_SP_HYST_CNT, 0x00000000},
> +       {REG_A6XX_RBBM_CLOCK_CNTL_GMU_GX, 0x00000222},
> +       {REG_A6XX_RBBM_CLOCK_DELAY_GMU_GX, 0x00000111},
> +       {REG_A6XX_RBBM_CLOCK_HYST_GMU_GX, 0x00000555},
> +       {REG_A6XX_GPU_GMU_AO_GMU_CGC_MODE_CNTL, 0x20200},
> +       {REG_A6XX_GPU_GMU_AO_GMU_CGC_DELAY_CNTL, 0x10111},
> +       {REG_A6XX_GPU_GMU_AO_GMU_CGC_HYST_CNTL, 0x5555},
> +       {}
> +};
> +
>  static void a6xx_set_hwcg(struct msm_gpu *gpu, bool state)
>  {
>         struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> @@ -747,6 +804,45 @@ static const u32 a660_protect[] =3D {
>         A6XX_PROTECT_NORDWR(0x1f8c0, 0x0000), /* note: infinite range */
>  };
>
> +/* These are for a690 */
> +static const u32 a690_protect[] =3D {
> +       A6XX_PROTECT_RDONLY(0x00000, 0x004ff),
> +       A6XX_PROTECT_RDONLY(0x00501, 0x00001),
> +       A6XX_PROTECT_RDONLY(0x0050b, 0x002f4),
> +       A6XX_PROTECT_NORDWR(0x0050e, 0x00000),
> +       A6XX_PROTECT_NORDWR(0x00510, 0x00000),
> +       A6XX_PROTECT_NORDWR(0x00534, 0x00000),
> +       A6XX_PROTECT_NORDWR(0x00800, 0x00082),
> +       A6XX_PROTECT_NORDWR(0x008a0, 0x00008),
> +       A6XX_PROTECT_NORDWR(0x008ab, 0x00024),
> +       A6XX_PROTECT_RDONLY(0x008d0, 0x000bc),
> +       A6XX_PROTECT_NORDWR(0x00900, 0x0004d),
> +       A6XX_PROTECT_NORDWR(0x0098d, 0x00272),
> +       A6XX_PROTECT_NORDWR(0x00e00, 0x00001),
> +       A6XX_PROTECT_NORDWR(0x00e03, 0x0000c),
> +       A6XX_PROTECT_NORDWR(0x03c00, 0x000c3),
> +       A6XX_PROTECT_RDONLY(0x03cc4, 0x01fff),
> +       A6XX_PROTECT_NORDWR(0x08630, 0x001cf),
> +       A6XX_PROTECT_NORDWR(0x08e00, 0x00000),
> +       A6XX_PROTECT_NORDWR(0x08e08, 0x00008),
> +       A6XX_PROTECT_NORDWR(0x08e50, 0x0001f),
> +       A6XX_PROTECT_NORDWR(0x08e80, 0x0027f),
> +       A6XX_PROTECT_NORDWR(0x09624, 0x001db),
> +       A6XX_PROTECT_NORDWR(0x09e60, 0x00011),
> +       A6XX_PROTECT_NORDWR(0x09e78, 0x00187),
> +       A6XX_PROTECT_NORDWR(0x0a630, 0x001cf),
> +       A6XX_PROTECT_NORDWR(0x0ae02, 0x00000),
> +       A6XX_PROTECT_NORDWR(0x0ae50, 0x0012f),
> +       A6XX_PROTECT_NORDWR(0x0b604, 0x00000),
> +       A6XX_PROTECT_NORDWR(0x0b608, 0x00006),
> +       A6XX_PROTECT_NORDWR(0x0be02, 0x00001),
> +       A6XX_PROTECT_NORDWR(0x0be20, 0x0015f),
> +       A6XX_PROTECT_NORDWR(0x0d000, 0x005ff),
> +       A6XX_PROTECT_NORDWR(0x0f000, 0x00bff),
> +       A6XX_PROTECT_RDONLY(0x0fc00, 0x01fff),
> +       A6XX_PROTECT_NORDWR(0x11c00, 0x00000), /*note: infiite range */
> +};

fwiw, I needed a small fixup in the CP_PROTECT settings to fix
perfcntrs (fdperf, perfetto):

------
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index b13e58e62589..e6b35fa2b0c7 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -815,7 +815,7 @@ static const u32 a690_protect[] =3D {
  A6XX_PROTECT_NORDWR(0x00800, 0x00082),
  A6XX_PROTECT_NORDWR(0x008a0, 0x00008),
  A6XX_PROTECT_NORDWR(0x008ab, 0x00024),
- A6XX_PROTECT_RDONLY(0x008d0, 0x000bc),
+ A6XX_PROTECT_RDONLY(0x008de, 0x000ae),
  A6XX_PROTECT_NORDWR(0x00900, 0x0004d),
  A6XX_PROTECT_NORDWR(0x0098d, 0x00272),
  A6XX_PROTECT_NORDWR(0x00e00, 0x00001),
@@ -824,7 +824,7 @@ static const u32 a690_protect[] =3D {
  A6XX_PROTECT_RDONLY(0x03cc4, 0x01fff),
  A6XX_PROTECT_NORDWR(0x08630, 0x001cf),
  A6XX_PROTECT_NORDWR(0x08e00, 0x00000),
- A6XX_PROTECT_NORDWR(0x08e08, 0x00008),
+ A6XX_PROTECT_NORDWR(0x08e08, 0x00007),
  A6XX_PROTECT_NORDWR(0x08e50, 0x0001f),
  A6XX_PROTECT_NORDWR(0x08e80, 0x0027f),
  A6XX_PROTECT_NORDWR(0x09624, 0x001db),
------

(sorry gmail probably screwed that up)

but otherwise,

Tested-by: Rob Clark <robdclark@gmail.com>

> +
>  static void a6xx_set_cp_protect(struct msm_gpu *gpu)
>  {
>         struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> @@ -758,6 +854,11 @@ static void a6xx_set_cp_protect(struct msm_gpu *gpu)
>                 count =3D ARRAY_SIZE(a650_protect);
>                 count_max =3D 48;
>                 BUILD_BUG_ON(ARRAY_SIZE(a650_protect) > 48);
> +       } else if (adreno_is_a690(adreno_gpu)) {
> +               regs =3D a690_protect;
> +               count =3D ARRAY_SIZE(a690_protect);
> +               count_max =3D 48;
> +               BUILD_BUG_ON(ARRAY_SIZE(a690_protect) > 48);
>         } else if (adreno_is_a660_family(adreno_gpu)) {
>                 regs =3D a660_protect;
>                 count =3D ARRAY_SIZE(a660_protect);
> @@ -806,6 +907,13 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu=
)
>                 uavflagprd_inv =3D 2;
>         }
>
> +       if (adreno_is_a690(adreno_gpu)) {
> +               lower_bit =3D 2;
> +               amsbc =3D 1;
> +               rgb565_predicator =3D 1;
> +               uavflagprd_inv =3D 2;
> +       }
> +
>         if (adreno_is_7c3(adreno_gpu)) {
>                 lower_bit =3D 1;
>                 amsbc =3D 1;
> @@ -1084,7 +1192,7 @@ static int hw_init(struct msm_gpu *gpu)
>         /* Setting the primFifo thresholds default values,
>          * and vccCacheSkipDis=3D1 bit (0x200) for A640 and newer
>         */
> -       if (adreno_is_a650(adreno_gpu) || adreno_is_a660(adreno_gpu))
> +       if (adreno_is_a650(adreno_gpu) || adreno_is_a660(adreno_gpu) || a=
dreno_is_a690(adreno_gpu))
>                 gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00300200);
>         else if (adreno_is_a640_family(adreno_gpu) || adreno_is_7c3(adren=
o_gpu))
>                 gpu_write(gpu, REG_A6XX_PC_DBG_ECO_CNTL, 0x00200200);
> @@ -1991,7 +2099,8 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *de=
v)
>         info =3D adreno_info(config->rev);
>
>         if (info && (info->revn =3D=3D 650 || info->revn =3D=3D 660 ||
> -                       adreno_cmp_rev(ADRENO_REV(6, 3, 5, ANY_ID), info-=
>rev)))
> +                    info->revn =3D=3D 690 ||
> +                    adreno_cmp_rev(ADRENO_REV(6, 3, 5, ANY_ID), info->re=
v)))
>                 adreno_gpu->base.hw_apriv =3D true;
>
>         a6xx_llc_slices_init(pdev, a6xx_gpu);
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/=
adreno/a6xx_hfi.c
> index 2cc83e049613..25b235b49ebc 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> @@ -414,6 +414,37 @@ static void a650_build_bw_table(struct a6xx_hfi_msg_=
bw_table *msg)
>         msg->cnoc_cmds_data[1][0] =3D  0x60000001;
>  }
>
> +static void a690_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
> +{
> +       /*
> +        * Send a single "off" entry just to get things running
> +        * TODO: bus scaling
> +        */
> +       msg->bw_level_num =3D 1;
> +
> +       msg->ddr_cmds_num =3D 3;
> +       msg->ddr_wait_bitmask =3D 0x01;
> +
> +       msg->ddr_cmds_addrs[0] =3D 0x50004;
> +       msg->ddr_cmds_addrs[1] =3D 0x50000;
> +       msg->ddr_cmds_addrs[2] =3D 0x500ac;
> +
> +       msg->ddr_cmds_data[0][0] =3D  0x40000000;
> +       msg->ddr_cmds_data[0][1] =3D  0x40000000;
> +       msg->ddr_cmds_data[0][2] =3D  0x40000000;
> +
> +       /*
> +        * These are the CX (CNOC) votes - these are used by the GMU but =
the
> +        * votes are known and fixed for the target
> +        */
> +       msg->cnoc_cmds_num =3D 1;
> +       msg->cnoc_wait_bitmask =3D 0x01;
> +
> +       msg->cnoc_cmds_addrs[0] =3D 0x5003c;
> +       msg->cnoc_cmds_data[0][0] =3D  0x40000000;
> +       msg->cnoc_cmds_data[1][0] =3D  0x60000001;
> +}
> +
>  static void a660_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
>  {
>         /*
> @@ -531,6 +562,8 @@ static int a6xx_hfi_send_bw_table(struct a6xx_gmu *gm=
u)
>                 adreno_7c3_build_bw_table(&msg);
>         else if (adreno_is_a660(adreno_gpu))
>                 a660_build_bw_table(&msg);
> +       else if (adreno_is_a690(adreno_gpu))
> +               a690_build_bw_table(&msg);
>         else
>                 a6xx_build_bw_table(&msg);
>
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm=
/msm/adreno/adreno_device.c
> index 8cff86e9d35c..e5a865024e94 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -355,6 +355,20 @@ static const struct adreno_info gpulist[] =3D {
>                 .init =3D a6xx_gpu_init,
>                 .zapfw =3D "a640_zap.mdt",
>                 .hwcg =3D a640_hwcg,
> +       }, {
> +               .rev =3D ADRENO_REV(6, 9, 0, ANY_ID),
> +               .revn =3D 690,
> +               .name =3D "A690",
> +               .fw =3D {
> +                       [ADRENO_FW_SQE] =3D "a660_sqe.fw",
> +                       [ADRENO_FW_GMU] =3D "a690_gmu.bin",
> +               },
> +               .gmem =3D SZ_4M,
> +               .inactive_period =3D DRM_MSM_INACTIVE_PERIOD,
> +               .init =3D a6xx_gpu_init,
> +               .zapfw =3D "a690_zap.mdt",
> +               .hwcg =3D a690_hwcg,
> +               .address_space_size =3D SZ_16G,
>         },
>  };
>
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.h
> index f62612a5c70f..ac9c429ca07b 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -55,7 +55,7 @@ struct adreno_reglist {
>         u32 value;
>  };
>
> -extern const struct adreno_reglist a615_hwcg[], a630_hwcg[], a640_hwcg[]=
, a650_hwcg[], a660_hwcg[];
> +extern const struct adreno_reglist a615_hwcg[], a630_hwcg[], a640_hwcg[]=
, a650_hwcg[], a660_hwcg[], a690_hwcg[];
>
>  struct adreno_info {
>         struct adreno_rev rev;
> @@ -272,6 +272,11 @@ static inline int adreno_is_a660(struct adreno_gpu *=
gpu)
>         return gpu->revn =3D=3D 660;
>  }
>
> +static inline int adreno_is_a690(struct adreno_gpu *gpu)
> +{
> +       return gpu->revn =3D=3D 690;
> +};
> +
>  /* check for a615, a616, a618, a619 or any derivatives */
>  static inline int adreno_is_a615_family(struct adreno_gpu *gpu)
>  {
> @@ -280,13 +285,13 @@ static inline int adreno_is_a615_family(struct adre=
no_gpu *gpu)
>
>  static inline int adreno_is_a660_family(struct adreno_gpu *gpu)
>  {
> -       return adreno_is_a660(gpu) || adreno_is_7c3(gpu);
> +       return adreno_is_a660(gpu) || adreno_is_a690(gpu) || adreno_is_7c=
3(gpu);
>  }
>
>  /* check for a650, a660, or any derivatives */
>  static inline int adreno_is_a650_family(struct adreno_gpu *gpu)
>  {
> -       return gpu->revn =3D=3D 650 || gpu->revn =3D=3D 620 || adreno_is_=
a660_family(gpu);
> +       return gpu->revn =3D=3D 650 || gpu->revn =3D=3D 620  || adreno_is=
_a660_family(gpu);
>  }
>
>  u64 adreno_private_address_space_size(struct msm_gpu *gpu);
> --
> 2.39.2
>
