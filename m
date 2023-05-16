Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE53670486E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjEPJGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjEPJGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:06:47 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DB8C4
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:06:45 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bc040c7b8so20894858a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684228003; x=1686820003;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WfR5x7lYlGZxQEhgIr7ehFRWybZSX2Ee6e6eJ8QySGY=;
        b=hvOWGF/FhwNQBPa6krRzcpKhHdtUfi7ZJ5kDslFuENrTh00ATMGwvIrItcmF7b7+nT
         z8UWvCIFVVnxs6C2l/7+ULaSKddSfYBWdl+kr3+n1DXe1hExwO4CpRDRgnw3miH32How
         XbmP8kNjcbfK5uDg2yKOMMm9yvQUepl3otYxRJ8JBugbG3nnuupT/2LFLNbclAN4/Bn3
         c+QRh8Gh19YGm+m6YMDI/GI2IuG4n5wwrOjNRRqk3IxwxaPlZjPUGbrdq3vHO9LyIfz4
         SJxndrkwQ/g4hnQrJrH2aUXV2oytN7lBIA3mEhkfqUN32wEY7ys6gkUUc3va5EqwiALT
         rmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684228003; x=1686820003;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WfR5x7lYlGZxQEhgIr7ehFRWybZSX2Ee6e6eJ8QySGY=;
        b=DBROjSIAIADXFY0saMxb1rHy6UiKgdPo1CJLfqY+bXvVuzgyg7O/999cUkC8FE+lJC
         qALjetiF4ed619B4Ads6D/N2lgrV1EMxZvq/xVVJjk/IxnG6rBuDfCvyXcbfIdhNg1ha
         cHZkQ17AWh4gXWm99a1/anVCpj3W31qychHyoVxVp0PSEbeE8FE1bd4hmkuEzaevakhH
         1DthVb+GXeRwIYixhV6dCsaSSaycT8jZAc3H0riTJYjedYasIepblAuswJtxDmDo/Uot
         1WKuzWt0l9Om+wg8HMqeaTXKsesFlb2NVc0DYOc/i2w41zMN1ldpaGHGP46KQlxA+C0s
         Jt/A==
X-Gm-Message-State: AC+VfDwuAzjmuFlUkXOPGgnsFtYYrLUaTBLywW3pKeRdzb14T9vLHeSY
        QlWm8tQSxskZPoMThr31S1WpWA==
X-Google-Smtp-Source: ACHHUZ7QHeXISFZJrF36Tge1qRT3h5Ie2KasB8KSTNRVYPo6emVX2nmGRkC2/597xXYyRrgbjxN4wQ==
X-Received: by 2002:a17:907:846:b0:965:e5cf:bb35 with SMTP id ww6-20020a170907084600b00965e5cfbb35mr32739005ejb.22.1684228003549;
        Tue, 16 May 2023 02:06:43 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:77d1:16a1:abe1:84fc? ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id my37-20020a1709065a6500b0094f44bdf7acsm10738310ejc.57.2023.05.16.02.06.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 02:06:43 -0700 (PDT)
Message-ID: <cca446b3-9b92-3191-ae0d-1bd7e552c90f@linaro.org>
Date:   Tue, 16 May 2023 11:06:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1] Documentation/process: add soc maintainer handbook
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor@kernel.org>, soc@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Olof Johansson <olof@lixom.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
References: <20230515-geometry-olympics-b0556ff8a5f7@spud>
 <cf1c6b8c-8a3f-eca1-948f-e41946d4c34c@linaro.org>
 <20230516-grader-dejected-df65cdc584b3@wendy>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230516-grader-dejected-df65cdc584b3@wendy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 10:57, Conor Dooley wrote:
> On Tue, May 16, 2023 at 10:31:19AM +0200, Krzysztof Kozlowski wrote:
>> On 15/05/2023 21:20, Conor Dooley wrote:
>>> From: Conor Dooley <conor.dooley@microchip.com>
>>>
>>> Arnd suggested that adding maintainer handbook for the SoC "subsystem"
>>> would be helpful in trying to bring on board maintainers for the various
>>> new platforms cropping up in RISC-V land.
>>>
>>> Add a document briefly describing the role of the SoC subsystem and some
>>> basic advice for (new) platform maintainers.
>>>
>>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> 
>>> +devicetree ABI stability
>>> +~~~~~~~~~~~~~~~~~~~~~~~~
>>> +
>>> +Perhaps one of the most important things to highlight is that dt-bindings
>>> +document the ABI between the devicetree and the kernel.  Once dt-bindings have
>>> +been merged (and appear in a release of the kernel) they are set in stone, and
>>> +any changes made must be compatible with existing devicetrees.  This means that,
>>> +when changing properties, a "new" kernel must still be able to handle an old
>>> +devicetree.  For many systems the devicetree is provided by firmware, and
>>> +upgrading to a newer kernel cannot cause regressions.  Ideally, the inverse is
>>> +also true, and a new devicetree will also be compatible with an old kernel,
>>> +although this is often not possible.
>>
>> I would prefer to skip it and instead: enhance
>> Documentation/devicetree/bindings/ABI.rst and then reference it here.
> 
> Sure.
> 
>>> +Driver branch dependencies
>>> +~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> +
>>> +A common problem is synchronizing changes between device drivers and devicetree
>>> +files, even if a change is compatible in both directions, this may require
>>> +coordinating how the changes get merged through different maintainer trees.
>>> +
>>> +Usually the branch that includes a driver change will also include the
>>> +corresponding change to the devicetree binding description, to ensure they are
>>> +in fact compatible.  This means that the devicetree branch can end up causing
>>> +warnings in the "make dtbs_check" step.  If a devicetree change depends on
>>> +missing additions to a header file in include/dt-bindings/, it will fail the
>>> +"make dtbs" step and not get merged.
>>> +
>>> +There are multiple ways to deal with this:
>>> +
>>> + - Avoid defining custom macros in include/dt-bindings/ for hardware constants
>>> +   that can be derived from a datasheet -- binding macros in header file should
>>> +   only be used as a last resort if there is no natural way to define a binding
>>> +
>>> + - Use literal values in the devicetree file in place of macros even when a
>>> +   header is required, and change them to the named representation in a
>>> +   following release
>>
>> I actually prefer such solution:
>>
>>  - Duplicate defines in the devicetree file hidden by #ifndef section
>> and remove them later in a following release
>>
>> We can keep both, but mine above leads to cleaner changes in DTS file.
> 
> I think all of the options involved are either a bit ugly, or a bit of a
> pain in the hole.
> 
>>> + - Defer the devicetree changes to a release after the binding and driver have
>>> +   already been merged
>>> +
>>> + - Change the bindings in a shared immutable branch that is used as the base for
>>> +   both the driver change and the devicetree changes
>>
>> The policy told to me some time ago was that no merges from driver
>> branch or tree are allowed towards DTS branch, even if they come only
>> with binding header change. There are exceptions for this, e.g. [1], but
>> that would mean we need to express here rules for cross-tree merges.
> 
> I've got away with having an immutable branch for dt-binding headers!

Of course, all is in an immutable branch, but in which tree?

I talk about a case when driver tree, e.g. different clock maintainer,
takes the binding.

> That said, Arnd did actually have a look at this (and suggested some
> changes) before I sent it & did not cry fowl about this section. IIRC,
> this is actually his wording, not mine.


Best regards,
Krzysztof

