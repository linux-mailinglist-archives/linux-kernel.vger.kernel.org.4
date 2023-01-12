Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D4E667EE6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjALTUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240362AbjALTTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:19:44 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF9BB9B
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 11:07:46 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id r130so16055512oih.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 11:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GiJEsLNpkHnW+GAQ0NBigzoD8JOv1F6wdXxOX2ruxq0=;
        b=Oheuo3BVTnqAZlN/6ElEIymARl5QOK1V5kY8iK6oj+KM7C4k7SjlcnaDljEFwlwcYm
         GOV8V0+Mkpgf72QV2JFVsrxOcUsWhwUS3c/JJofbAh0l+OwCr3i6Q02y/Eo342moqK+O
         oHs27IiX4biAXdNzZWFrp/RdzzirfxM8tDGjIJuIBOedKNJLOyVKYD0b4EN5NsNJ1PL7
         3dvWW6s0MWS3LvEqwFxlRi5sjLB+xWggFjNnwepkvufPYVb1DFaRqHwvP+m1cmJUHAEr
         T9Z42IBFfdOCwii2BRkohu+ZeJQI4GQ/J2glQFmhrABacuWEwoC82rgueKv0Ss7rU0i7
         MLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GiJEsLNpkHnW+GAQ0NBigzoD8JOv1F6wdXxOX2ruxq0=;
        b=H+jcmmA2nbYE6smGCxc1awDoxILqD3oYxl3jEb0p7wpzXGXwCn9+JXkKsiohyyC6Xx
         ynSDT/8ESak8fVNuQBHxWTf6S3DrzEowyEEnn8jsQ5152VaACgOLeExlOwBatFxCqiVW
         dC2w1ndM0XsXhsEj4+AxdKuXvmyZy38+H3OHBWd8tOb07NBYXE8Xp7nQCwF7h5xRuDSB
         wB+clOhx5cgSa266vYQgarYQVxNetL3GQoC7ukHNEbBDeWPinbwexuEigJmV7H0y36Iv
         j2RwPNbCTwWxkNPu/3x2drkgEZLAQVjFoa2XmUV3THNhlr8T0jHoyS6Sfed8PmbnNdxK
         buFQ==
X-Gm-Message-State: AFqh2korNu0PdKvVpQSuaH7PH3ggkqTNNrs6mSlQnpKcFRY9BmInQA0w
        y/5UsPhikvj8vMOmwjFmSQZ40mzW9OeDZkJ13Vw=
X-Google-Smtp-Source: AMrXdXusvS3C+v7xV1vK0cy5jdeabhFLWWpt3LVQ6eqjaO2XL1mtufA1+VPFCSBypjA5EBfJ0rsqKpNsWmFeOs8JYdE=
X-Received: by 2002:a05:6808:2001:b0:35b:d93f:cbc4 with SMTP id
 q1-20020a056808200100b0035bd93fcbc4mr5087507oiw.96.1673550465717; Thu, 12 Jan
 2023 11:07:45 -0800 (PST)
MIME-Version: 1.0
References: <20230112032049.128610-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20230112032049.128610-1-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 12 Jan 2023 14:07:34 -0500
Message-ID: <CADnq5_N=gp4KXxt6SCg31tRbOu66qp5NV2V9OKcMWP2fRntbhQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove useless else if
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Abaci Robot <abaci@linux.alibaba.com>, Xinhui.Pan@amd.com,
        Rodrigo.Siqueira@amd.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        alexander.deucher@amd.com, christian.koenig@amd.com
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

Applied.  Thanks!

On Wed, Jan 11, 2023 at 10:21 PM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> The assignment of the else and if branches is the same, so the if else
> here is redundant, so we remove it.
>
> ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:1951:2-4: WARNING: possible condition with no effect (if == else).
>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3719
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 4300ce98ce8d..aa3024e58d12 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1948,10 +1948,7 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
>                 dmub_asic = DMUB_ASIC_DCN21;
>                 break;
>         case IP_VERSION(3, 0, 0):
> -               if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 0))
> -                       dmub_asic = DMUB_ASIC_DCN30;
> -               else
> -                       dmub_asic = DMUB_ASIC_DCN30;
> +               dmub_asic = DMUB_ASIC_DCN30;
>                 break;
>         case IP_VERSION(3, 0, 1):
>                 dmub_asic = DMUB_ASIC_DCN301;
> --
> 2.20.1.7.g153144c
>
