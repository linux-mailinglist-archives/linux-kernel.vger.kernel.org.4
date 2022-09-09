Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19875B4149
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 23:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiIIVJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 17:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiIIVJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 17:09:16 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0C5102D72
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 14:09:15 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-11e9a7135easo7145503fac.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 14:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=7jvsuFLboFap0DqFA/F94XSGxZ5vpki++gWbUl4bVvA=;
        b=Au7/wxInrHM2+FVGogak8BOmCEKU4fP6ejt+uu8CNyvGnOnKKmg3YfFDsmXi3AI3nn
         sFiyvQGDDZiiJeIz6PR2+RXiV5paMtA/B+oQlM+x1ZVRfAubnFK35jdVEiTHZypLDSk0
         NtyEkCqOeDfd/nrycdsCM0Z952j2YLpaohtOflkIMESmYI1j9VcP9fhE9kWudTqxdORH
         rd5zg8dUXyt/HMTaultDr2IQoIqPo7lWTklGtoI5uAee9UKxffbOKYJx9pJb7Nk2pJvm
         oFom7uH/LOHuKsMBc76e/XAbcnM0pB4leQN9pDtMOJLedqiT04hvNClGnjCEZMf3RmG8
         5P/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=7jvsuFLboFap0DqFA/F94XSGxZ5vpki++gWbUl4bVvA=;
        b=EeS6b5Q9JCoTbcDNkyzlwDwm7S9lumhtITJCtdWjlS/SG/cp3ZXySCybXf4xIK19lB
         SS/n5RUvrMv858GYxIsgSpzraJT0TC+dR3edO6XZRr01uVpFEtzMGaLD59q63A3xhKwX
         4MhZajmEajcMYt0rACZA+wBq3qOzs2Q7j+52r9YgjgKBt6TtFk/fMWopoeb7Cbjfvhm0
         5OrXD3g+JaEt7p588nqfohOxQ+5glTfotI77bZO9p7PJ4def2MZMVgwnCDp/szFKKd7L
         Sv14yaJ7lWnDkQxEv0JiY/lJSlTIeTGAo7yYkILgvrLMS+WSIqoopw7jESwjiiE8kLkx
         iVwQ==
X-Gm-Message-State: ACgBeo0HVTA7zViPnqdAwPDRDJWlqeAfTtw9r+ZF6lEB9DalwSzxppLT
        EDRbESohrG1r+otnGJFY8cVwYHF2O2lo0AuvxKZDQU8t
X-Google-Smtp-Source: AA6agR6P3Z9Yu9X16sZVcmgZ+vejDXLgEOwexym9sd9UWT7wVFeWHkLdC9YDaDu7OcRPbLdR2ANVekydwJBWMDFUgco=
X-Received: by 2002:a05:6808:138e:b0:345:13d1:fd66 with SMTP id
 c14-20020a056808138e00b0034513d1fd66mr4554277oiw.96.1662757755081; Fri, 09
 Sep 2022 14:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220909195330.85888-1-jingyuwang_vip@163.com>
In-Reply-To: <20220909195330.85888-1-jingyuwang_vip@163.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 9 Sep 2022 17:09:03 -0400
Message-ID: <CADnq5_P+iumnU+UPk5=HjYD7ie5Kr+dYy0j6vPTRycH-H-nBeA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display: remove unneeded "default n" options
To:     Jingyu Wang <jingyuwang_vip@163.com>
Cc:     arry.wentland@amd.com, Rodrigo.Siqueira@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks,

Alex

On Fri, Sep 9, 2022 at 3:54 PM Jingyu Wang <jingyuwang_vip@163.com> wrote:
>
> Remove "default n" options. If the "default" line is removed, it
> defaults to 'n'.
>
> Signed-off-by: Jingyu Wang <jingyuwang_vip@163.com>
> ---
>  drivers/gpu/drm/amd/display/Kconfig | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
> index 413d8c6d592f..6925e0280dbe 100644
> --- a/drivers/gpu/drm/amd/display/Kconfig
> +++ b/drivers/gpu/drm/amd/display/Kconfig
> @@ -28,7 +28,6 @@ config DRM_AMD_DC_SI
>         bool "AMD DC support for Southern Islands ASICs"
>         depends on DRM_AMDGPU_SI
>         depends on DRM_AMD_DC
> -       default n
>         help
>           Choose this option to enable new AMD DC support for SI asics
>           by default. This includes Tahiti, Pitcairn, Cape Verde, Oland.
> @@ -43,7 +42,6 @@ config DEBUG_KERNEL_DC
>
>  config DRM_AMD_SECURE_DISPLAY
>          bool "Enable secure display support"
> -        default n
>          depends on DEBUG_FS
>          depends on DRM_AMD_DC_DCN
>          help
>
> base-commit: 5957ac6635a1a12d4aa2661bbf04d3085a73372a
> --
> 2.34.1
>
