Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12FC6BC7CE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjCPHy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjCPHy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:54:26 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6520D19C70
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:54:21 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r11so4078628edd.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678953261;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N02M+a2kTE3JjbB1vKJlAR3DvW9jYOfPwGPBh9ASs+Q=;
        b=SWSVd6ySZdhrva/u5nGRqpZhyDkJ06XCrgRVKv58H9y0OIYoLg8/UkCHXfSbcWQWzO
         v3NYh3owdES5B3VkxthZnh4Z3eD+C5SwdtHy2f0TsF+FHha0hHtGo3lJ6BbDF9nWS6+I
         Nm/BaNzzXyJjkDlcnDJ6eX/vb8KfobSoObNrtVCBn7pBx053k1fMoIdN4kw7xmm21dlK
         rv+ZUjhmitsYAPS9cXdI+j5ubzEMm9obkk5ojTgwgzQZF5gvzpMXs2GJ9oppVYx/JZY0
         OiR1Mbg1MCzpsGr1BfK0wOpUDRU6TOuHZ7CNcQokydS6P7XbucK8CpOGNvgt1kjBseyO
         TdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678953261;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N02M+a2kTE3JjbB1vKJlAR3DvW9jYOfPwGPBh9ASs+Q=;
        b=1MI/uLh4PuN3YInp+qdDY8qR/PaItPLfs7cYHIZVWG2AwrERxXTNvJ3PN/ZLBS3x6d
         jYm0zmcoZv76YhL3t5PX5FAxyRexA5jhPl7k2NGjcVv+LETHBX+OZA9mbhRCgTNN7/EP
         8aLj4MrYWSHm4y0Q3Ro26mfUUhdcVW+VHbZU08wuRX7ECp+qZhYl3pz8vbrdma4B/EJF
         p8Js04eXy2ULDjaDyrHaUkhucuqxWdvzny7pQMI6o6J+igK0CoABZMleK4+hIt2ydTh3
         J1HUGGRyaiQ4f78mx8M4EkM/+j7WqlejgLVQcROrWUslIa44KLd/SKFZUlWrF6Ezg7G5
         9WKQ==
X-Gm-Message-State: AO0yUKXfqvunQyvtt7z82xN6OYW/X2XgRcouPPsHPRMr5D1HX8rKFIzO
        JhsgjkFQxR3vzGNJr7RIW0Vm/A==
X-Google-Smtp-Source: AK7set/EFFCpeXuICHSKn98C4EGdOoLaorJK1gOh5sdWDsbs9zFMCDjWCkUn6JCF+ly3akI/kJJU5A==
X-Received: by 2002:a17:906:16c5:b0:8f7:d5c0:c71d with SMTP id t5-20020a17090616c500b008f7d5c0c71dmr7712893ejd.60.1678953260916;
        Thu, 16 Mar 2023 00:54:20 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9827:5f65:8269:a95f? ([2a02:810d:15c0:828:9827:5f65:8269:a95f])
        by smtp.gmail.com with ESMTPSA id n18-20020a170906701200b00927f6c799e6sm3484762ejj.132.2023.03.16.00.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 00:54:20 -0700 (PDT)
Message-ID: <95b3c16e-b888-9fec-7f6f-633021289642@linaro.org>
Date:   Thu, 16 Mar 2023 08:54:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] dt-bindings: mfd: qcom,spmi-pmic: Add PM2250
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230315183819.3563704-1-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230315183819.3563704-1-konrad.dybcio@linaro.org>
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

On 15/03/2023 19:38, Konrad Dybcio wrote:
> Add a compatible for PM2250, commonly found with QCM2290.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 1 +

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

