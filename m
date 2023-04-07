Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D52A6DB0B2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 18:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjDGQe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 12:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjDGQeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 12:34:23 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E968C155
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 09:34:22 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id d7so10088177lfj.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 09:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680885260;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ns5LOSHu/7rt5El0gaG0VOdBa6A5/wehdLEQPfWFNHE=;
        b=Zd3qxX1eMvUbWNHlNFJpQr1IW9sKUSqmV5VO2F6q3ZofrQcEu9R1utBg4mkgi14+Ed
         NmMEyHFk1xPRHx+wbV9I6I/gUBaXp1M8AGbPtKJYCMtryWy3yvSXL3Lh4J8Uh7BHlV33
         y7jxzYBqA93sFwBQF++Dz1QZpW/nAKpe92lBzyAjO7a9A4i8p0FD6lfZ3fV7XH3x6Es2
         DBxtHKdFYaIb7l4T+KSGlb/Vb4mQytUcU2GlB8vjHF3h/VmhJgJ6gbZU6jhU1OB9C+WR
         tPpbF/DEHec62VEnr754lztIaWAHrLYFdc3xK/6D3F7s46kBh0n6tiospMzOHWRQ2fYg
         I9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680885260;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ns5LOSHu/7rt5El0gaG0VOdBa6A5/wehdLEQPfWFNHE=;
        b=zfJusH1bHumoov0vFy75gZgTSsPFWIu6K2KddrGanerfJpvQ54WVGw1y3S7nb15bD9
         Xh8KfLheH+k/B0dqtLHbA/I1UFvbXRypS7KDkwGfkj4ld9il5igq4K+YJ362C5OXf7uw
         vZbcBn/e94q9KeINptxXXky/1ltaOIEv45B2OL//nXusyfjdwi9okKUmMcajXq4qfO9X
         +fmvbLL3pNEWqoNE3tpqA5v0p8qFJDgDbcwm93ycVg8FVAS5SDBsPyKXK0tgWkF0wjeJ
         rsNWoyaEzLY3RYnLx4AxkoGv9Si7VjOgq7dfR4SNckbqXUL5jEhvZN9VzN9Jh76Zyd2g
         k1nw==
X-Gm-Message-State: AAQBX9fBdfx4rhCn2NfjDTVLL/aaEKz/B5X2PHKwwGth9740dfpfzHv8
        GWE1DsRua6pJuywpAWp+qSFWCg==
X-Google-Smtp-Source: AKy350aeMn+uduz5SM1Q+zIFL1amX8/Z79FODoWr4RrabDEAu57MaCpeRCFE4XzvSXWyJrDeJL/JEw==
X-Received: by 2002:a19:f70f:0:b0:4ea:fdcf:8f62 with SMTP id z15-20020a19f70f000000b004eafdcf8f62mr978422lfe.0.1680885260281;
        Fri, 07 Apr 2023 09:34:20 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id 16-20020ac24850000000b004e817c666eesm774924lfy.193.2023.04.07.09.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 09:34:19 -0700 (PDT)
Message-ID: <118af32a-c5d8-2c93-887d-8da83779eb9a@linaro.org>
Date:   Fri, 7 Apr 2023 19:34:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v8 09/10] arm64: dts: qcom: sc7180: Add support for HDCP
 in dp-controller
Content-Language: en-GB
To:     Mark Yacoub <markyacoub@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     seanpaul@chromium.org, suraj.kandpal@intel.com,
        dianders@chromium.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230331221213.1691997-1-markyacoub@google.com>
 <20230331221213.1691997-10-markyacoub@google.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230331221213.1691997-10-markyacoub@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2023 01:12, Mark Yacoub wrote:
> From: Sean Paul <seanpaul@chromium.org>
> 
> Add the register ranges required for HDCP key injection and
> HDCP TrustZone interaction as described in the dt-bindings for the
> sc7180 dp controller.
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
> 
> ---
> Changes in v3:
> -Split off into a new patch containing just the dts change (Stephen)
> -Add hdcp compatible string (Stephen)
> Changes in v4:
> -Rebase on Bjorn's multi-dp patchset
> Changes in v5:
> -Put the tz register offsets in trogdor dtsi (Rob C)
> Changes in v6:
> -Rebased: Removed modifications in sc7180.dtsi as it's already upstream
> Changes in v7:
> -Change registers offset
> Changes in v8:
> -None
> 
>   arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

