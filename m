Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAA1648512
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiLIP00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiLIP0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:26:23 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3999C8AAFC
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:26:22 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id g7so7563646lfv.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 07:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pLB1Wp3SQOJvU3kmfPpuZm7QuXVx8DYyBfu0xuLdcZw=;
        b=m3hxql7NUdafbTVeg6ijPntzDBxQVpRc5SWUf8+sGDBP7ZLuHGeqdSTidfzXI2OeGz
         d7jUrkc/b3Ioz97kyV7naZ1GT95f7m7jUadk+KW9MxmdxO4kDNIa8ZG8vHvhA8BUUr3v
         E8eMALq+oA5w6jzSbVgg2jW8JrpK1y92yxYEBuzVpYhRga8Q/5ePYfkVhqqgxpR247xh
         piqcwWwxSy66pxc6pCi/FW9UT6BJOfz8mPoohSczDqj6LHQH9z4TtOghDLiEDb+Hcb+W
         4wxgBisisAqnht1uTCJFo760Iv0YrOHwU/KUf3emx2rYQ6DUYB3l7k+woqjeABpqp+3h
         O5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pLB1Wp3SQOJvU3kmfPpuZm7QuXVx8DYyBfu0xuLdcZw=;
        b=FN82GRzErPJdeDWkGa1g3WRZ1FzvmMTjNQ7025oVhiUgoaGOS6n0DrMPspdomX72i3
         TKt+pt7j7dXsSvYm56kB4rXNiP/KtRFvQvlHIdK/ofZy/1TFvtrdfQiPd29VGIo/tcTG
         UcUkY6a9SMuGA2BtvlTAHSt66/qF3n/5NbGdCVhxGeeOcxJHxizUUuH1uHmSidpD+zEJ
         ChaTRN2bVhLAKZkos2GrnTL3eLTQs4Rav8aOgTeRv4RYHe34hbwhvg6mGVxqGR0lTwHF
         V73cBSVYq9ih+zpw8CnoAidHfbPbxaiQC6rjso21edvqIP+JQsimtzvpYxpuk9w/zoBk
         P2mA==
X-Gm-Message-State: ANoB5pn5gmKCIXXU+ge6GvIWkPPTY57skXpzmBkjVt9xiB9Vb9nBMl7H
        OAfb++u2aYn6HexuCwV3hde3lQ==
X-Google-Smtp-Source: AA0mqf4taA+JeYEBat76sf7r3OiUs4uoVxCCpHSHBKIeuJiMnNnndlfjtMxgKqqIZfbViMyJW4ZPSA==
X-Received: by 2002:ac2:4c07:0:b0:4a4:68b9:66f5 with SMTP id t7-20020ac24c07000000b004a468b966f5mr1397063lfq.64.1670599580603;
        Fri, 09 Dec 2022 07:26:20 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id n21-20020a05651203f500b004b4ea0f4e25sm299664lfq.301.2022.12.09.07.26.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 07:26:20 -0800 (PST)
Message-ID: <a4a88541-2e5c-7f7f-ae3a-38f0f48c1feb@linaro.org>
Date:   Fri, 9 Dec 2022 16:26:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] arm64: dts: zynqmp: Add xlnx prefix to GEM compatible
 string
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com
Cc:     Harini Katakam <harini.katakam@amd.com>,
        David Heidelberg <david@ixit.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Sean Anderson <sean.anderson@seco.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <718283a9f5493ab63b4aaa12337dd5cab6538ff5.1670594172.git.michal.simek@amd.com>
 <ff731bed-1df5-aafd-d490-7bdf9382ff38@linaro.org>
 <d097b9f5-a82d-f343-088d-d745d5d1ed32@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d097b9f5-a82d-f343-088d-d745d5d1ed32@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2022 16:23, Michal Simek wrote:
> 
> 
> On 12/9/22 16:11, Krzysztof Kozlowski wrote:
>> On 09/12/2022 14:56, Michal Simek wrote:
>>> From: Harini Katakam <harini.katakam@amd.com>
>>>
>>> cdns,zynq/zynqmp/versal-gem was recently deprecated in Linux in
>>> favour of xlnx prefix. Add this new compatible string and retain
>>> the existing string for compatibility with uboot drivers.
>>>
>>> Signed-off-by: Harini Katakam <harini.katakam@amd.com>
>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>> ---
>>>
>>>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>>> index 8553299f12eb..233127d94204 100644
>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>>> @@ -507,7 +507,7 @@ nand0: nand-controller@ff100000 {
>>>   		};
>>>   
>>>   		gem0: ethernet@ff0b0000 {
>>> -			compatible = "cdns,zynqmp-gem", "cdns,gem";
>>> +			compatible = "xlnx,zynqmp-gem", "cdns,zynqmp-gem", "cdns,gem";
>>
>> That's not what the bindings are saying. If this was the intention of
>> AMD, you should have replied to my patch that you need prolonged
>> backwards compatibility.
> 
> I have sent the patch to U-Boot to support new compatible string and CC you on 
> that too.
> 
> I have no problem to do switch just to xlnx one but it is not fully accurate 
> that cdns,versal-gem wasn't used. True is not in Linux but it was used in U-Boot.
> 
> If we can go straight to xlnx,zynqmp-gem, cdns,gem I will send v2 of this patch.

Yeah, there might be also few other users of these bindings (other
systems), thus the DTS change might need to wait a bit. The other way
would be to change bindings to match your three-compatible usage, but
then we would have these in three places in DTS (old compatible,
new+old, only new).

Best regards,
Krzysztof

