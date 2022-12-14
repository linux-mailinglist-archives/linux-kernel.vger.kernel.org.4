Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C571264C4C2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 09:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237622AbiLNINF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 03:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237594AbiLNIMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 03:12:10 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDF25593
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 00:11:49 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id a19so5936272ljk.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 00:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ip0serP3xmmQbIfs4fDtH7mgxkF1llT1RnwM7UmnRxc=;
        b=y9eh1KomaAEcgSF+zPUM9+IKthe5Z61BSrr2KkQzhUJ3CoMOAP2TBO5WaUqLUeuIBQ
         bmO6KPMtdivLDpVoN2F2ldk4lnU+hz/rSDhdR4xjnQDZ4UsM6imYDQ5zWaiONmIOR+g7
         AlFi51ewsRfZYiUvEirTK5cZ8VUG8rjfeXQbBi0MOOsxyG9xgRDpGN1ZAmtOhl5vUgwv
         cUqgGVQCop9Aoxq+hr3fOrGp8t9eI6O8r/9QnfNnvhyaObmgQo0vIGxcA4HYOHDW6qc8
         iWG/Y7M12pz+FaXCdeVXXDdra/X4WSOds7z519eSPFpZu3AFK4vDfEocMzyrDAmV7yeZ
         IE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ip0serP3xmmQbIfs4fDtH7mgxkF1llT1RnwM7UmnRxc=;
        b=drZmfQ4Qi2b6Pnl1KcLmAs/OQywnz0sVdx2qpRxf3Yx+lnPQyCR5K7Ou8dDf5Hyjv9
         Jumtgpdn/c6Ob8pQMt5LFqG7sUuB2dskUC5jrLI95Xn8ledMhxGGgSNTsmGeSy21xSkE
         5fXv7t9rRtB4xMAYnG8tduhpKuiufLaGIcy0Wcemeqp3A8ELSx0MI+uSFm2DEsT4q4jn
         JF1E2V8LML+8Vqg0vSQBBiqX+8ulbYu/U6HfQK0XotF23lyJfQcJPfYqHFnWWmtiQs2c
         hSpdpprPfMmxvAtwOOg2U/P+wqvmJcoo2X2CrM6gNUuKDyfggnx0huSQyH7cg1gTa1wB
         NDIA==
X-Gm-Message-State: ANoB5pkm0si2TL7WD6Gk2Q9DQrLXMZbsHzZEeG2OGE6q/GE4dXISLBAt
        IZMLVdZ6gZE63Xgo0QMBDuMkpw==
X-Google-Smtp-Source: AA0mqf7MPF0BZwKj8sqR8TNQS+aLTPnWVDGKHcSD+DqGHkLhS9ezekrute2N8ZC+NaYodC1ke+k0MQ==
X-Received: by 2002:a2e:a4b4:0:b0:279:fb4d:34f5 with SMTP id g20-20020a2ea4b4000000b00279fb4d34f5mr5939057ljm.40.1671005507615;
        Wed, 14 Dec 2022 00:11:47 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u16-20020a2eb810000000b00277041268absm527879ljo.78.2022.12.14.00.11.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 00:11:47 -0800 (PST)
Message-ID: <e79ae240-95ce-1629-70f3-378d98f38841@linaro.org>
Date:   Wed, 14 Dec 2022 09:11:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/2] dt-bindings: reserved-memory: rmtfs: Document
 qcom,assign-to-nav
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221213170340.456252-1-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221213170340.456252-1-konrad.dybcio@linaro.org>
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

On 13/12/2022 18:03, Konrad Dybcio wrote:
> Some SoCs mandate that the RMTFS is also assigned to the NAV VM, while
> others really don't want that. Since it has to be conditional, add a
> bool property to toggle this behavior.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml  | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
> index 2998f1c8f0db..1d8c4621178a 100644
> --- a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
> +++ b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
> @@ -31,6 +31,11 @@ properties:
>      description: >
>        vmid of the remote processor, to set up memory protection
>  
> +  qcom,assign-to-nav:
> +    type: boolean
> +    description: >

No need for '>'

> +      whether to also assign the region to the NAV VM

Here and in property name you express desired Linux driver action, but
it is better to express the property of the hardware. What is
different/special in these SoCs or their configuration that additional
assignment is needed?


Best regards,
Krzysztof

