Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15BD60FFFF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 20:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236542AbiJ0SOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 14:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236410AbiJ0SOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 14:14:10 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C316BCE3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 11:14:09 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id p127so3195739oih.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 11:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O9gqzuSFD8OHrR9IjrolL9UfkWIT9N31C4ipvtJhMW8=;
        b=JuqTzzID34wq6D1oN12Cd6J4Zq0xzc0zuLcz6NUrrTu9+v7ofooLT1itaZcs9MzZC1
         BCG3RGQpB22gU3Au43lu42WPhkdsUVfRTWPVEA3xcJ6YMMwI+I5EOtqCr5fLJ5R7blLA
         urKyTSa0XqOGaw/Hu1yj3mY37fHb0qUEutsEEXtpZvmD0scdfh9OkPfzccjMRYE0y7Xg
         heGrCoUmunHuaIkUrQcsCQX0GFZI1FIOdngfGdOsSI5gEZtaTLtuLIpa+8jEPT5etey0
         ZU2BjmXhwgkY8QhWy5HogrSpZJn5RabKCUKX6xgyo6OWgPizrzYC/TeVKc8P67QJEnaS
         uJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O9gqzuSFD8OHrR9IjrolL9UfkWIT9N31C4ipvtJhMW8=;
        b=B3d3le2Qtafu1AotPKRfyJyclykgxjkBBqH5EX8+Q6LOwwyGuwlg0qgP1wOmWsPvZv
         lwthX/59fGYiAX35yHK4sBDXbSPG9Nhd1AOFZeigWZZrIwA084OlnJTKyuWJdPFmpcrd
         dwBn+kQI1gNEeM0e8ZDOadiZl568ENvUeqOwGr407yCf7Cor793JTEnVogZahwFCBHqo
         ql1uw01TfFWPlkBm37k9wnSmiNyPnNhffwoNF4PAb74EOkiEnemJUMc/gvbOBGX5WThs
         RvQR3OHgkYwGsXHNdIThNcS+HTWNqRu8WxyB0KSUL+AfwxVwTzzKYQVsXgbnXsKcW0Ko
         aQDw==
X-Gm-Message-State: ACrzQf2k+8RC1a1xKeOaXeU5t9uoTVwEyLTkknrUsuuooqnwzmJSNuGu
        Mc0bBYDkdcrDjz5w8yPSCQ6gQrUbEvQ/3GnOjUzrDVw7
X-Google-Smtp-Source: AMsMyM4TkBtBzw97AttzykCWImSm8pLeapwXLsEUfoctb8c365GhyTENUYp7BGzF7yEEe04UhM5r8FrNGPbwWBbbzNM=
X-Received: by 2002:a05:6808:14d2:b0:354:c733:abd3 with SMTP id
 f18-20020a05680814d200b00354c733abd3mr5721852oiw.96.1666894448715; Thu, 27
 Oct 2022 11:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221026070110.35364-1-jiapeng.chong@linux.alibaba.com> <20221026070110.35364-2-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20221026070110.35364-2-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 27 Oct 2022 14:13:57 -0400
Message-ID: <CADnq5_M4jCG4fuikkegn+PBMedW=xX=qLq86uFhwKNw7k_EsAw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/display: Modify mismatched function name
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

Applied the series.  Thanks!

Alex

On Wed, Oct 26, 2022 at 3:02 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> No functional modification involved.
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:615: warning: expecting prototype for setup_subvp_dmub_command(). Prototype was for populate_subvp_cmd_pipe_info() instead.
>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2587
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> index 774e06936661..67eef5beab95 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> +++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> @@ -595,7 +595,7 @@ static void update_subvp_prefetch_end_to_mall_start(struct dc *dc,
>  }
>
>  /**
> - * setup_subvp_dmub_command - Helper to populate the SubVP pipe info for the DMUB subvp command
> + * populate_subvp_cmd_pipe_info - Helper to populate the SubVP pipe info for the DMUB subvp command
>   *
>   * @dc: [in] current dc state
>   * @context: [in] new dc state
> --
> 2.20.1.7.g153144c
>
