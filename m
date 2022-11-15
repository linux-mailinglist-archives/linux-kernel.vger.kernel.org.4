Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E116D629CD0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiKOO76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiKOO74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:59:56 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A8723384
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:59:55 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id bs21so24732003wrb.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:reply-to:organization:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VZvJ6/3BqvyPf+pzGos2oDLHrGIaz7vagLhxMIbbdag=;
        b=E7xm6VJfsawpfWB8Jt6W2hrRrvISw4FVgxyFm6Edw2eInKscMIixwZ3hHVYzm+tnel
         YuVb6XV4vthoKczmyW/ItA5ljymXLJ9q5rYVpNoWpXztFZFNkZY7Tj0uVOi4YrOxahIz
         SRxtpwhfQ4XdRkxvSESf31Ycj/DziujLUelMamVZ/8PlOkhm5/tKcirB7NtNIKu2bhyR
         x8FlWyhT9sVwQkfAzkS0mM/kWNh1BrkBQvSGxP9Y29S+W1p3chilLv7+OzltJ21b9lWs
         CSzGfWRv5Gu+MztMbcrW3LYuVJ1A4j9Vh32T+SH8ka97F9u0pKeDDtECMmqEfrybhyrX
         t6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:reply-to:organization:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZvJ6/3BqvyPf+pzGos2oDLHrGIaz7vagLhxMIbbdag=;
        b=lt377AGA0AFOYFI3T//NCFbbaCv8JEMCMjf5+N/5Cdr9r2dZgkExkbIA6egEDknp60
         snk5Ss+rrkuUBlTLusVne6Cytv3ZYUTw6jbmoHcSli+gNImnxkRxPepJjyJ1y4lQJ1YK
         oYpqfAIW67/ts23UE3JAvvvh8AbVBfyIDDFQTruy8AvRRMC4B20Sw/hBkMvnijz3SNRL
         RvTe7rknJk6g3JsOCsRC6bjZJi9khQ3NAvkspjG51bxcvM87oJ1XCVhm2WVIUbTdv4gT
         CL+RsBHGifuPaBIVW90f5jkg0yWzrY8ZyACGNWEXlsCw9z0cLY1EVoF7YKgGMn7Fig2Q
         ZUGQ==
X-Gm-Message-State: ANoB5pkeA01ntuLDm/+rHVGZyax+oMj5T+brrU6qpR6NuNIOFpymlCnv
        qsIkzc5EvyRvQYvYYCiVsxoIVQ==
X-Google-Smtp-Source: AA0mqf6Jor9LYoLr9QBx6i0iQ3nk/BYX/fdO0UrwfcTyHitEt0Gq4DsOS2gB8DRtRgiEpkmPPcG4qQ==
X-Received: by 2002:a5d:604c:0:b0:22e:7630:dfa with SMTP id j12-20020a5d604c000000b0022e76300dfamr11357620wrt.1.1668524393957;
        Tue, 15 Nov 2022 06:59:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:fcf3:1c15:2e51:def7? ([2a01:e0a:982:cbb0:fcf3:1c15:2e51:def7])
        by smtp.gmail.com with ESMTPSA id b13-20020adff90d000000b0022584c82c80sm12485483wrr.19.2022.11.15.06.59.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 06:59:53 -0800 (PST)
Message-ID: <0b5ad94a-c470-422d-45eb-1ec0e77a27da@linaro.org>
Date:   Tue, 15 Nov 2022 15:59:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v4 1/2] dt-bindings: regulators: convert non-smd RPM
 Regulators bindings to dt-schema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org
References: <20221005-mdm9615-pinctrl-yaml-v4-0-463523919c19@linaro.org>
 <20221005-mdm9615-pinctrl-yaml-v4-1-463523919c19@linaro.org>
 <166851961643.867594.12105329661363857830.robh@kernel.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
Reply-To: neil.armstrong@linaro.org
In-Reply-To: <166851961643.867594.12105329661363857830.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2022 15:11, Rob Herring wrote:
> 
> On Tue, 15 Nov 2022 11:12:35 +0100, Neil Armstrong wrote:
>> Convert the non-SMD Regulators bindings to dt-schema, the old text based
>> bindings will be deleted later since the RPM bindings are not yet converted.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>   .../bindings/regulator/qcom,rpm-regulator.yaml     | 128 +++++++++++++++++++++
>>   1 file changed, 128 insertions(+)
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> ./Documentation/devicetree/bindings/regulator/qcom,rpm-regulator.yaml: $id: relative path/filename doesn't match actual path or filename
> 	expected: http://devicetree.org/schemas/regulator/qcom,rpm-regulator.yaml#
> 
> doc reference errors (make refcheckdocs):
> Documentation/devicetree/bindings/regulator/qcom,rpm-regulator.yaml: Documentation/devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml
> 
> See https://patchwork.ozlabs.org/patch/
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 

Damn, will fix in v5.

Neil
