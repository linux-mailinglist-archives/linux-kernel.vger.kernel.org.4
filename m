Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F65663135C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 11:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiKTKgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 05:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiKTKgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 05:36:36 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70927DC8A
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 02:36:34 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id a29so14865517lfj.9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 02:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bkqr5CITlf9Pw0k+sezW0jUIFDxvpCmwSMWyehFOiNM=;
        b=l01VxSQh8yun766SjOSDe7zfb3SL3HFlZdKdnKf6D2EiEzXVI2Av+lmCp2NZ3lVlpi
         Y1vEvHZJw3wFXGX8mBTgR99tBrci4iwdycuAW/irJzmXCKEaLmEYE7tla4U219jYYgbu
         Ak71A+oY5nA0KSe2u+ozcIWsvG4O2ZWQUiXohw9BlFJCJFvsfSfm2aLpRJ2dQORoJodZ
         4qb7oYyFiJcNAQpz4ahaM//QrbawwiBwlOtchNsCfw4bxU1aDWxicQcnRxjMPb6tfVKa
         lilYfjjOSydFNN055+AMwVyOy7UBFRTHzCkdQlVY+9eDKHuOYZ01pXXvoMEHytic9Ecg
         dzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bkqr5CITlf9Pw0k+sezW0jUIFDxvpCmwSMWyehFOiNM=;
        b=y/Pz7ElrJbtzeaat+j/l/Lz4FyVa5uDXgn/xUi6mXbwQwXlS9VDwXXg/Hoh0wj+86Q
         t0g790Ox9a6ag5qSyVKe0n/sM/fCKdRm6M6xsqNRZQt7ownv51v7/tdRzVV8n9UVnS7s
         J6rT3tB8o/MkOZV9a49Prf+gyswT3mhMdpfIYmUHa6+oDVcNEa28IUYihZLn9N9pEo7o
         aM7LspNKxb+iUVZVBukEnJn3vI20nn1SZbZ/Ce5UdFnfnfH5G6wDP96fwIVRwpLzPMZF
         1qG9mpN6DBmcohWJWeKBb30p9c13Endl3CsdGqCg4rJtpOhpafts7afqp0bm3zdC8ep8
         kOaw==
X-Gm-Message-State: ANoB5pl0C5io0Z4O/WvNzv4wH37+mAr1eWc1e4Q/Of2fuU8Jg7j12bfQ
        zC2xkuhn1v4gG9LCxGfeKmZ/Rw==
X-Google-Smtp-Source: AA0mqf6Mn70Z7ivGYWkW2u7n1bmFEm8KUVOAgQ7UoY06kP3Jgu4IpvXfJfXjOWCewEwECTOGz+/xQQ==
X-Received: by 2002:a05:6512:b8f:b0:4a2:3953:7e43 with SMTP id b15-20020a0565120b8f00b004a239537e43mr4517786lfv.229.1668940592846;
        Sun, 20 Nov 2022 02:36:32 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u21-20020a196a15000000b00498f871f33fsm1497394lfu.86.2022.11.20.02.36.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 02:36:32 -0800 (PST)
Message-ID: <238f7bf8-578c-5bb4-9f00-50f36334c5cf@linaro.org>
Date:   Sun, 20 Nov 2022 11:36:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 02/14] dt-bindings: media: rkisp1: Add i.MX8MP ISP
 example
Content-Language: en-US
To:     Paul Elder <paul.elder@ideasonboard.com>
Cc:     linux-media@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Helen Koike <helen.koike@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221118093931.1284465-1-paul.elder@ideasonboard.com>
 <20221118093931.1284465-3-paul.elder@ideasonboard.com>
 <ca8a6070-3888-8d42-5974-d7c2adc62417@linaro.org>
 <Y3h93cLdEvMzInXe@pyrite.rasen.tech>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y3h93cLdEvMzInXe@pyrite.rasen.tech>
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

On 19/11/2022 07:55, Paul Elder wrote:
> On Fri, Nov 18, 2022 at 02:06:14PM +0100, Krzysztof Kozlowski wrote:
>> On 18/11/2022 10:39, Paul Elder wrote:
>>> From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>>
>>> Add an example to the rockchip-isp1 DT binding that showcases usage of
>>> the parallel input of the ISP, connected to the CSI-2 receiver internal
>>> to the i.MX8MP.
>>>
>>> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>
>> Missing SoB.
> 
> I don't quite understand. I see an SoB right there.

Laurent did not sent it. Did you run checkpatch before sending?

> 
>>
>>> ---
>>>  .../bindings/media/rockchip-isp1.yaml         | 72 +++++++++++++++++++
>>>  1 file changed, 72 insertions(+)
>>>
>>
>> I don't know what do you demonstrate there... usage of endpoints? That's
>> the only difference. Such usage is the same everywhere, nothing specific
> 
> I guess...? Doesn't the same argument apply against the px30 example too
> then?
> 
>> to this example. You already have two examples, so I don't think this
>> brings anything more.
> 
> We do have usage of this in imx8mp.dtsi and overlays for the ISP, but
> those patches haven't been sent/merged yet, so in the meantime I think
> there is value in providing an example here for the imx8mp.

The examples are not for demonstrating imx8mp or any other soc, but this
one given binding. Changing compatibles and few properties is not a
different example - from "exampleness" point of view it is very similar.

Best regards,
Krzysztof

