Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796D2667BFA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 17:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240886AbjALQxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 11:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241462AbjALQuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:50:21 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F1861452
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 08:39:20 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id g19-20020a05600c4ed300b003d9eb1dbc0aso12590897wmq.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 08:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oNoDERFzuHtGjh505WCrPCBr/BG/rip1kZiId3Be/GI=;
        b=cl2oSlH4OtIGvtF7iZB18s/42WjMGjp1oKU7WSh9k1h0DZSM2SsgF/2ftksmfK8XPw
         00vubvCH5Nrmc+jkSiwP3lbKMUYZRcLcRsOFUB6fQOmUCTeMH3JxTgri8ubBLLM+kMNC
         81enQ0iyCX8a4tANW+umatSqYRIoq1wiaZUb7b2e1GF+3Nw6KGXkTuhnZsQMSl8qytbv
         Kc9FSS0qFwFAzN7fXSeTePnO61aLfU+LMq2W4yN7N+JhLPNzy3tRjtIQ7UMbjvS43QVj
         HoF7JRib11KcugZcYeZN9ofPIkZQrX9wdU3EkzH7HKPsV+z0AHvSubEyu3n4ePv25dCa
         QGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oNoDERFzuHtGjh505WCrPCBr/BG/rip1kZiId3Be/GI=;
        b=ANFPviMaPzUvSA6tEtk7n6k72vN0d1Rkv+gwcYj8GfKaJ6tdE+ci4M46vxoAe7dfTQ
         69vhr4QGN0xJHnep6ZMn0u176Qu5xg8trA4eBOKdKWKeX/WUNxUcTLKf6c10GEqd7Lf+
         DgRs8xi6xrZtrCKlfPt35WzCnT/eAh7vzqSa4qdbsnZJjXOIJveiAYEwHpyIpXDF/fBh
         ltDT6l6neNlDCt0lqBP7wZGiAYSWPTpuKlB2HC1mGvYhMIbHhDUXnkUfUH3yb7FapT8N
         EFn5ptQqiHJhQeVaIi7JGXoIWsn+SQPzs3HCASqtDeCKKftn8mPngKdX/P4xUgqOSP6W
         I+4w==
X-Gm-Message-State: AFqh2kp7gBAnqqKHhuTkFq0AcZVE9AX53H59P289TCft7Q7iZDpmP65S
        c4TkMZZ63rSvbutg45rEiMoU3A==
X-Google-Smtp-Source: AMrXdXs15DjC4J5PPOePtPbWvkBZ9iT8rKmYrvMiti76tS0pVRxoU2T7Hs73Kn3X7jhXxZJV3KJtIg==
X-Received: by 2002:a05:600c:3b22:b0:3c6:e63e:814b with SMTP id m34-20020a05600c3b2200b003c6e63e814bmr55209828wms.2.1673541544909;
        Thu, 12 Jan 2023 08:39:04 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:3b9e:7554:4633:9a59? ([2a01:e0a:982:cbb0:3b9e:7554:4633:9a59])
        by smtp.gmail.com with ESMTPSA id p3-20020a05600c358300b003d1f2c3e571sm30045642wmq.33.2023.01.12.08.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 08:39:04 -0800 (PST)
Message-ID: <fbe7deb6-c23e-0374-f87e-aa7cb9386cce@linaro.org>
Date:   Thu, 12 Jan 2023 17:39:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 0/2] arm64: defconfig: enable modules for Qualcomm
 SM8550-MTP display
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230110-topic-sm8550-upstream-display-defconfig-v2-0-c29b9714c85f@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230110-topic-sm8550-upstream-display-defconfig-v2-0-c29b9714c85f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn,

On 12/01/2023 10:42, Neil Armstrong wrote:
> Enable the SM8550 DISPCC and Visionox VTDR6130 panel drivers as module
> to enable display on the SM8550 MTP device.
> 
> To: Bjorn Andersson <andersson@kernel.org>
> To: Konrad Dybcio <konrad.dybcio@linaro.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> ---
> Changes in v2:
> - build SM8550 DISPCC as module as asked by Bjorn
> - Link to v1: https://lore.kernel.org/r/20230110-topic-sm8550-upstream-display-defconfig-v1-0-9941c8083f10@linaro.org
> 
> ---
> Neil Armstrong (2):
>        arm64: defconfig: enable SM8550 DISPCC clock driver
>        arm64: defconfig: enable Visionox VTDR6130 DSI Panel driver
> 
>   arch/arm64/configs/defconfig | 2 ++
>   1 file changed, 2 insertions(+)
> ---
> base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
> change-id: 20230110-topic-sm8550-upstream-display-defconfig-deffeeeee051
> 
> Best regards,

The python email module messed up the msg-id references (see [1]) so b4 won't be able to apply the
patches using the cover letter msg-id, here's the following messages links:
https://lore.kernel.org/all/20230110-topic-sm8550-upstream-display-defconfig-v2-1-c29b9714c85f@linaro.org/
https://lore.kernel.org/all/20230110-topic-sm8550-upstream-display-defconfig-v2-2-c29b9714c85f@linaro.org/

I can send them again with a shorter msg-id if it can help.

Neil

[1] https://lore.kernel.org/all/20230112152621.ersbloeygrvci2ww@meerkat.local/
