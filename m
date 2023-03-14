Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5186B9EB7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjCNShh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjCNShe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:37:34 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902E0B6D14
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:36:52 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ek18so34734725edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678818964;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vU8ewe7YUx76dQmc2DDXv3uelHQa9W6P/2AW1+JtsIg=;
        b=DllDgqSggOF6tAhFlRa0vuEX9QjanXxfCADZtVDo6N4f93Av5mqicAkX/ppXGOCXjM
         xVasNMV1pm4I/loFktos3KKvMzoGHhaSwWY1srrzt5nblohxfpz1HgUvjhdEIDgDeqLT
         PTPCP6LNGkMh7KzCp5n4eeGrdcbo9SvzZmLF/nXheYH5f7EZpmicz1dBY8Hte1vS/kIt
         kEJ/EwXIyl9NtwBVuVfHR6vUXsd5Ua8EdO3n2bAij28QUVoQSdnc5xO90dB9PMc/kmd9
         X4Dj0+o1HzuYIbowvoO03I8AHiR2MEfaumMdemm2VcV8XC3S6gRFzy7TA8bJ5DK3/pu+
         us+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678818964;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vU8ewe7YUx76dQmc2DDXv3uelHQa9W6P/2AW1+JtsIg=;
        b=KGu7eB7FC2wkImhxGzJe7gfo0a3ZwSWSwvVVzDGSTGq8/KXNppOHGmuKVDihO/dwS2
         nr3v8Y82kIgtYTlsJZkpKMJuGG6ymBcAL43q5QKRY4QoMHkCOHlrK2ldAe0m5Br7RH9f
         kEVFshuCiKkRgSFMPwBWDmsFzJ+zFZ7ebQ5Ao1vrIKqMaFTWnDVRQFGhCbn5gkVvKKRK
         aAl/2fOHs+3B6p2E639a1FhCLAuQWZNe8hzX9Dn25qCkpW2JwvlusCGG/xwaKeKtMKSR
         XBc1GtOaLbZgjmgVg0U3XqtGpjVFF1sd9sZ0FZKDeo3f4eKqwKXZOYWUGFLg6eGoFzqR
         jxDg==
X-Gm-Message-State: AO0yUKWlEJaQmrpFOMfcaNk5rH0EuKlZRhDRORnHLkGh7gmAlQSAf7jC
        vxonQ5C2wNhma4VfdskjTZEdig==
X-Google-Smtp-Source: AK7set8nWGXtmYI4avqOXTLg2T/X56lvI43BlpZyPq/vx0/8/n4Yaonioo8LqlfKUTl96zb8rIyDvw==
X-Received: by 2002:a17:906:3714:b0:92b:4f8e:dde1 with SMTP id d20-20020a170906371400b0092b4f8edde1mr3711409ejc.20.1678818964709;
        Tue, 14 Mar 2023 11:36:04 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:59be:4b3f:994b:e78c? ([2a02:810d:15c0:828:59be:4b3f:994b:e78c])
        by smtp.gmail.com with ESMTPSA id qx15-20020a170906fccf00b008e772c97db6sm1468894ejb.128.2023.03.14.11.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 11:36:04 -0700 (PDT)
Message-ID: <0d13bcfe-6234-4102-c32f-5d175c0df10c@linaro.org>
Date:   Tue, 14 Mar 2023 19:36:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] media: dt-bindings: ov2685: convert to dtschema
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-media@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        phone-devel@vger.kernel.org,
        Helen Koike <helen.koike@collabora.com>
References: <20230206-ov2685-dtschema-v1-1-9e4da3474c10@z3ntu.xyz>
 <2665862.mvXUDI8C0e@z3ntu.xyz> <ZBBh9Euor7R24euV@valkosipuli.retiisi.eu>
 <5654018.DvuYhMxLoT@z3ntu.xyz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5654018.DvuYhMxLoT@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2023 19:33, Luca Weiss wrote:
>>>> ia/i2c/ovti,ov2685.yaml
>>>
>>> Looks like rockchip-isp1.yaml uses very incomplete sensor examples in
>>> their
>>> binding example, which sort of makes sense since those bindings are
>>> showing
>>> the rockchip isp bindings and contain the bare minimum to show how a
>>> sensor is connected in dt.
>>>
>>> Not sure how to solve this - ov2685 is also one of three sensors that are
>>> used very abbreviated there.
>>
>> Could these regulators be simply made optional?
> 
> Sure, from driver side it would just get dummy regulators instead.
> 
> Still the clocks are also missing in this rockchip example. Any suggestion 
> what to do about those?
> 
> Honestly I don't want to spend too much time on some ISP docs that I don't 
> really care about, would be nice if the maintainers of that could do that...

In perfect world, the bindings describe the hardware and if hardware
requires supply or clock to operate, then it should be required in the
binding. If some other DTS do not validate - their problem...

In practice, we make tradeoffs. But is it the case here? The binding was
always requiring supplies and clocks, so there is no reason to make
supplies optional. Unless you know the device and they are really optional.

Best regards,
Krzysztof

