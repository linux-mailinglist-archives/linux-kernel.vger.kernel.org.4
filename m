Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F063165DB48
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 18:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbjADRah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 12:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjADRaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 12:30:35 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F35C15725
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 09:30:34 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id v15-20020a9d69cf000000b006709b5a534aso21139806oto.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 09:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qcvt8eh5u3jiwS1uurMGyfwX+9LkSAcqQgzciAku68s=;
        b=d8/9SpVPU7WL3d9+TCOTqSUjTgV0TdrbEaPSgajJJe80tyjT9JW0e2ovpH1D5hQf1i
         5y+NXU1Isls0KfGTP45/Bc1gYfX51BRNOG8drqyq7w5WV5fJ9ACZ6A4CqWZ6De16gTtZ
         1wX3nWw4VyjWp8yTViHWaQqCLamPkidvDtHj12/uYbZfqkLGaPzhuN0EK2ZeCkrEbn4O
         yUmTbpQd+Mb02PZLFPuxCvjfxGnsvGPshMhkt2sq5J+yVlAx4sBU5ONIL8EcrFPcWFQz
         uZoChbKguX9jiIybrGeu2LdLadfMcXpwsmEtHw0Kx+t7Sjr5VihhAp0X4D/cIyBtqqC+
         pbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qcvt8eh5u3jiwS1uurMGyfwX+9LkSAcqQgzciAku68s=;
        b=eQGMXzcIevtWMQSvsdjr4LRcvF/aH1rdanVxR8gZlVFjfEmxnq4SktVGLdrjUliluY
         uEmInJdxyXrwXra4ozL0NCzCVNBqBbdokFWy7Tzoc7844E460+cgMZacJsEh1+UJKIam
         VNE17uLhes+1SdprddkH0LJxJJuUUF4UPO1vkvb6CVYb7iOKu3SX39chFv2Z3gioq5Oh
         gg12coXQ3RoGxeGKdJZt1jAWvKq4hpoBUw8WQzzS8HsD+GocOwaGolBB3Arh5Qhyn5fD
         wyDfHhnrr3u/N4cYN3hklAe/32RBbDTDbLNdIgr24TdsY5ri4zhJQ7RjYTK4erni07GP
         wBCA==
X-Gm-Message-State: AFqh2krfCKJDO8udm+4bMw/+x7E5jcZi5J68ib/CdOd2YbfwPvIDoXg4
        IycMFAO5uDF/+qteiIIQzRcXfkz8jqcx12V8Tek=
X-Google-Smtp-Source: AMrXdXtMAMNL/KMNkRIFRDaQNb7XroAB+qD+qaH8wu1bibXrlG8xHLN3IbD2SQrSd9LHx19dUTDLMJ2ScX135Ata/0Q=
X-Received: by 2002:a9d:6ac6:0:b0:671:cacb:681f with SMTP id
 m6-20020a9d6ac6000000b00671cacb681fmr3039203otq.233.1672853433856; Wed, 04
 Jan 2023 09:30:33 -0800 (PST)
MIME-Version: 1.0
References: <20230104164042.30271-1-mario.limonciello@amd.com> <20230104164042.30271-46-mario.limonciello@amd.com>
In-Reply-To: <20230104164042.30271-46-mario.limonciello@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 4 Jan 2023 12:30:22 -0500
Message-ID: <CADnq5_OkOvjaJFFj2HzQE+PTRqMby0uHEkgziGnaxwn1=JoRiA@mail.gmail.com>
Subject: Re: [PATCH v5 45/45] drm/amd: make amdgpu_ucode_validate static
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        linux-kernel@vger.kernel.org, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Lazar Lijo <Lijo.Lazar@amd.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Carlos Soriano Sanchez <csoriano@redhat.com>,
        christian.koenig@amd.com
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

Other than the patches I commented directly on, this series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Jan 4, 2023 at 11:45 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> No consumers outside of amdgpu_ucode.c use amdgpu_ucode_validate
> anymore, so make the function static.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index dc6af1fffdd9..b759a4300d7a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -504,7 +504,7 @@ void amdgpu_ucode_print_gpu_info_hdr(const struct common_firmware_header *hdr)
>         }
>  }
>
> -int amdgpu_ucode_validate(const struct firmware *fw)
> +static int amdgpu_ucode_validate(const struct firmware *fw)
>  {
>         const struct common_firmware_header *hdr =
>                 (const struct common_firmware_header *)fw->data;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> index 7fd2f04f7f98..28fc2960edfe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> @@ -543,7 +543,6 @@ void amdgpu_ucode_print_rlc_hdr(const struct common_firmware_header *hdr);
>  void amdgpu_ucode_print_sdma_hdr(const struct common_firmware_header *hdr);
>  void amdgpu_ucode_print_psp_hdr(const struct common_firmware_header *hdr);
>  void amdgpu_ucode_print_gpu_info_hdr(const struct common_firmware_header *hdr);
> -int amdgpu_ucode_validate(const struct firmware *fw);
>  int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
>                          const char *fw_name);
>  void amdgpu_ucode_release(const struct firmware *fw);
> --
> 2.34.1
>
