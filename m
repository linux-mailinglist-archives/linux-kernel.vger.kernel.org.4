Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C807027D1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 11:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238107AbjEOJFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 05:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEOJFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 05:05:08 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522BCA7
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:05:05 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so109415386a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684141504; x=1686733504;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KuwukPTyOXu6w4JEQ/VrXwexvRuPurINFM94wED3Sso=;
        b=Kv2ht60gYFBv4etr27i9EKrgSochPbuhVf5uJlzNG/lc21Y8EBQWy06sYdLkyISS23
         zDgVeR5VJinSrx76bcM1QgZp4Rsuf677CDq9ChvmSrKYiIg7rBbvcWexOtZ//G17lvHr
         v3CRmxnrmn6gCyhQlTWtc3f0BpOx9gXao+Wj9chY3IftxW/aDganPGRviRHhINuFCd+N
         EPeMO0spmg7puz0od5egsciVSeB2iUherUdEjHJGnQ1Ayi7+7TxJtNTb8NVsSM7GVKTJ
         OcdIkV4KvYAAkAVTW1i2xmwaYG4OETpSXfqG15bQXQ0BO5ovfp+HrXsk0n/KadvFS5bc
         mrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684141504; x=1686733504;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KuwukPTyOXu6w4JEQ/VrXwexvRuPurINFM94wED3Sso=;
        b=gn9zfaPpJdfvU22vXJV2MlFRQReyQPXvxXQVpJP49iRPtGIdqQrJolUY9FzF51og4F
         MaqxOnStTqLIoAOv+Y4jeGUcU9AHYYAa8XEkfcKo79wrfxpOs9+ZCby1RZFwwR65zrCT
         7Tg0QQC3BFuNNDbDXiGc6wnHv3r6MKf05ZE9yZG8jlDktgO9aunoN7mGGdpwMWPCEFXI
         sieiWTMU+78kAtLFHDK0vcgXdAJ60v9HJWTTbzGCGJNpwAvvEAR1tsmTL2HUbQdT4VTH
         Add19+AQSa4yWbKk9qLddtV5QPaCsl/hMpigP07xuyWAQfPOlJ4fR2SRB024i63xkCIM
         SK9A==
X-Gm-Message-State: AC+VfDwXOilY94DJV5Oz5J8Io/q2w1NUqXuomLuZAepez+UXuTxg1iAj
        /XmeoMgfjKedxv8LrFqL/9g66A==
X-Google-Smtp-Source: ACHHUZ69UoYWOUicY+L0mCVSuMqQk8xbvxh05YvF9x5IjZ3VBDavAVm8Ei+PNtD2wopg59g8izC9eA==
X-Received: by 2002:a17:907:7baa:b0:966:1484:469e with SMTP id ne42-20020a1709077baa00b009661484469emr25828771ejc.17.1684141503759;
        Mon, 15 May 2023 02:05:03 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6470:25b8:7c2d:1992? ([2a02:810d:15c0:828:6470:25b8:7c2d:1992])
        by smtp.gmail.com with ESMTPSA id my37-20020a1709065a6500b0094f44bdf7acsm9232272ejc.57.2023.05.15.02.05.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 02:05:03 -0700 (PDT)
Message-ID: <e553d2c4-8891-fe84-eff3-d3f6a35b7e09@linaro.org>
Date:   Mon, 15 May 2023 11:05:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 02/10] dt-bindings: nvmem: qfprom: Add compatible for
 QDU1000/QRU1000
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230512122134.24339-1-quic_kbajaj@quicinc.com>
 <20230512122134.24339-3-quic_kbajaj@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230512122134.24339-3-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 14:21, Komal Bajaj wrote:
> Document the QFPROM on QDU1000/QRU1000 SOCs.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

