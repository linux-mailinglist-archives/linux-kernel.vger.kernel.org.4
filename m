Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586B55B40D7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 22:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiIIUnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 16:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiIIUnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:43:20 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D666125184
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 13:43:19 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-11e9a7135easo6984948fac.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 13:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=UpjlPyvLcw4N5LfAVf39R6W0A9McL24cYMQux8ptGv8=;
        b=e7HTVip99SqvqlRZXZalCOLj/1aFRkt+uGXux/sme46CxsjwtMp+xi7Uqnt0bgf1EF
         r55WBVxyF+PHAVpNFPwxSSAmQ8dLlHLPSq/IQsglAGoFpR+9oE33Hi2HAxmKBPg9yN7a
         1CcykSngo3e/TdSKIVGFIUvf0TdXX2SnrRJLLPjtv2C56Z0Z5UcKWzr3fXvIsX+zd+jq
         5zrekY3mfYb7QxEW0gJ5OcJHizC5Q3dUDEWEmDVj59QZRCikXp3eztjQI7uyF6glIACs
         PxlJv/rdKi0M1lDNE8+0mgsnS+/LPUI+GvoDZKMEB1AOVwVNJyKXv8fgqCabiKkRsrWv
         ozkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=UpjlPyvLcw4N5LfAVf39R6W0A9McL24cYMQux8ptGv8=;
        b=nASPSLsv7vahGmt0qkTZUTwbxlVKiguYB8CO2Df79l7OMq2CDysH2GYD/DCkHcPuY6
         vWHPG4ikxz7Dcz2YriNrE0dm0LcEyX3YJycbFS3yc11IBliFVt/eHoYKYWThhh7oQcci
         0mlFl/g4axnJcqVPomqtzV8m2nFKsPV86El+86JmNTPj/IHknyeul0uSCzznc5WcdpZH
         /Dxqxrcko0T0fOvgBC0WaOEN56XzMIWTKX53kvxOhkv8unMKS0brhjZi6ynKOvANNeWm
         ouREenFlqkeStEE6+tAhTuj3CqAb6u49DTW28spx7/AgCuhfGr5JYk5q43uI67MiH0hj
         rnow==
X-Gm-Message-State: ACgBeo22QvYl6J3NddYP92cXlcOevdA/tJ0/DHnELCvkgHJGXGsEq7Se
        pUiZMBjRCksXNTiYxrpMPzTEx+gt6WsQbEZA9HQ=
X-Google-Smtp-Source: AA6agR63zDi5mAVL6/Z4bTAfycaBgTKj2tKmHeRB6tfaRZx/HB4UWxeu3FEPvQrmT0fCvfSoxEcgxiYj/Jej3LHXWP0=
X-Received: by 2002:a05:6808:138e:b0:345:13d1:fd66 with SMTP id
 c14-20020a056808138e00b0034513d1fd66mr4517729oiw.96.1662756198847; Fri, 09
 Sep 2022 13:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220901081131.76486-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20220901081131.76486-1-yang.lee@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 9 Sep 2022 16:43:07 -0400
Message-ID: <CADnq5_OOTCb_AXV6rpB5DWnAv2+khhZuDZPrA5V0OGacuXTsdQ@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: Simplify bool conversion
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     alexander.deucher@amd.com, sunpeng.li@amd.com,
        Abaci Robot <abaci@linux.alibaba.com>, Xinhui.Pan@amd.com,
        Rodrigo.Siqueira@amd.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, christian.koenig@amd.com
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

Applied.  Thanks!

On Thu, Sep 1, 2022 at 4:11 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> The result of relational operation is Boolean, and the question mark
> expression is redundant.
>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2027
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  .../gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
> index dc501ee7d01a..e4fd540dec0f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
> @@ -1873,7 +1873,7 @@ void dml32_CalculateSurfaceSizeInMall(
>                 if (UseMALLForStaticScreen[k] == dm_use_mall_static_screen_enable)
>                         TotalSurfaceSizeInMALL = TotalSurfaceSizeInMALL + SurfaceSizeInMALL[k];
>         }
> -       *ExceededMALLSize =  (TotalSurfaceSizeInMALL <= MALLAllocatedForDCN * 1024 * 1024 ? false : true);
> +       *ExceededMALLSize =  (TotalSurfaceSizeInMALL > MALLAllocatedForDCN * 1024 * 1024);
>  } // CalculateSurfaceSizeInMall
>
>  void dml32_CalculateVMRowAndSwath(
> --
> 2.20.1.7.g153144c
>
