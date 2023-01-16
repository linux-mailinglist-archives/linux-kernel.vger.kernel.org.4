Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B8466B885
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 08:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjAPH63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 02:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjAPH6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 02:58:25 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D7A1042A
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 23:58:24 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id az20so46990714ejc.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 23:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3P6m9cygArzQUzcA1d5DwOn4hihKZKZ13H0Eg/NjplU=;
        b=bvbnoadocjzFvIY8rA2ScL3BHDG5nGLrhnObZLR5L5GxVum3MWkfyz1psbXIfhmohJ
         OeRm3E++cDyQz0UmArQ/li1KchmCcsQ++YH5az6lgQ4Q6PY9jDgP502Trnf0IKltb7kU
         TN8nqaAGrquKIVHvf9UneOe3K03O1UTKd9eRunWf+EZ3vImN4he4WfxRVkDrh6c54TtF
         05dslx+JuVNgcWXpVARuax/eCChE70fouqeKq1yv8ZHXlHJcGqX61Lt6X11HygWws0d0
         q4SX4h7lMpCqPYjkCCT8k2HE17vDVeMwaPrmaZkHiZbKxAwql4y489KPwkKKY+3DtClD
         cdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3P6m9cygArzQUzcA1d5DwOn4hihKZKZ13H0Eg/NjplU=;
        b=ATbXcTZ2kfShGnukUtArFDrEUYvFv0mtM/N7Mevr/rmA7A06uTv30LKoQhCDwt+tAk
         M/2VJ4ndtbjcSxFHyxjPHYePApFZhtOB82LLQ516Oe6i8YeOb3ColvJud0IYjTPZ9oA0
         YOZn2w1MYWmR/o90nMJvqrtUyj1g1Q+T2/o1mZz3zTxZ3Z0CuBcT5X7lsKz863o7iHgJ
         bzwUlF44kLXL9nRyK+0rcNmC8rzz8nUz10GpNQTBgMycTJKqPCqbSbCMNzJSEqJgop63
         V9ZaO51G7eH/zhCJve2gzD3DzvtphRlQuuCWyPLA9vY7DK+2c2oakgd9WMwQEWeWNkZK
         /2wg==
X-Gm-Message-State: AFqh2kp93VqaOzrHHvkZcnHarnTKZQAiWy/rVzMTil3BVDSDh4qNAYQi
        kyp7q7ocF/1Fqnvf0miH2IPkcg==
X-Google-Smtp-Source: AMrXdXuDcVGn28fkOHFfMl2xwsTevHvQAKWtTc2UKZJEFgpVWjyxOj8xWnSiMJ754nRI5I2rklLXhQ==
X-Received: by 2002:a17:907:c019:b0:7c0:b569:8efe with SMTP id ss25-20020a170907c01900b007c0b5698efemr72786145ejc.60.1673855903025;
        Sun, 15 Jan 2023 23:58:23 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v2-20020a170906292200b008710789d85fsm530701ejd.156.2023.01.15.23.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jan 2023 23:58:22 -0800 (PST)
Message-ID: <20385103-2217-a5d0-6355-802bc87ec888@linaro.org>
Date:   Mon, 16 Jan 2023 08:58:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/6] arm64: dts: qcom: sdm845: move WCD9340 codec to
 separate file
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230113162245.117324-1-krzysztof.kozlowski@linaro.org>
 <20230113162245.117324-2-krzysztof.kozlowski@linaro.org>
 <e3c367ba-b752-d116-0b84-fd2437e565b8@linaro.org>
 <5e784285-c391-91f4-c9d1-a53443fc4264@linaro.org>
 <CAA8EJpr+0fnhy+aHwmdKQA_xk2Qkse0L5u8JdCJNDZqqdYwhrg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAA8EJpr+0fnhy+aHwmdKQA_xk2Qkse0L5u8JdCJNDZqqdYwhrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2023 06:55, Dmitry Baryshkov wrote:
> On Sun, 15 Jan 2023 at 13:21, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 14/01/2023 21:33, Konrad Dybcio wrote:
>>>
>>>
>>> On 13.01.2023 17:22, Krzysztof Kozlowski wrote:
>>>> WCD9340 codec node is not a property of the SoC, but board.  Move it to
>>>> separate file and include it in the specific boards.  On all others,
>>>> keep the Slimbus node disabled as it is empty.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> ---
>>> Generally this should be SoC-independent, for example some newer
>>> MSM8998 devices shipped with the 9340 codec that most 845 devices
>>> used, but earlier ones used the WCD9335 found on MSM8996
>>
>> OK, but I don't get if you expect me to change anything?
> 
> Maybe it might make sense to name new include file just 'wcd9340.dtsi'
> rather than 'sdm845-somthing.dtsi'? Same applies to the wcd9335 codec
> found in msm8996.dtsi, if you are going to extract it too.

Ah, then I vote against, because it is not only codec, but also it's bus
attachment. It cannot be re-used on other devices.

Same approach with sc7280 audios - not re-usable for other SoCs.

Best regards,
Krzysztof

