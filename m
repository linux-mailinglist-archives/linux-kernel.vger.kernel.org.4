Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DA16329A3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 17:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiKUQer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 11:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiKUQeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:34:36 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C167D64A2F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 08:34:34 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id r12so19684659lfp.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 08:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oLPxPT/ez55qwQtV+SkxKyABW1GmxAMlzf1SH869HGc=;
        b=u6hup9OTpwsYNdfPj0KkeCiopyWC5GBXLjvb4rUlz7SQmsEJyGG7rwtghv3pSngYrP
         kX46P4iip9hJVQCQblutCV6T2sG2kvZl9cMDSofJWHE6fQxbbrZ0NVHPR6V6mjNVeE55
         YiqhLoz44OMGgWRKIr0k1+vsNCOlVhY6qvCqemszGj2QjsePVSpLazdekTAFNkfyWgua
         5krqYtfRidcU72VjJuTcFltP4ebumzg/uHm2ZigjgGikQYbnl1JH62GzxtOelrm99ABm
         M/2teDoLjepO1ieakzO4TNm4H57uvgGX0Nbz18OyX0hyrzM01Wuv2yD/faJo5ejhx6jq
         lsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oLPxPT/ez55qwQtV+SkxKyABW1GmxAMlzf1SH869HGc=;
        b=7pvOZDd/uksJ7teKVDme2BrZ4lraTGbJg7kfKQwVJvJ+ArlKv01LD//pC9N7ksm/Hz
         W5eLPfeaEuwKzMbLgcZPIkR0lthhVfvdSebvgGsRNZzh5QXWqo9zsQgSN6w2fnCDm21C
         gh48Klb5QT8LzKXDzJZtgEkYIfJr4QzXZFyfYaFeR1yEveIsCpkbHUgn2jzDUdp33cbM
         cPOHgW3mJkdL7E9j0t7X+PWix8igwAk1lUZ0xciMKeWQmteNoi5fHMEeEXaAhNd0ExCE
         a9a9S58JAkPw4YxdPCkYinsL7juhp1DlciHSo8joLZww1CF6bdEeF/BLF8iDepzdSMzx
         7Lfg==
X-Gm-Message-State: ANoB5pmDAMUlZnl2muaD51zfYQ+W7KAq0juTdmaqD9gwJUNFTdRAU2Iv
        27tqvfo+cDHYL6fWoMKxnDCRLQ==
X-Google-Smtp-Source: AA0mqf6q18BM7XpFsuKlzTo8yn08h/4aqehlKnIklUNOwvJiugO5IJ2gOEsHuGPxQMmZZko9LRc8OQ==
X-Received: by 2002:ac2:47fc:0:b0:4a2:2f31:12bf with SMTP id b28-20020ac247fc000000b004a22f3112bfmr6787809lfp.550.1669048473094;
        Mon, 21 Nov 2022 08:34:33 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a25-20020a056512201900b00492dbf809e8sm2077689lfb.118.2022.11.21.08.34.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 08:34:32 -0800 (PST)
Message-ID: <a461416c-e8c1-002b-efae-fa56723fb148@linaro.org>
Date:   Mon, 21 Nov 2022 17:34:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 1/3] dt-bindings: interconnect: Add rpmh virt devices
Content-Language: en-US
To:     Georgi Djakov <djakov@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Odelu Kukatla <quic_okukatla@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221118182245.31035-1-quic_molvera@quicinc.com>
 <20221118182245.31035-2-quic_molvera@quicinc.com>
 <3bc11449-bd5f-f4c4-98da-ebc0d7c8b309@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3bc11449-bd5f-f4c4-98da-ebc0d7c8b309@kernel.org>
Content-Type: text/plain; charset=UTF-8
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

On 21/11/2022 16:23, Georgi Djakov wrote:
> Hi Melody,
> 
> On 18.11.22 20:22, Melody Olvera wrote:
>> Add documentation for virtual rpmh devices. These interconnects
>> are not controlled by the application processor and thus
>> require separate bindings. Also, move compatibles for sm8450 to
>> this document and add them for QDU1000/QRU1000 platforms.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>   .../bindings/interconnect/qcom,rpmh-virt.yaml | 55 +++++++++++++++++++
>>   .../bindings/interconnect/qcom,rpmh.yaml      |  2 -
>>   2 files changed, 55 insertions(+), 2 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,rpmh-virt.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh-virt.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh-virt.yaml
>> new file mode 100644
>> index 000000000000..5cbaa51df863
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh-virt.yaml
>> @@ -0,0 +1,55 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/interconnect/qcom,rpmh-virt.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm RPMh Virtual Network-On-Chip Interconnect
>> +
>> +maintainers:
>> +  - Georgi Djakov <georgi.djakov@linaro.org>
> 
> This email is not valid anymore, so please replace it with djakov@kernel.org.

It's still listed in bindings maintainers, so people copy what is there.
Can you update your emails? Mailmap is also missing.

Best regards,
Krzysztof

