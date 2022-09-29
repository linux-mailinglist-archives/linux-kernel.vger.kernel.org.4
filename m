Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070A55EF415
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 13:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbiI2LOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 07:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbiI2LOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:14:02 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D6A133C81
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 04:14:01 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id a3so1705958lfk.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 04:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=JCh++P5qIzDBHCAdkyavsqkmhn8xd4gauTae0eHjI/s=;
        b=asdXkChlFju1IPfKnT9Zzz6BqO2nzkgscO8FO1TEbmmzGObR03XAcp68Q31idxjF8b
         +IWu1Mz5jExFv8XhVka2L2sp6GVtnewzz78xdUNgjd6RfnkVF3H1vFMeLx1QrMBC5MKU
         oep7vR7UyH/T5/zYUinW1WizcVWnmUU82z1y37x0OWrZKbIh7zebtVBy7f5am7X/utUH
         bgpQL2hPF9v6sc6aSMfNJhKg8RqDRbWyemuG3xqhO7ZDIieabIX9iZr+4TOhNur4GpcN
         Cd8to3ntEON8IOE1YP0IxdrQ9Rh3rvSfJmLeLR1iHYJq9VnycbtbBusGVFL1XncctcJ+
         ytGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=JCh++P5qIzDBHCAdkyavsqkmhn8xd4gauTae0eHjI/s=;
        b=7EHdwD5elZSCdJzR7eMI88u1CVtUdaryOsI+Z7+n+6K48Upi9CzIz5jJ9gwvpKShDF
         ktLJeLKx+dJUkcxoTJHMO+OVnYn7FaIYbjthuCPNuQmOQJFL7nbNd+SknYzIfohkPhyT
         ixvTOjvDQ59Cx5osKgoGKGUUY/sFpy+jLxL+lt6cmI1fQfM/SU/JhXME3yrbcCbGF3Ei
         4Hwdq+LAG3XtqmBIgKbGGuBXyf3GMDOvfbu1FvDg+tvEmBYMokNxFnqXAEfKzOY18DdC
         CnSge4r6NcaQ3C32ZN/YVtuWpl55XhbhL9cIPjPVuR26iaNY2Ar08rJezieXrft3qokp
         E+LA==
X-Gm-Message-State: ACrzQf3fACPVCZ2ra1FInMsTtpEzKPT1Pr5Dt3KLsahkjdYHS1OVPGCq
        mpy7RJINOwLa1Vklnsiz31drnA==
X-Google-Smtp-Source: AMsMyM7bglyEuBmB9wRohtd/U31Y9OxzxlLBUyiz3f5gaY77GVWK03UTalRPBdrK2kpVNQprzV8gdQ==
X-Received: by 2002:a05:6512:401c:b0:49f:4b2e:7153 with SMTP id br28-20020a056512401c00b0049f4b2e7153mr1115352lfb.443.1664450039671;
        Thu, 29 Sep 2022 04:13:59 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u1-20020a056512128100b0049a5a59aa68sm757355lfs.10.2022.09.29.04.13.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 04:13:59 -0700 (PDT)
Message-ID: <e5d8c7f3-3d06-f9e0-0d81-32ceb371f27f@linaro.org>
Date:   Thu, 29 Sep 2022 13:13:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 2/2] dt-bindings: add bindings for QCOM flash LED
Content-Language: en-US
To:     Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Cc:     quic_collinsd@quicinc.com, quic_subbaram@quicinc.com
References: <20220928024239.3843909-1-quic_fenglinw@quicinc.com>
 <20220928024239.3843909-3-quic_fenglinw@quicinc.com>
 <6c0e5083-baae-3ed3-5eed-e08bbb9e7576@linaro.org>
 <2d6fac8d-0ac1-75bb-0b4c-c2c34583b09e@quicinc.com>
 <d6dc534f-2dc4-979c-ddad-c2122db7923a@linaro.org>
 <107dfb13-85fc-123d-d244-962ce6c1cdb7@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <107dfb13-85fc-123d-d244-962ce6c1cdb7@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 12:56, Fenglin Wu wrote:
>> If driver binds to only one compatible, it is expected to be the
>> fallback for all others. There might be exception for this rule but it
>> does not look like here.
>>
>>> But I was thinking to give out the PMIC names
>>> here so anyone who is using the driver could easily identify if the
>>> driver is suitable for the HW that he/she is using.
>>
>> I did not say to remove other compatibles, but to use one fallback for
>> all of them.
>>
> Do you mean to update it similar to this?
> 
> compatible:
>    items:
>      - enum:
>          - qcom,pm8150c-flash-led
>          - qcom,pm8150l-flash-led
>          - qcom,pm8350c-flash-led
>      - const:
>          - qcom,spmi-flash-led

Yes, just const is not a list, so "const: qcom,spmi-flash-led"

Best regards,
Krzysztof

