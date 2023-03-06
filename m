Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4CE6AB8FA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjCFI67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjCFI6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:58:54 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807B412BF7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 00:58:35 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id ay14so31666442edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 00:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678093115;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qax62+Ek+98BjcfFBzDht0kDLSEKv3DkEE9gZpZsrKw=;
        b=KnMl6Li/TvvidwiidEc3hQr/LFaEWlZpB0CExOUcrC3GR4XHZFgzeuMCa/b+/OwcLo
         9N/5/j4+z2oJ65eC4Z7692mE+uMFROAZypFz5ajFuNyOW0jVeLEGFLLjiUcRyAiniHBI
         IhR6fGOPtrh28nqIdV9nMXfPy7I5sze7udh/H0cuBR+5X/VoeFm0Lx3z7/L4VLq8PObD
         VoxAh6G+ZGZbu3Lxf8lQRuwUYhNRmqtmdCsqZrtP1E2vJv/o173zi/MJ5o2kXJtFR+lE
         W97Qbv0fVPnkXnY5p3T/s0j2X7K+EbfdAHshEauk/S6mh0g87fwZ5qDeBm43V8CjfSkX
         PI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678093115;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qax62+Ek+98BjcfFBzDht0kDLSEKv3DkEE9gZpZsrKw=;
        b=2B0o0r5GcTEL6/ZGWTiEVLNoLfGomjvZ4+2W3hz2I3AfJK2/ca+noz2QC0uTYMwG/S
         CUJGDAsxBSd+XbuBnzH4xyrVuFcM1i53+nbU7uvxVjG0GzDdK7VZLURtQdIeTmmfQ43N
         8A1zUyFsfs6tQ4m6DHPr+2LDXTP6KQsKHqAqNT/lK/5KSZZHWc0Fhu/nIWt2sE80TRB0
         hRCUs+4jdb2zJKZdsez/Ta5BO9hBM4lQ8Q21AyG5OGXpScD0c3QAJlKbvM5p6+evwk2P
         CaL06xGT7k7hKuxuv6tGQD5cbDemTONKhbHfEd6PK59N8JSaSmpDMkpYc+8DGOFYSWX8
         wW3A==
X-Gm-Message-State: AO0yUKU3wDrP21Im4STqUcQ0c8wNufAEC3doDLLE8jxk6HYcMglm4xAa
        NalT2ejcXCtKxGjUQxE1gnXxXg==
X-Google-Smtp-Source: AK7set9p7B2EXwGRzK3tQA+hkA+tlIfV2D0L5YBCvz6MVJJeXyzr+RLTECAnVLpRF0B3jK9oPxzckQ==
X-Received: by 2002:aa7:d910:0:b0:4ad:7c44:35fc with SMTP id a16-20020aa7d910000000b004ad7c4435fcmr8567769edr.6.1678093115026;
        Mon, 06 Mar 2023 00:58:35 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:d85d:5a4b:9830:fcfe? ([2a02:810d:15c0:828:d85d:5a4b:9830:fcfe])
        by smtp.gmail.com with ESMTPSA id v12-20020a170906338c00b008ba9e67ea4asm4300598eja.133.2023.03.06.00.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 00:58:34 -0800 (PST)
Message-ID: <79c44d5b-c7ab-8a40-c17f-adf72f92a8ab@linaro.org>
Date:   Mon, 6 Mar 2023 09:58:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 03/15] dt-bindings: sram: qcom,imem: document SM6375 IMEM
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230303-topic-sm6375_features0_dts-v1-0-8c8d94fba6f0@linaro.org>
 <20230303-topic-sm6375_features0_dts-v1-3-8c8d94fba6f0@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230303-topic-sm6375_features0_dts-v1-3-8c8d94fba6f0@linaro.org>
Content-Type: text/plain; charset=UTF-8
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

On 03/03/2023 22:58, Konrad Dybcio wrote:
> Add a compatible for SM6375 IMEM.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/sram/qcom,imem.yaml | 1 +


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

