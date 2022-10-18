Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129DF602C8B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJRNLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiJRNLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:11:52 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58FCC705B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:11:51 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id d13so8543636qko.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gFI1bQqti6oQ8LxaWAG4fVYATWtdUovKKyLQ/A268Bc=;
        b=V0rRk9jTWV2LwxkPjvBKehj0gnVqhihTFsLNlct1zhNnxIfdj6L7vI9CqSvpMGPdGq
         8ru4AhKuryfocbeTDIEz65YniIblEjpd7L2vMUUzhJc1a0ME3n/CjtKlYkcsiifc/VwM
         /DMZFjIsdAaXMRlLns9pTztXmlZEv+n9C/CU/L3WYlwpU3eUDmbEoUdO+7IrGLi5oF84
         hObMKgdXE/eyY9nbHOd+YTmFnU6+FPGCIIHEqhDxVZdPXdo3PvJy1hJXUpa9nd7n9kUj
         FHDyKChBYqqwUTt+uHi11/edsRVo6V9r1+t6TMfz4thNeMw3UI6lslt/+6Oy3xPguZ82
         CN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gFI1bQqti6oQ8LxaWAG4fVYATWtdUovKKyLQ/A268Bc=;
        b=t3KprgtVZ1PrGTLNDtuxulzdc+lF3ix8gQCRFnSBxakCXcY6NETij11wt5jSRUI1vw
         /tjjMYAM2Ni7Lp24hEPE1zTLhwcuY+lsObBTq7lss7KrLGhRhSoQZ/WWP3U+5cjj0Nd9
         8eyRklekvk8r5I8Z4Xp/CG10Pn/Wiyqbkzn6JdK2oEnZMlCKu+GEI2WFk5jTPq7LX7FT
         CoxcH/zcSS6JMx5hRPMLfsmxe4kdx1vj5A/57BA4ke2fAsAIwfkPGlmYrm7q3R81FwnU
         OeDobSbZ+Rt0KKnlic9tlhy2GFer463+naDY2YL3SCjkBMQ+EDpvgByMkmdfUxLQUAUt
         BbwQ==
X-Gm-Message-State: ACrzQf14ZcfaSVorl8foHsqUrVFCBoYI3pM8911NkZRrDDiwPt6ZR5Kh
        sv8S84uV+zy8ViGC+shw9HZzqw==
X-Google-Smtp-Source: AMsMyM7kSLBFDxaR0hdilsR4CoglosKJmFXZBn8yUdDuhyXL+XyatgehjaXN4MO1M2yTglX3l6EW5g==
X-Received: by 2002:a05:620a:486:b0:6ec:543d:c32e with SMTP id 6-20020a05620a048600b006ec543dc32emr1710817qkr.161.1666098710902;
        Tue, 18 Oct 2022 06:11:50 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id f7-20020ac84707000000b003431446588fsm1934703qtp.5.2022.10.18.06.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 06:11:50 -0700 (PDT)
Message-ID: <c20edd0d-7613-5683-60e7-54317cac6e0b@linaro.org>
Date:   Tue, 18 Oct 2022 09:11:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RESEND PATCH v2 3/5] dt-bindings: firmware: qcom-scm: Add
 optional interrupt
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     David Heidelberg <david@ixit.cz>,
        Robert Marko <robimarko@gmail.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>
References: <1661898311-30126-1-git-send-email-quic_gurus@quicinc.com>
 <1661898311-30126-4-git-send-email-quic_gurus@quicinc.com>
 <c842f6c8-fe7b-1e74-d873-4b674556ec40@linaro.org>
 <a42f6664-0f6d-657e-9934-907ebb5408ee@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a42f6664-0f6d-657e-9934-907ebb5408ee@quicinc.com>
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

On 18/10/2022 01:49, Sibi Sankar wrote:
>>>   Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>>> index e279fd2..4d6c89f 100644
>>> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>>> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>>> @@ -75,6 +75,11 @@ properties:
>>>         Specify this flag to remove SCM call serialization. Need to ensure that
>>>         the firmware being used supports this feature first.
>>>   
>>> +  interrupts:
>>> +    description:
>>> +      The wait-queue interrupt that firmware raises as part of handshake
>>> +      protocol to handle sleeping SCM calls.
>>
>> Missing constraints.
>>
>> Which firmwares support it?
>>
> 
> The interrupt property for scm firmware from a binding perspective
> is completely optional i.e. not all tz fw running in the wild on sm8450
> devices support this feature. The bootloader does the interrupt property
> addition on sm8450 devices with support.

OK.

Best regards,
Krzysztof

