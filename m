Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDE7698570
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 21:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjBOUUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 15:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjBOUUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 15:20:33 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C76F2A6FD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 12:20:31 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id o36so14252352wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 12:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kNzCuF6BCyXsL2yh1ARNBckVMji8pzlET6deYgUkxoE=;
        b=XSFpJ/VevZDFan5kWJUyXz9WwmiflZO3DOFhA4+AF8vqE6RUr6/iCVk8JQzqwhaEeZ
         t6gERriMHefRcBZ3gW87YjfyQDjXuAwfEcdWu/6LmiwCRELo5LT0bglwGFgMLRWv9UVr
         2oA3KjvI0qlohDfKpzUWIV1YceyqPCAj4WkCuRFYmeFC8EAQ3yjVAFK79iGopxCSqX98
         XEPh5IUPqDXeJKqb+R5CHwg8CGotNyxYgFiEQPLyXLvAh+ldKo4oWWNwhfn2+EBnO6G9
         iZP2ObgDXL31cnnyrgPsnHPqLoq5xN62QODC8H7oVyv4Q/Tf/t330v9HlX8jiFgI5UGs
         wVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kNzCuF6BCyXsL2yh1ARNBckVMji8pzlET6deYgUkxoE=;
        b=LN73M76GjBZxy2zL3jcYy6/f5NMhLMEfjvQi9ue6aVtvAyeoVH8jDqD/+uj87+ZjIr
         5wF2TdTqXRUxISfv1pozArePEupF5wOGd0YOKZAIORiSKblQFi9s+rA1S537Mj33nOag
         HNMaNDixtYnqkbVKYyxvagrrAqSYWQT2LjLDz5LOfMJMhbyc54TYFesb7AXU8SBFVp6q
         YqZPZD9sl3Ldjy1AqhCUFlt6xepWoKOgJbfJ95hO07hPIqwKTzXS4vrh3qk0jIiSLWHd
         hmDyxslB26neFeFnwt9eOQC+rLxfuTiOcu6wWSMleHirOaLdTz607uXmKRLcCakoGPbN
         fZUA==
X-Gm-Message-State: AO0yUKWUcC8dj6naTeVGyNnexb70GjCiLv+vD/5J6gI76KZC3RN2eppR
        3uKKDolj0+v67PdmXBlA0UvL9A==
X-Google-Smtp-Source: AK7set9HivnC5lM/33lGnpMP4+zfEdLK/YWpE4+Ki+SgmylRZwxipc7gomV24OC7lBQFZ7fBot4O1Q==
X-Received: by 2002:a05:600c:130f:b0:3dc:198c:dde with SMTP id j15-20020a05600c130f00b003dc198c0ddemr2710643wmf.41.1676492429680;
        Wed, 15 Feb 2023 12:20:29 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b003dc492e4430sm3163621wms.28.2023.02.15.12.20.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 12:20:29 -0800 (PST)
Message-ID: <865420b3-6afe-7f91-7a89-f9fbf831c2ab@linaro.org>
Date:   Wed, 15 Feb 2023 21:20:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 5/9] dt-bindings: remoteproc: mpss: Document
 QDU1000/QRU1000 mpss devices
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20230213185218.166520-1-quic_molvera@quicinc.com>
 <20230213185218.166520-6-quic_molvera@quicinc.com>
 <aba45ae9-8558-50c1-e5ad-dd910dacdbb3@linaro.org>
 <0cb9dcb8-130e-7ad2-1f58-3d2f1bb48a49@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0cb9dcb8-130e-7ad2-1f58-3d2f1bb48a49@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 22:23, Melody Olvera wrote:
> 
> 
> On 2/14/2023 12:28 AM, Krzysztof Kozlowski wrote:
>> On 13/02/2023 19:52, Melody Olvera wrote:
>>> This documents the compatible for the component used to boot the
>>> MPSS on the QDU1000 and QRU1000 SoCs.
>>>
>>> The QDU1000 and QRU1000 mpss boot process now requires the specification
>>> of an RMB register space to complete the handshake needed to start or
>>> attach the mpss.
>>>
>>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>>> ---
>>>  .../bindings/remoteproc/qcom,qdu1000-pas.yaml | 127 ++++++++++++++++++
>>>  1 file changed, 127 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,qdu1000-pas.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,qdu1000-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,qdu1000-pas.yaml
>>> new file mode 100644
>>> index 000000000000..eb6ade984778
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,qdu1000-pas.yaml
>>> @@ -0,0 +1,127 @@
>>> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/remoteproc/qcom,qdu1000-pas.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Qualcomm QDU1000 Peripheral Authentication Service
>>> +
>>> +maintainers:
>>> +  - Melody Olvera <quic_molvera@quicinc.com>
>>> +
>>> +description:
>>> +  Qualcomm QDU1000 SoC Peripheral Authentication Service loads and boots firmware
>>> +  on the Qualcomm DSP Hexagon cores.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - qcom,qdu1000-mpss-pas
>> What about other remote processors? The subject prefix suggests it is
>> only for mpss, but filename is different.
> 
> Yeah so QDU1000 and QRU1000 only have mpss; there are no other remote processors.
> However, it uses the same PAS driver as the other remote processors on other SoCs.
> I can rename to Modem Peripheral Authentication Service.

Yes, please rename the title. Also please rename the file (and $id) to
be based on compatible:
qcom,qdu1000-mpss-pas.yaml



Best regards,
Krzysztof

