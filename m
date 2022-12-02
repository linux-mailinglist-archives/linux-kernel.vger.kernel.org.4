Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5916404AF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 11:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbiLBKbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 05:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbiLBKbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:31:46 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329D5CCFD8
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 02:31:44 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m19so3217605wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 02:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tpgR7pRmFJycE5juehMe9lXGNFOIC2Jg3yR3SdfGV3Q=;
        b=kAIaXElswPaD8NtoI48FFLnKsfZQp1QhGnJzvLTVGKUZJDkFd2Mbr/AGVWmVuQJxCI
         9r5ln6OzdVBbIkTsAKWuX64ISrhZlF9X1DCnfi+ldTwV/3WUTza1wTlaLkl49XyMEJuZ
         w/4k+LDJZWJRtfnn4syMUZtFzqwJ6RAnJGUvD2nHy6rKrzQAC3wx0Mj5SdLA5+Z+kC4U
         XI9a8fAWzl4Sw2wpNXoAlPyitqZgFCSrWofg25Xn06Ye+HpSXCRVQv0/0gQj1WatDp8d
         GDBT7U3hFadUsTuj0r7Ke/xXeG3HN86C0f47pNq5kwKqjWEGFJk9sWAoXbMvdGJP5KHG
         ff+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tpgR7pRmFJycE5juehMe9lXGNFOIC2Jg3yR3SdfGV3Q=;
        b=X2oHCiRgPIkSE2HoSyMBh1hAIAN4acvq32jMzKo1/6U47uyDt03N6EYnApqK8DK+Mc
         oGKvAlYhKjbSnzYwY/HN6mgau4/31svK6HqvIHvKvJS99Fa5Mv/2Q4kWKhsRtay6X8gT
         GWzJPUQiz1T9LombiB+BDYIo2GB1ZIlBNK+ryAcPgQ2S3VFGeqWiJ1jcoBZEWf6Kf7s1
         I1dOjKe9M44Lu3zs8Dy7xDS4hOPuzE+RjKisXmmVokj9AkxViCNtd+0vYGmHu+VhPtBF
         jzDtgvc3ryPIv0Yv6R+yKUUopz7jcmGVfUgsQgTDHo/w1NCJciKQVfZYGN3V/rxHrg9Q
         dacg==
X-Gm-Message-State: ANoB5plTJFIUM9RtmNu6OurB7p9CmifObICR4qSn4wW9xM0wjcdmxtWg
        KIEgkHv8PSJtp9M0p7Nkc7kb9A==
X-Google-Smtp-Source: AA0mqf5ZsA5TJh1Q7xGsfJLmfo0FHPpIAKx6lDtFkJ9hTVmk3H1hgCeu4oFc91crWFpwA/Yj1GX0jA==
X-Received: by 2002:a05:600c:3d18:b0:3cf:b7bf:352d with SMTP id bh24-20020a05600c3d1800b003cfb7bf352dmr43563053wmb.106.1669977102746;
        Fri, 02 Dec 2022 02:31:42 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:c6e:eb0:b551:55ee? ([2a01:e0a:982:cbb0:c6e:eb0:b551:55ee])
        by smtp.gmail.com with ESMTPSA id m35-20020a05600c3b2300b003b50428cf66sm9273753wms.33.2022.12.02.02.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 02:31:42 -0800 (PST)
Message-ID: <8a3ba65e-c5cf-4340-67f2-b67bb2b59958@linaro.org>
Date:   Fri, 2 Dec 2022 11:31:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 1/5] dt-bindings: remoteproc: qcom: adsp: move
 memory-region and firmware-name out of pas-common
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
 <20221114-narmstrong-sm8550-upstream-remoteproc-v2-1-12bc22255474@linaro.org>
 <a221bcc0-9cad-e2ad-62fc-a97fa3aa804c@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <a221bcc0-9cad-e2ad-62fc-a97fa3aa804c@linaro.org>
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

On 01/12/2022 11:54, Krzysztof Kozlowski wrote:
> On 30/11/2022 11:29, Neil Armstrong wrote:
>> Move memory-region and firmware-name definitions out of qcom,pas-common.yaml
>> since they will be redefined differently for SM8550 PAS bindings documentation.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml       | 4 ++++
>>   Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml | 8 --------
>>   Documentation/devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml | 8 ++++++++
>>   Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml | 8 ++++++++
>>   .../devicetree/bindings/remoteproc/qcom,sc8180x-pas.yaml          | 8 ++++++++
>>   .../devicetree/bindings/remoteproc/qcom,sc8280xp-pas.yaml         | 8 ++++++++
>>   Documentation/devicetree/bindings/remoteproc/qcom,sdx55-pas.yaml  | 8 ++++++++
>>   Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml | 8 ++++++++
>>   Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml | 8 ++++++++
>>   Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml | 8 ++++++++
>>   10 files changed, 68 insertions(+), 8 deletions(-)
> 
> Looks good. If my patchset is not merged soon, I will squash your change
> to my set.

Ack

Thanks,
Neil

> 
> Best regards,
> Krzysztof
> 

