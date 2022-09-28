Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19F45EDB5B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbiI1LJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbiI1LIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:08:02 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04D43B70C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 04:05:46 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id o2so19771275lfc.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 04:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=YUBENAqL9cz3x47ZkApm64Ghusef9pzCbzdp0VZZH0c=;
        b=IGmumPyEliwITuR/gP7rn80KLyO2YWXwwhwnxpr8eUpxYshKAr611Zi54zL+sAhAr4
         oFgys6wUlPInWIezyKTfQPQBTgAekvl8DJReYIc2rN6ogmQ/AVzvrOcQ/OZy78hJKU2a
         gI6aQipju4L+lIz4VqaLJS/8FRfMKVOJ9/CvKx4dvX/++0Z7qN9P2CJzCg4tdMywktpO
         14Se2RjVDtgsL4L1isxO92kRMS4SY5KPCTAM1c/u0rUeT3xFZ6i0vo8ksN/X8mxs4dZo
         TyB7VP2XpjU+CNq0nhClbKxz/RQVFXbjkIztXipaW2tsCbR6gh5v/rcA69P0qvf9Bdk7
         /OFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=YUBENAqL9cz3x47ZkApm64Ghusef9pzCbzdp0VZZH0c=;
        b=BTF/sjcBjuZEUZKQBmADeD0psXQAjRLShZNDpQQN9MQuSgK6naWVYyAexWhgApKhNa
         j4JEgWwcD5RXXIc/vABtGkVVK96lLeEap/glZ7Bw76BsP8nakZgsz/yL8u3LFf7r3tto
         6caRSTj0/VueK4RTrP/Ou8VMrRxbNnB5B2RXck+NKYYGboFL5SY6oj6RVYOgyE8yeEJR
         EdOv557opXvmzZvI+OI1kS72Ml1eo0WJhbKdoH5asgKO4RXyYe6COHx6J8i/pSfAY5zL
         u9vVgNOGkTqW+ejFJPz13JjCoKAqR5C+3j24e7tlBm5wZOWSMS5rpA9nhmuZbxE8mrCI
         rX1A==
X-Gm-Message-State: ACrzQf2oFVtCfFbX4Hg3vFGq07pfDQR1R/JepRzFxR32QG7yFQ6reSDa
        qcqv51CJm4Zvu/c3JTORsZzATQ==
X-Google-Smtp-Source: AMsMyM40llb+tgJ8wO9eLpDRQXSEmVBBHTpF0DBjgb6yHbuGpMB0EPV1y/M5NpM2p1EFgKvbSJlqtw==
X-Received: by 2002:a05:6512:3d1c:b0:49d:87fc:f63 with SMTP id d28-20020a0565123d1c00b0049d87fc0f63mr13177528lfv.327.1664363144742;
        Wed, 28 Sep 2022 04:05:44 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id e11-20020ac2546b000000b004946c3cf53fsm246003lfn.59.2022.09.28.04.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 04:05:44 -0700 (PDT)
Message-ID: <c93d5255-6b27-6bdb-3330-97a12e04ead5@linaro.org>
Date:   Wed, 28 Sep 2022 13:05:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 3/3] dt-bindings: mfd: qcom,spmi-pmic: use generic node
 name "gpio"
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220908080938.29199-1-krzysztof.kozlowski@linaro.org>
 <20220908080938.29199-3-krzysztof.kozlowski@linaro.org>
 <YzQWvEGeKNWKrsWh@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YzQWvEGeKNWKrsWh@google.com>
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

On 28/09/2022 11:41, Lee Jones wrote:
> On Thu, 08 Sep 2022, Krzysztof Kozlowski wrote:
> 
>> GPIO controller nodes are named by convention just "gpio", not "gpios".
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> I guess I can't take this until the 2 arch/ patches are applied.

You can. It will warn when running dtbs_check, but that's not a big
deal. Anyway DTS patches wait for quite a while, so there was enough of
time for them to get to next.

Best regards,
Krzysztof

