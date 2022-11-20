Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FBC631358
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 11:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiKTKer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 05:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiKTKep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 05:34:45 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C19A7D50D
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 02:34:44 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id j4so14968345lfk.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 02:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8D4BClPP9qrwATF1t4nCunXzUqHb8yDxaV0KlH+7vLs=;
        b=ngHAa6H5aYEfS3vMjANdUuM9RsJdWy9RmqP1HxGhiDlqZzHX3bMuK5JHG7yjhKHMU9
         41+DdKziUR4qZ0Jg2m6OxkucZzaC/z2rTF2766hh1O4sxASm9sHaaZup8FvZVV9IaHdc
         ObKMgReB3Ym325bcng3X/NNJXvSs4oJz9QymH9VVmZf0CeGfE+CqVop6efX552xJuiNN
         lV/XAtAsIcsyDwObFzlyrXidYxHA0If1H2ZiPZurHoTek8gXD+7wR2kvRQgb29vRj+jd
         WCcNeu9OJ7ehepkL3CUw+x+t4Ccka9BkJdI8Q/6HpFA3SohZd6OarmGaUZEnQU8lB4Ez
         x/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8D4BClPP9qrwATF1t4nCunXzUqHb8yDxaV0KlH+7vLs=;
        b=up7AKg4CRzt3JKiAnCt/9SxUOhsqFXHEflRDnO3vB0g5TxvBGbaVfgNVtf9Kaswcqm
         b9KgqCct5YjUjYkqHnSMJUD5zdj6cwUaX6rraVhvNRfnorwKyE8CWN/ph7moOTv7HRpU
         zLNTX9kZxmU29Gu5inAaJ7CE8Vih6uyhuWVUPTU9vlr8p9JdKl4gOoIM0rMCuN7Xz6Fk
         U/vddq9xlKU4x/1Kz4/roe5vcLE9AxoibYepcLJ+zqmzWBYgYP0bV2PDSyCteph2IYOV
         HDLlme1RDHJbWqMSm/KAu2VfwhwUNT5aBX9NVEjLIrm5uST6Vea9sypngcGBNBhbuc8R
         YlSQ==
X-Gm-Message-State: ANoB5plhNmEY6DbCMEkNl3VguO4Y4UYAIXuzjRzPHq+h8qhwQVssme9B
        qjCE/PyNtAEdEiUtt6R7ZhKGOA==
X-Google-Smtp-Source: AA0mqf7o759OuxPpc1jEao2vB98NHQHMxY3bsLWqPy3t+QLguIdEiBC/oMg307GKo5mtBXonCmHJYA==
X-Received: by 2002:a19:ca0b:0:b0:4b1:7972:627a with SMTP id a11-20020a19ca0b000000b004b17972627amr4266924lfg.101.1668940482960;
        Sun, 20 Nov 2022 02:34:42 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id i5-20020a0565123e0500b004978e51b691sm1491759lfv.266.2022.11.20.02.34.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 02:34:42 -0800 (PST)
Message-ID: <7ab50a13-9711-2d77-ff47-ad4c2d9b4faf@linaro.org>
Date:   Sun, 20 Nov 2022 11:34:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 02/14] dt-bindings: media: rkisp1: Add i.MX8MP ISP
 example
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Paul Elder <paul.elder@ideasonboard.com>,
        linux-media@vger.kernel.org, Dafna Hirschfeld <dafna@fastmail.com>,
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
 <Y3kLZ6nQ1VzN+2eu@pendragon.ideasonboard.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y3kLZ6nQ1VzN+2eu@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/2022 17:59, Laurent Pinchart wrote:
> Hi Krzysztof,
> 
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
>>
>>> ---
>>>  .../bindings/media/rockchip-isp1.yaml         | 72 +++++++++++++++++++
>>>  1 file changed, 72 insertions(+)
>>>
>>
>> I don't know what do you demonstrate there... usage of endpoints? That's
>> the only difference. Such usage is the same everywhere, nothing specific
>> to this example. You already have two examples, so I don't think this
>> brings anything more.
> 
> The i.MX8MP is the only SoC integrating this ISP (and supported in
> mainlineà that has an external CSI-2 receiver, as opposed to using the
> CSI-2 receiver from the ISP. This patch this showcases the DT
> integration for that use case. If you think it's not worth it, I'm fine
> dropping it.

The purpose of examples are not to demonstrate the SoC, but only this
given binding.
> 

Best regards,
Krzysztof

