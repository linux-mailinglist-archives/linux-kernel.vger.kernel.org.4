Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C4363384F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbiKVJZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbiKVJZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:25:14 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE59C49B7E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:25:11 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id bp15so22661199lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O8HnwlLIuUW6GQ7MF6wb6CuJekIWr1nSvjXjmRhkscs=;
        b=IiWqDjT6H1cRpC90wd65AWT/9WXUU+5hNY7FkQZBesPVQr9IdCFRIGTV34ehmgTZZK
         3Jus1oyGfk+IMtnQAxdJLPDiOq9V8rNWApdkLIk+5alXBEh5o14B1MyG8uWIV2dzOuG8
         toUTbMdScxGAqDtDb0qvamE57LbdJBuSEqdLOyuNLT5l/LGKQEuiZyH71dfr2IUMi0q6
         /HKVLbgm1JY3WWz3viCNGwcOBt3cG7lrcIpnxAeIs2ULThxcyFaW0M58yA0S7mFSw+xQ
         UNrZYm4Z5E5U0rleIsGfQlNV5rp5siEptUh093+4dlwIS7VXqJ063vgla6ASbpcWJ7++
         9+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O8HnwlLIuUW6GQ7MF6wb6CuJekIWr1nSvjXjmRhkscs=;
        b=aYlK7Rd7TXvIFWVkRUP7fd8o2QPYRi66HC0ynVnFsDdtq+ONqDjhZi87Nzsyl/IT9R
         6L+ekzRZfulNIApMMfaEZbxvxoamtZlHY8cYYNPrgPL2w71QQ0T0X3Skk1kKyEadC0+x
         Hoy/dC5g4G5MZ7+5tUJ40CDoWOCmtW5luOuGvVkSJHGz+flSw4q4+BvU8kDEdmqlMg+b
         3FZIqZ2HqKktcBb3QlRNExl95NQiJguYXzYoDSFlW2+UXdZuG7bsrI8V5+CuCcUzMyuQ
         lDkeBgqMRQrxB3Inzx4kNFkLQcJ8iOOnJLx1bIGdKqmZlEmaKLcmxRarmKCwWq4O3gFF
         XRTg==
X-Gm-Message-State: ANoB5pkLQLigZy3GeetoVNCkPO4H9sDGX10qONxgmMWqQlcIFODkUUPT
        sTbimGWedeicgLyTpxijAXOElQ==
X-Google-Smtp-Source: AA0mqf5byVk5N0XWLkFNIEkusMvYIeYHdcBQgOYQ8RWpuWexV58KEhN68yvC6R+ZBH9j/xzMZoTDiw==
X-Received: by 2002:ac2:4424:0:b0:4a2:2dc9:3e0e with SMTP id w4-20020ac24424000000b004a22dc93e0emr8339106lfl.272.1669109110296;
        Tue, 22 Nov 2022 01:25:10 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q6-20020ac25fc6000000b004a45f2e49b1sm2378780lfg.273.2022.11.22.01.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 01:25:09 -0800 (PST)
Message-ID: <09aaf26a-7377-a4f6-6145-5301304927b7@linaro.org>
Date:   Tue, 22 Nov 2022 10:25:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 1/2] dt-bindings: gce: add gce header file for mt8188
Content-Language: en-US
To:     =?UTF-8?B?RWx2aXMgV2FuZyAo546L5YabKQ==?= <Elvis.Wang@mediatek.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        =?UTF-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?= 
        <yongqiang.niu@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20221104074443.26172-1-Elvis.Wang@mediatek.com>
 <20221104074443.26172-2-Elvis.Wang@mediatek.com>
 <bdb46b7c-6e08-26cf-491d-ca68d36f29af@linaro.org>
 <fcec5536-6ba8-9cac-2001-710a7170df70@gmail.com>
 <5ad6c51677e1476d08ae6de6bd5021384a689b31.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5ad6c51677e1476d08ae6de6bd5021384a689b31.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2022 10:10, Elvis Wang (王军) wrote:
> On Mon, 2022-11-07 at 12:18 +0100, Matthias Brugger wrote:
>>
>> On 06/11/2022 11:27, Krzysztof Kozlowski wrote:
>>> On 04/11/2022 08:44, Elvis.Wang wrote:
>>>> From: Elvis Wang <Elvis.Wang@mediatek.com>
>>>>
>>>> add gce header file to define the gce thread priority, gce subsys
>>>> id,
>>>> event and constant for mt8188.
>>>>
>>>> Signed-off-by: Elvis Wang <Elvis.Wang@mediatek.com>
>>>> ---
>>>> Thanks for the reviews, I have removed the incorrect reviewed
>>>> message.
>>>> ---
>>>>   include/dt-bindings/gce/mediatek,mt8188-gce.h | 966
>>>> ++++++++++++++++++
>>>>   1 file changed, 966 insertions(+)
>>>>   create mode 100644 include/dt-bindings/gce/mediatek,mt8188-
>>>> gce.h
>>>>
>>>> diff --git a/include/dt-bindings/gce/mediatek,mt8188-gce.h
>>>> b/include/dt-bindings/gce/mediatek,mt8188-gce.h
>>>> new file mode 100644
>>>> index 000000000000..e2e2c56016a1
>>>> --- /dev/null
>>>> +++ b/include/dt-bindings/gce/mediatek,mt8188-gce.h
>>>
>>>
>>> What is a "gce" subsystem or type of hardware? Why do you put
>>> headers in
>>> "gce"?
>>>
>>
>> Yes, I think we should move all header files from the gce folder into
>> the 
>> mailbox folder.
>>
>> Regards,
>> Matthias
> 
> There are still a lot of header files undre gce. If all of them are
> moved, it will also involve the modification of yaml and corresponding
> project dts files, which requires more effort. Can we deal with the
> 8188 part first?

Sure, just put the new bindings in proper location (mailbox if this is a
Mailbox).

Best regards,
Krzysztof

