Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936336B8D8C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjCNIiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjCNIiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:38:01 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3468C960A3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:37:39 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x13so11420988edd.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678783057;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZhkWJWB/QILI29aR1cuF6lJwDUoq5EmMZm4n+spt5CQ=;
        b=uAxm5FkjIYZOECZtc87G48gZLsAWCBlaLNe+JsXx2om3LsoJQlcRAzkOiqzDfWCh19
         s/a2zPZoWrf01wgNBp6KCMKcTB1iJiQL+YHXQClRNKlRAQNx6Bf5tXAR4GOO7lyhFunq
         5Xz8YainFO3uMAXFfZsLqIOSMYra6qgWAZMU6+PVzeiSaAhcgaMeh/2LWetJ0IVJQbWu
         efS+5+60tWgykPrqtLbPUwXamaLh2MZQ+3RpoXzo4xMaI1pZVkuEqtQxmF6h6BIJokKZ
         A/DwGtM4UmF8YUqqt1lDmG2udPPjAzS1BGG4KtQ203vakqDcm4O92YIJUCeI+UWtWGNc
         2JBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678783057;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhkWJWB/QILI29aR1cuF6lJwDUoq5EmMZm4n+spt5CQ=;
        b=Yre1jsSoQSs9ID/uyZquVUFPOrPOuASbVqlmatO1V42fu0e3hNl7gb9itGsJrJ9NKL
         V0ftrbDx+GWr1geRoI/Brvq76w+6XhAKYBMYmQ+FSHJFRr1wYLDRjZazSuheMAfMQG8G
         Z4CRqYfQGC+Bq3ScexlUlvuWIelu7+eRb072XY9k3Kyvq6vWfJY61q9YxwKw+WEPdImu
         n2+eA0PtdIUOu+MGtvDTAsO6Rk4BIVsK5EVRh7mzt704iHFXwhLlxqyrkUWwsNoq2YcI
         qGGUfkT8oET/63R/BIk7a8B+nUsQl3NxdFE7PR/P4ZL47iOgvX+TpFgM1gN6W/yT93ry
         Muow==
X-Gm-Message-State: AO0yUKWtkl6+OrRt4CJTaHVmsfVjA6r6V5ETBnae61rp6KMVdH15/B6c
        nOm3+ZvYmipQ28SiaI1624dsRA==
X-Google-Smtp-Source: AK7set9hCuaWCYXf6ZhFcRcnJHFdzkn/baMrWGlS3433Rq6tjpWP/CevB5vef2TFRonZGZQOCGwHdw==
X-Received: by 2002:a17:906:e093:b0:921:a224:cd15 with SMTP id gh19-20020a170906e09300b00921a224cd15mr1579392ejb.15.1678783057701;
        Tue, 14 Mar 2023 01:37:37 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:59be:4b3f:994b:e78c? ([2a02:810d:15c0:828:59be:4b3f:994b:e78c])
        by smtp.gmail.com with ESMTPSA id kw10-20020a170907770a00b008bc8ad41646sm795370ejc.157.2023.03.14.01.37.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 01:37:37 -0700 (PDT)
Message-ID: <3cf8f543-d439-5d9e-5b07-08bb8991e774@linaro.org>
Date:   Tue, 14 Mar 2023 09:37:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] dt-bindings: remoteproc: qcom: Fix sm6115 pas
 documentation
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     mani@kernel.org, mathieu.poirier@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
References: <20230313202655.1719587-1-bhupesh.sharma@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230313202655.1719587-1-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2023 21:26, Bhupesh Sharma wrote:
> Fix the sm6115 pas yaml documentation to note that 'memory-region'
> is a required property.
> 
> While at it also mark that memory-region property supports
> only one item.
> 
> Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

