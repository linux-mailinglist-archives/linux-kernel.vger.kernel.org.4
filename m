Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8E962F2EF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241788AbiKRKqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241849AbiKRKqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:46:05 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0A49B3B0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 02:45:37 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id s8so7569041lfc.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 02:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EDQMv2x+NfeIg4hepEP6f1FTphfl0o9/8AhuUMjcc+I=;
        b=sDy8EIdAnoCUVGOoAcV7a1Xz+JDtSiutjXCMQ9DacYCE85IA7POPH2g46V2/ASaX8+
         0H+UuTNobIW6VnIA0Y+jMhQF9OvEFJ579KwI4my7rti5tneyBCPJWV/sjyxi0Nf8JC0G
         Yh5Fz7aPbnSg4xqWRgY6TM+xwtqMNlMj2tWyzCtmaUZps05NP+PYP/UoJS1JnJ4Xh6ng
         R/cIuopHomP5BrSgr+NyeHJA1PRElc58svbC3pqyFmaOLQ5cEXh2v0GK1ZK3ztOGldHY
         dMWDR4FCYxKI15PcBZPhn/AA1acLScP7xz+qr61Gmy8/F6y2/fQZQxftIw4H6Vo1vLFy
         E1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EDQMv2x+NfeIg4hepEP6f1FTphfl0o9/8AhuUMjcc+I=;
        b=Pgpc9qjkq3TC2dbQMe43EhARw/6ryW3v42xXO4nhXS03bRozvgmnFTMO9W6pm2j6c8
         gF2SIoBEOZBg2axDHZnxWI0+aLInR1klpIs7DDfn/VBZfu44bTLqj4RhdfoQNjaOsYjs
         LBib7FNy2gyZn9wFN5HmLu/YXmurJ6Sxzz6UdF4q/FWRcEFtob48QAZlx1mGkAawvgYf
         TURgCCuaH/RySdJ27cD2IjNHj7FjwLChAiRi4TvBcmv73cIz5sBtsZ+XmkLbjneKyu7B
         LF3gdjVXIUqBkYzjtLc+wX2EC7+rethkWSERZCCvrTGgkKGpzhPikQ/cUyk7ts7bbYFX
         eftg==
X-Gm-Message-State: ANoB5plYS/qhE4bZGwAuEkLSsgBl8VcIDY+Cd6L2xy5do1feEy06vP07
        fEpeJFjUdqFrHmBMg69IUBHC8g==
X-Google-Smtp-Source: AA0mqf7vV2tdGnpiXwtC5D6ZTxDgazbRllYin5VA7YoKbD6XgEbHhhwH389oMxgifnqkjCGApx/E+Q==
X-Received: by 2002:a05:6512:16a1:b0:4b1:4933:d0de with SMTP id bu33-20020a05651216a100b004b14933d0demr2096379lfb.10.1668768336006;
        Fri, 18 Nov 2022 02:45:36 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m7-20020a0565120a8700b004b497035243sm608798lfu.184.2022.11.18.02.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 02:45:35 -0800 (PST)
Message-ID: <dfec6a0b-86c6-fb61-51f6-d1e400a6f5ef@linaro.org>
Date:   Fri, 18 Nov 2022 11:45:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dt-bindings: reserved-memory: document Qualcomm MPSS
 DSM memory
Content-Language: en-US
To:     neil.armstrong@linaro.org, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221114-narmstrong-sm8550-upstream-mpss_dsm-v1-0-158dc2bb6e96@linaro.org>
 <20221114-narmstrong-sm8550-upstream-mpss_dsm-v1-1-158dc2bb6e96@linaro.org>
 <38fff21b-3e75-13f9-664e-a115bc527b67@linaro.org>
 <9aa23650-6ae1-3844-7cf3-6812dc023c11@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9aa23650-6ae1-3844-7cf3-6812dc023c11@linaro.org>
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

On 17/11/2022 10:47, Neil Armstrong wrote:
>>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: qcom,mpss-dsm-mem
>>
>> Why do we need dedicated binding and compatible for it instead of using
>> memory-region phandle in the device?
> 
> So like rmtfs, this memory zone is shared between APPS and the MPSS subsystem.
> 
> Like rmtfs it makes no sense to link it to the MPSS PAS, since it's only a launcher,
> it doesn't represent the MPSS subsystem.

This also does not represent a device. Memory region is not a device, so
this is as well not correct representation of hardware.

> 
> In the PAS startup process, the resources are released from APPS once the MPSS subsystem
> is running, which is not the case with the MPSS DSM where it must be shared during the whole
> lifetime of the system.

I don't think that PAS releases the region. I checked the
qcom_q6v5_pas.c and there is only ioremap. The device stays loaded thus
the memory stays mapped.

We have already three of such "memory region devices" and we keep
growing it. It's not scalable.

Best regards,
Krzysztof

