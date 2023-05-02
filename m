Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C811B6F421B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 12:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbjEBK5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 06:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbjEBK5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 06:57:47 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E893C19;
        Tue,  2 May 2023 03:57:45 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-305f0491e62so3097994f8f.3;
        Tue, 02 May 2023 03:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683025064; x=1685617064;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DDJi9AIZyULJzV1gZ9+9jWSqsME0OxYa9uIICo13pFc=;
        b=mfmy/R0ZSIVqI4XixQQdYvEd66euVQ01y0GhwyD3yyFcQTV0xfEHWRAXbgaeX51SEQ
         OEq4e8dM53t0Zv2/R4EZSKJuNuwxbaPhMFZH7IZ+EcXZmvI8aItIfZxbMkNgw1h8xQqj
         20ZQzi6y1CS2m0omo529hL0EGzwoTYT7chOWoVzTlpD2iDtp76L8kRWEUMu7tEZ9pXol
         8YZQrRw7T1/t9DTyZGyLy7+ub0nFIKA8vzygltwEEWjzBcYckPKSxVXYO80Yd8Sunh0d
         8sQIKwCWhQ68rA1MZdRQS9P3Uh2BFQvXl8ky3neaZtbBgIUbOmo9TyP29hdV7g+I8DNL
         WSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683025064; x=1685617064;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DDJi9AIZyULJzV1gZ9+9jWSqsME0OxYa9uIICo13pFc=;
        b=WEW5flWjR28i/MlXmHKZAru0X5dDHAdDk/qrOTOsHLbWGITAUNhfpwJvN38FGLwkwh
         cdbPO0+/Tbc60dikYPvinS7gB1/xaxP0bwSSfM+5hiCnbvfTOHbmSxpQcaL7pBDyH5Pb
         EEfk4uBf8NHn2Sy6kdlcyd7RrOUCbfkNFAvmhHot99yF91vIKp1PyF6m0KpHUI55zJki
         M5RrhiMkizIuT6aCPMxF43jSV9I/rKXsx1bvvrs3PF5NooQg0H0Kxn6U/6pTLuisEDBM
         5XRW40kbi/2EyvFuYrUhUL2JrpF5JXeAnru2F2DzcFSmX2yXeeulVOAWKfBAaYK7Y83t
         ys7A==
X-Gm-Message-State: AC+VfDx6VHeCilOcWB3Vfmrh/5si1+ZZxd79thhjX7R8s5YeKJ6vJ9ns
        rtBACfwd/K/80vZksqtEuXvQR1zOom8=
X-Google-Smtp-Source: ACHHUZ5vqREH3GsF9Xfd06WlyD/FNtrjzHg2ArdPeYVb3hH3MYV5B/xy/27JgFg+XKI2quH7JgUbTA==
X-Received: by 2002:a5d:4563:0:b0:2ef:eb54:4dc0 with SMTP id a3-20020a5d4563000000b002efeb544dc0mr10983220wrc.51.1683025064124;
        Tue, 02 May 2023 03:57:44 -0700 (PDT)
Received: from [192.168.2.202] (pd9ea3834.dip0.t-ipconnect.de. [217.234.56.52])
        by smtp.gmail.com with ESMTPSA id eo9-20020a05600c82c900b003f0ad8d1c69sm31957462wmb.25.2023.05.02.03.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 03:57:43 -0700 (PDT)
Message-ID: <1980901a-d525-9147-17bb-1094bf18f711@gmail.com>
Date:   Tue, 2 May 2023 12:57:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 3/4] dt-bindings: firmware: Add Qualcomm QSEECOM
 interface
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
 <0fbd5236-d923-0a8d-c7cd-c8e814211651@linaro.org>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <0fbd5236-d923-0a8d-c7cd-c8e814211651@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/23 10:31, Krzysztof Kozlowski wrote:
> On 08/03/2023 23:44, Maximilian Luz wrote:
>> On 3/8/23 23:16, Rob Herring wrote:
>>> On Sun, Mar 05, 2023 at 03:21:18AM +0100, Maximilian Luz wrote:
>>>> Add bindings for the Qualcomm Secure Execution Environment interface
>>>> (QSEECOM).
>>>
>>> Pretty sure I already asked, but no answer in the commit message. Why do
>>> we need this? You've already declared the platform supports SCM calls
>>> with "qcom,scm". Why can't you probe whether you have QSEECOM or not? DT
>>> is for non-discoverable h/w we are stuck with.
>>
>> Yes, you've asked this before but I can only repeat what I've written in
>> my last response to your question: I am not aware of any way to properly
>> discover the interface at runtime from software.
>>
>> If it makes you happy, I can put this in the commit message as well...
> 
> Yes, please, because commit msg should answer to "why we are doing
> this", when this is not obvious. If the reviewer asks the same twice it
> means it is not obvious.

Thanks. Hopefully I can manage to tie that (reliably) to qcom,scm and we
don't need the specific compatible for v4 any more. I will try to be more
descriptive for the next set of patches though.

Regards,
Max
