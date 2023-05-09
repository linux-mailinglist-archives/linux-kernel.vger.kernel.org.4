Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101FE6FC02A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 09:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbjEIHIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 03:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbjEIHIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 03:08:21 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FC240F7
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 00:08:18 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bc070c557so10662973a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 00:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683616097; x=1686208097;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ijqKQLeIRjvBb3i4iB7l0bYhwmssEZf0GIGJ6UemaFA=;
        b=NAPiPEacVNMeV/8T7Qyn/B67Q3fDRfn+csLq9mfxJU+3v/exzCRl2ZV0FUDgEArjvC
         P9hFE8Vp+LTTGw6f/wwv/GeeHYvqO4GzBD4l2W07YBZ9PmzFyBwyXHzhSD3GUrKXFfO2
         zGwxQHwOgvcB6uBMR2jKiDMPRSDpmm3AK5f8CflcVFNQc8XeCXcT7yLb9/ulSg1+OdMo
         B/DxccJiNrvy6rq7XvZu20gyrwmxFQ3vIXxSxMHVZ079ahKrB5D1+i0N+txwzNKVLyGH
         KUjwLbdCfRILMBV0duoIQ0MV+FBjvMpG1XVa2MZu7hfsw6rvPFHyfkzCbrQ1UWDm2ugV
         xanw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683616097; x=1686208097;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ijqKQLeIRjvBb3i4iB7l0bYhwmssEZf0GIGJ6UemaFA=;
        b=jHd9GkNtVswpa60YCwyXd9DYua0emZVa4cUi1EGLuVtqa8xPWN7TibKWjcyhGLM0Ni
         IKH2y7mGCaN83Gb1YxnsjYe/o+q052uP4asZi5HhpsMtZPtNtWfNQ7RfBa1Wh7FgmwiL
         wCiVY054/wd34KbDKmoot5hSebSILHekQkzo+XCkHyIwifbbplQRtudTXDM5YJK0d4Fm
         ETR0hdeLRLrjFE6bfFnqT0+CHPHKiC7v/XlrP78tIaIRtnIC4m4p670WpdfG4h9mjMPt
         9t9Tem1h6Nc/VCEx3yFoTHVhigiuhFwWHQuGNHqhmz1DNtogxv+KfISJxOcfBhwRT9v1
         xldQ==
X-Gm-Message-State: AC+VfDzPRzIGOF63omSXKL3cl6ao+tBBOzR056Hx55cqQFTX88rJR/2X
        IpC+Htnq1aHytd8uEVzX6OnDzA==
X-Google-Smtp-Source: ACHHUZ6oKQbYJQadciEcI19zNNY1h9h3yTo1GwrdDAWBngJN5RZQsYi/bp6k+xH6GRfHLRlP5gCkCA==
X-Received: by 2002:aa7:d382:0:b0:50b:c3b1:9790 with SMTP id x2-20020aa7d382000000b0050bc3b19790mr10628592edq.16.1683616097109;
        Tue, 09 May 2023 00:08:17 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d0d5:7818:2f46:5e76? ([2a02:810d:15c0:828:d0d5:7818:2f46:5e76])
        by smtp.gmail.com with ESMTPSA id z24-20020aa7d418000000b0050bfa1905f6sm424071edq.30.2023.05.09.00.08.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 00:08:16 -0700 (PDT)
Message-ID: <e63a3e34-1f73-3661-8655-e34e1e955804@linaro.org>
Date:   Tue, 9 May 2023 09:08:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 01/11] dt-bindings: remoteproc: qcom: Add support for
 multipd model
Content-Language: en-US
To:     Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, mathieu.poirier@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, quic_gurus@quicinc.com,
        loic.poulain@linaro.org, quic_eberman@quicinc.com,
        robimarko@gmail.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
References: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
 <1678164097-13247-2-git-send-email-quic_mmanikan@quicinc.com>
 <38a5a268-7d8a-6e61-4272-8e9155df0034@linaro.org>
 <790496d7-98dc-c92e-dedc-1c89395a1ad8@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <790496d7-98dc-c92e-dedc-1c89395a1ad8@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 15:45, Manikanta Mylavarapu wrote:
> 
> 
> On 3/7/2023 8:47 PM, Krzysztof Kozlowski wrote:
>> On 07/03/2023 05:41, Manikanta Mylavarapu wrote:
>>> Add new binding document for multipd model remoteproc.
>>> IPQ5018, IPQ9574 follows multipd model.
>>>
>>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>>> ---
>>>   .../bindings/remoteproc/qcom,multipd-pil.yaml | 282 ++++++++++++++++++
>>>   1 file changed, 282 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml
>>> new file mode 100644
>>> index 000000000000..b788607f5abd
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml
>>> @@ -0,0 +1,282 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/remoteproc/qcom,multipd-pil.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Qualcomm Multipd Secure Peripheral Image Loader
>>> +
>>> +maintainers:
>>> +  - Bjorn Andersson <andersson@kernel.org>
>>> +  - Mathieu Poirier <mathieu.poirier@linaro.org>
>>> +
>>> +description:
>>> +  Multipd Peripheral Image Loader loads firmware and boots Q6 pd, WCSS pd
>>> +  remoteproc's on the Qualcomm IPQ5018, IPQ9574 SoC.
>>
>> What is a "pd"?
>>
> Pd means protection domain.
> It's similar to process in Linux. Here QDSP6 processor runs each wifi 
> radio functionality on a separate process. One process can't access 
> other process resources, so this is termed as PD i.e protection domain.
> Here we have two pd's called root and user pd. We can correlate Root pd
> as root and user pd as user in linux. Root pd has more privileges than
> user pd.
>  From remoteproc driver perspective, root pd corresponds to QDSP6 
> processor bring up and user pd corresponds to Wifi radio (WCSS) bring up.

Parts of it should be in description. And definitely "pd" should be
explained.

>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - qcom,ipq5018-q6-mpd
>>> +      - qcom,ipq9574-q6-mpd
>>> +
>>> +  '#address-cells': true
>>> +
>>> +  '#size-cells': true

...

>>
> Sure, will add.
>>> +    description:
>>> +      Qualcomm G-Link subnode which represents communication edge, channels
>>> +      and devices related to the Modem.
>>> +
>>> +patternProperties:
>>> +  "^remoteproc_pd1|remoteproc_pd2|remoteproc_pd3":
>>
>> No, underscores are not allowed. Also, what is pd?
>>
> Sure, will remove underscores.

Shouldn't this be just pd-1?


>>> +    type: object
>>> +    description:
>>> +      In Multipd model, WCSS pd depends on Q6 pd i.e Q6 pd should be up before
>>> +      WCSS. It can be achieved by keeping wcss pd node as subnode of Q6
>>> +      device node.
>>> +
>>> +    properties:
>>> +      compatible:
>>> +        enum:
>>> +          - "qcom,ipq5018-wcss-ahb-mpd"
>>> +          - "qcom,ipq9574-wcss-ahb-mpd"
>>> +          - "qcom,ipq5018-wcss-pcie-mpd"



Best regards,
Krzysztof

