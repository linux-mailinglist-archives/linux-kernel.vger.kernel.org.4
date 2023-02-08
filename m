Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D810068EC27
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjBHJvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjBHJvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:51:33 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50F03D09E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 01:51:15 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id a2so15861966wrd.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 01:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cyRYvJyCWI/JC6w1OyETD6RGehTmuMlsiaeC8jqJRf8=;
        b=HhhpXjGkga91Ht/Or9neGo0HwbyHY5UY8vw4lWSBuKPkFt/WMkA1uBS1G9oXVPciP4
         Snowf8jEYyA+8WBNB7R52KUhURGgOnBOiC9SNQSnDCl2f/5gpF0wFp4I7aUDw9KfF/Bh
         Fx5jx+ghwoXotQ3XWbV2Edq9h/mF0jzr+dvbM2TAZk/tNj35TNLc8uCEbXRJ3CtD8Mrw
         EO2ovRiDVJ80O64LQMT/G0WC+/gIaDD8PX/d296uy7swyGKh+MU/aKZ+vAsk1g9XCEEg
         ewnSDivSI51CNW1aw3+2NE4qfzDHjRrPCPuAqH/vSDor3M/cknhkRh1JZma8bbMX2EGm
         JltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cyRYvJyCWI/JC6w1OyETD6RGehTmuMlsiaeC8jqJRf8=;
        b=VILjwT03vGo0sKMgU5VZMB8eIOwCqut+qeuaZBiYIqc2gSKs4QulnVjUsngXjxVF1a
         XhzCZyCIou+JXUBDLaXklIdivBVwfgmXhNxdEaKyMHNPVWxxwrn7SfV8Xftd7TNKGk7p
         V0M7fwBVu+iKNqBnifmQkRqmaUpHQnMf0AOe0WTGAumKWXVsFp+L9awFT4SpEuinQaQa
         vg4tc5VZu0nmhCbLVYUKiRdwmrxyI4b1y0VjMU+4aPREDf8aH4kMrv4bcCqh3ChGfWru
         wfx/as594bncIa8cMjnmWwzUA7ARPahOTt6PimMTQtNNbEzYFPd//kM2zHVxKA6qwjm6
         D+gg==
X-Gm-Message-State: AO0yUKUJ9sJVlx1OfFEGN86cHFO5SQdIzJNoZOwW5dEerh+sdEx+t+SI
        NPzKVa5TBbCduVhhADF4Mc6/Bg==
X-Google-Smtp-Source: AK7set++Unt7Q/QYP1bYshyjzJ08uYUUK2mlbfn9Zedzo8Q1sGp65Kt0qdP9N/93pqakSbATQXV2ng==
X-Received: by 2002:a5d:6885:0:b0:2c3:f038:f38b with SMTP id h5-20020a5d6885000000b002c3f038f38bmr6682705wru.24.1675849874388;
        Wed, 08 Feb 2023 01:51:14 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id s21-20020a1cf215000000b003e001119927sm1362996wmc.24.2023.02.08.01.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 01:51:14 -0800 (PST)
Message-ID: <7b71af71-ebb3-7339-2ae8-0c5d0148bdb5@linaro.org>
Date:   Wed, 8 Feb 2023 10:51:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 4/5] dt-bindings: remoteproc: qcom,glink-rpm-edge: convert
 to DT schema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230207090852.28421-1-krzysztof.kozlowski@linaro.org>
 <20230207090852.28421-4-krzysztof.kozlowski@linaro.org>
 <20230207184230.GA3950598-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230207184230.GA3950598-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2023 19:42, Rob Herring wrote:
> On Tue, Feb 07, 2023 at 10:08:51AM +0100, Krzysztof Kozlowski wrote:
>> Convert Qualcomm G-Link RPM edge binding to DT schema.  Move it to
>> remoteproc as it better suits the purpose - communication channel with
>> remote processor.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../remoteproc/qcom,glink-rpm-edge.yaml       | 92 ++++++++++++++++++
>>  .../bindings/soc/qcom/qcom,glink.txt          | 94 -------------------
>>  2 files changed, 92 insertions(+), 94 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,glink-rpm-edge.yaml
>>  delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,glink-rpm-edge.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,glink-rpm-edge.yaml
>> new file mode 100644
>> index 000000000000..07cd67ec97c1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,glink-rpm-edge.yaml
>> @@ -0,0 +1,92 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/remoteproc/qcom,glink-rpm-edge.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm G-Link RPM edge
>> +
>> +description: |
>> +  Qualcomm G-Link edge, a FIFO based mechanism for communication with Resource
>> +  Power Manager (RPM) on various Qualcomm platforms.
>> +
>> +maintainers:
>> +  - Bjorn Andersson <andersson@kernel.org>
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,glink-rpm
>> +
>> +  label:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description:
>> +      Name of the edge, used for debugging and identification purposes. The
>> +      node name will be used if this is not present.
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  mboxes:
>> +    items:
>> +      - description: rpm_hlos mailbox in APCS
>> +
>> +  qcom,remote-pid:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      The identifier for the remote processor as known by the rest of the
>> +      system.
>> +
>> +  qcom,rpm-msg-ram:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: |
>> +      RPM message memory resource (compatible:: qcom,rpm-msg-ram).
> 
> '::' is not a thing in YAML.

ack

> 
>> +
>> +  rpm-requests:
>> +    type: object
>> +    $ref: /schemas/soc/qcom/qcom,smd-rpm.yaml#
>> +    unevaluatedProperties: false
>> +    description:
>> +      Qualcomm Resource Power Manager (RPM) over G-Link
>> +
>> +    properties:
>> +      qcom,intents:
>> +        $ref: /schemas/types.yaml#/definitions/uint32-array
>> +        description:
>> +          List of (size, amount) pairs describing what intents should be
> 
> pairs? Sounds like a matrix then.

I'll fix also second appearance of this property
(bindings/soc/qcom/qcom,apr.yaml)

Best regards,
Krzysztof

