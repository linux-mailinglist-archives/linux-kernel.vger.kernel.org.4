Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330AF6A1C76
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 13:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjBXMxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 07:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjBXMxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 07:53:36 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F81230B22
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 04:53:23 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id p18-20020a05600c359200b003dc57ea0dfeso2143061wmq.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 04:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B43T0AEPZJigOIS/UyBFbfsmEoemf/SiYcHZlZbArDU=;
        b=OGkN0CXJsVpWhKLUzO+2J2EP6C2ZwB2OfxpxnFiy9L1Ff+oeVtGaepYwATvJ1ZZ2pK
         hufBlMrsd5ufeluzrEuT2G6PrqLLHAaEj7ri3YUxeIxkHrE4IoovPC7ZgmmfsffFQqsU
         l8WMxxt1p91VeqyXKQpa+1NBGX/TvqdlWA1ebvxb9jJqb6nd7OETN5acxdOZrwT3LeJk
         AjMddVKub+kRR/yfFld6Vgb0sXEcu2Ij3T+7YWPVi+pE0jTucksi8gBObYgLYBoMHyP1
         kcctMIK+wi9WUWr86QW7tJUK09EBVwTMFmx2p4HG9FEJPMBfQ7KrVOifpmLjKTqhTveX
         stXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B43T0AEPZJigOIS/UyBFbfsmEoemf/SiYcHZlZbArDU=;
        b=0x9urYH09deE8ozas3IN+AzA8znO9ICk+wQ2RTrHY9W9PvY2n0dRaqJTIT2V2YENHe
         4MqFYDsbbxoZ02jvmx2BPN1cPlmhS8O37ndKV3Ooz/rTLLxI28EcJxI53WRCCPpfzqIh
         +/w35OzKfQb+bBPJwVeWQzIFA7hXjAt7KBZSAbrvccax3hVRFxpCYsk2HqMWMqvngmLz
         6f4A/D52F/HvZmDMI0sdEcitFfyXKvxT+TSc4+bwt6nrR2bB0xmC/orXRdJp11GDnuaq
         yxJpxXYqvPwwwHaW+WFUxPB8LigatM45KZNZnOUTIUm4ESiz1NpwfTxKs48ldFkTh8aJ
         RCXw==
X-Gm-Message-State: AO0yUKUeUIav7EJwMETo9nEbjDpPBQhnsezHLLndH/G3idggbMTZOSiF
        W+iQ/U+8jqjlh8D3tk4NV0AoDA==
X-Google-Smtp-Source: AK7set+9lbd6dHt3hcDH3Rll7jbmvT9hwcj+WcM08mZeJj4pNOSU1eN9J5AAw4Qd2Tb4Iivb4brDXw==
X-Received: by 2002:a05:600c:348f:b0:3ea:f132:63d8 with SMTP id a15-20020a05600c348f00b003eaf13263d8mr2323258wmq.5.1677243201812;
        Fri, 24 Feb 2023 04:53:21 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f5-20020a1c6a05000000b003dfe5190376sm2713538wmc.35.2023.02.24.04.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 04:53:21 -0800 (PST)
Message-ID: <9a25020c-de26-5c1d-f7ff-c2dbb38d3872@linaro.org>
Date:   Fri, 24 Feb 2023 13:53:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] ARM: dts: mvebu: add device tree for IIJ SA-W2
 appliance
Content-Language: en-US
To:     INAGAKI Hiroshi <musashino.open@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
References: <20230223132502.2045-1-musashino.open@gmail.com>
 <20230223132502.2045-2-musashino.open@gmail.com>
 <76395d89-1c56-12b2-b6f7-e77603019b70@linaro.org>
 <e9da7a1e-d48f-014b-a0a7-841c77feb12f@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e9da7a1e-d48f-014b-a0a7-841c77feb12f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/2023 13:28, INAGAKI Hiroshi wrote:

>>> +
>>> +/ {
>>> +	model = "IIJ SA-W2";
>>> +	compatible = "iij,sa-w2", "marvell,armada380";
>> It would be nice to start documenting the board compatibles, at least
>> for new boards.
> 
> So...how do I do that?

Start with something like this for Marvell:

https://lore.kernel.org/all/20230222203847.2664903-2-colin.foster@in-advantage.com/

But maybe someone already started it for Marvell? Marvell SoC
maintainers might help here to coordinate to avoid duplicated work.

Best regards,
Krzysztof

