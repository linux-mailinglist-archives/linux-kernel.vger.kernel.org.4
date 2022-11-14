Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5186276A1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 08:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236008AbiKNHsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 02:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235848AbiKNHsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 02:48:21 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB361011
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:48:20 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id d6so17899964lfs.10
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RtaXBhnGo8MVscIrQnKGheYkcw3Kx7+UsbUghToyCVI=;
        b=SMH/wDR0ipSJQ9BUzSRMG2RWykZI8v94NQ6rQnIPL3+Oq+ZKPi/veswxkIv+yEMztD
         2QmI0HH5GldekYzi2aGpmm2oQ8bYqWvWukggo1oah2jteXry9sKr9hhszaCUNhe7JaZB
         wtQ2IWfLRze8qnIqqOUGV270budQ2QuruVB/5jdcg93GlDmIcmNOQ93VZ2dwFWHN/cNM
         JLIE+7LyCVT068CkPRhtyAPK3R1eNs1lvDXpLB6AOz3Qp4VaXNsJRRW7UsnXmx6847Yu
         TDymNZOPJZcegB76FHBGkSFkdBDkb9j47VZng4bShYGV0+c1jYTr0NOza+VNBooBqfle
         LnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RtaXBhnGo8MVscIrQnKGheYkcw3Kx7+UsbUghToyCVI=;
        b=nr9BWdOkg3GgZRA6GNMf0HO8Huo61pmmkejk03hvWvorS+qIVt43myV62oPVGbgKFo
         c+PSujbiXrMYQ0j3liOMzWR9B6R6EHFa128NE8BzQJBmYPrH/Wjdy+Kdh+eCEKa42KEi
         7FoRYfssxvI/fhzjtdrN9vzr/PiNBk3kf8F2VXnHSJJUCvKnP4vL71h09e2Vh2IdghD5
         f64gC3KX5SF11sSNZZ0CrvMVs4mrCVeEwBwzoONa0ZENFaTLHQSrRI+6BbyGM7HEP3OS
         +p31xsnY6L8BYhpMsErLBt4VyeO2ecSRe9OIlNq4622oN7T4G313Q9HgBuVlzuiYd63b
         Bzqg==
X-Gm-Message-State: ANoB5pkRhDgiJpbeCsyo7uLAlr+8VG4QcocA9QNtB6Nj/SXYSxfUWz0N
        iEHnBNliAXtjPL0/zJyG4iAidQ==
X-Google-Smtp-Source: AA0mqf4L855tMQ/hmtg1Tuny5MoKVDR9pzpMX2tlC4Cl8NJCd/Q5ZQSx1O0gm5QI6BjibY6zuXXH2w==
X-Received: by 2002:a05:6512:6d5:b0:4a9:6659:40d5 with SMTP id u21-20020a05651206d500b004a9665940d5mr4232367lff.516.1668412098837;
        Sun, 13 Nov 2022 23:48:18 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k20-20020a2eb754000000b0026b2094f6fcsm1899097ljo.73.2022.11.13.23.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 23:48:18 -0800 (PST)
Message-ID: <0ee5db9e-d80c-947d-73d6-6214e9299b23@linaro.org>
Date:   Mon, 14 Nov 2022 08:48:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 00/10] ASoC: dt-bindings: Rework Qualcomm APR/GPR Sound
 nodes for SM8450
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Patrick Lai <plai@qti.qualcomm.com>,
        Srinivasa Rao Mandadapu <srivasam@qti.qualcomm.com>
References: <20221111113547.100442-1-krzysztof.kozlowski@linaro.org>
 <06da072c-8cf0-8181-3c32-4592fe41f9c2@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <06da072c-8cf0-8181-3c32-4592fe41f9c2@linaro.org>
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

On 11/11/2022 17:15, Srinivas Kandagatla wrote:
> 
> 
> On 11/11/2022 11:35, Krzysztof Kozlowski wrote:
>> Adding sound support for Qualcomm SM8450 SoC (and later for SC8280XP) brought
>> some changes to APR/GPR services bindings.  These bindings are part of
>> qcom,apr.yaml:
>>
>>    apr-or-gpr-device-node <- qcom,apr.yaml
>>      apr-gpr-service@[0-9] <- qcom,apr.yaml
>>        service-specific-components <- /schemas/sound/qcom,q6*.yaml
>>
>> The schema for services (apr-gpr-service@[0-9]) already grows considerably and
>> is still quite not specific.  It allows several incorrect combinations, like
>> adding a clock-controller to a APM device.  Restricting it would complicate the
>> schema even more.  Bringing new support for sound on Qualcomm SM8450 and
>> SC8280XP SoC would grow it as well.
> 
> Why would this grow? All the dsp services are static and they will not 
> change per SoC unless there is a total firmware change in DSP.

They grow now with SM8450 which requires changes there. Otherwise DTS
does not pass with current bindings. The bindings before my fixing in
2022 were really incomplete. Now they are complete, but:
1. Not for SM8450 - this will bring new things,
2. Very unspecific as they allow multiple invalid configurations.

> 
>>
>> Refactor the bindings before extending them for Qualcomm SM8450 SoC.
> 
> I dont understand this bit, what is SoC audio support to do with DSP 
> bindings. DSP bindings should be totally independent of this.

APR/GPR bindings are for SoC audio, so while adding SoC audio the first
are affected. If you went through the commits here, you would notice the
changes.

Best regards,
Krzysztof

