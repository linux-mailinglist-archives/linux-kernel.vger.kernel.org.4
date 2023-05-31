Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4272471894F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 20:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjEaSWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 14:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjEaSWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 14:22:47 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF7E126
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:22:45 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-974265a1a40so277040366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685557364; x=1688149364;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nt8LHmKS0VqTExnrso7f52eqGbP3H6l1JdiRr3yLNXo=;
        b=BLDdvbq0iEWIHxy7r9xs0SB5E0j4lYxXTLT59PEF6CCbj3finoHUhXf37htvqbDv/L
         0b4SmZv9638jK1cocYCbDlST4G6ItC2KGHdjQ7NBaxa2aie7tbm/lyh0B88GmYPT0bLU
         8EWPpiLJdTgUtNVpTYrGgB82cqciLvqAwIQ/yZ+3GXF5PK26YeLajIBD2T980RU7rv0z
         OI889BlhGDetA8fVKMzcy6TlbfsG2ii6GPktQjibu5wvAVemqLTNhM4wQrRRFPxE1M9s
         i8Mv4ph02g3MMcvvXsI29DLeI5VP4pmQrZiIuN3Qu+6/kP/wRrAhtNMRhLzkveyBUyK8
         erfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685557364; x=1688149364;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nt8LHmKS0VqTExnrso7f52eqGbP3H6l1JdiRr3yLNXo=;
        b=MlQHme7+zmincQBquKLO1VEhFLjdr7ru73Kcp6V2dszksRtltJ+rVAb6ioaHV2Izg/
         trDlbvO1lyOoVhCtokv7A/WZZJlfJBYrt1DqTnWJwkj7qsSdHXhUtZcNdKj3bhM7vUng
         R36d1qwaPwwcrooJyT+BIopaLEu2sF7zbI9BdeUk9QA80tF1gUTmbbPFKOySWZFwyBnN
         guVlGA807T2Wc9X6uQ2hYPghP0gSzMiUsjoiV0yYRCjzo7wsy0s0JpwPtJmeriJs0h8o
         /iSTRmlU58YtcNOdAtbESaByKzCKEcsyW38hyyHgYcjC+QWaGzUN7qImtIoarY2iFmiw
         fvmw==
X-Gm-Message-State: AC+VfDzfWYIqVsdjNjvSdRYTmFz0nW7FKoVoSm6cCepnhTP5KrgIfn9+
        UbH3+GNul8dzK7d9EFZydJx9Dg==
X-Google-Smtp-Source: ACHHUZ50hF9d1nBxKFL28H/6u+ho2Z0QvmpFevAn6NSANiuAJ6ir1uTC/K+3y05wSy2WkKbf6QptbA==
X-Received: by 2002:a17:907:746:b0:96a:1ee9:4b0 with SMTP id xc6-20020a170907074600b0096a1ee904b0mr13378970ejb.33.1685557364274;
        Wed, 31 May 2023 11:22:44 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id f16-20020a17090624d000b0096b20c968afsm9222266ejb.124.2023.05.31.11.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 11:22:43 -0700 (PDT)
Message-ID: <bc1cefef-eeb9-67d5-ca73-64855a85b01b@linaro.org>
Date:   Wed, 31 May 2023 20:22:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/3] dt-bindings: phy: realtek: Add the doc about the
 Realtek SoC USB 2.0/3.0 PHY
Content-Language: en-US
To:     =?UTF-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>, Conor Dooley <conor@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>,
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
 <20230529-impurity-dismount-bca5c9100c9b@spud>
 <6f8fb4c9d5d14cfd8c4f1feafa229df7@realtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <6f8fb4c9d5d14cfd8c4f1feafa229df7@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2023 04:53, Stanley Chang[昌育德] wrote:
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - realtek,usb3phy
>>> +      - realtek,rtd-usb3phy
>>> +      - realtek,rtd1295-usb3phy
>>> +      - realtek,rtd1619-usb3phy
>>> +      - realtek,rtd1319-usb3phy
>>> +      - realtek,rtd1619b-usb3phy
>>> +      - realtek,rtd1319d-usb3phy
> 
>> Ignoring everything else, because I really want Krzysztof or Rob to
>> review this rather than me, but what's going on here with the
>> compatibles?
>> What hardware do "usbNphy" and "rtd-usbNphy" represent?
>>
>> You have device-specific compatibles, which is great, but you also allow
>> only those two generic ones. I had a _brief_ look at the driver, and it
>> seems like there is no decision making done based on the compatibles,
>> only on the properties. Is that correct?
>> If it is, I would understand having "realtek,usb3phy" as a fallback
>> compatible for "realtek,rtd1619-usb3phy", but I do not get the current
>> setup.
> 
> This driver is compatible with all Realtek RTD SoCs without specifying different settings.
> So use "realtek,usb3phy" as fallback compatible for all SoCs.

Binding says something entirely else...

Best regards,
Krzysztof

