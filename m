Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FB670C1C5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbjEVPCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbjEVPB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:01:57 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88B51A6;
        Mon, 22 May 2023 08:01:31 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-55239f43426so2982996eaf.1;
        Mon, 22 May 2023 08:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684767691; x=1687359691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LskgHOf5lGt4WW6mhU+hd1LEcknlCNNiGlqCh79E5+g=;
        b=eJzekwbN+X72DkwCy+MOL+AkfzJw7Ouu2/fbRJx9LwCWIVKelYH2d8MSf9QgxtSp6+
         90uO/nFEaG0ZiIddOXSJLoceP7eYcL122SdBLfmwHkvlUmArTt2kdZnhLCABvDe03kFS
         fJaHkNd+pgUhfqdZdYAWkHDHfYJSDbyoR/yJ1OTGGGTe6RsecWWyQtPl4cMQQRnuzmTN
         LPzCuRaHN8Sn78z1ALkb7vU6IpgMAOp0CGV/06AIuha/Fz7B5TB/oeZ53l1yRiasL28i
         yeuXTEswRs3gfO/2VTu7UrF1LyfgDU7qlqR0Yf1JRiROTEeGhSr06JJuN5cxlhrAkX8m
         qkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684767691; x=1687359691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LskgHOf5lGt4WW6mhU+hd1LEcknlCNNiGlqCh79E5+g=;
        b=FTBQbiKTRar8r3GwjvihxKTeKEMzrx8Xc8+hNsh7JpzO0B9LWplBmRLhdNL1uP0Pqd
         Ar7Mef7smLpFYqnRbanAcCqptQW1X/maWFp/Lo8yeQwnJG2zoC5Jlr2KADAhEdnSH38c
         iIZ3TtkHG5S+lv37rzb0WSIIgRIk/aZUoT9BbIxptTiEAoqrvJyoBQ2Z+Btn74I6NgYM
         ClxXmlTP5MBEMgoxk7Dt5eVQ27QNYO5zLoNKLmTMeJCRUAhxc/Ddqv2AE6nsRoM64X5V
         SKA7CTvxsMD4aG7XMFuVGcXQZPVEY/j+nfyiLT+omymuJ25onTeoBSMfV1sz9Sy8UoxP
         2OrQ==
X-Gm-Message-State: AC+VfDzeUqFoclLjuOxsY9+0gpXVyi0xlaXVPksi73xXtjtEYP3NFvPP
        SQdH9rek0J1qSv9tHcjlSyH0Q5HgtzW12WliUK4k0C6B
X-Google-Smtp-Source: ACHHUZ75G0qJhT/m2qSgb9+WWMdeqH1Ah7M89gkxZtrFtqS2/ByNyxqosAJRpSfrrKPHtBuX0EyH1sTv0kdmIoQQWRE=
X-Received: by 2002:a4a:6f45:0:b0:546:ecb3:f42 with SMTP id
 i5-20020a4a6f45000000b00546ecb30f42mr4416072oof.8.1684767690994; Mon, 22 May
 2023 08:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230522090252.913910-1-colin.i.king@gmail.com>
In-Reply-To: <20230522090252.913910-1-colin.i.king@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 22 May 2023 11:01:20 -0400
Message-ID: <CADnq5_NMdZWU0ES1aKfmr-8-5VOK_Gfve-12ieKwtABuNkzCfg@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu: Fix a couple of spelling mistakes in
 info and debug messages
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Xinhui.Pan@amd.com, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, May 22, 2023 at 5:02=E2=80=AFAM Colin Ian King <colin.i.king@gmail.=
com> wrote:
>
> There are a couple of spelling mistakes, one in a dev_info message
> and the other in a dev_debug message. Fix them.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index 59b8b26e2caf..789cc16e1be7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -1007,7 +1007,7 @@ int psp_spatial_partition(struct psp_context *psp, =
int mode)
>         cmd->cmd_id =3D GFX_CMD_ID_SRIOV_SPATIAL_PART;
>         cmd->cmd.cmd_spatial_part.mode =3D mode;
>
> -       dev_info(psp->adev->dev, "Requesting %d paritions through PSP", m=
ode);
> +       dev_info(psp->adev->dev, "Requesting %d partitions through PSP", =
mode);
>         ret =3D psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr=
);
>
>         release_psp_cmd_buf(psp);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_xcp.c
> index daeb6bcc9245..e9586a0dc335 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -359,7 +359,7 @@ int amdgpu_xcp_open_device(struct amdgpu_device *adev=
,
>                                                 file_priv->minor->index, =
i);
>                                 return -ENOENT;
>                         }
> -                       dev_dbg(adev->dev, "renderD%d partition %d openne=
d!",
> +                       dev_dbg(adev->dev, "renderD%d partition %d opened=
!",
>                                         file_priv->minor->index, i);
>                         fpriv->xcp_id =3D i;
>                         break;
> --
> 2.30.2
>
