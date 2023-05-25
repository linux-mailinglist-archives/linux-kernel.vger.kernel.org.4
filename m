Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC4D7113AE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbjEYS3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbjEYS3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:29:36 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8B3125
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 11:29:35 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f4c264f6c6so2841196e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 11:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685039373; x=1687631373;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H+b24C77d9A2u9UTnLoifoUxD5slr2fdLTj++pWst70=;
        b=fLEkzZfSVZKSHIt49CCsR3FwdXcGBM+yggkoWf6irQPOVz9dI4elnrX6N9qKeRjvZ8
         DEJlyMRpYESTW8CwsZzEmuSExNZZ8cdJ5iA7uq8zdD+8FoWv9EWlKcqGnr5MqeZwAT9W
         tgPbbeAaKbkoQROrQn8bbtaTGAccu13e+zC0DBd/9aByAy8AL3Th1V5sNTPnRS6WUmxx
         WIHZF5+4q7biw21do3UBX1Tdql0b5fXjglVfSV+A8PPdvhi/EltrD7SDLzCoGR8N+dvx
         NhvtMfVxZA55p/+xiRf4NO/d/aRUF4+S2kVhnmn1kGR8FK8D9fBtjxZbJwP+aoRAtVtc
         Vw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685039373; x=1687631373;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H+b24C77d9A2u9UTnLoifoUxD5slr2fdLTj++pWst70=;
        b=RoFpCsmnuwA6ma6OSBF2l2veX1A6xzhaqv2SGpHXIsmTNKz1YR/LEwiqhUK04tRd7+
         FkvwVhylevf4GchFQJS0AF8Xy8SvzEMJkj/ZLM7G0NbvYHCHoEfGcZlc5XthQxAgzbT9
         wsWsIEF1SZpNCEyttUqm0eOW9hRuR9LpQpb/rPJF5YRNH2+8uV7lcxh78SYN9MalhJLx
         HLcw4FOxFyP28Ptcj++o+vRE2m7nQE8PATefm9P0LWYFF4zCVoEvDJwoytxXmKEkXRRu
         g8rlje+GNbz16zdRIjxfnewNORTUpbupfUdl4VP5IEaHysnfBItMwF6ZQmIg9pofglEL
         bIJg==
X-Gm-Message-State: AC+VfDxxTVVRxn6PQ6D0wf8LRajf1fLr7KXyzhq0xVUl4rGS/66bG3Yp
        s6F1sSwPkZt9E4Ylve0gqAyEAA==
X-Google-Smtp-Source: ACHHUZ4cuZ+XPY8hnX4V/tTQBykGPBXRAE5A+zNP3iexE+m6J8nJtSxLuUXwZj5ASu6EX4nyvgoeew==
X-Received: by 2002:a19:c517:0:b0:4f3:792c:289d with SMTP id w23-20020a19c517000000b004f3792c289dmr6409992lfe.20.1685039373522;
        Thu, 25 May 2023 11:29:33 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id k19-20020ac24573000000b004db3eff4b12sm295337lfm.171.2023.05.25.11.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 11:29:32 -0700 (PDT)
Message-ID: <85b1c798-bb6e-a37c-d84f-983d19cb96c2@linaro.org>
Date:   Thu, 25 May 2023 21:29:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6] drm/msm/dp: enable HDP plugin/unplugged interrupts at
 hpd_enable/disable
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com,
        quic_sbillaka@quicinc.com, marijn.suijten@somainline.org,
        leonard@lausen.nl, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1684878756-17830-1-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1684878756-17830-1-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/2023 00:52, Kuogee Hsieh wrote:
> The internal_hpd flag is set to true by dp_bridge_hpd_enable() and set to
> false by dp_bridge_hpd_disable() to handle GPIO pinmuxed into DP controller
> case. HDP related interrupts can not be enabled until internal_hpd is set
> to true. At current implementation dp_display_config_hpd() will initialize
> DP host controller first followed by enabling HDP related interrupts if
> internal_hpd was true at that time. Enable HDP related interrupts depends on
> internal_hpd status may leave system with DP driver host is in running state
> but without HDP related interrupts being enabled. This will prevent external
> display from being detected. Eliminated this dependency by moving HDP related
> interrupts enable/disable be done at dp_bridge_hpd_enable/disable() directly
> regardless of internal_hpd status.
> 
> Changes in V3:
> -- dp_catalog_ctrl_hpd_enable() and dp_catalog_ctrl_hpd_disable()
> -- rewording ocmmit text
> 
> Changes in V4:
> -- replace dp_display_config_hpd() with dp_display_host_start()
> -- move enable_irq() at dp_display_host_start();
> 
> Changes in V5:
> -- replace dp_display_host_start() with dp_display_host_init()
> 
> Changes in V6:
> -- squash remove enable_irq() and disable_irq()
> 
> Fixes: cd198caddea7 ("drm/msm/dp: Rely on hpd_enable/disable callbacks")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_catalog.c | 15 +++++++-
>   drivers/gpu/drm/msm/dp/dp_catalog.h |  3 +-
>   drivers/gpu/drm/msm/dp/dp_display.c | 71 ++++++++++---------------------------
>   3 files changed, 35 insertions(+), 54 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

