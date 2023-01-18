Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6417167248C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjARRMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjARRMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:12:33 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3956256EE0;
        Wed, 18 Jan 2023 09:12:32 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id bk15so27368677ejb.9;
        Wed, 18 Jan 2023 09:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TSqHeiPg445FTYU+12Cfi8M5vyG4aei2V8sKE7XRXUg=;
        b=lY/JCaGJUPV5uWawP1aJnQI0yK0dF8yAAOjzPOSVhkofmd+c2D+3aqiGyeBd2xAdgy
         quJ7zgi91QqHv0fXLs+VXV+LiZhZ+VqB1sOWxU11yFTf4xJMe/O7aJ4S096JjIjc9v3Z
         WwxBHk5+bjaYG6mQUwPSo7OwZWlAI+NF/gPTyd4Qipnzq+NPuFHtBRz0qHkj4D1pB8Kx
         FbIFDJ6XqixSPf8B59sOIhSdl4GgPS2o3AyfdlaA0nQSIr4DCa60xbahHCXA/Rs/G9LU
         9f/PpblwA1QDt2AYcr5vSfslcqpjiJtbLzrGvpTqbMEeZ8IDsMNR6sqChmgbWvydRri1
         +o+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TSqHeiPg445FTYU+12Cfi8M5vyG4aei2V8sKE7XRXUg=;
        b=z1U6qJ4qUICFMolCeeyYvIiwwpivXHKZEHk9xuabZw27I2/wLVt7JY+lLvrsXl0Gtr
         ScdvCmANeQfA18voEtuKJi2JKz6CPJl847yM8SiUzoLabGkKu+K1u1hbOX8+e49cS4+r
         nWcy4+I0DR1HvLxoXLaUzmjs5q5f4OujwS8aAHUFSACDn96/vNjtwvFpRnuGM9ZFA9Q4
         Q1U9U7ERwAG0FXyGpSUiwApQdUezgPmujgn1mBpQWiPbjy6J5vt7bpgH4JkU9q+oIK/Q
         gWFoJ6+HzQjjrqHweKabRuFs5Y2gTUunQQGr0bSbKrjra1BX8JA6UpC4Y120VPd7kY31
         xUuQ==
X-Gm-Message-State: AFqh2kptBEykoQgWyT4v/BuaYQ+bzi3PsKzfKABz0+BUZ8u3rFIxFkD7
        10B9PY5JSslpoh+Tsumm33U=
X-Google-Smtp-Source: AMrXdXsQ5zjMfW51P4D6BEYdSqcJGv6m0Wfy377/gQMr+nFfipIAGkyxbuzQOsQP+/cyzlyjwMeVlw==
X-Received: by 2002:a17:907:c017:b0:840:c37d:b5e4 with SMTP id ss23-20020a170907c01700b00840c37db5e4mr9070990ejc.16.1674061950703;
        Wed, 18 Jan 2023 09:12:30 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id et21-20020a170907295500b00871f66bf354sm3266487ejc.204.2023.01.18.09.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 09:12:30 -0800 (PST)
Message-ID: <f624fcf3-f8f1-68c0-eab0-43bcda3cbe90@gmail.com>
Date:   Wed, 18 Jan 2023 18:12:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 1/4] dt-bindings: gpio: rockchip,gpio-bank: add
 compatible string per SoC
To:     Rob Herring <robh@kernel.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kever.yang@rock-chips.com, sjg@chromium.org,
        philipp.tomsich@vrull.eu
References: <08de3f4b-e33f-95c8-3297-814ea107272a@gmail.com>
 <20230118153236.GA33699-robh@kernel.org>
Content-Language: en-US
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20230118153236.GA33699-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/23 16:32, Rob Herring wrote:
> On Wed, Jan 18, 2023 at 01:13:23PM +0100, Johan Jonker wrote:
>> Currently all Rockchip gpio nodes have the same compatible.
>> Replace all the compatibles in gpio nodes to be able to
>> give them a consistent ID independent from probe order or alias.
> 
> I fail to see how the compatible change affects probe order or aliases. 
> It is also an ABI break if there is not the existing compatible as a 
> fallback. State the problem you are trying to solve with this change, 
> not just what your solution is.

Hi Rob,

Since the yaml conversion of rockchip,gpio-bank.yaml we have generic "gpio" names instead of "gpio-1".
For both Linux and U-boot there's a need for a consisted ID order between the nodes.

The kernel has no logic to decide between the first compatible and the fallback.
A fallback doesn't have ability to add/select "data" with probe, but have to use
of_device_is_compatible(np, "rockchip,rk3188-gpio-bank") for  "15"  SoCs instead.

I can produce a serie with fall back.
Let us know how to move forward here.

Kind regards,

Johan Jonker


===
Linux driver behavior:

	id = of_alias_get_id(np, "gpio");
	if (id < 0)
		id = gpio++;

Problems:
Alias not always available in existing DT files(not part of the binding)
Probe order is not guarantied and possible number gap for rk3066a between gpio4 and gpio6.
(id counter gives not consistent result)

===
U-boot rk_gpio.c current behavior:

	end = strrchr(dev->name, '@');
	priv->bank = trailing_strtoln(dev->name, end);
	priv->name[0] = 'A' + priv->bank;
	uc_priv->bank_name = priv->name;

Problems:
Crash when node name has no "gpio-1" format

U-boot rk-gpio proposed: 

	priv->name[0] = 'A' + dev_seq(dev);
	uc_priv->bank_name = priv->name;

Problems:
Reduced FDT's and rk3066a gives number gaps.

===

My proposal:

struct lookup_table rk_gpio_rk3188_data[] = {
	{0x2000a000, "A"},
	{0x2003c000, "B"},
	{0x2003e000, "C"},
	{0x20080000, "D"},
};

	{ .compatible = "rockchip,rk3188-gpio-bank", .data = &rk_gpio_rk3188_data },

===


See links for previous discussions:

[PATCH v1] arm: dts: rockchip: sync rk3066/rk3188 DT files from linux-next v6.2-rc4 Johan Jonker
https://lore.kernel.org/linux-rockchip/6ec4427e-f56f-7545-2296-bc75d74f4364@theobroma-systems.com/T/#t

[PATCH 1/3] arm64: dts: rk3399: sync rk3399.dtsi from 6.1-rc1 Peter Robinson
https://lore.kernel.org/u-boot/0ab9a600-b517-0ce5-d189-99fc8eddfa60@theobroma-systems.com/

[PATCH/RFC] rockchip: derive GPIO bank from alias if available John Keeping
https://lore.kernel.org/u-boot/CAPnjgZ3j7YVJt+B-uEKS_rsSRBSR-kmyLujV3RozL7kbFNrqFw@mail.gmail.com/

[PATCH] rockchip: derive GPIO bank from alias if available John Keeping
https://lore.kernel.org/u-boot/Y8gaqasu9ho0vl8X@donbot/T/#m00e3823cf74d35a7c8536a1193ed1a77c7698135

Broken U-boot gpio driver:
https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/gpio/rk_gpio.c#L154-L157

> 
> GPIO shouldn't really have an alias either IMO.
> 
> Rob
