Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA99D6B6F8D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 07:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjCMGmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 02:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjCMGmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 02:42:19 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF203CE12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 23:42:16 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id er25so16192915edb.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 23:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678689735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tJFT9u3bvtPcninrG0NN6UOEEY9m29foYTk2CZyPssw=;
        b=WhzTMI0eGE+Dt5eR5cjCn9l/z3FNa2B6ZQOjAWOty0R9C+2gtJfzq6ciHytYxotCPd
         mDT2dJ1QQ5TClYTpHl8Pg3KQkM3i7/SngpRY1jJOVjSZL/E+iN3NYPn0MDmRs6oF7nxX
         8EMOU2N6FcnJrawqWmzR6SqBuqKP6jtAVZXeRNP+L8Ie3hRyQmhRUEkG43Lw0MxTXFl0
         Nd4Jwb1VOhmYQB0seo0ActQhYEYfnR4j9W7ckPA7j/k1HxExEwcEcU8ajAySfob7WAQg
         3sxu4+lst0ny0zEgEEzoggX+JzRPG1gSZ2TkeieZsd/1u75ZAKq//ZX4lFwiD7okyp3M
         hVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678689735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tJFT9u3bvtPcninrG0NN6UOEEY9m29foYTk2CZyPssw=;
        b=PGFqpzmwgNfr+xOGyZk1IBnOym42Eybwi8OINm+qd5HRb7f37OyQAQCL6BzO/6byDE
         muq6QnWzdq1exyuTJKXpeFhA+8gnj6dD0hGqSpMzuNsUG7lJkLTDgN1uAYpogYW9pIiQ
         +UcjbPj26SyQw9E+kUX46XXSr1yQay++ZWBN11GVqKFEgzPtwZuxPOSA47skS97QyPRX
         MWpSiFQP69krHcT1vb9D1PA3bH+u35koIhzkJidVuIqwqts0o3EuEqVGpa3OquhXhIV6
         yc7qh6Hj/dQI4UCg0EJZZdttjM89DcfDHZhrRIL60BzXbMlYlB/0eWnmW/VDlFUxh/wQ
         4EQg==
X-Gm-Message-State: AO0yUKV2/8PlSC3R41uxnQheLcayirqbhT6ocDP0hnflK5hRhtNBihCB
        YNspiLaoW4XNLCNP2Y9TIY2s0w==
X-Google-Smtp-Source: AK7set/IjyqRt2Nd4PWCNZARNzfUSLymHTNlZR0SbMg/gHWa0lryDIhV0nnxoWpPHiy1+vw0YF1vsA==
X-Received: by 2002:a17:906:ce46:b0:8b1:ce91:a40c with SMTP id se6-20020a170906ce4600b008b1ce91a40cmr29808199ejb.53.1678689735378;
        Sun, 12 Mar 2023 23:42:15 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:f052:f15:3f90:fcb3? ([2a02:810d:15c0:828:f052:f15:3f90:fcb3])
        by smtp.gmail.com with ESMTPSA id m18-20020a1709062b9200b008ca8b62cda6sm3080553ejg.177.2023.03.12.23.42.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 23:42:14 -0700 (PDT)
Message-ID: <4f864115-ef66-6940-c1c3-6b296de4cab5@linaro.org>
Date:   Mon, 13 Mar 2023 07:42:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/5] dt-bindings: input: touchscreen: add bindings for
 focaltech,fts
To:     Joel Selvaraj <joelselvaraj.oss@gmail.com>,
        Caleb Connolly <caleb@connolly.tech>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Jeff LaBundy <jeff@labundy.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Markuss Broks <markuss.broks@gmail.com>,
        Jean Delvare <jdelvare@suse.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Job Noorman <job@noorman.info>,
        Alistair Francis <alistair@alistair23.me>,
        Chris Morgan <macromorgan@hotmail.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230312093249.1846993-1-joelselvaraj.oss@gmail.com>
 <20230312093249.1846993-2-joelselvaraj.oss@gmail.com>
 <c9db83e8-f87d-b94d-0c23-8114adb312e1@linaro.org>
 <02012975-8b4c-58ba-b002-d2983c0e1500@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <02012975-8b4c-58ba-b002-d2983c0e1500@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 13/03/2023 01:21, Joel Selvaraj wrote:
> Hi Krzysztof,
> 
> Thanks for the review! I agree with most of your comments and will
> fix them in v2. I have a few doubts as discussed below.
> 
> On 12/03/23 15:47, Krzysztof Kozlowski wrote:
>> I have doubts you will cover here all possible FTS controllers, so
>> filename should be more specific, e.g. choose the oldest device compatible.
> 
> The driver is kind of widely used and can actually support 49 touch
> panel variants as per the downstream code [1]. With some slight
> modifications, the other touch panels can be supported too. However, in
> real world, we have only tested the driver against the two panel we have
> access to (FT8719 - Poco F1 Phone and FT5452 - Shiftmq6 Phone).
> 
> Although its very generic and widely used, I agree we don't know that
> will be the case forever. So I am ok with changing it to more specific
> one. But I don't think the panel chip number denote which is older and
> which newer. Shall I just go with focaltech,fts5452, as that's the
> lowest number panel that we have tested so far and is supported?
> 
> Or do I just keep it generic as it can potentially support a lot of
> variants?
> 
>>> +  focaltech,max-touch-number:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: max number of fingers supported
>>
>> Why this is not implied from compatible? IOW, why this differs between
>> boards?
> 
> Without proper datasheet it is kind of hard to say if this is the
> maximum supported touch points by hardware or just a vendor specified
> one. Because, downstream has it as devicetree property and we only know
> what's set in that from each vendor tree. The FT8719 used in Poco F1
> specifies 10 touch points in downstrean devicetree. But, if I specify it
> as 2, it will still work fine. The FT5452 used in shiftmq6 specifies 5
> touch points in downstream devicetree, but we won't know if that is the
> maximum possible, unless we try to increase it upto 10 and confirm.
> 
> So, yeah without the datasheet, we will be just kind of assuming that is
> is the maximum possible number of touch points by the hardware. I am not
> sure if we wanna hard code that in the driver. Is it okay if we let this
> configurable? Boards/Phones can use the max touch number their vendor
> driver points too or if they have a datasheet, they can specify maximum
> supported one too.

Downstream DTS is never a guideline on design of upstream bindings. They
violate DT binding rules so many times so much, that I don't treat it as
argument.

The property does not look board but device specific, so you should
infer it from compatible.


Best regards,
Krzysztof

