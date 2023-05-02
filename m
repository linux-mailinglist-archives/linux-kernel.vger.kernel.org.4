Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901796F3F1F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 10:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjEBIbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 04:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbjEBIbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 04:31:40 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2144684
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 01:31:38 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bceaf07b8so1553109a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 01:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683016297; x=1685608297;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+vq95rI3k+qtNoUgGZVAuxriMrIyzuC5jkHyoK3pkYA=;
        b=wCmHiPiURd74ZS0m8aQVNlCMYF4t5m815+o6DKuLU0E/9pNLe3Y+iJm0D3C040cNK+
         fDikIztacxOhjsuWuY2SWCAX5HBn0hxBq3phZ+aNWYnNPSCJUy+ZbCIZ9gaW2l3WcBJD
         rp8TLbzWp3+PDd78az93FsFpLXGQYTYQSVNDqwIIijScA/89YbX9ANzX2hvv3PAHXnbs
         NfZRpggUkRSfmK4stYI0wxJTGqk27eLcyOmgdI/n4W4wlzigY25zfo8MEzqVdF5+HdAq
         rd15GRQYH7CaseqizCOG+DpiSQs/A60dDVsZRg2Zk2/6fMQInnWw1uDa5mDAZIcz/SuO
         CQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683016297; x=1685608297;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+vq95rI3k+qtNoUgGZVAuxriMrIyzuC5jkHyoK3pkYA=;
        b=U1DOb3Sq/9Bb7L6LaJ5FHaa3xSEldRZ8LQ2bXcv3iM1ThGqs3pI0Coa4noM1it7dn2
         DBFpNDn8lvHk8pYWCNk6xmim+SBGsqb2N+0JA5wdqvGC5WzVAIV2lnvGm/maf6bhNvEI
         q1K8J+8J6MTfY6i54oaDg/Wv9HYSVDT3wQTsgPJAod0rnF1dyRuPpX8073klHq7oXS35
         3Qta0/3bAd564Dm2dvejngtTFGfvEB8bRxKrPAF93dClVW94NprvlQACkvpgaoeRNKTh
         Nwor2svLX0dRNmmR/Q+jLfVIaX0L4fXUvqtwt0iUNHPei1W44uATkXwhf+NeGp4BMcKF
         CMWw==
X-Gm-Message-State: AC+VfDwylsUzBxk7tYWsQnXyts8g3RbKg09nwGJ5dU4O9elxN+VB9Q6o
        CYFsNeqZDymFkOipkxbAHKhVoA==
X-Google-Smtp-Source: ACHHUZ6mElOu0Lip0J2gjJLKiz6U8CQAoJwnINNRtPIfe/suHDIiA4olQHwoLoFSOrlpBVJSn5oWyg==
X-Received: by 2002:a17:907:7245:b0:88f:a236:69e6 with SMTP id ds5-20020a170907724500b0088fa23669e6mr13778125ejc.7.1683016296704;
        Tue, 02 May 2023 01:31:36 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bafd:1283:b136:5f6a? ([2a02:810d:15c0:828:bafd:1283:b136:5f6a])
        by smtp.gmail.com with ESMTPSA id sb11-20020a170906edcb00b0094f7c1b6a94sm16021020ejb.11.2023.05.02.01.31.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 01:31:35 -0700 (PDT)
Message-ID: <0fbd5236-d923-0a8d-c7cd-c8e814211651@linaro.org>
Date:   Tue, 2 May 2023 10:31:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 3/4] dt-bindings: firmware: Add Qualcomm QSEECOM
 interface
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
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <93657561-d545-7ead-7f6c-dd2c62aab319@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 23:44, Maximilian Luz wrote:
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

Yes, please, because commit msg should answer to "why we are doing
this", when this is not obvious. If the reviewer asks the same twice it
means it is not obvious.

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


Best regards,
Krzysztof

