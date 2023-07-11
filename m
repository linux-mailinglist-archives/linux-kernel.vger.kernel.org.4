Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F2474E767
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 08:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjGKGeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 02:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjGKGeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 02:34:09 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C33E77
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 23:34:04 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51e278e344bso6400043a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 23:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689057243; x=1691649243;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PGCWjcfxiQ3gZrIHV8xXlPXazSWRuwdZd5KsYoVmkEw=;
        b=lW9wrsgS0xuRn0BldBSAtCkAG/xvrcHnt+KSEnhWxn+0HYb3hgW6ZAmsIvwZ687tDl
         qIGNN5urQiizOTKAsGr+auLd3ybzyrvBi7vxmQ2BDTU1mCaIM4TSWt2fiSvkEQAPjjcJ
         Cm8WBtHlGhC8/iaJGzdwsRL69t2JwM97wdaPemFeN76PWo7tEzd54ztpwZS8EB6A3007
         7ExKB1TE2ZxGO6GnUXjCf2fVkcaVerEx77rmUbCNwBEsob1wbtOBBUS20Y+XN/ou/ikn
         xKp2a00Kryymi8VliXxevhIM95/XPO8szIpsd+DFCBN20XhUaMdbblTTT5TJjAyjaBoC
         mn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689057243; x=1691649243;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PGCWjcfxiQ3gZrIHV8xXlPXazSWRuwdZd5KsYoVmkEw=;
        b=Zvy2ZHA/rxqfpc+3QprFMpoD+DpVh0uRgCAcz/C16ipFYPULrraKh4aOQ2hwi2SBgd
         DGf5Fj5N1qExq5wtY6R8mR9uIKe8jA2ty6H4kUXDsZLKCaQmAh9FJfFnXAG5Xhv8ZxEr
         EfgQj9Z696UBGTMWeGnfT8mNWJrHcja7sivAyldNKVnv+1YyM8mZaoC+XFRAEcCiTI2F
         q1ur/OTBaPvNnZtXH/6HH6qltoKWUK2QqS4ks4q2xa85IkopMO+CamVHiP1/1BWbEIwt
         7a28wIhxFd1c/q7s6wsKS8uTGFkHLTO+3X9hrPk8gOFNQzUU8jIK4B1eKpg3cJo3GbAy
         PINQ==
X-Gm-Message-State: ABy/qLb30u602IK78C+KPHrtV7UFnUWacwWarjwa6CsXiDJX6xgRrY6M
        VwS0Vtj1Bw1EE3rgqrnIlITyDQ==
X-Google-Smtp-Source: APBJJlGMPmsubyu2deM1+C9ib+4PQJBqlAYcGORczvM0biVnkBNQzxbsN7w/J1dpCR5dkJNjot+GgQ==
X-Received: by 2002:a17:906:1092:b0:993:fba5:cdfa with SMTP id u18-20020a170906109200b00993fba5cdfamr7290749eju.26.1689057243370;
        Mon, 10 Jul 2023 23:34:03 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id r11-20020a1709067fcb00b009929d998abcsm686124ejs.209.2023.07.10.23.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 23:34:02 -0700 (PDT)
Message-ID: <31eb0ecb-858d-6913-fae1-d88a7f203efb@linaro.org>
Date:   Tue, 11 Jul 2023 08:34:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/3] dt-bindings: power: rpmhpd: Add Generic RPMh PD
 indexes
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1689054169-10800-1-git-send-email-quic_rohiagar@quicinc.com>
 <1689054169-10800-2-git-send-email-quic_rohiagar@quicinc.com>
 <2040226e-9b45-b409-3edd-a5b86d86daa8@linaro.org>
 <8a3124ce-a11d-2491-eaee-1695cec70b17@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8a3124ce-a11d-2491-eaee-1695cec70b17@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2023 08:17, Rohit Agarwal wrote:
> 
> On 7/11/2023 11:22 AM, Krzysztof Kozlowski wrote:
>> On 11/07/2023 07:42, Rohit Agarwal wrote:
>>> Add Generic RPMh Power Domain indexes that can be used
>>> for all the Qualcomm SoC henceforth.
>>>
>>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>>> Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>   include/dt-bindings/power/qcom-rpmhpd.h | 30 ++++++++++++++++++++++++++++++
>>>   1 file changed, 30 insertions(+)
>>>   create mode 100644 include/dt-bindings/power/qcom-rpmhpd.h
>>>
>>> diff --git a/include/dt-bindings/power/qcom-rpmhpd.h b/include/dt-bindings/power/qcom-rpmhpd.h
>>> new file mode 100644
>>> index 0000000..4da2e04
>>> --- /dev/null
>>> +++ b/include/dt-bindings/power/qcom-rpmhpd.h
>> Filename based on compatible.
> This is not specific for SDX75. These are generic ones that should be 
> used for all other targets.

qcom,rpmhpd.h

Best regards,
Krzysztof

