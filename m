Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9016BF2A3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 21:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjCQUds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 16:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCQUdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 16:33:46 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DCD5B9D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:33:43 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id v17-20020a9d6051000000b0069a413e9cf6so3535641otj.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679085223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wke3FPs7Ksv6rdzTGLQOkGDYUGmajxnF7vbyk/QEY5M=;
        b=d2K5saJxtag/+i3+VeoPKXiNDCahExg8ilgXIYP14klahMootWNVks/mtmw/SAt9we
         dM2fd88rxNN55ZVnAfU+nYcFq3NYemlyDsgC/T3CiC765J026M/3Ulbl+8aLZCN5c2yo
         bcgl1ylGyBLUJhq0o3bu7QjKdmjlFbmUIVS7CU9AQo0UInUuGAMKL7dBw9RmQfFcoOpy
         nZ155XRJw9gsaCQoyodEMg/BGSVN067wTsOYxm/8jFtaSIA9T+8jq249qJhhjfNQ2UCq
         749nWIIh4uNdG1he5P8ZgeM8H+KtN5QEv/LLeWE1h5NVpL1yEcFsu1yxd0xcQlhVdWWi
         ikSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679085223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wke3FPs7Ksv6rdzTGLQOkGDYUGmajxnF7vbyk/QEY5M=;
        b=sEcl7ENcV58BnTe5n1C8j1I7t/lKshwdcqtit9bXK1LXRjABgaKU5VCixBsFFLjDxe
         h8IQ90t0arJffqL4MFRAmoSY85F/FOt5hv+NKF6vWb8EbOe9Sob1BQWCKKcGZMSC2sFN
         E0y6Y2aXiNaNj0nePU0gmJxJd3HhH8Pk62DT533TQtgjic/Mgs0eArZpsY7AfRr/5If2
         6DPRAUJndDRmA8U3rqVVKUDUdXFg488pV0HZHN1Mz+d6DKeVsXduJAfEbVnnYuVqctxA
         XE6L8W/imAd0RktopdDtO7/YNC9NwFmwTtziK6Wc96XY0Nog6qrF2naf4Q0t5iyJxaoH
         bC5Q==
X-Gm-Message-State: AO0yUKUI7VFJBs1UTutpkQKtVS/tgOtys0a6AUUMDagdsx3zVuYorxN8
        caGie8Hogb91pMvA4wRwzGM5J8nQJ8tMnPmorqk=
X-Google-Smtp-Source: AK7set/YuBkzP6WyMGzlC9nZEPEbnnDJ9dqg2061edUzcDXG7f3D3edvz316vDzNRmw/On8Ilp4z5tSaeQqfvaVv+ag=
X-Received: by 2002:a9d:5d04:0:b0:69f:882:cdb2 with SMTP id
 b4-20020a9d5d04000000b0069f0882cdb2mr6297oti.3.1679085223009; Fri, 17 Mar
 2023 13:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230317081718.2650744-1-lee@kernel.org> <20230317081718.2650744-28-lee@kernel.org>
In-Reply-To: <20230317081718.2650744-28-lee@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 17 Mar 2023 16:33:31 -0400
Message-ID: <CADnq5_M5Q+MJvd6RJjeYNMmf3WgnGkUBKhp3v8BU67CaaKokrA@mail.gmail.com>
Subject: Re: [PATCH 27/37] drm/amd/display/dc/dce/dmub_psr: Demote kerneldoc abuse
To:     Lee Jones <lee@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        David Zhang <dingchen.zhang@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
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

On Fri, Mar 17, 2023 at 4:23=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:257: warning: Th=
is comment starts with '/**', but isn't a kernel-doc comment. Refer Documen=
tation/doc-guide/kernel-doc.rst
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: David Zhang <dingchen.zhang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/=
drm/amd/display/dc/dce/dmub_psr.c
> index 27b8f3435d86f..9705d8f883825 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> @@ -253,7 +253,7 @@ static void dmub_psr_set_level(struct dmub_psr *dmub,=
 uint16_t psr_level, uint8_
>         dc_dmub_srv_wait_idle(dc->dmub_srv);
>  }
>
> -/**
> +/*
>   * Set PSR vtotal requirement for FreeSync PSR.
>   */
>  static void dmub_psr_set_sink_vtotal_in_psr_active(struct dmub_psr *dmub=
,
> --
> 2.40.0.rc1.284.g88254d51c5-goog
>
