Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC26F6B1A28
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 04:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjCIDv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 22:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjCIDvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 22:51:23 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740DCC80A9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 19:51:09 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1767a208b30so1087480fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 19:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678333868;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hp14W4WtX0awNKWlLDE8zn48w3QnOXp8Ol12gIgmm9Q=;
        b=VZC2zz9bQaHlgp8s90U6kGkWkCxhJ0OE6aJWd1dOE4d569lv4K6qFJSquVuLElIU2D
         5ODRKZ63UrxfYKmBbMwSdSoQseO4AfRK8ijNU9SkX2D8EX9Gk83Bnu4EnkfvfY6w9upt
         D5/Qtn9yzYeGgoB8Bkmh4nvLK9glBHUKJzQnfzR1YXvDippAqffd19QWHj3tY1v/Vs3X
         nd0C2ks7xZaVJpQjsl0Cexx5DUixu11eN5ZOIAsQEqp56KkY3RZPtfOFKRY9dkVsfA3A
         APpFa2to/g+3eoj7mBecMyyk76ALfu9L4xC70YQmfF2mkvU0jR59u1xV6dOWvCMXUWuA
         /Jug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678333868;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hp14W4WtX0awNKWlLDE8zn48w3QnOXp8Ol12gIgmm9Q=;
        b=Gh+Rg6z/kLgEulIKFSlh2zW560yYcTul6mgtaSeWppnVvq2F+W4dPHZWhLF8RazIa+
         soyqq47OXofzF6Ndr9X5SJBc1Qzb0uBgh/8q+vAgswcys0CPVAfwHfRko6mPrzjwziLV
         81s8GntA/xIBuEagW4vOalhW2Agr22WNDMr6zuwE/7Rlo+xoqyn5xa3S81wrYStzRqUq
         HrgthtPcfeR833nEPRjzXMLIn/7zxJN06OMTemttl9txO4wJ2qM6t2YbS3HBqXeQy8JS
         A3uGqJhamkPp12T6i87nDUG2DfoalXTuMcODlbas68fV2Gfmk+BXIGm8TCfMuz4VvS+E
         MhdA==
X-Gm-Message-State: AO0yUKWHfpj8O5BjeZjFHAGCPg1LQJgIan7DKeUL9KKLq9+Hpc2w3811
        XohHOGfgGE5Vow63eRKKfDwYSG5KS/MLeII6z3l4PY/7
X-Google-Smtp-Source: AK7set8/iY7kVgL0ioTsy+Jeuo0eKBcUzi4tLPsAvZfwHYXHjco2pvMZKjXNsvI/ayzliVhBEIXgojGVUdg8xahMuAY=
X-Received: by 2002:a05:6871:6ab0:b0:176:4261:5e36 with SMTP id
 zf48-20020a0568716ab000b0017642615e36mr6988343oab.3.1678333868432; Wed, 08
 Mar 2023 19:51:08 -0800 (PST)
MIME-Version: 1.0
References: <20230309033654.64762-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20230309033654.64762-1-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 8 Mar 2023 22:50:56 -0500
Message-ID: <CADnq5_NEYTz3kU+2BRC9x3hyMGO7+hEmr4zoabKpU9uzW3xG8g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Remove useless else if
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     alexander.deucher@amd.com, Xinhui.Pan@amd.com,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, christian.koenig@amd.com
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

On Wed, Mar 8, 2023 at 10:37 PM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> The assignment of the else and if branches is the same, so the if else
> here is redundant, so we remove it.
>
> ./drivers/gpu/drm/amd/amdgpu/nv.c:1048:2-4: WARNING: possible condition with no effect (if == else).
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4454
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 855d390c41de..84803929f7d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -1045,19 +1045,11 @@ static int nv_common_late_init(void *handle)
>
>         if (amdgpu_sriov_vf(adev)) {
>                 xgpu_nv_mailbox_get_irq(adev);
> -               if (adev->vcn.harvest_config & AMDGPU_VCN_HARVEST_VCN0) {
> -                       amdgpu_virt_update_sriov_video_codec(adev,
> -                                                            sriov_sc_video_codecs_encode_array,
> -                                                            ARRAY_SIZE(sriov_sc_video_codecs_encode_array),
> -                                                            sriov_sc_video_codecs_decode_array_vcn1,
> -                                                            ARRAY_SIZE(sriov_sc_video_codecs_decode_array_vcn1));
> -               } else {
> -                       amdgpu_virt_update_sriov_video_codec(adev,
> -                                                            sriov_sc_video_codecs_encode_array,
> -                                                            ARRAY_SIZE(sriov_sc_video_codecs_encode_array),
> -                                                            sriov_sc_video_codecs_decode_array_vcn1,
> -                                                            ARRAY_SIZE(sriov_sc_video_codecs_decode_array_vcn1));

This should be vcn0.  I'll send out a patch.  Thanks!

Alex


> -               }
> +               amdgpu_virt_update_sriov_video_codec(adev,
> +                                                    sriov_sc_video_codecs_encode_array,
> +                                                    ARRAY_SIZE(sriov_sc_video_codecs_encode_array),
> +                                                    sriov_sc_video_codecs_decode_array_vcn1,
> +                                                    ARRAY_SIZE(sriov_sc_video_codecs_decode_array_vcn1));
>         }
>
>         return 0;
> --
> 2.20.1.7.g153144c
>
