Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB005EA238
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 13:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237131AbiIZLEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 07:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237172AbiIZLDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 07:03:31 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA265E305
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:32:22 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id k10so10114985lfm.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Ppgskzcs0IRjENYynELJGMW2eRkYjwxFUGvz8QmabCI=;
        b=xEHY9hKPN5+g0Up7Z5BW1HBukr47ui9VT78DO85ZNWGhMcdDMyDIE0WmywWPmNaT7+
         pZBGM07yDZLikVxgxTkInBpmtdZcyyBUl5xVxVk6m7loWGeMBOMqSTcKlDdCFm6v2vSM
         MYEVA7kmnPU+5XoUuIU6a0POrj6mSD5BxPiQzSeRFd8qi040ALxHvqwjy5f6Q5VA3BLl
         wc0XkfFGRaio1x5DTDuMNNyhZH29mi4+cJoyn9ogl8ZOW41v+jUZg1vOFdtnNRDXW3em
         3ieI5pJMlz7W9VOQadaWYl2708G/E7DqyrgLHYc7Bt8RorPYCjo7MQTlsHGdpUgNe/Zh
         mV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Ppgskzcs0IRjENYynELJGMW2eRkYjwxFUGvz8QmabCI=;
        b=ypCkIJjeALJWnBB/BEGKdt2pftKUq/bt+bLE7Fv4XpeiwEUPJ3zk0VtkXjCiTh4uac
         izbzVa8c4MepbeoC1dc1oK9kjQAUT/TwrgOZ+7nZDmSpyVpU+3sNyd8dxLeNy19jxxbd
         bucPnxFhJNcDeT2Y8b20G5nyZVbZyYHSYv46Kjt/W91Ad/PfKnU14oMT94NnrMz8gghB
         XddeE2hGR0HKB90vPxzp0WrZ8D3RA91GWn0MFP3+bcD2Z7oOzRigQ0XMn51T/wTTOtNm
         xMomcppj35cqy8R/mvjkzrp1TWpHhXOJfvSIWRx38U0EILM8kxo9d2FOyqroCddOiZfI
         0nbw==
X-Gm-Message-State: ACrzQf0Wcn3hyX5tUIBrRpAew2xGqJMbfwpwgEBWOKaIvSQuTuz3YCcF
        Yj0WJxAFCrNyXugh8p9snjHrvA==
X-Google-Smtp-Source: AMsMyM718lAHi/XQO9pRng3KyE8uJbsmjxvFCdTiup3iVL7kEiWEo2WeLb5ppkuAOSNb4uBtv0fp1Q==
X-Received: by 2002:a05:6512:138e:b0:47f:77cc:327a with SMTP id p14-20020a056512138e00b0047f77cc327amr8872511lfa.277.1664188240965;
        Mon, 26 Sep 2022 03:30:40 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v8-20020ac258e8000000b004947a12232bsm2486244lfo.275.2022.09.26.03.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 03:30:39 -0700 (PDT)
Message-ID: <fe747000-a650-ed2f-8581-92b044f86f2f@linaro.org>
Date:   Mon, 26 Sep 2022 12:30:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v7 1/3] dt-bindings: arm: qcom: document qcom,msm-id and
 qcom,board-id
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kumar Gala <galak@codeaurora.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh@kernel.org>
References: <20220830065744.161163-1-krzysztof.kozlowski@linaro.org>
 <20220830065744.161163-2-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220830065744.161163-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2022 08:57, Krzysztof Kozlowski wrote:
> The top level qcom,msm-id and qcom,board-id properties are utilized by
> bootloaders on Qualcomm MSM platforms to determine which device tree
> should be used and passed to the kernel.
> 
> The commit b32e592d3c28 ("devicetree: bindings: Document qcom board
> compatible format") from 2015 was a consensus during discussion about
> upstreaming qcom,msm-id and qcom,board-id fields.  There are however still
> problems with that consensus:
> 1. It was reached 7 years ago but it turned out its implementation did
>    not reach all possible products.
> 
> 2. Initially additional tool (dtbTool) was needed for parsing these
>    fields to create a QCDT image consisting of multiple DTBs, later the
>    bootloaders were improved and they use these qcom,msm-id and
>    qcom,board-id properties directly.
> 
> 3. Extracting relevant information from the board compatible requires
>    this additional tool (dtbTool), which makes the build process more
>    complicated and not easily reproducible (DTBs are modified after the
>    kernel build).
> 
> 4. Some versions of Qualcomm bootloaders expect these properties even
>    when booting with a single DTB.  The community is stuck with these
>    bootloaders thus they require properties in the DTBs.
> 
> Since several upstreamed Qualcomm SoC-based boards require these
> properties to properly boot and the properties are reportedly used by
> bootloaders, document them along with the bindings header with constants
> used by: bootloader, some DTS and socinfo driver.
> 
> Link: https://lore.kernel.org/r/a3c932d1-a102-ce18-deea-18cbbd05ecab@linaro.org/
> Co-developed-by: Kumar Gala <galak@codeaurora.org>
> Signed-off-by: Kumar Gala <galak@codeaurora.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> ---
> 
> Changes since v6:
> 1. Update header with defines
> 2. Add Rb tag

Hi Bjorn,

Any further comments on this? Can it be applied?

Best regards,
Krzysztof

