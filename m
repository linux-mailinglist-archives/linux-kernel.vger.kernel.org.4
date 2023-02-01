Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5BD68608E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjBAHZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 02:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjBAHZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:25:37 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597796580
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 23:25:36 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d14so16351511wrr.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 23:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BPo/q9D5ac3uSvDlctkYDl419CKsFo9D1tuwF0xBQlM=;
        b=fy0dKzPqaB8hOEpanX1S5Gbg3Ip9oWiLfNZbjZIZeSvomNGiBtB1E5o5ouFodKSw54
         pghlzI6+1roiTNyQsG/cTRHAe/TeSAcUUbBjALLR9njBpZgdabNMtAEI5vIYy4cqJfC4
         8SeKCr+ppc/G5NmQXFmRbA3mA1OgxDwJMbPbPExqWTNGfs/hR/8Tj98nyrl0LS4Tqa0i
         liBeBJ7iTtVUCCJkvtp9bYhxoOKxCdznnX8OWX7iDe40mWAqi/xL+z7DvEnAb9vWyrHx
         VZTs1XPf3SKsxTYLz4/DYW7Ufr5Yk4EzwsnU+ebRk76Hez0PA7dbUFBYfRBNu5OcMZDH
         fA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BPo/q9D5ac3uSvDlctkYDl419CKsFo9D1tuwF0xBQlM=;
        b=O0z+Iijfq73fBp1i/ACLDH/NNG0IHDT6XbZeKTF4xStWSeOpNHN8/VL+rDzIBIqdPd
         h7bXUUzZQ4CcsBNlvpHgS5HFsm73AP/pFvDc6jj5gR6KvWgvvHHVivRB73ZGCMP+Sefc
         92z7i1JCYj0LgcFDq8eqqeuWtroIkV8G9P4o1rIDXe2K/OfKDg0M47DvioUjOLnEb5Y1
         rWL+5B5Yp79R9WHr0V34vwzXmihD/c3U3yc4NCEj0K5RedhFTSqVaCDHOjr9jzaE6BLr
         CNpID3CpkUjL74CzgCZ8HG3C4rFBNeZ+8cgEPbt3DOGgzyx5SuRd+2nI0D6Tf/pzTtHE
         TYqA==
X-Gm-Message-State: AO0yUKUplZUcjspITZSSfAu9qm53+yPy7mfS2sprCuaGqTf0zgboijck
        qualJi0xO/oWkoOZuUu+t//cUA==
X-Google-Smtp-Source: AK7set+prGSYrdiu8oqIfF4ozlr1/98VvmogLktJ4xqgfQoviK77oZcGC9yxgETNqDXONBvvoaJTSQ==
X-Received: by 2002:a5d:4b4e:0:b0:242:eb5:254f with SMTP id w14-20020a5d4b4e000000b002420eb5254fmr636375wrs.48.1675236334808;
        Tue, 31 Jan 2023 23:25:34 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m15-20020a056000024f00b002bfae16ee2fsm17168542wrz.111.2023.01.31.23.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 23:25:34 -0800 (PST)
Message-ID: <f67f81fd-c770-45b2-9c5e-7ea53e956db9@linaro.org>
Date:   Wed, 1 Feb 2023 08:25:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 2/5] dt-bindings: mfd: Add ADI MAX77541/MAX77540
Content-Language: en-US
To:     "Sahin, Okan" <Okan.Sahin@analog.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20230118063822.14521-1-okan.sahin@analog.com>
 <20230118063822.14521-3-okan.sahin@analog.com>
 <c4433cba-ce35-e5d3-f04b-ba8f9f501732@linaro.org>
 <MN2PR03MB51685B56D49CBB590BBE6B7EE7D09@MN2PR03MB5168.namprd03.prod.outlook.com>
 <04ac07ef-ee4b-abb8-9fb2-114e3a646a2f@linaro.org>
 <MN2PR03MB5168884376CEE35E73739A95E7D09@MN2PR03MB5168.namprd03.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <MN2PR03MB5168884376CEE35E73739A95E7D09@MN2PR03MB5168.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2023 22:28, Sahin, Okan wrote:
> On Tue, 31 Jan 2023 7:44 PM
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 31/01/2023 13:02, Sahin, Okan wrote:
>>>>> +  regulators:
>>>>> +    $ref: /schemas/regulator/adi,max77541-regulator.yaml#
>>>>
>>>> No improvements regarding bisectability - this patch fails. If you
>>>> tested this patch, you would see it.
>>>>
>>>> Instead of ignoring comments, either implement them or ask for clarification.
>>>>
>>>>
>>> Sorry for misunderstanding, I checked patchset as a whole not one by one this is
>> why I did not get failure after "make dt_binding_check " . Right now, I understand
>> why you are saying this patch fails, but what is your suggestion?  what is the
>> correct order for this patchset? I sent adi,max77541-regulator.yaml in path 4/5.
>> In the light of discussion, should I remove all the parts related to regulator in
>> patch 2/5, then add adi,max77541-regulator.yaml and update
>> adi,max77541.yaml in patch 4/5? or should I add new patch to update
>> adi,max77541.yaml?
>>
>> Regulator binding patch should be first in the series (bindings are before usage),
>> then the MFD binding should come. Your cover letter should clearly at the top
>> mention the dependency. You can also mention dependency in MFD patch after --
>> -, because many of us do not really read cover letters...
>>
>>
>> Best regards,
>> Krzysztof
> Hi Krzysztof,
> 
> Thank you for your feedback. I tried to explain in cover letter .However, I understand that it was not clear enough. I do not want to take your time, but let me ask one thing to understand the case completely. Right now, my order is like below
> [cover letter]->[mfd driver]->[mfd binding]->[regulator driver]->[regulator binding]->[adc]. 
> Should I completely change the ordering  e.g. starting with regulator ending with mfd or is it sufficient to just get the regulator binding just before the mfd bindings?

"bindings are before usage" - what's unclear?

How can you use binding before defining it?

Best regards,
Krzysztof

