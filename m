Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0664167651F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 09:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjAUImJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 03:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAUImH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 03:42:07 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890926AC9B
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 00:42:05 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id z7so8008445ljz.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 00:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rtcfHZAR7Ysq5XNRm/jCy3LiiJsqdTUfh0gGDYHtMjI=;
        b=ttPttT4fXeRLAIGUhnlOd/e1nfyPSbx1mjkJhmM+Nxee/NpQkGX06mVqwSY0Hh9Xkn
         DrQQ7z8exjG3ZzZdRqG/CdbF1QxliQh0pkb/uPp3kWuhNSeAKoSrTsHAagWkTgvUd68V
         WnPtqsXV9LNksxGoISAYyl3siHpFd0QjyDmyc2dkHHxhBGAlo3KBv4xRSEfcqS13p9CZ
         MayPk2HmayTK9apWRtZ6KDk+4MnVGtEM4xWbFePfLOWOlufpHsGV4xKWClSrrM27RrH3
         EDdFDFd5s5N4miDsmrQNlVNM5Aj8WCnr2ecetSq0XSRdv4cOWzh93aT3+cLJfbo4kNdW
         kBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rtcfHZAR7Ysq5XNRm/jCy3LiiJsqdTUfh0gGDYHtMjI=;
        b=6V8ueu24UhzEDK231EMzxkhgDLyhlCRwIqSqonnMCfXBA/6Z8NjAC86oqFFtm1MAyP
         tf4vdelWrQd+htus9C4Dxh9YNHfVlRzfCV00wsu3dtjb0kcj/SDBp5O+S00oBp+d2kK6
         kdzckkGLOHgCmbEKwiFSPg42STXnnrBOMVGJZ0xtrzx+TJX8N18OMAftirDQ+Oib44PK
         T0zUBSMdHuFnbBwmhwU/s9N1BdyKUu2sQ+6p/PS4KIVS1f1qLz/xDix+3cnnclPNqILa
         GBkv5zbjC8gKGcQdWxTQ0h0XFSWLB2FdhnxFf2m0CCOjAZOEfkSQqyauoV6MDCGESpAK
         OvzQ==
X-Gm-Message-State: AFqh2kpl6V8Mi/dLHYGo94y45hQoVvDsjmaBBQlmepEcNM5b4E1wBX65
        Lfdu/KaMYiSv0acl7jCDlvkgYw==
X-Google-Smtp-Source: AMrXdXsbtbF+q/skX2lYOVrY6nCebNMS9fJNREzP8Yx1fO97MiS2zdHfmNzBb36aUjgFxzyI/n2Y8A==
X-Received: by 2002:a05:651c:81:b0:27f:d5c6:f4f with SMTP id 1-20020a05651c008100b0027fd5c60f4fmr4446567ljq.29.1674290523906;
        Sat, 21 Jan 2023 00:42:03 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id k9-20020a2ea269000000b0027fc14cdfa5sm2553634ljm.42.2023.01.21.00.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 00:42:03 -0800 (PST)
Message-ID: <f665b62f-d5c7-d02a-d775-434c4445ad86@linaro.org>
Date:   Sat, 21 Jan 2023 10:42:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/8] drm/msm/dsi: Allow 2 CTRLs on v2.5.0
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230120210101.2146852-1-konrad.dybcio@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230120210101.2146852-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2023 23:00, Konrad Dybcio wrote:
> v2.5.0 support was originally added for SC7280, but this hw is also
> present on SM8350, which has one more DSI host. Bump up the dsi count
> and fill in the register of the secondary host to allow it to probe.
> 
> This should not have any adverse effects on SC7280, as the secondary
> CTRL will only be touched if it's defined, anyway.
> 
> Fixes: 65c391b31994 ("drm/msm/dsi: Add DSI support for SC7280")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/gpu/drm/msm/dsi/dsi_cfg.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
-- 
With best wishes
Dmitry

