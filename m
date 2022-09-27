Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EAD5EC19B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbiI0Li0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbiI0LiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:38:19 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC411449D3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:38:15 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j16so15302934lfg.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=cnbtuJqShkVt4h95QD+zLCK0/9qnRVCyBaJyOk7itxQ=;
        b=BoAMliHmsbF4Ku7NnbL7OW3mQQYB8xD7LrE7WarQXJAOVAI9/5re2/JhelWnR2MNul
         5KLK3YkxOxzgtbwOVB02VLBhhDjjvX535XM8AfC5DnSPUsw7RURMy8bjzfxiTX55pfsX
         +ZM/1ftZR5YegIX9wQSsva4BGegIDY7plf0J0OdgDMOPMFcOiP/fNuDaFjmLMCQBxZfp
         uu1OMmydUn/8jxuE/wI7EG1RFl83JuxzdpL/AFgNX1MktXDhiT77sZ2OZC+tm9gsjXIO
         yFobNsPFm30QK0tTDySDdQKY7mDMTDwGh2OsyoLXhbZ7Yih89841L2T6y8PCl3hm+9WX
         oS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=cnbtuJqShkVt4h95QD+zLCK0/9qnRVCyBaJyOk7itxQ=;
        b=NkkwUDUUEG20HXuMynp9Tr3LPspW/gMivr6PqvPbVII01Bt1n5cgy1vJwqYCnz14Km
         cVqd81hLQWRUdnJIhABapmUyyz+2O7MzfSs3AQu/FvuVWFMqx4p9IihHX6t6xB6Q7pdA
         yhuC2SGy3k1gfb9Bi6ZNUdMpHEI+i5SrkLvWMRoau+J+TYs6IrD+AbTLU1b2uxn/CkU3
         bvyI77m/pSPO3b6WIITk0StG5KeoVmW9t1kCTaAQXR4MNkpDeVYDR4rQ2EpkREZACCXf
         ZIB7NmtoBOp3zmvHPzabaDofE4ehd3hn3EToQlrCItORgBLcx587H0DJLvTeJ8Ukc9O7
         XnkA==
X-Gm-Message-State: ACrzQf1R1YDKDwcAb8MK8bn0KT0CxyqZpVnWuDVNSxxD5Ad2J9PkLiJ0
        f/wqdJ9tnvGXLaIVW566Uu5OAQ==
X-Google-Smtp-Source: AMsMyM7Yt1EsHtR3BT1w9tuWa1xA6Dn+i3G8IKdV5ZWjYKrBkxnA28FFVwKIJuHCq/kO9ypNZxHINA==
X-Received: by 2002:ac2:4c8d:0:b0:4a0:559c:d40e with SMTP id d13-20020ac24c8d000000b004a0559cd40emr8181899lfl.508.1664278693650;
        Tue, 27 Sep 2022 04:38:13 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g24-20020a2ea4b8000000b0025ebaef9570sm141559ljm.40.2022.09.27.04.38.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 04:38:12 -0700 (PDT)
Message-ID: <c3ff6ace-3e58-0b0d-920e-e53a451206a2@linaro.org>
Date:   Tue, 27 Sep 2022 13:38:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 25/32] dt-bindings: pinctrl: qcom,qcm2290: do not require
 function on non-GPIOs
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220924080459.13084-1-krzysztof.kozlowski@linaro.org>
 <20220924080459.13084-26-krzysztof.kozlowski@linaro.org>
 <20220926231505.GA3149014-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220926231505.GA3149014-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2022 01:15, Rob Herring wrote:
>>      properties:
>>        pins:
>> @@ -116,6 +115,16 @@ patternProperties:
>>      required:
>>        - pins
>>  
>> +    allOf:
>> +      - $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
> 
> You can drop the quotes here.
> 

Ack.

Best regards,
Krzysztof

