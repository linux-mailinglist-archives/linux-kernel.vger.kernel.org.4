Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680D763394D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiKVKEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbiKVKEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:04:34 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D2525C54
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:04:33 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id g12so22849053lfh.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R06iF1lW8HVirDTOwJwPuzxMcJld7yeTkT0z9J3Upeg=;
        b=zoR6Mq5LrTNQRHFkWpPD82uatdPjvEutxHMyA1e8lIujn9o9beflOexcSaMXQjlZPc
         jalv612+Ct5uQpet+BdbenIzglbSKhHQwQ6ar29HX3Cem4Qt5wvKk2W7RzgPwws8s+bx
         njA1An8sPCjUrQ8u6FHnosGXS1319c1OJt0sNAa1qAOZ6qREF1cZ+CXW8rBkS4J2niG8
         d27L7ElLhgWniwA+U+Pzjjonjurk6ZV5YQlzGsmNNaApy1nVclm58hu2c40aLcB/CTn3
         YQqyxo6W2jAUMV05Fw/e7+U/X83+zSTdUphh33RWIUdoPpSseYWOWeDs68EVvDZRPsSU
         g2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R06iF1lW8HVirDTOwJwPuzxMcJld7yeTkT0z9J3Upeg=;
        b=SgjfLL/0el4qMN5syTp1pA93knN6wK+l7oGP+1p/BjdYn0K9ni46ytjaOciy6/HWYw
         /BiEuMZKJ4VFkayj/MM2d5gOWTH1jIx8aLN2wPUHx2ZgDhD7L3xrHwL7nLG6DBBvTdg7
         luCARYFfacFOi954aC2HmcxKwsofRjutQFxYHDIL2DgCfLe1hkoBjWRZ6FVSKsK8B3gg
         Fk105uMXEPaIaPQSRWSuaODAHi6SVVV86qsIW90X9g0rZP3WmbMOtxMJPj72brdl8ADX
         hIHFB3hU/PiWWYO3CjSChG2Ocy5A6NUWS2ykPYBcuFNmXxuwp8V5B3yXMnRPPU83cv4m
         kwgQ==
X-Gm-Message-State: ANoB5plbpyyq15DhXcuSpfCEdLaIKjgdzmY5YVfXCP3zbYy/kjrpkVXc
        ruiEPvsSyTnFyf/oQVlsGyrQQg==
X-Google-Smtp-Source: AA0mqf7tOh8RcFdN6STWJY2o+5o3qTtMp2J2qYpU+zLGRIVC+txFUFYRg2U+Cvi2fR0smD5hVkE3Yw==
X-Received: by 2002:ac2:5f6c:0:b0:4a2:bca5:76bc with SMTP id c12-20020ac25f6c000000b004a2bca576bcmr1760004lfc.123.1669111471800;
        Tue, 22 Nov 2022 02:04:31 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 26-20020ac25f5a000000b004ac393ecc34sm2410886lfz.302.2022.11.22.02.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 02:04:31 -0800 (PST)
Message-ID: <e0fb4c60-3c84-cc52-b6ca-6ed081bb36ef@linaro.org>
Date:   Tue, 22 Nov 2022 11:04:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: qcom: Document the sc7280 CRD
 Pro boards
To:     Rajendra Nayak <quic_rjendra@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org,
        mka@chromium.org
References: <20221122094921.23109-1-quic_rjendra@quicinc.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221122094921.23109-1-quic_rjendra@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2022 10:49, Rajendra Nayak wrote:
> Add compatibles for the Pro SKU of the sc7280 CRD boards
> which come with a Pro variant of the qcard.
> The Pro qcard variant has smps9 from pm8350c ganged up with
> smps7 and smps8.
> 
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---

What changed? It's v3 so there should be a changelog here. Same for patch 2.

Best regards,
Krzysztof

