Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0E671A2C8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbjFAPc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbjFAPcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:32:55 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15DFAA
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:32:53 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51456392cbbso4866403a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 08:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685633572; x=1688225572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d+hD8sanORaWT0+7h4FlSb8jJyfN127ZPZqGdgRFUik=;
        b=ElKVSOFj2eQz/HLNwoODWxWCWoi2Kx/s1W/rVvvxdLHDkzhxpGLwE89chXLB0Mnq5q
         25EkWgrR7i96Rbz+knEOs6rDhevaooR2wnXmShLYc0TtwXW0IGH9npeIYsuUkXM/eHx1
         ZuSPtyUAl4O8d7ayCPJqGiSKRW44M+xAk0JCdFG8x09GTqkvjvIHK5Z303ohDAIRQ7jP
         tdZGtiEgqRhhOHYSlYqxuv1bQEOz0ZozvnJcjRyhKEoA0C2dqXxzJWabeMMDhPP4Fs89
         qsA0JBbna14pQ78O/ir++cbTJWSptZ8LzT4qVMMHmKW2DnOYq2ajzzg6eWAyn3gDhY0O
         NWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685633572; x=1688225572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d+hD8sanORaWT0+7h4FlSb8jJyfN127ZPZqGdgRFUik=;
        b=MDVu4a3fSSPMx3o12hJLeL7pxwNWCeXAfs7yf5WTIzkbwqMa+4khtEUHiEB6o30k64
         EJAYshTVui252F1CJtSWvD0MGMEqo+WkY46u/D3IuzYEAUvjrVhhJqG6i1srXwP+m3cE
         2EAuktbU2vXSQpYPIhIXqG5HWIUhvk8sRe013+EJMiVg4OcL6/62MjiXq4dAQi7TDXpI
         LOuPVeIkij9KUv/+zdoCmQ9Ust0jkxuDHUS8qefyMo9Z7pT/nICU+phCiyOKWUE49w0h
         DQMxtNMH5hr5Zg351psxBGzfKaBiudh7z5IkrxDNz90AA9g8xnqGtYnC1qXPzR4d8IZR
         mL/A==
X-Gm-Message-State: AC+VfDzINMyLbKWfWEuKOFv9FlEVm9YBomp2NtBUn+kyUnY65J++AjN3
        jkkRGr/Yk8TXAWXiERg4UkBT8A==
X-Google-Smtp-Source: ACHHUZ7a+j5H+4n877373TAsr1A1hwAPC3YrdKs+go0xqZQRXTvLCs8FQzyxfAYg3gC+80JnFGDtfA==
X-Received: by 2002:aa7:ca4f:0:b0:514:a016:9cd1 with SMTP id j15-20020aa7ca4f000000b00514a0169cd1mr140984edt.8.1685633572310;
        Thu, 01 Jun 2023 08:32:52 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id y2-20020a50eb02000000b0050488d1d376sm7361686edp.0.2023.06.01.08.32.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 08:32:51 -0700 (PDT)
Message-ID: <c49f5619-286c-fbb7-0f18-5869527081c8@linaro.org>
Date:   Thu, 1 Jun 2023 17:32:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/3] dt-bindings: phy: realtek: Add the doc about the
 Realtek SoC USB 2.0/3.0 PHY
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
        Flavio Suligoi <f.suligoi@asem.it>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ray Chi <raychi@google.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
References: <20230525022617.30537-1-stanley_chang@realtek.com>
 <20230525022617.30537-3-stanley_chang@realtek.com>
 <0b2143ca-ead7-c8fa-2e80-a94222af51ca@linaro.org>
 <ee65a9d6d40d4099987db5ff1ad1753f@realtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ee65a9d6d40d4099987db5ff1ad1753f@realtek.com>
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

On 01/06/2023 12:49, Stanley Chang[昌育德] wrote:
> Hi Krzysztof,
> 
>> Thank you for your patch. There is something to discuss/improve.
>>
>> Actually a lot... The bindings are not suitable for review.
> 
> Thanks for your patience in reviewing my patches.
> 
> Most of the properties are about the phy parameters.
> Is the phy parameter data suitable to be placed in DTS?
> I referenced other phy drivers. 
> These parameters should not be defined in dts.
> I would move the parameters to the driver.

If these can be in the driver, why would ever they be in DTS in the
first place?

> 
>>> +  realtek,usb:
>>> +    description: The phandler of realtek dwc3 node
>>
>> "phandler"? Except obvious typo, drop "The phandler of" and describe what is
>> it for.
> 
> realtek,usb is a phandle of syscon used to control realtek dwc3 register.

Then no, phy should not control dwc3.

> 
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>
>> Anyway, it shouldn't be here. No, no.
> 
> Can I use it for phandle of syscon?

PHY getting phandle to block using this PHY? Looks wrong. Why would PHY
need to poke IP block register?


Best regards,
Krzysztof

