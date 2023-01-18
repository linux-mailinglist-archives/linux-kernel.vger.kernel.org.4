Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71135672702
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjARScW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjARScU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:32:20 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEBA599A9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:32:15 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id q10-20020a1cf30a000000b003db0edfdb74so1626918wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MDOMgu1R5MZdFuG1WoMkXEWXWPDB9V7oXEVPOSPFqMk=;
        b=WHaUr7JkLqMIDHA/hXsqBjkSWmDZFiUxCHf2dftPrBezsoW+dLizp4JrGqrPYf3WLl
         JOm5jBVrjlBDqw5Ha/qcs+r/dwUOKQCzYpcjU/p04GEBOccP9SeLIz6EDm/vLWbo8tBW
         hhP3cVm1n6WGcDMAyMBWpQlW8F1PpQp5l0Qpge5N4cUjxUm/ty47jo8J4zHUcSvJ5vOA
         uCzsdRdwwtJTcc2fW7Pg6xl1CgeYurWytPgfrvv3PGxI3FiNCLWGc9M0i6VWbXlKpWUX
         S5zfo7sem5bmk2tW1QoVf3Swfgrwvtg28GBXWO3v/IVC9sjGqgTrpxoDQVkt1cLUwWeA
         FL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MDOMgu1R5MZdFuG1WoMkXEWXWPDB9V7oXEVPOSPFqMk=;
        b=EAmuvrUX0wRYOZcridWOmNMXAwSRi8ok31kYcKObS6aqywLHgTsFCQH7jJ2EcuDHEm
         V+ZwLJi41o2wH4blkVUqmOFZphos9XE45aWI/izRYlwy9ByN51vSAeO8dPBXJMeJ36+q
         02S64G7XP98fr1+3tAk9oJN3xkCdV+9QV2bxcKLb2j+jz2RdoIYyG8ckpjlJB/t64z/R
         /PcCxW9noRDFJMxQ5MTyhhiciORAQliRLCjsPmhG+BsYj7wbDijCx7U8J0bz/sIp97vc
         yDyeH/43U5lCkYdiWWfjOluC7/Jo9GHxIaV47bQNbWjrsOR5KyDFNqxx6xHd2/LlDBop
         Xmkw==
X-Gm-Message-State: AFqh2krdGaJZ9knQe3HLqRdbVJp5VmwSrtzZP65x5Hwf0H4zsx0GCkJ8
        tsz18MK74jjXXuLNSJ0Wrb8/FQ==
X-Google-Smtp-Source: AMrXdXtdP5gAkiej7sOvZztosqeKCQeZenZx5m8n552mmlJwQ5zMJxYUgthGWLC97j6Vtmg0xkfOIw==
X-Received: by 2002:a05:600c:214f:b0:3d9:ecae:84f2 with SMTP id v15-20020a05600c214f00b003d9ecae84f2mr7409139wml.25.1674066734461;
        Wed, 18 Jan 2023 10:32:14 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id bg1-20020a05600c3c8100b003db09eaddb5sm2270616wmb.3.2023.01.18.10.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 10:32:13 -0800 (PST)
Message-ID: <a60e7f50-c39f-07e5-7238-e3a4031b45a4@linaro.org>
Date:   Wed, 18 Jan 2023 19:32:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v1 1/4] dt-bindings: gpio: rockchip,gpio-bank: add
 compatible string per SoC
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, Rob Herring <robh@kernel.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kever.yang@rock-chips.com, sjg@chromium.org,
        philipp.tomsich@vrull.eu
References: <08de3f4b-e33f-95c8-3297-814ea107272a@gmail.com>
 <20230118153236.GA33699-robh@kernel.org>
 <f624fcf3-f8f1-68c0-eab0-43bcda3cbe90@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f624fcf3-f8f1-68c0-eab0-43bcda3cbe90@gmail.com>
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

On 18/01/2023 18:12, Johan Jonker wrote:
> 
> 
> On 1/18/23 16:32, Rob Herring wrote:
>> On Wed, Jan 18, 2023 at 01:13:23PM +0100, Johan Jonker wrote:
>>> Currently all Rockchip gpio nodes have the same compatible.
>>> Replace all the compatibles in gpio nodes to be able to
>>> give them a consistent ID independent from probe order or alias.
>>
>> I fail to see how the compatible change affects probe order or aliases. 
>> It is also an ABI break if there is not the existing compatible as a 
>> fallback. State the problem you are trying to solve with this change, 
>> not just what your solution is.
> 
> Hi Rob,
> 
> Since the yaml conversion of rockchip,gpio-bank.yaml we have generic "gpio" names instead of "gpio-1".
> For both Linux and U-boot there's a need for a consisted ID order between the nodes.

Still do not see how compatible is related to this.

> 
> The kernel has no logic to decide between the first compatible and the fallback.
> A fallback doesn't have ability to add/select "data" with probe, but have to use
> of_device_is_compatible(np, "rockchip,rk3188-gpio-bank") for  "15"  SoCs instead.
> 
> I can produce a serie with fall back.
> Let us know how to move forward here.
> 
> Kind regards,
> 
> Johan Jonker
> 
> 
> ===
> Linux driver behavior:
> 
> 	id = of_alias_get_id(np, "gpio");
> 	if (id < 0)
> 		id = gpio++;
> 
> Problems:
> Alias not always available in existing DT files(not part of the binding)
> Probe order is not guarantied and possible number gap for rk3066a between gpio4 and gpio6.
> (id counter gives not consistent result)

Again, how compatible is related to this?

> 
> ===
> U-boot rk_gpio.c current behavior:
> 
> 	end = strrchr(dev->name, '@');
> 	priv->bank = trailing_strtoln(dev->name, end);
> 	priv->name[0] = 'A' + priv->bank;
> 	uc_priv->bank_name = priv->name;
> 
> Problems:
> Crash when node name has no "gpio-1" format
> 
> U-boot rk-gpio proposed: 
> 
> 	priv->name[0] = 'A' + dev_seq(dev);
> 	uc_priv->bank_name = priv->name;
> 
> Problems:
> Reduced FDT's and rk3066a gives number gaps.
> 
> ===
> 
> My proposal:
> 
> struct lookup_table rk_gpio_rk3188_data[] = {
> 	{0x2000a000, "A"},
> 	{0x2003c000, "B"},
> 	{0x2003e000, "C"},
> 	{0x20080000, "D"},
> };
> 
> 	{ .compatible = "rockchip,rk3188-gpio-bank", .data = &rk_gpio_rk3188_data },

Which you did not do... Your patch is doing something entirely else.

Best regards,
Krzysztof

