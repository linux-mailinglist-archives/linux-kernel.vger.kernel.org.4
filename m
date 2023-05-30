Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4417160FB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbjE3NDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbjE3NDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:03:19 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75754107
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:03:13 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51493ec65d8so5530345a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685451792; x=1688043792;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sxSrHcQ+Rfv5WsJBf8E7yyTNyGPqPL0fjVeC2MNErXk=;
        b=qA4PIGQoDKrsxkHHX+DKsKbUKxUC97JbrgygST95dAvXvCdyG0IzQDXaaZqunaxM0k
         Uo/aTqlH4B/p0/h/6D9EqHad2J67br3d/6etgDDn7srO1UZaZjwNX26pKArUPBTMYcp+
         sWcyDfNsDj/gw1TAZKYIE6mjHqOeCsAjRGV9pl025mjYhYaaL2ivr4yUbxxw9WJ+4yOQ
         w5eCHXims/Vo3twYU39ORtQwxeOkqiWdCxNxtwe2Yh297xKyFE1iQxEse2je5EAEO2Qu
         XAb8HAf2zYgQitFTyA5w9w9J5EihjdhhA7xq0RezZFYmJitT5iwt4dRiNiCmkR3IiySC
         7SeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685451792; x=1688043792;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sxSrHcQ+Rfv5WsJBf8E7yyTNyGPqPL0fjVeC2MNErXk=;
        b=BXs8M0EqHljp0M4duJLk6NV+Wi/M2M9xfNJLSCMwgceyuetLxevgooR8et/bsWd6J+
         kQCUC9A1C+QTLhYdZ5avRcpHm8/gPjctfUWXmZW3Skgi9cuwr391fyOlAglqFwAsmK3t
         g6ZJLmaXDz1l2zhZbqnO2399G2T3d2dz7uPXQz4lPeBLiWjguW1JrnwcwvAdlCPVTGff
         Hg1DRaiKNsoQ/2CUCGOaLh0mlNQHf1H/oE62B7EkT6Nl4Pra2HSkNYkJPbTw6DNHk7qz
         Xmr1unKNf+AUwi1fdGrXoesDgr9MmybRp8uamx2uCRuMqH0KX8W4itbnQdn/inNsyznv
         h6+Q==
X-Gm-Message-State: AC+VfDxIikQzNVjahsLwwQ9FmeAksvUz6cxcZAyCZ1JJeiUETCVAIq53
        s3wdX4iGDSe7qbCPfvJJTAzHFw==
X-Google-Smtp-Source: ACHHUZ4YokxW5yBSu8opb+3Wdc9O/FIwR5swnl0lU0efma8tJWTF9gW7M5io/1Q45rU1m21plhKTsg==
X-Received: by 2002:a17:907:9342:b0:96a:ee54:9f19 with SMTP id bv2-20020a170907934200b0096aee549f19mr2515980ejc.48.1685451791771;
        Tue, 30 May 2023 06:03:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id sa24-20020a170906edb800b0096595cc0810sm7329283ejb.72.2023.05.30.06.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 06:03:11 -0700 (PDT)
Message-ID: <8ea4e54a-56bc-c3a9-f67e-7d2fad4ba09c@linaro.org>
Date:   Tue, 30 May 2023 15:03:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 1/4] dt-bindings: nvmem: qfprom: add compatible for few
 IPQ SoCs
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Kathiravan T <quic_kathirav@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org
References: <20230526125305.19626-1-quic_kathirav@quicinc.com>
 <20230526125305.19626-2-quic_kathirav@quicinc.com>
 <20230530125918.4waqxc4xmnetb5wb@krzk-bin>
In-Reply-To: <20230530125918.4waqxc4xmnetb5wb@krzk-bin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2023 14:59, Krzysztof Kozlowski wrote:
> On Fri, 26 May 2023 18:23:02 +0530, Kathiravan T wrote:
>> Add the QFPROM compatible for IPQ5332, IPQ6018 and IPQ9574
>>
>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>> ---
>> Changes in V2:
>> 	- No changes
>>
>>  Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 3 +++
>>  1 file changed, 3 insertions(+)
>>
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/1786533
> 
> 
> qfprom@1b44000: compatible:0: 'qcom,qcm2290-qfprom' is not one of ['qcom,apq8064-qfprom', 'qcom,apq8084-qfprom', 'qcom,ipq5332-qfprom', 'qcom,ipq6018-qfprom', 'qcom,ipq8064-qfprom', 'qcom,ipq8074-qfprom', 'qcom,ipq9574-qfprom', 'qcom,msm8916-qfprom', 'qcom,msm8974-qfprom', 'qcom,msm8976-qfprom', 'qcom,msm8996-qfprom', 'qcom,msm8998-qfprom', 'qcom,qcs404-qfprom', 'qcom,sc7180-qfprom', 'qcom,sc7280-qfprom', 'qcom,sdm630-qfprom', 'qcom,sdm670-qfprom', 'qcom,sdm845-qfprom', 'qcom,sm6115-qfprom', 'qcom,sm6350-qfprom', 'qcom,sm6375-qfprom', 'qcom,sm8150-qfprom', 'qcom,sm8250-qfprom']
> 	arch/arm64/boot/dts/qcom/qrb2210-rb1.dtb

Not related, can be ignored.

Best regards,
Krzysztof

