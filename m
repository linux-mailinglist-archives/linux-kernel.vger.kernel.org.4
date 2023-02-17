Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EB069B383
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 21:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjBQUIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 15:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjBQUI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 15:08:29 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F62312053
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 12:08:26 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-171872a792fso2429272fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 12:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xtVHaFcLaV3UoWU9Nhrzhuzu3cPVZ3Sq7osbDb6HaUs=;
        b=IPET/YQD1zt2dKuCNYeXspwZF2Mdwqbqvp6ACWfPk25cSLErwYndHB+GX2X0Qla1hX
         fBbp89RuZ0GV0uVotYv1TQCYpQuqcn7P7/jVvVFmD6sMI2Cab3XOQsljDpuTu+LfzR6x
         DzFrUJpWtPQu60hlPmIW8yjt/aMA/SU0TaoM/j45BPzTRMc4AIX5QyWmjcF6cwo4JUzt
         ktwN2AIMDhrMhJsSKbI+dJ2brt/v6jyOciKjWkJA6LIEb3rNnKbiTSLWe9MRMyAMvnQO
         1WWK3nYYo/D8SKzSMRnY16XWUjwBI0XB1vlLr3q59+T8B4C7crvQr4ZEZ33HMm+7d+Cg
         KxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xtVHaFcLaV3UoWU9Nhrzhuzu3cPVZ3Sq7osbDb6HaUs=;
        b=XNb9Ec14BFxDebWAIQATyAaHUqrijmOVs5Z2Hhn3/5I1Z2r9nfeK2uBVTi3Gtrp8GX
         x/EJfMEk5YfuLfpGsFsJ2o8U2AsFllJ349jasWsUZDY5yB9nZjgJlpoxHrNrOiHVRklZ
         wn5jZLdj2BjMHSlKaeAANdF2Q+s5CJIG+FjAMPDlhSyUrEECThxWuVuaHqPKjMyxkocn
         Ygvjb5JSIds7zMR6FBKWvRirfuV1PFq/VYD6aBzzKGZ1rfwYzaEybv2lpvXxJ7eGYTC7
         W9dF41kK5BfsnnbQClmvvLi5qm5JGyebiZMdlxDeJCJt4IKie7nLTMIhav+JHeOyqMPv
         pAcg==
X-Gm-Message-State: AO0yUKVcIiQGqT3VWrsHMQzACD1rohqOvpnIOzlV5LWEo33DrtT5OzLs
        hDUYeDy2CzUTKaYlRX62mjzDxeIVO+lmWf75L7s=
X-Google-Smtp-Source: AK7set/i5lu6BZPRg5UK2Qdn96F60bY6LFITBSPWXluDBI6/WklEXoQKB5+25LAr9DM+nIdzVW6lL6rAX4Dpd/7oD0o=
X-Received: by 2002:a05:6870:e88d:b0:16e:91ef:75a0 with SMTP id
 q13-20020a056870e88d00b0016e91ef75a0mr370672oan.138.1676664505561; Fri, 17
 Feb 2023 12:08:25 -0800 (PST)
MIME-Version: 1.0
References: <20230217074449.14594-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20230217074449.14594-1-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 17 Feb 2023 15:08:14 -0500
Message-ID: <CADnq5_MX-fdkqseNuP+Ej6WZ5-FmowWosY-nb2kwEhqxMP-PoQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Modify mismatched function name
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

Applied.  Thanks!

Alex

On Fri, Feb 17, 2023 at 2:46 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> No functional modification involved.
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_detection.c:1199: warning: expecting prototype for dc_link_detect_connection_type(). Prototype was for link_detect_connection_type() instead.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4103
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/link/link_detection.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> index 38216c789d77..5394d8a6087a 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> @@ -1189,7 +1189,7 @@ static bool detect_link_and_local_sink(struct dc_link *link,
>  }
>
>  /**
> - * dc_link_detect_connection_type() - Determine if there is a sink connected
> + * link_detect_connection_type() - Determine if there is a sink connected
>   *
>   * @type: Returned connection type
>   * Does not detect downstream devices, such as MST sinks
> --
> 2.20.1.7.g153144c
>
