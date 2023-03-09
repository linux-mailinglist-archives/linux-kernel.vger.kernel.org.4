Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D1D6B18CB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 02:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjCIBdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 20:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjCIBdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 20:33:10 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05A7EB67
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 17:33:03 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id f18so385622lfa.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 17:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678325582;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6T7a+GoKNa0Y7d8xLGi142ICSO8XflBf9jWK/0+KgpY=;
        b=usoICJVkduIvA2JiFTDjVhRsWR8wu3RepR96fqFKWGnSRi7BDF9X/oXlV98uwqWnlC
         BiN1xiQ0xxGXzyizKuI086gA0Bz+5+hGot5zNSbTlL79UhRjNCg+A6JGQVGjg9FlpsRx
         4sqB0DLnPOBlyLD83ypyqwvmKe/WxLWrmhZMqEfpA8NioOQ8UDXyWU5Nxnj064KPvqiw
         JJqRFZ27g9s8d4SDjldLoQEhAsrw04Id2UOoWxwIkm8D5f2vEvVdBeFA5OnDC017U9Jv
         R68gQZJw+eipKhiL2h+4V14y1e+oUL/t6FB3fqTZzXDNPpv64tNts3eLds169Vy2qu7O
         o6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678325582;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6T7a+GoKNa0Y7d8xLGi142ICSO8XflBf9jWK/0+KgpY=;
        b=LBmls65jEToaobQw0jvUTHuIpMlOldkmF386to0mVvACAbrdddiTuIH00inNihLB/+
         wzJ1jDTOisYI47kWASM2Ia2++W4HXavmHqud1nsQP3j7PMPd3PH3B2Ntf7wJgB04URAm
         8Kd4+hxbhLC+jQpHqQB1sYVikIzfjNJJuDHIvLuMxBaLkQnrbm9L1HNvJKhPVR2AOm8w
         IzeSVaI1LJBulzZaGbU1jnHqarprchdn6Ghv87kZj1+VMnJHGqhxW7PueJauiS6EBCje
         QhyW3/FnbMCnRuFoSAr/X/FCzqAm+ljJPpeH1W+pwZXBhps8U8Vs5kXB2Kzzzs7zlxpY
         xW4g==
X-Gm-Message-State: AO0yUKUmQ8zCxSEuty9U3IEnuCqt06EfVDeMNBI3lEggjhekj2CsxtsJ
        JTMPFBdduFe8s6lXrVIfQBuvuA==
X-Google-Smtp-Source: AK7set8za/4SoEAXr6FrFPjG87XJm1SvKzTphQD0DOfViMEWfMMzZWa6i+jfnsrslszvdiEIa7ZBuQ==
X-Received: by 2002:ac2:5dd6:0:b0:4dd:ad4c:74b6 with SMTP id x22-20020ac25dd6000000b004ddad4c74b6mr5999377lfq.1.1678325582201;
        Wed, 08 Mar 2023 17:33:02 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id x5-20020ac24885000000b004db50b52c08sm2483080lfc.102.2023.03.08.17.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 17:33:01 -0800 (PST)
Message-ID: <c92a44fe-7057-2d81-41fc-2e84ae60f881@linaro.org>
Date:   Thu, 9 Mar 2023 03:33:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 3/4] dt-bindings: firmware: Add Qualcomm QSEECOM
 interface
Content-Language: en-GB
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Rob Herring <robh@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230305022119.1331495-1-luzmaximilian@gmail.com>
 <20230305022119.1331495-4-luzmaximilian@gmail.com>
 <20230308221657.GA3935330-robh@kernel.org>
 <93657561-d545-7ead-7f6c-dd2c62aab319@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <93657561-d545-7ead-7f6c-dd2c62aab319@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 09/03/2023 00:44, Maximilian Luz wrote:
> On 3/8/23 23:16, Rob Herring wrote:
>> On Sun, Mar 05, 2023 at 03:21:18AM +0100, Maximilian Luz wrote:
>>> Add bindings for the Qualcomm Secure Execution Environment interface
>>> (QSEECOM).
>>
>> Pretty sure I already asked, but no answer in the commit message. Why do
>> we need this? You've already declared the platform supports SCM calls
>> with "qcom,scm". Why can't you probe whether you have QSEECOM or not? DT
>> is for non-discoverable h/w we are stuck with.
> 
> Yes, you've asked this before but I can only repeat what I've written in
> my last response to your question: I am not aware of any way to properly
> discover the interface at runtime from software.
> 
> If it makes you happy, I can put this in the commit message as well...
> 
>> Why is software made non-discoverable too?
> 
> Please direct that question at the Qualcomm guys who actually designed
> that interface. I can't give you an answer to that, and I'm not all that
> happy about this either.
> 
> To reiterate: I've reverse engineered this based on the Windows driver.
> The Windows driver loads on an ACPI HID and it doesn't use any function
> to check/verify whether the interface is actually present. Adding a DT
> entry is the straight-forward adaption to having a HID in ACPI.
> 
>> Nodes with only a compatible string are usually just an abuse of DT to
>> instantiate some driver.
> 
> If you or anyone here has any idea on how to discover the presence of
> this, please feel free to let me know and I'd be happy to implement
> that. Until then, I unfortunately don't see any other way of dealing
> with this.

You can probably try requesting QSEECOM version. According to msm-3.18:

         uint32_t feature = 10;

         rc = qseecom_scm_call(6, 3, &feature, sizeof(feature),
                 &resp, sizeof(resp));
         pr_info("qseecom.qsee_version = 0x%x\n", resp.result);
         if (rc) {
                 pr_err("Failed to get QSEE version info %d\n", rc);
                 goto exit_del_cdev;
         }


-- 
With best wishes
Dmitry

