Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B1B710C02
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbjEYM1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjEYM1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:27:33 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F72A12E
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 05:27:32 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-96f53c06babso100785066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 05:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685017650; x=1687609650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvtCOkSJ1hLTpfTIe7dnnQ5oJVLpvePI0UcoHsPVr88=;
        b=rnQ0tZE2U5oV4ZOo0akozOdNKJxo/agK2VlMHzEek/5TolQqyKyAHV5cfKbHqngcl9
         5gVqamgLDFXPFSk2p1FOP6yTt0ZXRatdVRRCKcS63OgzD3mg1gMDz8mM49gABps2+0X/
         nwAcyjm9RGTdxHNWU7/LxCpFd9oea8vi9efYPmzWZt23iAFMJrVuvm+yn/dA7qTAp88H
         njMcW+H04uWM9mDUAEqfUFriLEbGqVDe3Ilsk/Yg8B5eTyR85lgCg0hPQegKYJmzH7Cs
         JhomoXskWtiuamodypAOZ6S214nWDLZUvm1PtkmwDdXMoYeOyGY4VOiRX1+RgDQ5mnLS
         2Eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685017650; x=1687609650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvtCOkSJ1hLTpfTIe7dnnQ5oJVLpvePI0UcoHsPVr88=;
        b=OQwanYSbPvI0pVlnXB5WGz6ahDFj446U1h+J45/GZuRzPQDkSNJqS4DrTBIFqZF1Ok
         BK+aFpqRCzYM/zZQVu8gfUsk4Wu9d4qhVJXdt+nx5xnpi0FjJu3vvdXflfxe8o9zI78A
         YvNotAQFPu84e3+d/PaU0TBR/3sgAVu/XnYRdm/qSvid8dTWQ9OCG4gt3Ivw7/eBA49U
         oWSoMO8Boes+DFY7ypFhn7T7VPpNFtodJZ3fMH2+cX68MRQor8s0ti7bq3Yk+H8sKAYe
         kTrVOOXuJ0gVNkkuqJbYDRDjh1MfDVsQ6iVyOjM45ch2ocbno5L9FVzKT73NU3VXdmdC
         7k9Q==
X-Gm-Message-State: AC+VfDyl32MJe70ydLIxsxcbPWfsDAXon6MET88qNWu/9fmM06o29X9r
        QL9nECcBSoihP4pWR5Xj3Gi+gnJUjaS+hD9srOM=
X-Google-Smtp-Source: ACHHUZ6JdEIWi2e9dAuwaN4KMmQbk4Bgx1kpd9m4V9ZJz9shZj29YNaMmmri+i7DPVlnx9uaHRO5vAVnOpaO/wyaUqY=
X-Received: by 2002:a17:906:478a:b0:973:9f60:c57e with SMTP id
 cw10-20020a170906478a00b009739f60c57emr1660585ejc.2.1685017650420; Thu, 25
 May 2023 05:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230525122112.647963-1-daniel.baluta@oss.nxp.com>
In-Reply-To: <20230525122112.647963-1-daniel.baluta@oss.nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 25 May 2023 15:27:18 +0300
Message-ID: <CAEnQRZBEVTghdM0hceMbATnNO-cfEJwgtchyhohAVuDTFSHYTg@mail.gmail.com>
Subject: Re: [PATCH linux-nxp] ASoC: SOF: imx: Add OF machine descriptors for
 i.MX platforms
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disregard this. Sent the patch from internal nxp folder.

