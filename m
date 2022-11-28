Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946F663A368
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 09:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiK1Is2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 03:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiK1IsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 03:48:25 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82393E1C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 00:48:24 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id a7so12290435ljq.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 00:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DyUL1Og+jo/ZDOoPr1xJAw3+yzTWwfhyA3J40qaa04Q=;
        b=dr+YzF1C/E9DNwFAV4PvvIjJxwtxMPOZ6crnVboKYsr67l1ag6YTekN1wmi5vfztZd
         SfAt7DZLkzNlycNIzmURTmrED9EUMQ7BHBDOJT3ToK5KRJJyitHn8e/dqEizbz1JYgk5
         wDHmyCOIqGC5xPYaG/H5oBbns2FWIat46Xp0IQSLDQwAkecQ47Wh11gTfhCP+KJTs54n
         HatiPP6UXkG0Vekho88t3Sm+YogWgFkwVvgLvYVvx7QVJohTv4KsMGM0XTzYPKC8P9lh
         6F8zCM77yxVV4lRlljET+W80ArkhgPNhXKSlx0fiGzP39zxvD9bnycHiSyw1JmPEnZbN
         6lXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DyUL1Og+jo/ZDOoPr1xJAw3+yzTWwfhyA3J40qaa04Q=;
        b=D4/IlNgCb9Pbzx4LV2UYGOgX7Zjeg943PX0RNnimHLqzpKbveqxCnRRzDfXkuTgnpk
         2Va6bVR7k4fQAiDOunQZ3VIfR6SI1hbIhJVHnJfmUgX/W+C3yxq3PARLB6DhYSqAVy4+
         Xx4l9mhvRHtTtCc8ABDInk4G3q61E1PRI55I4fwic5pcyauaJXUgs0IKW9bKdVuZsuy9
         KfquN68e5en+3R1tMhpJo2VuLbnYhpNkRkwz+FFFfCy88/+qTmdmc503so0IomxokMzw
         Iy0oKSWkjltPyP96MwRrS2BpoojAV7Zo8sA/BcYLwGQQ/hyXpElLuLAAZeIH7ysJORo4
         vYaw==
X-Gm-Message-State: ANoB5pkk4GInEKv4jR3fbNGhZTOYKJSVKovgaS1OMMQBnMhiM/UBRPWn
        UmBbMRdJBgz1GWmqcCGFdi28Ow==
X-Google-Smtp-Source: AA0mqf6Emtt2xBvkwqUH0D6tAfeP1i9Zs/1xVxKY56Q42DNsjCvlHvNu8pLcBLZD7SKHBjNDZ9j+bQ==
X-Received: by 2002:a2e:8619:0:b0:279:88ce:468f with SMTP id a25-20020a2e8619000000b0027988ce468fmr6244869lji.312.1669625302909;
        Mon, 28 Nov 2022 00:48:22 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v3-20020a2e9243000000b002770eafaafbsm1161654ljg.99.2022.11.28.00.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 00:48:22 -0800 (PST)
Message-ID: <0e07745c-7bf8-ef1b-5ac9-6fc40031d7b6@linaro.org>
Date:   Mon, 28 Nov 2022 09:48:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 5/6] dt-bindings: arm: sunxi: add Rongpin RP-H6B board
Content-Language: en-US
To:     Icenowy Zheng <uwu@icenowy.me>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20221127073140.2093897-1-uwu@icenowy.me>
 <20221127073140.2093897-6-uwu@icenowy.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221127073140.2093897-6-uwu@icenowy.me>
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

On 27/11/2022 08:31, Icenowy Zheng wrote:
> Rongpin RP-H6B is a development board with RP-H6C SoM, which uses an
> Allwinner H6 SoC.
> 
> Add compatible strings for it, including the board-specific compatible
> and the SoM compatible.
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

