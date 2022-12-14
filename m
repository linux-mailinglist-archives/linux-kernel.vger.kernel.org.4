Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B473764C7F1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 12:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238023AbiLNL2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 06:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiLNL2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 06:28:35 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09C721A7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 03:28:33 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id n1so6336226ljg.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 03:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hvAroDdwWclT+I1GDECncBtB6bsktnycLSnAVtAlODs=;
        b=Reb/5qzPI3qaiOQfZcT9RXpEa6WuSyCt1st2wjWRyv2Tg6iQOsWg/LrvuQz8gfck9N
         T9W5ieky2Z8+iY9+a/v69QRtebr+JzOhCEYSmLFRNE8e/eveWrC+7cXRiShigyZq/wCZ
         Nco1eJD3WmTXTzHdroV681g5MtC2YHWKi4Tlm+9HbVeVgg1ZyhESuH67yxUBVint+uOe
         gyYQCNlNlbL984MXe5zm54oI450m8lw0lyGG+H8rfAHkVUofVKMimSdAlHPzkkMuib9n
         PBECSdvwN3kno4QEBfW+vtJC5gPotDRhEIMH16GIopJo2tl++U6g+5cm1Jkb8tkxgfIc
         Bw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hvAroDdwWclT+I1GDECncBtB6bsktnycLSnAVtAlODs=;
        b=nK4BQZETTfG4jDoO43Z6staBoQbfEvXYRSX6+LAwPCbH80F0ftbL8uql5UroRUmsnV
         BfozJ+yqDZlZdgZ0Ixq45tKWG/ow3FPmTwH0wy1el38W7z6qF9a/Vhh0lRu816xmch8q
         p9PCj9GhwH1qaN8okh1cg+QJpsmlmnmauU22nYPb7UmKgxDnMBlqkts6RzdVUzYjC++o
         NUvxHf9Kp6t5ngFMZ1KBvm7tDS93+OtqrJ0GublWiOVW6TUwOvkMVbW9MHV1+Z/rtXJJ
         Em12uuOWsPxEJC7wAAtnY6hkuzESxiWoREWoT5nUdA7dqMHgpe6LXAoGG1prw+mrMoSi
         XWtg==
X-Gm-Message-State: ANoB5plRNw2VDbKQ/mneFaYkg8bX3gCaQVg0UJZAWGI+GKfr2DtyfARI
        wyNrB8asp8Nf7T+HOqo/u5djJg==
X-Google-Smtp-Source: AA0mqf5cBv+2ZGd6dWzFv9AajyDVrzF26X3qOsccWljiZU8RbckicbCeyN6eZKSVMcy7BieAsQmgcQ==
X-Received: by 2002:a05:651c:238a:b0:27b:4c80:d07b with SMTP id bk10-20020a05651c238a00b0027b4c80d07bmr4178936ljb.52.1671017312137;
        Wed, 14 Dec 2022 03:28:32 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z27-20020a2eb53b000000b00279c85d4400sm562101ljm.60.2022.12.14.03.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 03:28:31 -0800 (PST)
Message-ID: <1d3c7d01-bfa9-6654-28d9-b9f4964a88a4@linaro.org>
Date:   Wed, 14 Dec 2022 12:28:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 4/4] remoteproc: qcom_q6v5_mss: Use a carveout to
 authenticate modem headers
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        manivannan.sadhasivam@linaro.org
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, amit.pundir@linaro.org,
        regressions@leemhuis.info, sumit.semwal@linaro.org,
        will@kernel.org, catalin.marinas@arm.com, robin.murphy@arm.com
References: <20221213140724.8612-1-quic_sibis@quicinc.com>
 <20221213140724.8612-5-quic_sibis@quicinc.com>
 <8739f59b-c551-2da4-5523-a89f960bd402@linaro.org>
 <f4595a18-23bd-d54f-4e50-c0ed63008225@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f4595a18-23bd-d54f-4e50-c0ed63008225@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2022 11:33, Sibi Sankar wrote:
> 
> 
> On 12/14/22 01:17, Krzysztof Kozlowski wrote:
>> On 13/12/2022 15:07, Sibi Sankar wrote:
>>> The memory region allocated using dma_alloc_attr with no kernel mapping
>>> attribute set would still be a part of the linear kernel map. Any access
>>> to this region by the application processor after assigning it to the
>>> remote Q6 will result in a XPU violation. Fix this by replacing the
>>> dynamically allocated memory region with a no-map carveout and unmap the
>>> modem metadata memory region before passing control to the remote Q6.
>>>
>>> Reported-by: Amit Pundir <amit.pundir@linaro.org>
>>> Fixes: 6c5a9dc2481b ("remoteproc: qcom: Make secure world call for mem ownership switch")
>>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>>> ---
>>
>> Thank you for your patch. There is something to discuss/improve.
>>>   
>>>   	return ret < 0 ? ret : 0;
>>> @@ -1882,6 +1899,26 @@ static int q6v5_alloc_memory_region(struct q6v5 *qproc)
>>>   	qproc->mpss_phys = qproc->mpss_reloc = r.start;
>>>   	qproc->mpss_size = resource_size(&r);
>>>   
>>> +	if (!child) {
>>> +		node = of_parse_phandle(qproc->dev->of_node, "memory-region", 2);
>>> +	} else {
>>> +		child = of_get_child_by_name(qproc->dev->of_node, "metadata");
>>
>> Bindings do not allow to have child "metadata", do they?
> 
> memory-region property was used to specify mba/mpss region in a phandle
> array only from SC7180 SoC. All the older dtbs in the wild/upstream
> still had sub-nodes to achieve the same. Patch 3 allows for a sub-set
> of the SoCs (MSM8996/MSM8998/SDM845) to use metadata as a sub-node so
> as to not break bindings when newer kernel uses a older dtb.

This does not explain why you extend the driver without extending the
bindings. You do not do it for legacy stuff but for SC7180. But even for
legacy devices you cannot add new properties without having it in some
legacy bindings.


Best regards,
Krzysztof

