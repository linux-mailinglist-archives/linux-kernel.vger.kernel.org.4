Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F376D5C92
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbjDDKC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjDDKC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:02:57 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCCE268E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 03:02:54 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id cn12so128337814edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 03:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680602573;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VrJrSfzUnCKRzbUZ95CnZ0A/WFvFHJMR0ElfM+k3J7g=;
        b=VcM5GZrYUtI2CcaOY/MrHgcznPYHtNJRMSUjgCC7aNPfvXfXS4PsEWhymSU5/sOOSv
         0JlKPs/9MjQWmJk7Rbn3BhxkMyMRVa16TEuok3OXjQhSHpDaQORFCwJ1wE0a9NFWM3qQ
         nsJzjxOnVwP8f3baMKUYvNrR/UmV5GU4jsfZ5vOBN95elEdZ7P1RpCDNWaY6VMpedCFm
         hUAVPAMtAQe5QjZ7WTN0togRCgt7ZmK+G/tcPtwo6f30hICdzZP33yh1D/H2/qBiZm7G
         08Jyr1Ftb9v8/f2mZ134hyswOBWHunVzQYRz/kLdiOnYXqVfRTAPHNF3AEl4jEtHrXPg
         YSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680602573;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VrJrSfzUnCKRzbUZ95CnZ0A/WFvFHJMR0ElfM+k3J7g=;
        b=hEOoHmiKsn25EPBaxjK25peJTQOCLMNa1c0pe/ix0fZ4KDr5Rt6TtJAHj3Gvh98KAA
         Xm2DMSW1Mz2IAZckWzKUG1PYtnbtn8dCSl1sJLFm9kZSVJvFwV5Ek42WxBexxWVFngUH
         Hv4gqmo0gUe0YcIzsdxYVhGu0bEEZ5lcgsEIJH0vuMt5gR2mtqzDZAMs20tuWOQsBlcC
         Uy406IPfqMWmkO3VeNGD4BqzpIDPwKTER2fxImYX54C5Lb5sW43RAGRsyzhium12rzJi
         FirR7JRGjiRHmMFU+clEshRi2j55wO7Sm62SA+MseeZtgMmm742qRb+6dMyrmIXwaRA3
         YqoA==
X-Gm-Message-State: AAQBX9eJJihG0LHRVo0bqV+C5tdQ+Ww31Hwtz2DDD7wuKavpXLkLLGJf
        RybCdTuRYDdAOnS0m5moi1OVEw==
X-Google-Smtp-Source: AKy350Yzjr2rPqWhRThaGiXDw2PFXPUa98EwOG1YJOmfmJY+iSwMGKXyLuqrunhm2zoTuda8M44pEQ==
X-Received: by 2002:aa7:d409:0:b0:501:c839:cf91 with SMTP id z9-20020aa7d409000000b00501c839cf91mr1960730edq.6.1680602573018;
        Tue, 04 Apr 2023 03:02:53 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:99ed:4575:6001:8bda? ([2a02:810d:15c0:828:99ed:4575:6001:8bda])
        by smtp.gmail.com with ESMTPSA id u23-20020a50d517000000b004af720b855fsm5664083edi.82.2023.04.04.03.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 03:02:52 -0700 (PDT)
Message-ID: <14df1896-e59e-22a9-dcb3-a42fd47b98b1@linaro.org>
Date:   Tue, 4 Apr 2023 12:02:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/9] arm64: dts: qcom: Add initial QCM2290, PM2250 & RB1
 device trees
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>
Cc:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230403-topic-rb1_qcm-v1-0-ca849b62ba07@linaro.org>
 <20230403-topic-rb1_qcm-v1-3-ca849b62ba07@linaro.org>
 <e1c2605c-6976-4d3e-25c8-e71145eea518@linaro.org>
 <b99e4236-de56-95e4-f1a1-db52238e937f@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b99e4236-de56-95e4-f1a1-db52238e937f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2023 11:47, Konrad Dybcio wrote:
>>> diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
>>> new file mode 100644
>>> index 000000000000..27d4742cdb19
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
>>> @@ -0,0 +1,848 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
>>
>> Same concern. Also in DTS.
> This was based off of sm6115 dtsi, which is dual-licensed.
> I'm not a legal expert, not sure how much flexibility we
> can get here.

Ah, ok, then the weird license was chosen for sm6115. You should keep
the license then. It is always a bit surprising when people choose GPL
v8 for their code...

Best regards,
Krzysztof

