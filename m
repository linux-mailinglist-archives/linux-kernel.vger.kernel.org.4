Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F68700E71
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237397AbjELSNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238081AbjELSNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:13:10 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018E9271F
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:13:07 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2ac785015d7so113093911fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683915186; x=1686507186;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uKD+LoFNXdeJroT3MlEs5tmlumv0cQy/KCdwnSxoZK8=;
        b=VLoPyIveRs40es+1Zdi7/hqZ2yvU/choqNvtv3z+3a0MVMCQcLn0cFMhBXOLI/lVsQ
         TX90Civo7BLEzZElnQyzMJZ8xvrxB2quS71fH3LOkptwpklKHTahe0P6NWNmQScM0H4L
         nUdO6kgNJ3U5Ytf3TD4fx4uWx67VOpr7adGXuatWuwOfz/rhwbcHj0e4/RMviFzRIFcG
         VIO0Ok+SxEM47uRQPz1AunL6nfUty21jLgzCF6xzL2c032UZ2T6dB5ROK8Osk3TqX03G
         qwOJgYbZw6NZD3YNhEe61UOWD0Yuv+HyChwxSPNSBjr5kWywLVT8k4psJp8Kj57tEMve
         xfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683915186; x=1686507186;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uKD+LoFNXdeJroT3MlEs5tmlumv0cQy/KCdwnSxoZK8=;
        b=aTXbEdKCvajy0lp2cHbd4yK/a0CCfyzYQOrdFLUMqBmQ5fJQjB5ABSTWHMfgduhyDE
         sPXciFCVpd5Sv59KP/bCf0s8z1sxmoDrFzMmibgGMfKeM1g+9WWqMMHhp6OGynoPoYv3
         sggFoNyfVtsoWXZtT34RFYp7MuOYPN/+9qVQlHRN2Znw7BWVDIsez19sK2FNaNaZGyxB
         c6pnc2p1tq+wH+xt4ecirYdRPDLrXvTVXylCeCfYbAia2ZJqYJpa0bJ2feqQd2jug3BS
         4ovwzCrqw8y8PLLbgauZnRdFJBrXeC32DDhvlhG4wNU8IxmBkSA07ZP466inDTgdr/BD
         mlgQ==
X-Gm-Message-State: AC+VfDxJGwezZqVT5E1GImt5rv956EGQ+bNJAP0hWaCbYuXXzCj82vsj
        IUWmCV8lu3c/aPmm8EadM41vcA==
X-Google-Smtp-Source: ACHHUZ6XRMgKnPqEWJyYc/6mw+o+JZPDKh3xXIcQh+pV773C4JK7LbdiAPNfIiOQ3XOMFcWzQ6iivA==
X-Received: by 2002:a2e:9b97:0:b0:2ad:98a6:4af0 with SMTP id z23-20020a2e9b97000000b002ad98a64af0mr4602161lji.23.1683915186220;
        Fri, 12 May 2023 11:13:06 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id u24-20020a2e8558000000b002a7746800d0sm2844004ljj.130.2023.05.12.11.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 11:13:05 -0700 (PDT)
Message-ID: <053819bd-b3c4-a72c-9316-85d974082ad6@linaro.org>
Date:   Fri, 12 May 2023 21:13:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/msm/dp: add module parameter for PSR
Content-Language: en-GB
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        swboyd@chromium.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230427232848.5200-1-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230427232848.5200-1-quic_abhinavk@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/2023 02:28, Abhinav Kumar wrote:
> On sc7280 where eDP is the primary display, PSR is causing
> IGT breakage even for basic test cases like kms_atomic and
> kms_atomic_transition. Most often the issue starts with below
> stack so providing that as reference
> 
> Call trace:
>   dpu_encoder_assign_crtc+0x64/0x6c
>   dpu_crtc_enable+0x188/0x204
>   drm_atomic_helper_commit_modeset_enables+0xc0/0x274
>   msm_atomic_commit_tail+0x1a8/0x68c
>   commit_tail+0xb0/0x160
>   drm_atomic_helper_commit+0x11c/0x124
>   drm_atomic_commit+0xb0/0xdc
>   drm_atomic_connector_commit_dpms+0xf4/0x110
>   drm_mode_obj_set_property_ioctl+0x16c/0x3b0
>   drm_connector_property_set_ioctl+0x4c/0x74
>   drm_ioctl_kernel+0xec/0x15c
>   drm_ioctl+0x264/0x408
>   __arm64_sys_ioctl+0x9c/0xd4
>   invoke_syscall+0x4c/0x110
>   el0_svc_common+0x94/0xfc
>   do_el0_svc+0x3c/0xb0
>   el0_svc+0x2c/0x7c
>   el0t_64_sync_handler+0x48/0x114
>   el0t_64_sync+0x190/0x194
> ---[ end trace 0000000000000000 ]---
> [drm-dp] dp_ctrl_push_idle: PUSH_IDLE pattern timedout
> 
> Other basic use-cases still seem to work fine hence add a
> a module parameter to allow toggling psr enable/disable till
> PSR related issues are hashed out with IGT.

For the reference: Bjorn reported that he has issues with VT on a 
PSR-enabled laptops. This patch fixes the issue for him

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_display.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 628b0e248db6..dba43167de66 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -28,6 +28,10 @@
>   #include "dp_audio.h"
>   #include "dp_debug.h"
>   
> +static bool psr_enabled = false;
> +module_param(psr_enabled, bool, 0);
> +MODULE_PARM_DESC(psr_enabled, "enable PSR for eDP and DP displays");
> +
>   #define HPD_STRING_SIZE 30
>   
>   enum {
> @@ -407,7 +411,7 @@ static int dp_display_process_hpd_high(struct dp_display_private *dp)
>   
>   	edid = dp->panel->edid;
>   
> -	dp->dp_display.psr_supported = dp->panel->psr_cap.version;
> +	dp->dp_display.psr_supported = dp->panel->psr_cap.version && psr_enabled;
>   
>   	dp->audio_supported = drm_detect_monitor_audio(edid);
>   	dp_panel_handle_sink_request(dp->panel);

-- 
With best wishes
Dmitry

