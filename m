Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC73866034D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 16:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbjAFPa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 10:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbjAFP37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 10:29:59 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748CF8CD34
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 07:29:44 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id i127so1308067oif.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 07:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=65qSmGmypBwql4yygZi8U8Y0QUeOs13b5WCSPH/ZqUQ=;
        b=JLQykHDcS1zKJIrE0dQuyBmiNCv+IYRcVdtUJIsVEvjENQHoVGI1Ri8Ksd53ABlcrl
         SgDRUh5k0oyrXWzT8zfzWN61rdDPDITnmCEhACbCnFaRV6iT/meialGfRDV2iF0bIMJN
         25fnyBAfYt7aFExEHiZF6JkJ0xkRd1GAadfzjWHwzhj0/L9igcOn1Iq87cYNjA48z+NB
         VBxou58mvCaanlU3cZWo5fU/DBSHqQBadAcbID+bnAWxu7vrDLr59vJNx1aBTgpxTbri
         ABAjSaRx8lb2bzfdHbbbYVBPZw70pK+DIRsZvTAxoFvLo37mGt/PteosyvsWx/7F6ry1
         69KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=65qSmGmypBwql4yygZi8U8Y0QUeOs13b5WCSPH/ZqUQ=;
        b=7Z4qD2RGkvwdIW1dNTQ2atZVrCX8bmlMjOQ94LmdqzOmxRIkoiYcgNSrbWsfMvwKVj
         B6jKRIkHdP8We+zcbSQwMRv+TrQeeOAwJ26js2lJSgv2Nvxwg58BCXvuul2cqtQlnCc5
         QFpAXWQotSQ/QCLms6/WliIGggLIGYqqRhkd64ncjAlLdNFNWKcU8GCUkzoUoMP1gIM0
         0re5zfL+Ksy4xG8BzLJaQLYg6EXHqQ5zVpU+Bjjl9kzI4rFaPDwbjJp7afEQsg84sUYi
         bYrxJ7RyYwIVUoV9krLqMyUONdeDF0H6w2Kn+YKmS0jqHZ5nqY7GtiWcij0tA0sY2uJ8
         Tnew==
X-Gm-Message-State: AFqh2kq6arTJ7yNG1GnJo6yHP8sPqzrNqvj5RDLWyTHiTaj9oTwhS+MD
        2G4oTJ9cryEFhBdYcunvgW3B6nk9KGu3TdS/PKk=
X-Google-Smtp-Source: AMrXdXulMJ+JdC0imQzl49t89u5AcQDZaBrY9QdB91cd67Chvp/1y/weZ/pj9wtho0z2KnmqLYOGN63vb7U/0qsU4UU=
X-Received: by 2002:a05:6808:2001:b0:35b:d93f:cbc4 with SMTP id
 q1-20020a056808200100b0035bd93fcbc4mr3588739oiw.96.1673018983790; Fri, 06 Jan
 2023 07:29:43 -0800 (PST)
MIME-Version: 1.0
References: <20230106002453.18770-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230106002453.18770-1-yang.lee@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 6 Jan 2023 10:29:32 -0500
Message-ID: <CADnq5_POir-_+xrSL7eRQtPtMo1v2QkmuKdNFxg0oPYBGzi8eA@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: Remove unneeded semicolon
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     alexander.deucher@amd.com, sunpeng.li@amd.com, Xinhui.Pan@amd.com,
        Rodrigo.Siqueira@amd.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Abaci Robot <abaci@linux.alibaba.com>,
        dri-devel@lists.freedesktop.org
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

Alex

On Thu, Jan 5, 2023 at 7:30 PM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:7431:3-4: Unneeded semicolon
> ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:7485:4-5: Unneeded semicolon
> ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:7489:3-4: Unneeded semicolon
>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3635
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index cabe02cb307c..90dc72e98eb2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -7428,7 +7428,7 @@ static bool is_content_protection_different(struct drm_crtc_state *new_crtc_stat
>                         new_conn_state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
>                         pr_debug("[HDCP_DM] ENABLED->DESIRED & mode_changed %s :true\n", __func__);
>                         return true;
> -               };
> +               }
>                 new_conn_state->content_protection = DRM_MODE_CONTENT_PROTECTION_ENABLED;
>                 pr_debug("[HDCP_DM] ENABLED -> DESIRED %s :false\n", __func__);
>                 return false;
> @@ -7482,11 +7482,11 @@ static bool is_content_protection_different(struct drm_crtc_state *new_crtc_stat
>                                 pr_debug("[HDCP_DM] DESIRED->DESIRED or ENABLE->ENABLE mode_change %s :true\n",
>                                         __func__);
>                                 return true;
> -                       };
> +                       }
>                         pr_debug("[HDCP_DM] DESIRED->DESIRED & ENABLE->ENABLE %s :false\n",
>                                 __func__);
>                         return false;
> -               };
> +               }
>
>                 pr_debug("[HDCP_DM] UNDESIRED->UNDESIRED %s :false\n", __func__);
>                 return false;
> --
> 2.20.1.7.g153144c
>
