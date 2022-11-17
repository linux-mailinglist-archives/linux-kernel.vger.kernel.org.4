Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5112662D749
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239473AbiKQJm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239304AbiKQJmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:42:50 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB17657DE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:42:49 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id g12so2777914wrs.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RDiUNyLGINz4bNu2tXJbnzRCWz4xt6nCkosMidGCTP8=;
        b=cz6WIWe+HoeDjkfbCmslmgKChcNsPwENznXpyNBg1TtWpVKg8olK7v/JN34IYRuNgJ
         OvNEz3xnWoOVX6cQ1KwosDCfA3rAgcq6FSvn7zZWD6gttC75OryysFw3nkoekBrWOMw6
         ZU/LI7wMiAek3JORckRPy+72qvQcbXIf6KdlhQXupsNNEeOHDpAaP37tKLiHiQKKRFo+
         rBx1Aclv5Ru2RhSAInr5AcxD0RiuWVwbwA7wv/sJzv889bjha/WH6lE0xTbb5K+22rjJ
         Z54gFbCot5qgxUGtcyfUVGcd57AVFm4vI0EvU4FwQ59KeZI87VBKX5dZ3eYwTsNeKJCQ
         q3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDiUNyLGINz4bNu2tXJbnzRCWz4xt6nCkosMidGCTP8=;
        b=lGIP+w54gByMvQo/jRqSeq8QS5LtXlGE2Y4STFscu8AvuYg27EW1wfwAVpTjr+7uJW
         cjBE5tVA9OsGxbJNlCvaHZtFBkcqJqPqKODNpsn0/OD2ds+erzEtSrrm43lRnMoqEJNR
         m3lZbmJ7YjMtc4oujb1i6nbBxQifk0u5Gy7GY9/MyY5GLM98vfnGEFNKu5YME+/xmA55
         Vv14cXwrTFGAQZKmzj99EhrlgZpo0qa73ZOrluW5+gohRx0zGZC38JY3SA9Ycy41aenS
         bYLZ1zLvtYyEVYgjNe5JkD7C6yoUzaaRsAVA2BSjj9tZwVhW25pgBCt67DE31UGTZL+t
         kKgQ==
X-Gm-Message-State: ANoB5pn/v1SRKbEOvumXcCyQcmizYH0MUWhE8FW6J8gcXcSvU6rLQ5G7
        YUeVfobP/n+bK8kL90kNw6R7BA==
X-Google-Smtp-Source: AA0mqf5jf9a9rEXaGNrcCFERlvcfuQMmTx6Hk/1vl5s7IQ1reFpApijantaTxFMBZcTfVkwmFZx4Tw==
X-Received: by 2002:a5d:4ccb:0:b0:236:d611:4fcf with SMTP id c11-20020a5d4ccb000000b00236d6114fcfmr943748wrt.192.1668678168139;
        Thu, 17 Nov 2022 01:42:48 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:aad5:8d14:a22f:2e8b? ([2a01:e0a:982:cbb0:aad5:8d14:a22f:2e8b])
        by smtp.gmail.com with ESMTPSA id u12-20020adfdb8c000000b002367ad808a9sm471058wri.30.2022.11.17.01.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 01:42:47 -0800 (PST)
Message-ID: <8edb4848-105a-26a1-63e7-137526445d18@linaro.org>
Date:   Thu, 17 Nov 2022 10:42:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/4] dt-bindings: qcom-qce: document sm8550 compatible
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Andersson <andersson@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org
References: <20221114-narmstrong-sm8550-upstream-qce-v1-0-31b489d5690a@linaro.org>
 <20221114-narmstrong-sm8550-upstream-qce-v1-3-31b489d5690a@linaro.org>
 <51f5ee2c-bf25-71ab-594d-2da18a44d3b6@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <51f5ee2c-bf25-71ab-594d-2da18a44d3b6@linaro.org>
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

On 16/11/2022 12:54, Krzysztof Kozlowski wrote:
> On 16/11/2022 11:23, Neil Armstrong wrote:
>> This documents the compatible used for QCE on SM8550.
>>
> 
> So we have a dedicated compatible... This should be squashed with
> previous one, added allOf:if:then making clocks optional only for this
> platform (assuming that my understanding of "enable=exclusive control"
> is correct).

I'll wait until the dependent patchset is refreshed and a fallback plan decided.

Neil

> 
> Best regards,
> Krzysztof
> 

