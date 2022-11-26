Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3732263979F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 19:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiKZSTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 13:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKZSTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 13:19:45 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19BA1836F
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 10:19:43 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso8507293wme.5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 10:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0UpjTTETtcSExqVmm1nTB2R+TP2i/F9nDJvJKCWlEeQ=;
        b=jmpZk8cQQ0XIRmafKBM1hhNj7pmRKA+uirP3diyah5m5z5rFNQ3FggLgUBB5AxmjR4
         jG8XepfVssxY6aq+GeyKUat8leOEqUwcgx5UlPU6tfGFfcyRLIKrW9wSSTVZpNu97W8w
         rHjaaUQfHDp6EDRL1vuz3FXaoddRN/eo/llfF2ltdkZnAeES5ieOLj0XEwpHCqI3hh4y
         4vs2sLhltdlpXV21bALKRbH+u1UZfAn8XD83FL3gjq8ATv2vrbqR8daZCVuKcjLMKcfU
         XYjI6Ijz97d8PNX+HKWVmJnI9UaKvbjCVI+GU8ssH38sy1Fgzs80I7Fd4f86B6z7iYTJ
         pxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0UpjTTETtcSExqVmm1nTB2R+TP2i/F9nDJvJKCWlEeQ=;
        b=Br08utCqETEb0bcXFLcBBLVLSkt06E7H2fE2dHbTEMXe0ywdoswXs+jbVBaQrbZSp5
         Uhv6h4LdM66UZfhbqL30w9eYKbdgZLHunL0Q2nu4KbuSRoB2wTOQYbcT6MNVwShv1p6t
         ZMjqXx4QnSmeXHRYByzFz/35nFPE6UeSVmNzyFHrVn6O9ZU8tUQkkS+awstTVYgrb1tg
         kwrImh1hWRtxqRmdiz1BCFvjk4fThDonxPXRSFCM+dOwmC/5zVo4CDngpChfJpzKCCU5
         bLlM301uIaH59OFUfOe0Mcv7Xvh3EJPMeyrAi/IgVVFW82OZcZ0bw1VuqSK0Ta1FjpUu
         BKlQ==
X-Gm-Message-State: ANoB5pmIAZlffbkk3HWrS9pspMEFz9gnsL59NmeUcTZQ3U6rOU5vXPXg
        RjmVkDpdBaFZVJCNEToBmm1huA==
X-Google-Smtp-Source: AA0mqf7DFQ52pc1pbxMSQa3Nosikz/19JF/XJr/nS+Jgk2bxsKO1XcBU4NIn87IbIMkHrB1/D5heCA==
X-Received: by 2002:a1c:7909:0:b0:3c6:f83e:d1b3 with SMTP id l9-20020a1c7909000000b003c6f83ed1b3mr19426534wme.190.1669486782495;
        Sat, 26 Nov 2022 10:19:42 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id i17-20020adfe491000000b0022da3977ec5sm6412847wrm.113.2022.11.26.10.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Nov 2022 10:19:42 -0800 (PST)
Message-ID: <5f218d90-6582-9fa6-7cca-b243bb863f55@linaro.org>
Date:   Sat, 26 Nov 2022 18:19:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 08/18] dt-bindings: msm: dsi-controller-main: Add vdd*
 descriptions back in
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org, dianders@chromium.org,
        david@ixit.cz, krzysztof.kozlowski+dt@linaro.org,
        swboyd@chromium.org, konrad.dybcio@somainline.org,
        agross@kernel.org, andersson@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221124004801.361232-1-bryan.odonoghue@linaro.org>
 <20221124004801.361232-9-bryan.odonoghue@linaro.org>
 <b3a9f5e2-56ca-b112-e0f5-563404dcb05e@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <b3a9f5e2-56ca-b112-e0f5-563404dcb05e@linaro.org>
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

On 26/11/2022 14:46, Krzysztof Kozlowski wrote:
> 1. vdd->VDD

Hmm.

I honestly didn't pick that up from your previous comment but, np.

---
bod

