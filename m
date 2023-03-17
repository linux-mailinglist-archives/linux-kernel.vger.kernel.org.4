Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EE86BF233
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 21:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjCQUPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 16:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCQUPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 16:15:37 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CE93770D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:15:36 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id c11so4682958oiw.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679084135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssXa7B9Q8qv4Ykfx+ca3jrD7S00rXq3zvQFoTDsLna4=;
        b=G5mTBIbKn3hcD/N0ZdeF7HIwdAC8D+0YMLQkZmhv5iXmstGfrAM65vsTga9nN7i2wd
         PE9tmji5n0Gr2FDKPlr1Ne2P8E+C4CH6WPTcgYUKW5SCFbPcYKjyXKwpzixWqqN5T0V5
         sErftA+Vn6MmY7V1HTN2GPhCWtCyCce13HgtXhZyCxth+mTzMHilnJ4BIFlCN5ton1oc
         Pi60wgadA8N+XcJMBiGFBHbm4i/ZQqo4s+2lG9Xlqtt673FTwD1eXKtrBQKyhhahGLOH
         jQ/CgdL5LDayGA8TVTBzXQw4PUC8TRGJTuVTu/PnJxQa2ukF1FYzNju427liu2of5k2T
         /0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679084135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ssXa7B9Q8qv4Ykfx+ca3jrD7S00rXq3zvQFoTDsLna4=;
        b=K1Dc1WAYZ4PNMi9MflIfcfF4D3a7+5plRb2uEfvmm+DWRDjqRfHDFlTVs6vk5kawzM
         ykMWtO6cVI2Zo4l1lnH1pw8HGHQxnzi9ca6srey90j9wdRlfjYluSJ0W+oUEAg7aOtoD
         UTg4F+uNJ4IpGJAjGMegM3MmI8sz0GiNDX1ZQ5LWOdyQdQQTbi6cfeJwKVyDt+3jm8VU
         CJziO+rbGNWBHbi2q4xVbXUq9G+ZMcygrLiXllvyhQbidrF3FgcldlPucmxGSpWzxSl8
         4mKChZndgwgatgVDk0KoCvPnixvyU0WNh5z98quKGPL3jIS2M48TBbz4g7Ddae8m6yYs
         lP9A==
X-Gm-Message-State: AO0yUKWi82KxFDdECsNa71feIA4Xo3wGzJv1GZ82GeKqx97ohvIGMeMH
        UK+BRz+i5G9UGuPfonJP4mgQ3jY7HfvWcr5ZreAVLoKJ
X-Google-Smtp-Source: AK7set/bq+3Ab6sQ2VkRehpQP42jZXWmATFRqbNM/pQ1TKr6YG6iyG9jkGE8uiXf++HGwe6TOVCh7TYjfwDo1Kz4vnM=
X-Received: by 2002:a05:6808:6384:b0:386:9c6c:ebc with SMTP id
 ec4-20020a056808638400b003869c6c0ebcmr3705113oib.3.1679084135712; Fri, 17 Mar
 2023 13:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230317081718.2650744-1-lee@kernel.org> <20230317081718.2650744-2-lee@kernel.org>
In-Reply-To: <20230317081718.2650744-2-lee@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 17 Mar 2023 16:15:24 -0400
Message-ID: <CADnq5_MxtNaDZ8Q2DOnVxjt=eVquNeYJF=DZfRdtS==-VQ7GMQ@mail.gmail.com>
Subject: Re: [PATCH 01/37] drm/amd/display/dc/dc_hdmi_types: Move string
 definition to the only file it's used in
To:     Lee Jones <lee@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, Leo Li <sunpeng.li@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Wenjing Liu <wenjing.liu@amd.com>,
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
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dc_hdmi_types.h:53:22:
>    warning: =E2=80=98dp_hdmi_dongle_signature_str=E2=80=99 defined but no=
t used [-Wunused-const-variable=3D]
>
> [snipped 400 similar lines for brevity]
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
>  drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h       | 1 -
>  drivers/gpu/drm/amd/display/dc/link/link_detection.c | 2 ++
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h b/drivers/gpu=
/drm/amd/display/dc/dc_hdmi_types.h
> index c364744b4c835..b015e80672ec9 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
> @@ -50,7 +50,6 @@ struct dp_hdmi_dongle_signature_data {
>
>  /* DP-HDMI dongle slave address for retrieving dongle signature*/
>  #define DP_HDMI_DONGLE_ADDRESS 0x40
> -static const uint8_t dp_hdmi_dongle_signature_str[] =3D "DP-HDMI ADAPTOR=
";
>  #define DP_HDMI_DONGLE_SIGNATURE_EOT 0x04
>
>
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drive=
rs/gpu/drm/amd/display/dc/link/link_detection.c
> index fee71ebdfc733..8cfeddfb65c89 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> @@ -60,6 +60,8 @@
>   */
>  #define LINK_TRAINING_MAX_VERIFY_RETRY 2
>
> +static const uint8_t dp_hdmi_dongle_signature_str[] =3D "DP-HDMI ADAPTOR=
";
> +
>  static enum ddc_transaction_type get_ddc_transaction_type(enum signal_ty=
pe sink_signal)
>  {
>         enum ddc_transaction_type transaction_type =3D DDC_TRANSACTION_TY=
PE_NONE;
> --
> 2.40.0.rc1.284.g88254d51c5-goog
>
