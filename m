Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6CA63EE04
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiLAKiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiLAKiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:38:21 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9FAE02A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 02:38:19 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id bp15so1795399lfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 02:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ir3uvErgUob4NFVyXZ4JMzbDFyUKCFAp6JFwnKMpYXU=;
        b=sDiCfmTwLAL+IKSK6fOyjJI03hKdZIxAwTN23mUq3iwImjKp2FQBCLSi5GOXxBPsHz
         BdYaxRl6VVlyvlU6jG9NE6ZG8rv3Yj0JnmFXHJTRlzsuIL78G6czmw1vTpU9BjChZF3M
         rmMJqL65R3fZNXf0/E6oOy/hBWLN3/iir5072tqA+HRaWY7fBEiO0FbK5YJ6YijcnQ8a
         +mTJELLZsdyHs4cGNDjena94bfmGvZYxnw5jMqOsrOF0BvuaxqpN8pcLqOkR+sqcjRqy
         tsqki7IGeJr9MY0ED0VxJTG89l+ku1voRYszZZ+iJsbbJXKsZ69oEGGy6biAIZwn2wYU
         wjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ir3uvErgUob4NFVyXZ4JMzbDFyUKCFAp6JFwnKMpYXU=;
        b=SUP+oxVih2FMfejoDjxFaBCGTs/WB58KKSAP8h9U/ghnrju/VW5ShnSAXn2lqKT18M
         9QvP2ZZg5V/LuusgaaWtO8+fkoyLgrwj85qn3sFj3MhJElYcEPjszS69abjHk8D0PANG
         GLXwoXfGlOoTniU8usqbTtjCYd+hHwG57oluRg0gECWyumwoZenkGfK7mrIppsoueMpL
         Nxvu2vh/wmZ7TTSvOn7yQuAk9gWQbQGAgO/NZ9tqa0/Tr50I3kgyb00uP94atUU8ySA0
         AdLu17pzSVsfpIr1T/L+bNmPiYO56a09lcC+kF5TVteC5+GfMWCmqUJJNVnLrJLGz4fW
         viMA==
X-Gm-Message-State: ANoB5plmFX5YK7dGpgQf2ZHqvMaNXiNGPlntD8vQrv/xZVYc7xXQDKyu
        ioSj7OYp0HZSkuHBHbWFg8Na1w==
X-Google-Smtp-Source: AA0mqf5fOBE5NhPN7Xd+BTF4xDsWEodGVKp8iN4/HOQ8OyxhgwJEhznyaRqPwZeYHiXu0T46gbRvmQ==
X-Received: by 2002:a05:6512:3983:b0:4b4:f88:90d3 with SMTP id j3-20020a056512398300b004b40f8890d3mr23278296lfu.37.1669891098347;
        Thu, 01 Dec 2022 02:38:18 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k29-20020a192d1d000000b004b5138d82b3sm601559lfj.76.2022.12.01.02.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 02:38:17 -0800 (PST)
Message-ID: <382df687-c535-4dd6-125a-5f3b6022cbd2@linaro.org>
Date:   Thu, 1 Dec 2022 11:38:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 11/12] arm64: dts: qcom: sm6115: Add WCN node.
Content-Language: en-US
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20221130200950.144618-1-a39.skl@gmail.com>
 <20221130200950.144618-12-a39.skl@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221130200950.144618-12-a39.skl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2022 21:09, Adam Skladowski wrote:
> Add WCN node to allow using wifi module.
> 

A nit: Drop full stop from commit subject.

Best regards,
Krzysztof

