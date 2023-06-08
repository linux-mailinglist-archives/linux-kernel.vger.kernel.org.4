Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA72727935
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbjFHHwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbjFHHv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:51:57 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04966128
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 00:51:56 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-514953b3aa6so380021a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 00:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686210714; x=1688802714;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zct6XBCH1Tv2PsNs+IsnqKieyR9/tL3UgrCB0gy4jXs=;
        b=zNT6gX1jbLVwYb5r2yPvDYs7tM00gF/Z/k5vSxU9R26fslPMRem9O0S6Q55m+nZUkS
         HBqyvRrKNGJ+J4V+Cfqiy7uW378Lx3GR4YW4EmNL77thxyF8HXG2QpequMwDfeJ36qQN
         tuzZIbjT6GZwbCZYQG/xOIqjn7Ads3u2nA42BPQBo+wT6a6cRVncw49bwuCDpCCv68nm
         a/GXn7o/58lksvK9wT1DPTy/ImFhtIUwB8/eTE2cejFYbo1ISH8FPwIkV+0L9/aiNv5P
         yrJbsFHHmX4n9EuFQlaSI4cMhXNJsNkoiihvGs1Ywi1Nh6nd6N1V27YtZLF4EGPwD/Rv
         esAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686210714; x=1688802714;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zct6XBCH1Tv2PsNs+IsnqKieyR9/tL3UgrCB0gy4jXs=;
        b=PLsC62pUOHapNNTlibSS7ab8DvsKWTtofUHgUjmbPVlaiUUbxmpVOVgdYLyHNmqWmj
         jdTiwH2lPXeAFiHtm5vPHY13EaZhuQuU5+zhChk+D4faDsITTASFxvDLJUSdBSj7DCeF
         1PAtP79htLTGP+AxZPtKKR2PNFA+YFvxTGXRJ333TIrAe9zMUEdKg7cN6kfBv/y/GHP9
         hWweXA/6oucjVjutv4rI7nO0LzuzbvyIe28RjsPWhPut0rHG673GQzfrKpU/TIr0EtGQ
         xVRC36z0kfFxAhDhnT0SvR0fRBclsXC5/cUsyvIsb4rXW+Y/Q01dFfEtuULbkUEocv7t
         xDHA==
X-Gm-Message-State: AC+VfDyznSfQ/q1qoQ7sLODATKkAwUKkzpi2lr4JM4cFsBuddeKPncRO
        qnZ2wLQUcsPy5h70eljlYO1SCg==
X-Google-Smtp-Source: ACHHUZ50i+lzbZ8IfY8FXaq7GRfB2bVlYYuBbsPZqFrBSWvs6gxQ13zoI4jJba8mPl+4LFxqGTYqIQ==
X-Received: by 2002:a17:907:97c1:b0:973:d076:67ab with SMTP id js1-20020a17090797c100b00973d07667abmr10116923ejc.42.1686210714476;
        Thu, 08 Jun 2023 00:51:54 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id lr26-20020a170906fb9a00b009663115c8f8sm341825ejb.152.2023.06.08.00.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 00:51:54 -0700 (PDT)
Message-ID: <7390105c-dad9-2785-1768-7f50b067633a@linaro.org>
Date:   Thu, 8 Jun 2023 09:51:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 4/5] dt-bindings: phy: realtek: Add the doc about the
 Realtek SoC USB 2.0 PHY
Content-Language: en-US
To:     =?UTF-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ray Chi <raychi@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
References: <20230607062500.24669-1-stanley_chang@realtek.com>
 <20230607062500.24669-4-stanley_chang@realtek.com>
 <7cce1d72-6b4d-9fff-32bc-942193388134@linaro.org>
 <0c405afedbcf4e468add480399775ebd@realtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0c405afedbcf4e468add480399775ebd@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2023 09:47, Stanley Chang[昌育德] wrote:
> Hi Krzysztof,
> 
> 
>>> +      For most Relatek SoCs, one XHCI controller only support one the USB
>> 2.0
>>> +      phy. For RTD1395 SoC, the one XHCI controller has two USB 2.0
>> PHYs.
>>> +    properties:
>>> +      realtek,page0-param:
>>> +        description: PHY parameter at page 0. The data are the pair of
>> the
>>> +          offset and value.
>>
>> This needs to be specific. What the heck is "PHY parameter"?
>>
> It contains more parameters
> page0 has 16 parameters
> page1 has 8 parameters
> page2 has 8 parameters
> It's tedious if we list them all.

Sure, if you prefer not to list them, then they should be removed from DT.

> And we only set the part that differs from the default.
> It's hard to explain which parameters were changed because each platform is different.

If this is phy tuning per board, you need to explain and justify them.
If this is per platform, then drop it - not even needed, because you
have compatible for this.


Best regards,
Krzysztof

