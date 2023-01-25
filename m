Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06DD67B270
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 13:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235431AbjAYMOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 07:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbjAYMOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 07:14:22 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D17166E8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 04:14:19 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id q8so13585197wmo.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 04:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p3nys00BAXBYiwkPm1qWggtJyjI8u/AjRoT72LZRkRU=;
        b=ZVkUD6ZsfOdwT9ueAomuqAq6ckxKvFI+FNbG63seRbFc+FzIk0DARAldY6bLh7DuLU
         OcX3GcXfIoCT1WRgUsfdjdE01Yfll8h6zZWmgquYzteJyytjVgVj1Ao5lF1GidDrVIoQ
         RadeCoe3YsOppWFVBBBMwJ295ZZJR1WdbMq/nCIjVfd53tlk0va2iLSRK2121KX62KRk
         YbY58y7TNycB0eBjbFVu88hIdnJJNX+OwjmLPO7gQXyzpSM4pz8cQUUMg6yW9ygHVWi7
         MYv9Ojc6FurrZFVPctnX/ug+LRvRsbb+d9uZlGCN8xM8dJhbM6OCjHRcFtIF8l9t0wwx
         z8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p3nys00BAXBYiwkPm1qWggtJyjI8u/AjRoT72LZRkRU=;
        b=TCmueqwQ39AzoB5BxIWEwsjGkDPpdyEZF4vqzfRGSY9lwe8m+/9Y1PhNApg4Pweezz
         TNA6lN5JglJDilZnpU9QOctDQyyIcqKy1e87OZE3pX3lDYqYJkkMKlaNjudNuMVKFVN2
         cr0AwsiTzSGBbtKsIhPHhM22OG/qYr5WhqwT2Qg1U/VhC2G9atv1lnVT7w4Nv8qqQovv
         nRR7Kid+mvPi638vx0CBj8mjCj4xoCxId/qIag0HvA2tLFVUgBSsTrd0EdfIIUOPTnoN
         z1H+rtkBAoy4aR61WpNwjeiapln8K9P2ciuhfirj/bWBhp7LseWOtKlDCNDAc3uxGBbk
         Sqzw==
X-Gm-Message-State: AFqh2krWurAhmoOGSfxh2V6ahyOaKCT+ogTjuhVYSeiJOuvNjJGy8alW
        7AvPPGdeoGT9bklggTneJ7seDg==
X-Google-Smtp-Source: AMrXdXu4XO41SKZ2KvFIecQPMaaaNXvLZ7JH/wi5RI0Pa1oaXDVqsVic9AH1ko1mJxWoPe5walX2mw==
X-Received: by 2002:a05:600c:1e08:b0:3da:f443:9f0f with SMTP id ay8-20020a05600c1e0800b003daf4439f0fmr31882547wmb.18.1674648858488;
        Wed, 25 Jan 2023 04:14:18 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f6-20020a05600c43c600b003db06224953sm1852874wmn.41.2023.01.25.04.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 04:14:18 -0800 (PST)
Message-ID: <ec9fc589-2612-3315-3550-83b68bead926@linaro.org>
Date:   Wed, 25 Jan 2023 13:14:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 07/15] dt-bindings: clock: Add Ambarella clock bindings
Content-Language: en-US
To:     Li Chen <me@linux.beauty>
Cc:     Li Chen <lchen@ambarella.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "moderated list:ARM/Ambarella SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <20230123073305.149940-1-lchen@ambarella.com>
 <20230123073305.149940-8-lchen@ambarella.com>
 <0c19efb4-3bca-f500-ca24-14b9d24369ef@linaro.org>
 <87y1prgdyu.wl-me@linux.beauty>
 <b26a52ff-6b8a-8a64-7189-346cd2b0d705@linaro.org>
 <87tu0ehl88.wl-me@linux.beauty>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <87tu0ehl88.wl-me@linux.beauty>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2023 13:06, Li Chen wrote:
>>> Feel free to correct me if you think this
>>> is not a good idea.
>>
>> This is bad idea. Compatibles should be specific. Devices should not use
>> syscons to poke other registers, unless strictly necessary, but have
>> strictly defined MMIO address space and use it.
> 
> Ok, I will convert syscon-based regmaps to SoC-specific compatibles and of_device_id->data.
> 
> But I have three questions:
> 
> 0. why syscon + offsets is a bad idea copared to specific compatibles?

Specific compatibles are a requirement. They are needed to match device
in exact way, not some generic and unspecific. The same with every other
interface, it must be specific to allow only correct usage.

It's of course different with generic fallbacks, but we do not talk
about them here...

> 1. when would it be a good idea to use syscon in device tree?

When your device needs to poke one or few registers from some
system-controller block.

> 2. syscon VS reg, which is preferred in device tree?

There is no such choice. Your DTS *must* describe the hardware. The
hardware description is for example clock controller which has its own
address space. If you now do not add clock controller's address space to
the clock controller, it is not a proper hardware description. The same
with every other property. If your device has interrupts, but you do not
add them, it is not correct description.

Best regards,
Krzysztof

