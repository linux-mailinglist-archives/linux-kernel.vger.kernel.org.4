Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B75671FFF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjAROpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjAROo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:44:27 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302D33803A
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:36:26 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso1521811wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B9RzjYW5fk/Pv3a3HT0wliwsWy33+IKdBWh16kmMlOY=;
        b=ZizAwzMJ8r5IBCHKVkV64U1DkWX/9+dcs0OKEw4xzRcg5ZyV2GjIfZ5s1orTp6malV
         XYr5zhFLgJzJpCoErqMJMLg1GmPxrOsMzfYWik+wbc/fHhivIWM1DfCsxCuokIw6kQAE
         DuL4qE50QGKGH+9s785iJh+QeDF6Q/7d8AFO+sz3obvxZHlaxnnpSoM/tZtGbgqxPTPz
         Zp2tdsCOt+lEgAj+kM7Pf+/b1MUemxduB+o/VlLWgicsAIO7FYT/rcg9Lm0yboOzEf6X
         /a4FSpYHaNpxmqoR1wr9dQluOgMeH9ZogxNi2/tk4SffOHlNXkNufB31BOXKL9/ndv2I
         y6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B9RzjYW5fk/Pv3a3HT0wliwsWy33+IKdBWh16kmMlOY=;
        b=RzmNh1CDy0eRrZFnR/xGIhhax45/QXqzuTZlQWtSD42m3Aso8hyCoPpE8251CYwZHP
         EqE+ZcgxgDvf0WMT9j3srAv1hwy2q3rzh8I+tg2AlAyLliLuBK/8dyRHfubw/TJsFywd
         viXBE4W/4tytjOJfE9nP/EtSNETZ4VYWGGOgv3/o26UI+9qJ+S8p5DoDhdsQ3vrLEn9R
         QvuvfgSmddpllYYAjYAmitfnUHARiLhsEyN96iW9yLozRF9doQFG8FovYCZ6Ayh9Ns+N
         ruRmGw+ZRJ54FCFwCLDQ6YzeDQUDLfcIS9O+sKWb1sx3Y6APIHCqnLcqWeDdKYpdAG2Z
         c+Gw==
X-Gm-Message-State: AFqh2kqZIPARGwdbYVvMchScYVh568ErBjQrs7scUQJZ/IDXiTZKmCOR
        JT/bSxZAddbj6K/xEtOJBGrlgA==
X-Google-Smtp-Source: AMrXdXv3rm4w4qd+juSMayNoVzWpZf80FG5xR65ajZGt6zR3QffnVS5q8qUVv9r1aV9r3BnIDH5DPw==
X-Received: by 2002:a05:600c:920:b0:3da:22a6:7b6b with SMTP id m32-20020a05600c092000b003da22a67b6bmr6905330wmp.13.1674052584806;
        Wed, 18 Jan 2023 06:36:24 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i18-20020a05600c355200b003d9df9e59c4sm2538588wmq.37.2023.01.18.06.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 06:36:24 -0800 (PST)
Message-ID: <063d98af-7b9b-c918-6436-5402265628fa@linaro.org>
Date:   Wed, 18 Jan 2023 15:36:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v4 12/17] arm64: dts: freescale: apalis-imx8: analogue
 audio comment
Content-Language: en-US
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
References: <20230118072656.18845-1-marcel@ziswiler.com>
 <20230118072656.18845-13-marcel@ziswiler.com>
 <de1da42c-2fed-4c89-4cbe-be764b2859de@linaro.org>
 <da7cf752c820e1c2cda5de4865c33d1b1e7247cf.camel@toradex.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <da7cf752c820e1c2cda5de4865c33d1b1e7247cf.camel@toradex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2023 15:33, Marcel Ziswiler wrote:
> On Wed, 2023-01-18 at 14:59 +0100, Krzysztof Kozlowski wrote:
>> On 18/01/2023 08:26, Marcel Ziswiler wrote:
>>> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>>>
>>> Added a comment about Apalis analogue audio being another todo.
>>>
>>> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>>
>> You just added this file in previous patch. This should be squashed
>> instead of splitting one logical change (adding new hardware) into
>> multiple independent patches.
> 
> Remember, I explicitly did that for review purpose and even mentioned this in the cover letter.

There is b4 diff for this purpose. Splitting patches makes them
difficult to apply and confuse.

Best regards,
Krzysztof

