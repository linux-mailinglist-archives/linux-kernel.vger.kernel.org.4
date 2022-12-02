Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC726404B7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 11:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbiLBKdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 05:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbiLBKdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:33:23 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A577C1BC3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 02:33:22 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id o30so3231706wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 02:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=319dmF23gwJK1akaWUytWINSdZyUZn6mYWv2AFrEvXo=;
        b=LolCNAjp8odhCiMzE1CWcI/k7ve1fvFvyHmzTvLl5QBZgGw7eXneQh8wD3olh4o1Ri
         rtEuowwpMdnrC9s5Rlfw2Gwc+VTnv3ZBkXo2w94zYQcvWR9kE/WB8nW0pr15EpoxWOTU
         AndyX49+UzNhi65llM4u34e0ctQ8/hsQa2lOuUNBfnkTOylumMgMUIYC3074fH0TUoJR
         G6U2JLUDTbig+kheenO6WKmhAcSH3hIndDuqck25IWkIo+rm3kSYUS4L2AGTmBmHkmj6
         l6gTFk+CmulioyhUbFT8qf2n0YDBajiHS5nAKiKiw4AaU53sG+zU7JmL3bVpYqR89lJm
         Jimw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=319dmF23gwJK1akaWUytWINSdZyUZn6mYWv2AFrEvXo=;
        b=59BKvaXKgPZusizwrO2/Hukp7rzIH9cCQdBCnNO8p1sYjjVjYT/Q7BBQ25eyJmt14z
         eWcIlcdymLI8OC+nJh2k3OkbDyeKd0s3GtNzH/79jKkyzxWvp+Yg8Gij5fnCMYiida/y
         Muzu56WjvhqdtQSDG6k4yDDN6LiO8apkaNOOBbL1R6iagHKMMxwND3G2o3gkOMYLDVmI
         R0Fpv+AT7mg+jy/ZcTkeEc+zk5qZLcrvXzHgRKi3uSlG8zaeW8U0BWN/RTwGB9rk0g3+
         VcrpX++9J12JGM00i5QXpNQdvSqjldEJk63gL8zrV5K5HS3mtC9WMSgQGCiVECTxKcEm
         IGqQ==
X-Gm-Message-State: ANoB5pn4NGS+LlU+IMsi47Nn2ITEVmmdiBTunL1cN6g3KVV+XmK67DNK
        EIf52b2bvK1crsgN19eTNPCoSA==
X-Google-Smtp-Source: AA0mqf5MasTI2olKjBxig8ppzSE99CaJVV90JPkC7fb8qDKJK8xOdMTP/AoSJjoRRLZElCCYyX9HRg==
X-Received: by 2002:a05:600c:35c4:b0:3cf:9668:e8f8 with SMTP id r4-20020a05600c35c400b003cf9668e8f8mr42600076wmq.195.1669977200633;
        Fri, 02 Dec 2022 02:33:20 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:c6e:eb0:b551:55ee? ([2a01:e0a:982:cbb0:c6e:eb0:b551:55ee])
        by smtp.gmail.com with ESMTPSA id z12-20020a5d44cc000000b002362f6fcaf5sm6640919wrr.48.2022.12.02.02.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 02:33:20 -0800 (PST)
Message-ID: <ace35de2-9aa8-8cfa-1f4c-46480fbbc442@linaro.org>
Date:   Fri, 2 Dec 2022 11:33:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/5] dt-bindings: remoteproc: qcom: adsp: document
 sm8550 adsp, cdsp & mpss compatible
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        linux-remoteproc@vger.kernel.org
References: <20221114-narmstrong-sm8550-upstream-remoteproc-v2-0-12bc22255474@linaro.org>
 <20221114-narmstrong-sm8550-upstream-remoteproc-v2-2-12bc22255474@linaro.org>
 <8d7367b2-126a-d8ba-b616-be1ef9c67122@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <8d7367b2-126a-d8ba-b616-be1ef9c67122@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2022 11:58, Krzysztof Kozlowski wrote:
> On 30/11/2022 11:29, Neil Armstrong wrote:
>> This documents the compatible for the component used to boot the
>> aDSP, cDSP and MPSS on the SM8550 SoC.
>>
>> The SM8550 boot process on SM8550 now requires a secondary "Devicetree"
>> firmware to be passed along the main Firmware, and the cDSP a new power
>> domain named "NSP".
>>
>> A third memory domain for the DSM memory zone is also needed for the MPSS
>> PAS bindings.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> Thank you for your patch. There is something to discuss/improve.
> 
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          enum:
>> +            - qcom,sm8550-adsp-pas
>> +    then:
>> +      properties:
>> +        power-domains:
>> +          items:
>> +            - description: LCX power domain
>> +            - description: LMX power domain
>> +        power-domain-names:
>> +          items:
>> +            - const: lcx
>> +            - const: lmx
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          enum:
>> +            - qcom,sm8550-cdsp-pas
>> +    then:
>> +      properties:
>> +        power-domains:
>> +          items:
>> +            - description: CX power domain
>> +            - description: MXC power domain
>> +        power-domain-names:
>> +          items:
>> +            - const: cx
>> +            - const: mxc
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,sm8550-cdsp-pas
> 
> This entire if does not look valid - compatible is covered in the
> previous one. You should see `dtbs_check` warnings on your DTS.

Wow indeed, this should be mpss-pas...

The main changes here was firmware-name and memory-region to handle
the dtb firmware and the DSM memory region, are those OK ?

Neil

> 
>> +    then:
>> +      properties:
>> +        power-domains:
>> +          items:
>> +            - description: CX power domain
>> +            - description: MXC power domain
>> +            - description: NSP power domain
>> +        power-domain-names:
>> +          items:
>> +            - const: cx
>> +            - const: mxc
>> +            - const: nsp
>> +
>> +unevaluatedProperties: false
>> +
> 
> Best regards,
> Krzysztof
> 

