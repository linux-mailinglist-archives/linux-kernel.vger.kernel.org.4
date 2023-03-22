Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713556C50C9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjCVQb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjCVQbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:31:33 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428BA637C2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:31:19 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ew6so12366801edb.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679502677;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LFZ61u9VJpUAoRQg3tYOp0+T7FfcK8Yyt0cUesAGieo=;
        b=mSosGN2PMVqD3N3ytlg3MLYHzTKtWw5SEEAFlU+HPEKE8UvUDsEqzIJpCVFRTpVToH
         rnjAo370CQykNNjXeLGrJ/2/iJ3ngbS9reBPAczDi+vOshiD2Covtz29dZyLLDV1xJ4H
         YEEv1+ANUCr6Qa/t653F3IXXNi+l1cd9ll5KB9kLdlj5d/jFlHRQYKq4Ahu4TLwMGw0S
         K2DkbS4feGeAcRwmWRX0h5zXHU9iYsVTklwpIViF0n8hXAoc98y8cgv308YKFjoDkGnZ
         Y6ZMT6itJskGGm79cR3JCbnRl0J31FQ4nAwkatZKcrYEzeleB7d4iUmEbS5PyVpXqebe
         HLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679502677;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LFZ61u9VJpUAoRQg3tYOp0+T7FfcK8Yyt0cUesAGieo=;
        b=ohhX7OAFrvq/XN+LbUOKTyhWFJVdT9Z4lH8Yv4gLYNRUURQJJfTTsIcKB+62K7kHUq
         /4YwBhWeppSJu2VTBrJqqwPfE5hLeRN0uTGdh3ruco2MMQ1BL77wc3YzHkmWSu+WKqRE
         xonLw87luUG7WOJ3yBa60Budj/os1hzD/yuHLN7Xr2oq6JpfJg/n76lkpfok2az+G8PB
         KcOLPYUA8xTwQBIpBuNXlShq1bMh2ss114xhOzFOdfc+Lc7cDxMnDH7p4r7NvBWfIJii
         tXKI1BYey0R2e1zhULN2iV+UD/e1UI4sJ7o/HXoAeok2mlWqhDCPjc6O6Xti3kmq7Wtw
         RxdQ==
X-Gm-Message-State: AO0yUKVv8v+40tLJoDzu0jCrvmwtwNYzlLInnNSCXN2XbQmpWzQE/+Bj
        7eCwMTiD3UdkGdsk/A4dpYpzcQ==
X-Google-Smtp-Source: AK7set/0VxbL1t+c77xBvqnLXnH9QJBY6d7D9I3voRWBgpPjw55Gc7XlDpGQLhruT45zooGlUnpLnw==
X-Received: by 2002:a17:907:2169:b0:933:4ca3:9678 with SMTP id rl9-20020a170907216900b009334ca39678mr7792106ejb.24.1679502677576;
        Wed, 22 Mar 2023 09:31:17 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5050:151b:e755:1c6? ([2a02:810d:15c0:828:5050:151b:e755:1c6])
        by smtp.gmail.com with ESMTPSA id ml23-20020a170906cc1700b0092ce8344078sm7465296ejb.33.2023.03.22.09.31.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 09:31:17 -0700 (PDT)
Message-ID: <855b64ea-ccd3-4925-29a8-ebb8d0734adc@linaro.org>
Date:   Wed, 22 Mar 2023 17:31:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V1 2/4] dt-bindings: soc: qcom,mpm-sleep-counter: Add the
 dtschema
Content-Language: en-US
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1679403696.git.quic_schowdhu@quicinc.com>
 <576e53a1d0ef218536da976102b4cc207436ec1d.1679403696.git.quic_schowdhu@quicinc.com>
 <e845b412-9afa-3d9e-54fc-7f9f04d25c05@linaro.org>
 <8efa2296-7136-690a-6e6b-c9b41562ba84@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8efa2296-7136-690a-6e6b-c9b41562ba84@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2023 15:02, Souradeep Chowdhury wrote:
> 
> 
> On 3/21/2023 11:09 PM, Krzysztof Kozlowski wrote:
>> On 21/03/2023 14:51, Souradeep Chowdhury wrote:
>>> Add the device tree bindings for the module power manager sleep
>>> counter.
>>>
>>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>>> ---
>>>   .../bindings/soc/qcom/qcom,mpm-sleep-counter.yaml  | 40 ++++++++++++++++++++++
>>>   1 file changed, 40 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,mpm-sleep-counter.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,mpm-sleep-counter.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,mpm-sleep-counter.yaml
>>> new file mode 100644
>>> index 0000000..f9f46b7
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,mpm-sleep-counter.yaml
>>
>> Your code a bit explains this... this is not a device but some memory
>> region. Does not look like suitable for bindings as separate device.
> 
> Ack. Can you let me know the suitable place to put the bindings for this?

Reserved memory region? Or drop from bindings entirely.

Best regards,
Krzysztof

