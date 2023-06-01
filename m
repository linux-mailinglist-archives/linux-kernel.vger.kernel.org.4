Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C229771F0BB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjFAR2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbjFAR2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:28:19 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB7B136
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 10:28:17 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51492ae66a4so1712768a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 10:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685640495; x=1688232495;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GSwESS+oqrQo7VcXvwhXiCwIWl5mUyF6ny+bNRXBeIQ=;
        b=nHd8WRF6klc9Z8g+TDJuJUHm6TijemuLodkSm422zfT4tFWbkcxXEqEWmisXkKAKFh
         xU6O4ZHln1Cn2wSuQIA45xIKdxkSoCOTqGnBGJaPVFNj6utWUuiqPaA4qqGosTTPvyXW
         4/qts6KtDIBkRVCMQaGS2fBoB5ZTh4qXq/5zf4jFQV7JDK2RGOPa4Y1tcaR7mkWjJooQ
         AU3Z4hfv7PcwD+Uku90CMNEI9OSqo/JQsis1cJN+xPiqh1MSw8TnpY2V8OLfiScrD0OZ
         Klg3zUvADeRrl6UrfsnSLPA7cuBqk5xOcNgRkrcLsUMbOa62K9D7nf/YfCb1rjmFXuqC
         GMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685640495; x=1688232495;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GSwESS+oqrQo7VcXvwhXiCwIWl5mUyF6ny+bNRXBeIQ=;
        b=Zp+fG1Vojxrzau8b15fkwzwX8Z0+5J0iLGcIDSVJBRUCnVoMMs4rrnGEvS0Vaf/a3I
         jeYytUtfAhSUsSoz2obn2/SW9oOkPwda+4yf4Lhrrdrpg+H01Q39HtA8CsLxXzEdSSoi
         bDa/2xZEsjt246OLYAibnRbTCMBpU2UDfqb41FDTLhYIxnaNmj/TO6sFew3P1WRvDz+E
         MTBJwAexlL+h7eVXnOX7iUkFwq27B3OfaC0KdDWS99cf6IeuBCFd7yN+ItaF0y+YippV
         0rycneN/8Zhuwn4xL2UzRMrUr+nclEYw4I4Zb3JBeNeB2U7kxQAYIsr40Ds8W1/0Zjuj
         7pPQ==
X-Gm-Message-State: AC+VfDyHvK6K98N4bTCCZiZCKoyqxS8FI5SBY8wyf3IeqWtxRsfMgcbH
        8dCQMkLtQjnzDu84jKy+OEbZnA==
X-Google-Smtp-Source: ACHHUZ6YIptlr6jEij6iIoM3ConqqwwAbvwOwVU+9YBqV4AT0Ud9CPHQOdPmLDciLLjsLq+oCxDDxA==
X-Received: by 2002:a05:6402:2039:b0:514:ae18:1637 with SMTP id ay25-20020a056402203900b00514ae181637mr413205edb.23.1685640495827;
        Thu, 01 Jun 2023 10:28:15 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id i5-20020aa7c9c5000000b0051631518aabsm774311edt.93.2023.06.01.10.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 10:28:15 -0700 (PDT)
Message-ID: <22073218-42a4-9751-bcdf-02770ccd9c2c@linaro.org>
Date:   Thu, 1 Jun 2023 19:28:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RESEND 1/4] dt-bindings: arm: qcom,ids: add SoC ID for
 IPQ5300
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230601042054.29075-1-quic_kathirav@quicinc.com>
 <20230601042054.29075-2-quic_kathirav@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230601042054.29075-2-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 06:20, Kathiravan T wrote:
> Add the SoC ID for IPQ5300, which belong to the family of IPQ5332 SoC.
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---

This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions. However, there's no need to repost patches *only* to add the
tags. The upstream maintainer will do that for acks received on the
version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.

Best regards,
Krzysztof

