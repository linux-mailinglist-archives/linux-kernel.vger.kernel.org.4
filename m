Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30F66A08F5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 13:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbjBWMwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 07:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbjBWMwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 07:52:01 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF8956517
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 04:51:58 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id p8so10726644wrt.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 04:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=He3/T5rNjZxbvQvsLoh9SavvhiALDTplmrGhWdH6/2E=;
        b=alxxBCSG2sPNWiZwA17ja0FEz5b1RDxTTs4NGCFVIi8pqg9nexPHIGFFiVv19m7MF7
         9lQqxzBWsGQfoFuqnSSabuDcCcD9lLoEBQlTsTiTzzXMAhJwzI3msL3PxuEc4lX2LN7N
         PAUR1w6FHcB0gAgWqzWp+HhtdnvRT8MZq2jpz5WCzdFjfk2IAPyooUwKK4XswJVhkqMo
         YmIHqfHGLxCxaEf9bKUoaUZe74VVxinp9k1p0nQZyGUHYaZb2DAvdkDy4IcO9owSUaR0
         3o3gkdcYBcjVQvYgurSYyIazojzvlQ/gje1S+X7QFhPaWhuAI0wP7Yzp6C8UTFqkU/zu
         c4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=He3/T5rNjZxbvQvsLoh9SavvhiALDTplmrGhWdH6/2E=;
        b=Uv7NomgdtMNNpCTMOKyLltU6Jp8eArQIVSwmlxxxxCiyAYV1x/Sn4uKA8UsvEFASUQ
         V4sgA5LZZhUTtVKU1O0WsOWF3n7zhqPXPI2syS2PNt/LJl34c5EDGRfZDtvcvET3G3jM
         1ieofNtjIL0Ib0alfo8Fzm4WtWfYOxxpK8ykVHMwegh0igjvdAv0h1/n7fTXnFMaMDZ+
         G8dVd07RILc0Z0NF+wB+do6/omqEHg6IAI6zAHK2OaQcbeZzSxTXQDI+XjaCbh7PFXrT
         xfhQGq6fNX6lsSp3tieaKiDB8uJayEI3/l+/WiwC+TccvgEq0IxWHSQJ2wHNMtLZteZH
         z5bA==
X-Gm-Message-State: AO0yUKX4JiEF7omj1CueRaGcei3M+jN0Db5emE/jOAc7jd3LHXGIuwE0
        jih+QYIF9+23J5c60nyXr1IGpA==
X-Google-Smtp-Source: AK7set9ix212YSCnyGx56kbZG1wFRQMw0z+jnmOA6BkbGPbPtnvuzNhWX3F4lLDb03ZsXuDk0ySpaQ==
X-Received: by 2002:a05:6000:136a:b0:2c7:f56:28d9 with SMTP id q10-20020a056000136a00b002c70f5628d9mr2470997wrz.54.1677156716880;
        Thu, 23 Feb 2023 04:51:56 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c214a00b003e209186c07sm11194549wml.19.2023.02.23.04.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 04:51:56 -0800 (PST)
Message-ID: <f852bf35-6f29-a91a-00ab-9f7b2d709328@linaro.org>
Date:   Thu, 23 Feb 2023 12:51:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v6 2/5] arm64: dts: qcom: Add msm8939 SoC
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, agross@kernel.org,
        andersson@kernel.org, djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org,
        stephan@gerhold.net, Jun Nie <jun.nie@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Max Chen <mchen@squareup.com>, Zac Crosby <zac@squareup.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>
References: <20230222120411.55197-1-bryan.odonoghue@linaro.org>
 <20230222120411.55197-3-bryan.odonoghue@linaro.org>
 <56ed6a30-9815-002f-8174-95e7e9fc0954@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <56ed6a30-9815-002f-8174-95e7e9fc0954@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2023 17:08, Konrad Dybcio wrote:
>> +			interrupt-names = "wdog", "fatal", "ready",
>> +					  "handover", "stop-ack";
> This should be a vertical list
> 
>> +
>> +			clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
>> +				 <&gcc GCC_MSS_Q6_BIMC_AXI_CLK>,
>> +				 <&gcc GCC_BOOT_ROM_AHB_CLK>,
>> +				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
>> +			clock-names = "iface", "bus", "mem", "xo";
> This could also be one
> 

Sorry what are you asking for here Konrad

clock-names = "iface",
               "bus",

if so, why ?
