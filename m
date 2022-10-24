Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0A360B921
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiJXUE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbiJXUEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:04:33 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C2B171CC8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:25:43 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id d13so6602190qko.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kkHt7s7VueS+yqyVhguewaguIXeRKiiObRdiVTmhMq4=;
        b=p0wlLhqXrK6ojJ02m/2cIRUXP1W6sSSk3fUAwF328I0sJ3lYsP6NXYr2EBQdrTxwg2
         PsfXWuGh7tWOY6xhkbd7gS+lnkiqqnk1IRyGqLZpr0I3iqiGwYaHlbnH17OPz2jd4/7t
         RFDImnE+MwfMzyynMlkQyRnRki3OTEGmgEUyfiae7ksAAjT6IbZRRpii6oigTWJnHqTq
         Z6ZXpvHOvU+Plj6eytpMons6DnYioavxI0Me5Z5tokui3UGgaPY0v5ybWDUL8FRFegGO
         stwFELVTywZ2tZ804IkaVmuI49Y3MGu/Bk9Al7X5/lwSelRbijnzB8I4ST9wr07V5uP+
         JBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kkHt7s7VueS+yqyVhguewaguIXeRKiiObRdiVTmhMq4=;
        b=EXDunZ2AZazhyWg5jV2hsvcofj6RKbaKfBU/jntja/8Jb0xTJTfizVYILIbKcyXwp1
         cC4lvwfaNJFSdH3R1Z7Ph/d01yelY5Kw1abXNXw1fJnsz585v6yhq8qI77AwoEEOfv+e
         YPc7b3GEu+psL8eGpeT339avUwk2111CONNv9jP2zxToscRP86BLyBzsqWi2jX67+77o
         B0d/GM2Eun+hEzooQc+J0cNxS9X1JrD98u9g9jpjntRtmzRdPmH1k/g0MD+VAo3HKpdw
         toWFnMnN0EhDlYhLFqtfn+N1pUKLt3e1kTuAuXd6l8aPpmYXqoopeP+XHK/CPkTMpLgh
         nwNw==
X-Gm-Message-State: ACrzQf0TBc/ijCAYgcr5uSKVfaQb3q/ERq+IFvAfGaXEz9/2Ihq83NTl
        d9HyTuVDBI3EH19zX+CE/LnNUl7UV5+elA==
X-Google-Smtp-Source: AMsMyM4qoSseM95jLEm1elg8JEI6QXvCaGObqWcc5rQia54ewHUCVM578288JqDT4Iu4iJZI7rsS4Q==
X-Received: by 2002:a05:622a:211:b0:39c:f429:e03a with SMTP id b17-20020a05622a021100b0039cf429e03amr29174644qtx.389.1666628200951;
        Mon, 24 Oct 2022 09:16:40 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id d1-20020ac847c1000000b00398df095cf5sm181944qtr.34.2022.10.24.09.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 09:16:40 -0700 (PDT)
Message-ID: <0312d875-3e94-ebb6-017f-5f7559269d9e@linaro.org>
Date:   Mon, 24 Oct 2022 12:16:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 10/13] arm64: dts: qcom: sm8450: add spmi node
To:     konrad.dybcio@somainline.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211209103505.197453-1-vkoul@kernel.org>
 <20211209103505.197453-11-vkoul@kernel.org>
 <5035b6a3-164b-afa0-b714-4deb886f9f90@linaro.org>
 <59859752dbafda83c801c6a7bf0a06e1@somainline.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <59859752dbafda83c801c6a7bf0a06e1@somainline.org>
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

On 24/10/2022 11:06, konrad.dybcio@somainline.org wrote:
> On 2022-10-24 16:56, Krzysztof Kozlowski wrote:
>> On 09/12/2021 05:35, Vinod Koul wrote:
>>> Add the spmi bus as found in the SM8450 SoC
>>>
>>> Signed-off-by: Vinod Koul <vkoul@kernel.org>
>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>>> ---
>>>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 18 ++++++++++++++++++
>>>  1 file changed, 18 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi 
>>> b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>> index f75de777f6ea..b80e34fd3fe1 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>> @@ -645,6 +645,24 @@ pdc: interrupt-controller@b220000 {
>>>  			interrupt-controller;
>>>  		};
>>>
>>> +		spmi_bus: spmi@c42d000 {
>>> +			compatible = "qcom,spmi-pmic-arb";
>>> +			reg = <0x0 0x0c400000 0x0 0x00003000>,
>>> +			      <0x0 0x0c500000 0x0 0x00400000>,
>>> +			      <0x0 0x0c440000 0x0 0x00080000>,
>>> +			      <0x0 0x0c4c0000 0x0 0x00010000>,
>>> +			      <0x0 0x0c42d000 0x0 0x00010000>;
>>
>> This is a patch from December 2021. Is there anything blocking it from
>> being merged?
> I think it depended on a series of changes to the driver, as 8450 has a 
> newer SPMI ver
>

If the new device node in DTS (for new hardware) depends on driver
changes, then something here is completely broken. Probably in the
bindings for Qualcomm SPMI PMIC.

I expect adding DTS independently of driver changes. It anyway goes
always via separate branches.

Best regards,
Krzysztof

