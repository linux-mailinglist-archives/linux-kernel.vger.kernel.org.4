Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C1D629CC8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiKOO7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKOO7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:59:04 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A1B1E3F9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:59:03 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id l8so17814244ljh.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HYHQt7itCTdM7tQOSkDoNSdG5hIzfOsUcZ1K9F1d7kA=;
        b=LtsVRkRE1USanAXoAUY0HXOCia6YZE6iTd+CQirhwunvmvRlEW6plP+M+7xV7+c1NU
         H9x+dfDPNkZ44zLwCsh5R8rIKIW/4RoJeWuCf/fCqC+aHiFdjCm6xpmR28RhEMzpHaG0
         TIt7GgjxJmTWRDnfC8I3iu7pVawIUuP8NNrxDHUEDdlz1xZXkvxS+0eIPhsHLRkBWUxG
         VTljnD+7H6uK/1t05D2GvVLdOY02hL0SUhnsw33VigEey0T3Bgl1EMEXqN5RuuNfmk1X
         Do8cu4B7K+L7x0tPxXpmgWskVpfgTtZ/Rk1MAUaUrP7qXiN9dTGjHqUHQWkHfQ0bKz9g
         znsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HYHQt7itCTdM7tQOSkDoNSdG5hIzfOsUcZ1K9F1d7kA=;
        b=HpjEyKuPJs5542WG/4fLyVg+0zZ94aVzfCX16bvnE+RGhfjZaD4rX7SDqKVI65cx3z
         2bJkVu3E8NBpCic3By3T0cKMemeNqsQ9FYGWTK0RmTNiQlS/XltXH/3E3Yb/fKMmJOwC
         gh08wKifPJoZ6nFwzfPbs0Kbquj+zQkZXpGJEEAh+HM5CqI+rGC/m7bqBF1/PxDNjR2l
         JVpHVZmjLMifDi0c+Ll4m9YiHtSGgECcUzvtQoZiJNyjsrYCMoibH75ePQe78dKPxH6t
         Kj8o+kVhAR9W4A9unHCtLTk2RX8sJDIEVoMb9ktxtXDRY4dP3DQAoVt6Km4LqosaunVA
         OTXg==
X-Gm-Message-State: ANoB5pnZZWT6n4mD7HyfYyzBMUVVDJDdHr8jqt+HuuzaA3XDaVtVrdfk
        GwrCdbEmL1kdlNTbBHFpLK/Wwg==
X-Google-Smtp-Source: AA0mqf6I+kq7LIwQ7yhfRgW226duI2RLRbLmoUqTaDpTnaJXSf412EiQOBpBpv+DuPqS3XN22Nlikg==
X-Received: by 2002:a2e:7217:0:b0:277:2f73:9f7a with SMTP id n23-20020a2e7217000000b002772f739f7amr5682701ljc.448.1668524341362;
        Tue, 15 Nov 2022 06:59:01 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id y20-20020ac24214000000b004b384ae61absm2235672lfh.198.2022.11.15.06.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 06:59:00 -0800 (PST)
Message-ID: <cca63c93-afd7-12ba-b73f-f7d28870074d@linaro.org>
Date:   Tue, 15 Nov 2022 15:58:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 6/7] ARM: dts: r9a06g032: Add the USBF controller node
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Herve Codina <herve.codina@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20221114111513.1436165-1-herve.codina@bootlin.com>
 <20221114111513.1436165-7-herve.codina@bootlin.com>
 <51d42fc2-0492-9077-302d-5c3be4b45cd1@linaro.org>
 <CAMuHMdUHEc6XYcdrcZ=H_wjBy4vFBTRjUDE2rRmGd+Jyg7BzDQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMuHMdUHEc6XYcdrcZ=H_wjBy4vFBTRjUDE2rRmGd+Jyg7BzDQ@mail.gmail.com>
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

On 15/11/2022 15:11, Geert Uytterhoeven wrote:
>>> +             udc: usb@4001e000 {
>>> +                     compatible = "renesas,r9a06g032-usbf", "renesas,rzn1-usbf";
>>> +                     reg = <0x4001e000 0x2000>;
>>> +                     interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
>>> +                     clocks = <&sysctrl R9A06G032_HCLK_USBF>,
>>> +                              <&sysctrl R9A06G032_HCLK_USBPM>;
>>> +                     clock-names = "hclkf", "hclkpm";
>>> +                     power-domains = <&sysctrl>;
>>> +                     status = "disabled";
>>
>> If you provided all resources (clocks, power domains etc), why disabling it?
> 
> Doesn't this depend on wiring on the board, and providing pin control
> in the board DTS?
> 

Yes, that could be the reason, so if this was the intention, it's fine.

Best regards,
Krzysztof

