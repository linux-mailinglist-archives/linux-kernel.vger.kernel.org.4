Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C78C6F87F4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjEERsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbjEERsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:48:23 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D275C1A4AE
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:47:57 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50bc5197d33so3974444a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 10:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683308795; x=1685900795;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C8N9Yr+zLlSevy06onPb6pPa3VVo3y3jk+4XaNqiZBs=;
        b=sKW0VW5qv/7liKcH03jq3lk5gNpZ71TggQwdgC9owC7Qd+4QeRfutxoL3s2ngNcm32
         rGhb9Tg5t4Z35Xsh5i3B655ThqoI85HmZRcSn1wR7WLqL/aOVT8cN2dO90KMTQeW3SaX
         OPZByvxs8o5lkPwB+h2HTxUPB5FGMqImkY5jklyJnSGp5NMHhh0W1imyzaB4yfoETlgE
         K0WrgYY7ji9Xi+SGdABphR9eDWZsXGsWCzNPfLfSSPzh/5LSJ/YMmItvTe+N5PX699+v
         ytg90Sq221DtaqNUyguk7pT7ZqMUndt4CIXhDvUXren0qsZQcJy5DqQXOihgPl46JBK5
         aRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683308795; x=1685900795;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C8N9Yr+zLlSevy06onPb6pPa3VVo3y3jk+4XaNqiZBs=;
        b=B90JqF0VafyKHQvzbPuO58wYYX7YJm52W3jb/xmGSgh3NzDu49C6+OleErWkxQl1b2
         AY5fsOjOfDA4vgaED6o9Dog5DhBucaQk/Y45MrBjhaJe96gZER/+qIkUsNeQ/eUynZIe
         zCBB88oRq6J3RQ5atILnvDLJ33SPVvAc6pFUzEz0TIy96ns5gqlmQCBlcqXCd+Y0P1zz
         kFtnMXj3DIRTK3wGR8ZwKkZ86rnpAhmNqK+cHU1pRRBN5D7Rwmb6MzaxKwBPkcDJ+mxU
         qAXYiEA0ZJ4DikhWmMeiJIKkWVXx9Sr6wCnchSVafP5Lh26Uw/4rTn1A04TONRBboLqA
         BdEg==
X-Gm-Message-State: AC+VfDx8L1ZNVhfPVAEU47BJ7T4BIxJSgwDgfSGw8VzA9HBwRObIRack
        y38d15HrpAykgdCeQ9gop/ezfbqy8bmDuJzq97R+hg==
X-Google-Smtp-Source: ACHHUZ5YVY8N0DzX6h9cm4JNuQQzxfsGQgQZKNrnF1+roP7Bz5pge3isOtPrJreeZ48Xm5hU0N/W/g==
X-Received: by 2002:a05:6402:1343:b0:50b:caf9:4b85 with SMTP id y3-20020a056402134300b0050bcaf94b85mr2026314edw.18.1683308794939;
        Fri, 05 May 2023 10:46:34 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:52e:24ce:bbc1:127d? ([2a02:810d:15c0:828:52e:24ce:bbc1:127d])
        by smtp.gmail.com with ESMTPSA id s3-20020a056402014300b0050d83a39e6fsm286383edu.4.2023.05.05.10.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 10:46:33 -0700 (PDT)
Message-ID: <ccee82e5-96d1-1275-8fe3-73ccc81db11a@linaro.org>
Date:   Fri, 5 May 2023 19:46:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v10 2/9] dt-bindings: phy: qcom,qmp-usb: Add IPQ9574 USB3
 PHY
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        mturquette@baylibre.com, sboyd@kernel.org, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-clk@vger.kernel.org
References: <cover.1683183860.git.quic_varada@quicinc.com>
 <10b8b06f133c72415a609e6bc6595424712e029e.1683183860.git.quic_varada@quicinc.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <10b8b06f133c72415a609e6bc6595424712e029e.1683183860.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2023 09:35, Varadarajan Narayanan wrote:
> * Add dt-bindings for USB3 PHY found on Qualcomm IPQ9574
> 
> * Making power-domains as optional since IPQ9574 doesn't have GDSCs
> 


>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,ipq9574-qmp-usb3-phy
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: aux
> +            - const: ref
> +            - const: cfg_ahb
> +            - const: pipe
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sc8280xp-qmp-usb3-uni-phy
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 4
> +        clock-names:
> +          items:
> +            - const: aux
> +            - const: ref
> +            - const: com_aux
> +            - const: pipe

required:
  - power-domains


Best regards,
Krzysztof

