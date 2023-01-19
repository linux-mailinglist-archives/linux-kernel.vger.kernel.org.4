Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C653673727
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjASLlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjASLlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:41:13 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7520E4B184
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 03:41:10 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id w14so2513350edi.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 03:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YBCDQ4RcMX5cY0YERp9W+RwKWE5lA3CbAz1gwPZRUX0=;
        b=NZgSOq7Z0L76O7GqVX3ud2LsfuEpdZ7IvPLf8ZQzpetziragB0UtDNhzUMb0j4FgUN
         x3yLJosYMGORX3Js20oLfhCxIexVkl1q0FNsBECPeJlwjbmdH+9UWANqlKUbxphvKRB1
         Fp8iuhgwbH4vkgnTOTSTU8aJrMyY5WLf1QcoGRIGVsqsNRxX4J7NWB+HhbzfSrO+ZgY2
         KHD3Av7S0a10/xcPTas7iv+yOoBRmGHDkQ3JS31cx+mMuhfT+4Poy9xpvCsXk5jTXUAS
         VzLglQezCgDzG5/ywXuRSvjEdyD8B/0Hdt15HRCpNcujg3WwPzeJhJeX9iqQBufU1UiJ
         D7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YBCDQ4RcMX5cY0YERp9W+RwKWE5lA3CbAz1gwPZRUX0=;
        b=eFhpwbEy7d5lzYCMFbbxCKW35y9Wrd+d8d1Q0CgeH4E6ZsToSr5FaPAVmv6f9Fmb0U
         oRI/NOTrWckExmWlF62dTcKVsCXF3yT3tJq3iZ/VJsuzpez6enwJlsC+hdeFw7AshVVG
         VoXNc0FSoR354urocBuzCv3V6DiCJ9ZWstbhigGQtp4vyer2Q1nxSWYP1cFMzfVgiKci
         nrCTgSanbuvwbZ4M27M75b0ZDis+Zzfm2b8EdFXsJa9WfHL3egNf8wTdrJGCxoY9kRlM
         HWCpyRXp7O377j4KNFhCzzsvboTSXdJIfPAKlXLD7hEIoAF54e/SYOYyDfamapv8IbBS
         uUzA==
X-Gm-Message-State: AFqh2ko48TdgA/RWFfailhBbqru5FH8wEpPftgmeR0i8DRz0OEeHQPn/
        haW5oVIV2w3X5IuPGm87vDKROQ==
X-Google-Smtp-Source: AMrXdXuEhB91DER4SW1Ekfi/4jdryB/3nUIlOZVGP5Z0MrLtiEb6L2YHlxVVcLbEEX2XvcTtKn/KcQ==
X-Received: by 2002:a05:6402:35c1:b0:46f:f36b:a471 with SMTP id z1-20020a05640235c100b0046ff36ba471mr14431172edc.22.1674128468957;
        Thu, 19 Jan 2023 03:41:08 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id e20-20020a170906249400b0084d4cb00f0csm13368821ejb.99.2023.01.19.03.41.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 03:41:08 -0800 (PST)
Message-ID: <2c8fc24a-5a16-7817-4001-edc53340f9fd@linaro.org>
Date:   Thu, 19 Jan 2023 13:41:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v6 01/10] drm/hdcp: Add drm_hdcp_atomic_check()
Content-Language: en-GB
To:     Mark Yacoub <markyacoub@chromium.org>, quic_khsieh@quicinc.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run,
        airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        tzimmermann@suse.de, ville.syrjala@linux.intel.com,
        stanislav.lisovskiy@intel.com, matthew.d.roper@intel.com,
        imre.deak@intel.com, lucas.demarchi@intel.com,
        manasi.d.navare@intel.com, swati2.sharma@intel.com,
        bhanuprakash.modem@intel.com, javierm@redhat.com,
        jose.souza@intel.com, lyude@redhat.com, hbh25y@gmail.com,
        arun.r.murthy@intel.com, ashutosh.dixit@intel.com,
        ankit.k.nautiyal@intel.com, maxime@cerno.tech, swboyd@chromium.org,
        christophe.jaillet@wanadoo.fr, quic_sbillaka@quicinc.com,
        johan+linaro@kernel.org, dianders@chromium.org, marex@denx.de,
        quic_jesszhan@quicinc.com, bjorn.andersson@linaro.org,
        abhinavk@codeaurora.org, seanpaul@chromium.org,
        Jani Nikula <jani.nikula@intel.com>
References: <20230118193015.911074-1-markyacoub@google.com>
 <20230118193015.911074-2-markyacoub@google.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230118193015.911074-2-markyacoub@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2023 21:30, Mark Yacoub wrote:
> From: Sean Paul <seanpaul@chromium.org>
> 
> This patch moves the hdcp atomic check from i915 to drm_hdcp so other
> drivers can use it. No functional changes, just cleaned up some of the
> code when moving it over.
> 
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Reviewed-by: Abhinav Kumar <abhinavk@codeaurora.org>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
> Link: https://patchwork.freedesktop.org/patch/msgid/20210913175747.47456-2-sean@poorly.run #v1
> Link: https://patchwork.freedesktop.org/patch/msgid/20210915203834.1439-2-sean@poorly.run #v2
> Link: https://patchwork.freedesktop.org/patch/msgid/20211001151145.55916-2-sean@poorly.run #v3
> Link: https://patchwork.freedesktop.org/patch/msgid/20211105030434.2828845-2-sean@poorly.run #v4
> Link: https://patchwork.freedesktop.org/patch/msgid/20220411204741.1074308-2-sean@poorly.run #v5
> 
> Changes in v2:
> -None
> Changes in v3:
> -None
> Changes in v4:
> -None
> Changes in v5:
> -None
> Changes in V6:
> -Rebase: move helper from drm_hdcp.c to drm_hdcp_helper.c
> 
> ---
>   drivers/gpu/drm/display/drm_hdcp_helper.c   | 69 +++++++++++++++++++++
>   drivers/gpu/drm/i915/display/intel_atomic.c |  4 +-
>   drivers/gpu/drm/i915/display/intel_hdcp.c   | 47 --------------
>   drivers/gpu/drm/i915/display/intel_hdcp.h   |  3 -
>   include/drm/display/drm_hdcp_helper.h       |  3 +
>   5 files changed, 74 insertions(+), 52 deletions(-)

With the hope that commit message is cleaned up:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

