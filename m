Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E003A6DF4B5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjDLMJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjDLMJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:09:41 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BB346A9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:09:36 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id m4so14212422lfj.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681301375; x=1683893375;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u3h3Qb1KatJSKEmGkyYMOlAl0W2Gj+Vwa3k7Pw9iuQc=;
        b=ymGqYnFVBhofOGOwR5Qn/oIyKTYickjGrpi24ONt4lLyDsJ1ZrSBxT2macuyAsAJFP
         hNjr+Cimvgd0WnNteNTfVwBV/sRR83sEftpMy8pgGuoMmTudyQ5nNdUGfVFSS8HPF+Kk
         NySgC8kvT3AwWBvy8aynSZVGbMOGdAQlQzZ3VCa57lZwe89J0tlx0tHHwOQ1ySO0cgQ1
         kK2vGDlTslhj/6Q1o0+u288CzgaVXOb8EuW+ZOY684p2eudsdE3F7cvzZv7gkgwoVbZu
         IgzAuurhT0J3PBDtE+uitYQfjSSLi07EgpNdhS5PveseGSqYNIcH78ViLW8T+QWtZL/U
         RDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681301375; x=1683893375;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u3h3Qb1KatJSKEmGkyYMOlAl0W2Gj+Vwa3k7Pw9iuQc=;
        b=dbn6njq4q+TcxWXaim+56W+e0iS7Wbc+Sfue/HFAf+9hNSBnyDljX4O2WOiYh/JKLE
         KTELsnK2BXhcYWMsxPewPZtRe6gJrokN/GnijS2ScrTZNyQui97bRGFsCePw7LV+zJzT
         OLYSknXWwF17t/aeW4/6ryI1gbWx3nA49CS9vbhhnxdbXusXiY39mOH85vyF8vTKMs6L
         qOBHmY+QlNQqZpUljeMIvcpQnWsR3LPfYlp010pFMrP2WKRhW381wbHsXx1CQnwJ7fz0
         0dPh7gLaoxcRkEGlRyQh6p6N5iybhUm/TH+cj5HS+Ln16B+36AoiQiqO8gRknVQQ62uK
         udEw==
X-Gm-Message-State: AAQBX9eFN2R/15vgWHLSkHcftqyILUtNm7me8zIeZ0vSPkBAyGNwPCuM
        mTNUKltWEmdYIxDBi44K7nNVCw==
X-Google-Smtp-Source: AKy350YwSJR4JPJ3GVRU7sQeWv9eVe45n1srxKzeDCdDhA6t33VQwsIYqWpVyCNt21TlBJSmZ8MLEQ==
X-Received: by 2002:ac2:4d01:0:b0:4ec:7967:9e88 with SMTP id r1-20020ac24d01000000b004ec79679e88mr639622lfi.8.1681301375158;
        Wed, 12 Apr 2023 05:09:35 -0700 (PDT)
Received: from [192.168.1.101] (abxj23.neoplus.adsl.tpnet.pl. [83.9.3.23])
        by smtp.gmail.com with ESMTPSA id l6-20020ac25546000000b004dd6c325311sm2993786lfk.248.2023.04.12.05.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 05:09:34 -0700 (PDT)
Message-ID: <2e648a97-083e-8ee2-1695-4af299bb222a@linaro.org>
Date:   Wed, 12 Apr 2023 14:09:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/2] dt-bindings: interrupt-controller: mpm: Pass MSG
 RAM slice through phandle
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Cc:     Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230328-topic-msgram_mpm-v2-0-e24a48e57f0d@linaro.org>
 <20230328-topic-msgram_mpm-v2-1-e24a48e57f0d@linaro.org>
 <168069726278.2356075.14351594478003012447.robh@kernel.org>
 <20230405134727.GA2461305-robh@kernel.org>
 <1e6e2590-ac78-400b-35ce-321d5e52f385@linaro.org>
 <9df12111-ec84-c4f7-fbcb-bccaef91b048@linaro.org>
 <3ce9b5ec-8b02-537a-c663-c849e80cab66@linaro.org>
 <ZDAAToSzNLVo6le8@gerhold.net>
 <198523f5-d06f-15cd-af6c-f391c02bcaa9@linaro.org>
 <1f8fc036-380b-0a42-bb29-a3e275ed6a33@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1f8fc036-380b-0a42-bb29-a3e275ed6a33@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.04.2023 13:55, Krzysztof Kozlowski wrote:
> On 12/04/2023 13:47, Konrad Dybcio wrote:
>>> For unrelated reasons I actually have some patches for this, that switch
>>> the /smd top-level node to a "remoteproc-like" node dedicated to the
>>> RPM, similar to how WCNSS/ADSP/Modem/etc are represented. I need this to
>>> add additional (optional) properties like "resets" and "iommus" for the
>>> RPM, but it would allow adding arbitrary subnodes as well:
>>>
>>> https://github.com/msm8916-mainline/linux/commit/35231ac28703805daa8220f1233847c7df34589e
>>>
>>> I could finish those up and post them if that would help...
>> Krzysztof, what do you think?
> 
> I don't know what is there in MSM8916 and how it should be represented.
Similarly to other Qualcomm SoCs, MSM8916 has a RPM (Cortex-M3) core,
which communicates over the SMD protocol (or G-LINK on >=8996).

The Qualcomm firmware loads the RPM fw blob and sets it up early in
the boot process, but msm8916-mainline folks managed to get TF-A
going and due to it being less.. invasive.. than the Qualcomm TZ,
RPM needs a bit more handling to be accessible.

The M3 core is wired up through the CNoC bus and we communicate
with it through the MSG RAM and the "APCS mailbox".

Konrad
> 
> Best regards,
> Krzysztof
> 
