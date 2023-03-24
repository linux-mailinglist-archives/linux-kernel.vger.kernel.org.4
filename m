Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7BE6C7BDD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 10:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjCXJrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 05:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjCXJra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:47:30 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4643928E6F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 02:47:15 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id r11so5508902edd.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 02:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679651234;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=68LL2tN+tvRxnHcGQimYX0Fn4/Y+S7c6syZHdYwPnTI=;
        b=y/BAVhf7XMGXQZE1Y13WxXscpyxTT6091AZrh9ix9L48/sVvusr11hqc6a7R5l4o07
         Hef2LRkOT+/26787JYdcyIWbdLbGoSouYknRmm1W6yTY4olkw1zNQiKkQjpSVIBG694e
         27BbXDBWavVqMKuQvkf9SWWT2uJXHWenF7lwpBBXIRyMc8eQfDB97lfSsniY8/5/nANA
         Hy2G84NnlaQRruaNSjgPu8QVQ1zX6q3NkY0AZzKWfCQMnUvVqs0IvFDe/Xhb6PofXjet
         FlaT1RqrIOulyaSc2MGAiA2I2ipBZC05OzulHp8ycMGQJLraqRxSVgs0f6iNIl4MwLqX
         Ki9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679651234;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=68LL2tN+tvRxnHcGQimYX0Fn4/Y+S7c6syZHdYwPnTI=;
        b=R7nsvUPziK6i4QWac1Q2ZDeOtIp5ctqTVOOwsxtlqMn9a7LgHFyGfcYs9lHOGqTV/3
         7lBytg1zbDgPsvOsDPRVfIwXhROvnqo42C2hw3fb+9xP1ITG+7+y+mnBwndYRzVK6Er4
         7xLOdQfF/T4EwHSNtLjVSWpp8rsAwVZUPD8SyPiEsPOGe5NikNztbLRNEE5MQZK9lGsL
         MSNC1OTIxpPsY7vr6uZUh/80wdm5xYwnBPe5te36bhfTCTMAVgFLZfmvFikorkssTX4P
         3u4TvErVgIK9sS2K+TbdSeuN/VZPjCHE8XKH6kSNnNLiKLl9Qebbxh8Rxo/loEMfmict
         W6iQ==
X-Gm-Message-State: AAQBX9er90W1Oq/r7KGAYGUWjbalmjfILUIOFxhCQW+Mxalgvawkn6S7
        nVimiZ8H90J8g2rdgLT8Oy26yA==
X-Google-Smtp-Source: AKy350Y4KNEVHV8TIh4Rz8tGeMz+jN+kqcpiakNF+uVS+SRrsU5RH3vG1yCVv74fqqlCu7gw965hmA==
X-Received: by 2002:a05:6402:481:b0:4fc:7201:6de with SMTP id k1-20020a056402048100b004fc720106demr2150057edv.26.1679651233788;
        Fri, 24 Mar 2023 02:47:13 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ce50:243f:54cc:5373? ([2a02:810d:15c0:828:ce50:243f:54cc:5373])
        by smtp.gmail.com with ESMTPSA id t14-20020a508d4e000000b004d8287c775fsm10384125edt.8.2023.03.24.02.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 02:47:13 -0700 (PDT)
Message-ID: <b712b832-6b92-53aa-d6cd-124e079c8e07@linaro.org>
Date:   Fri, 24 Mar 2023 10:47:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/4] dt-bindings: display: msm: sm8450-mdss: Fix DSI
 compatible
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230323-topic-sm8450-upstream-dt-bindings-fixes-v2-0-0ca1bea1a843@linaro.org>
 <20230323-topic-sm8450-upstream-dt-bindings-fixes-v2-1-0ca1bea1a843@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230323-topic-sm8450-upstream-dt-bindings-fixes-v2-1-0ca1bea1a843@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2023 10:28, Neil Armstrong wrote:
> The DSI compatible changed between patchset revisions, but that wasn't
> reflected in the bindings. Fix it.
> 
> Fixes: 0eda3c6cb1c5 ("dt-bindings: display/msm: add support for the display on SM8450")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

