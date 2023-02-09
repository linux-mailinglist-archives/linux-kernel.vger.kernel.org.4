Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B67690BD0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 15:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjBIObR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 09:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjBIOay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:30:54 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AABB5C49C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 06:30:39 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-16346330067so2752421fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 06:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=chp1QLTcxBkTY4TOrgE4Wi5O1rzO5OCYMKuxrfK4j68=;
        b=KNzH3CVAWGBGlv02T5KfmPqSWwO7h1UluFuofcAgn10PE3n/U1bbqOvsVle1x7k9rV
         VBVUp56CSkXO/8bpa4WQ81GmMxywPDVOGfEHMWYB2XCjcI1rX3O4J66ALFMcUzYyuDab
         JbNBJpTangtVEFzLI/gZniRel+0gH2xQgAwbAoKble+ZkU1XxPD8D7erln07QJViF0q3
         zdydHL0uCPq5QkPWlrRAq56K5Qd5GUbkeoalyK26KbjX3bEWcMTkHgnWsFVMIhQcfGsf
         B406GaCQkUoPkhlqlf0LbLj/20CG9T+aNF7z+6rVW4TcRKUmgpdWXfz4y2FZCYKfNM2O
         RYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=chp1QLTcxBkTY4TOrgE4Wi5O1rzO5OCYMKuxrfK4j68=;
        b=4hH/2sqV6jFB2CJNBwZ654KWiZC/GdOgjCizEPzOu3QCTChZD67GXLGZ6kao4WpTjN
         qnCr4K1QLyVZz/bMEzDnlaQU+dT/Zlvt6D2gKdeYAHgGvSST6thjeEi9b2/7CeR3GQO4
         1ycrfUaNp74rlaOMMXSVbMuCUFejIW0215nYKM0l3DaRv0Jbi83iqwIkoCINOgfojpmw
         y2uI/fl/tgxbiAd+bXBMQUIwAu8kcDlyUDxGWUQaE8I0d211925tauje57uWPf8ZzxCl
         26bgSmDDufITn5AW0o0xrYNsAis/1FLJXdwkMfduOwZTUBmCc6E41+3//el+Inf4E6f+
         Wk4Q==
X-Gm-Message-State: AO0yUKVmI1pEBx3QuS5OKFQLA87zHZIPrOMzd7mpdkHZ+9583rXOea2y
        GyWngOei8CWDo1Mp1E/bQtU+n5BlRPd/4OCe+jA=
X-Google-Smtp-Source: AK7set+vS39LPKDgruUd/z+73JEkh3t78Mgwy0EAHKWoE/WoO3LHHU9ATlmJ3FF5Bh4+XR4xzAXPfIXnILGdHIZVsJk=
X-Received: by 2002:a05:6871:29c:b0:163:8cc6:86a with SMTP id
 i28-20020a056871029c00b001638cc6086amr1083190oae.46.1675953038825; Thu, 09
 Feb 2023 06:30:38 -0800 (PST)
MIME-Version: 1.0
References: <20230209134049.2000865-1-trix@redhat.com>
In-Reply-To: <20230209134049.2000865-1-trix@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 9 Feb 2023 09:30:27 -0500
Message-ID: <CADnq5_PnkVTYR87AWLBU1K6m4vVgp7vamVETO1DdRTXd9nUWfA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: set should_disable_otg
 storage-class-specifier to static
To:     Tom Rix <trix@redhat.com>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, Dmytro.Laktyushkin@amd.com, qingqing.zhuo@amd.com,
        Charlene.Liu@amd.com, nicholas.kazlauskas@amd.com,
        meenakshikumar.somasundaram@amd.com,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

On Thu, Feb 9, 2023 at 8:41 AM Tom Rix <trix@redhat.com> wrote:
>
> smatch reports
> drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c:90:6:
>   warning: symbol 'should_disable_otg' was not declared. Should it be static?
>
> should_disable_otg() is only used in dcn315_clk_mgr.c, so it should be static
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
> index 8c368bcc8e7e..a737782b2840 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
> @@ -87,7 +87,7 @@ static int dcn315_get_active_display_cnt_wa(
>         return display_count;
>  }
>
> -bool should_disable_otg(struct pipe_ctx *pipe)
> +static bool should_disable_otg(struct pipe_ctx *pipe)
>  {
>         bool ret = true;
>
> --
> 2.26.3
>