On Thu, May 25, 2023 at 3:21=E2=80=AFPM Daniel Baluta <daniel.baluta@oss.nx=
p.com> wrote:
>
> From: Paul Olaru <paul.olaru@nxp.com>
>
> Covered platforms: i.MX8QXP, i.MX8QM, i.MX8MP, i.MX8ULP.
>
> These descriptors are used to locate the machine driver and topology
> filenames.
>
> Note: because the compatible values for the boards do not change between
> the cs42888 and the wm8960 cases, I have selected a common topology
> filename, which is intended to be a symlink to either the wm8960 or the
> cs42888 topology file. For uniformity I did the same for i.MX8ULP.
>
> Signed-off-by: Paul Olaru <paul.olaru@nxp.com>
> ---
>  sound/soc/sof/imx/imx8.c    | 16 ++++++++++++++++
>  sound/soc/sof/imx/imx8m.c   | 10 ++++++++++
>  sound/soc/sof/imx/imx8ulp.c | 10 ++++++++++
>  3 files changed, 36 insertions(+)
>
> diff --git a/sound/soc/sof/imx/imx8.c b/sound/soc/sof/imx/imx8.c
> index 7e7d1f5c1147..2b91bfc8fb5b 100644
> --- a/sound/soc/sof/imx/imx8.c
> +++ b/sound/soc/sof/imx/imx8.c
> @@ -624,7 +624,22 @@ static struct snd_sof_dsp_ops sof_imx8x_ops =3D {
>                         SNDRV_PCM_INFO_NO_PERIOD_WAKEUP
>  };
>
> +static struct snd_sof_of_mach sof_imx8_machs[] =3D {
> +       {
> +               .compatible =3D "fsl,imx8qxp",
> +               .drv_name =3D "asoc-simple-card",
> +               .sof_tplg_filename =3D "sof-imx8.tplg",
> +       },
> +       {
> +               .compatible =3D "fsl,imx8qm",
> +               .drv_name =3D "asoc-simple-card",
> +               .sof_tplg_filename =3D "sof-imx8.tplg",
> +       },
> +       {}
> +};
> +
>  static struct sof_dev_desc sof_of_imx8qxp_desc =3D {
> +       .of_machines =3D sof_imx8_machs,
>         .ipc_supported_mask     =3D BIT(SOF_IPC),
>         .ipc_default            =3D SOF_IPC,
>         .default_fw_path =3D {
> @@ -641,6 +656,7 @@ static struct sof_dev_desc sof_of_imx8qxp_desc =3D {
>  };
>
>  static struct sof_dev_desc sof_of_imx8qm_desc =3D {
> +       .of_machines =3D sof_imx8_machs,
>         .ipc_supported_mask     =3D BIT(SOF_IPC),
>         .ipc_default            =3D SOF_IPC,
>         .default_fw_path =3D {
> diff --git a/sound/soc/sof/imx/imx8m.c b/sound/soc/sof/imx/imx8m.c
> index d20011349b43..a05497eb8d89 100644
> --- a/sound/soc/sof/imx/imx8m.c
> +++ b/sound/soc/sof/imx/imx8m.c
> @@ -487,7 +487,17 @@ static struct snd_sof_dsp_ops sof_imx8m_ops =3D {
>                 SNDRV_PCM_INFO_NO_PERIOD_WAKEUP,
>  };
>
> +static struct snd_sof_of_mach sof_imx8m_machs[] =3D {
> +       {
> +               .compatible =3D "fsl,imx8mp",
> +               .drv_name =3D "asoc-simple-card",
> +               .sof_tplg_filename =3D "sof-imx8m.tplg",
> +       },
> +       {}
> +};
> +
>  static struct sof_dev_desc sof_of_imx8mp_desc =3D {
> +       .of_machines =3D sof_imx8m_machs,
>         .ipc_supported_mask     =3D BIT(SOF_IPC),
>         .ipc_default            =3D SOF_IPC,
>         .default_fw_path =3D {
> diff --git a/sound/soc/sof/imx/imx8ulp.c b/sound/soc/sof/imx/imx8ulp.c
> index 52c357ba570e..0c9878c2c420 100644
> --- a/sound/soc/sof/imx/imx8ulp.c
> +++ b/sound/soc/sof/imx/imx8ulp.c
> @@ -496,7 +496,17 @@ static struct snd_sof_dsp_ops sof_imx8ulp_ops =3D {
>         .set_power_state        =3D imx8ulp_dsp_set_power_state,
>  };
>
> +static struct snd_sof_of_mach sof_imx8ulp_machs[] =3D {
> +       {
> +               .compatible =3D "fsl,imx8ulp",
> +               .drv_name =3D "asoc-simple-card",
> +               .sof_tplg_filename =3D "sof-imx8ulp.tplg",
> +       },
> +       {}
> +};
> +
>  static struct sof_dev_desc sof_of_imx8ulp_desc =3D {
> +       .of_machines =3D sof_imx8ulp_machs,
>         .ipc_supported_mask     =3D BIT(SOF_IPC),
>         .ipc_default            =3D SOF_IPC,
>         .default_fw_path =3D {
> --
> 2.40.1
>
