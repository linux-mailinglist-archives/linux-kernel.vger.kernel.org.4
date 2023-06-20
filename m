Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5164A736604
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 10:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjFTIXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 04:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjFTIXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 04:23:52 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C89DDD;
        Tue, 20 Jun 2023 01:23:50 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f866a3d8e4so3778093e87.0;
        Tue, 20 Jun 2023 01:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687249427; x=1689841427;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oSwcddgL+qqUejqCx92zoa7QNLnR9PVFOH6496qT1bw=;
        b=ldU4s8X0AvhotU7qiojJNp+Zyd5E/gkMCSAC5LGEWmGIEFUzYY5v+Cvc/Z2h5lQJQ/
         5AIWdvY58f2TEDyyIyC5BdS+Gi2dyam95EHa87vlUmJyK0FkWnFhRZqT/XqzBB6XbcC2
         7S6f2C68/MpmjNiT6z/5TLkAoU4uF+Sk22TlT2u9b0B85dOT0R58eBu4TWtCpYVLfQyD
         SY8OwSXxoMjDDbn+vvyZo5bbo0wndOMDx0N2rM9eelbNGuZ46IMgpwsF2APvJR0Go218
         B2R7vx2SWb9qDi5huSwrk13Su/Pja43HqfmY9o+2vY8Su27BRtu07y+gvjrNjjrTJvfe
         ikBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687249427; x=1689841427;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oSwcddgL+qqUejqCx92zoa7QNLnR9PVFOH6496qT1bw=;
        b=gTa0QX1GG+xon6YOQ4pwWcx8Xt7GeJHh66CB7ickcw3mBFl64EIz7Hxs7mdFOx38jd
         O5SHRJTZRGaHB9r1Bn0KBSmf5nE3+7vdAS9FwYj3p4PPAaf5nXqHFymhJzAMwEtT6JDc
         O40ZWYR76gVO6qk/+PHKhO4yrbOmUShry3sTWBvdXoeIFDuKTVbnFjuOJI3mxUM8veXH
         kqG8lH5aWGEVZRw05lzN8c65ossmOvqxJwFtruhh9oS9nixCvG3MAmbiZ1qoQi0E37Fz
         xrS+sjvHVbKSETSrYenOnxgpP9RQFKq0tnBaGwZqmQUJ3wAdwu/D/2G+scvuFNzfsKoA
         Jp0g==
X-Gm-Message-State: AC+VfDzF7UJgLBbzYx9nnXLVkQZR+0fD3yRj6lcdMehZ/8BU4csdtkua
        TAi+HqeMhzPHuhvNZ1UP916AbpkmU5E=
X-Google-Smtp-Source: ACHHUZ7s9r7oSraIVDZp9gPsA4qLQ2GMBsLV5uM/r7udlvpeLyf7L6ZkgYnTsyzazxEGlPBGqe/wMw==
X-Received: by 2002:a19:e001:0:b0:4f8:66e1:14e8 with SMTP id x1-20020a19e001000000b004f866e114e8mr4675950lfg.69.1687249426418;
        Tue, 20 Jun 2023 01:23:46 -0700 (PDT)
Received: from [192.168.2.145] (109-252-154-132.dynamic.spd-mgts.ru. [109.252.154.132])
        by smtp.googlemail.com with ESMTPSA id w5-20020ac254a5000000b004f3b319ed4bsm270518lfk.120.2023.06.20.01.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 01:23:45 -0700 (PDT)
Message-ID: <b50a7438-1c7c-bc54-a6e7-0ef1caa31a16@gmail.com>
Date:   Tue, 20 Jun 2023 11:23:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 2/2] misc: sram: Generate unique names for subpools
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230417-ux500-sram-v2-0-6e62ad551faa@linaro.org>
 <20230417-ux500-sram-v2-2-6e62ad551faa@linaro.org>
 <e41ff013-8224-1b96-5cd3-f0632d27191d@gmail.com>
 <CACRpkdagHDUz4P0Z81ZqyhJD97gfn=p1=fx1dwKTrO8J3zkPrw@mail.gmail.com>
Content-Language: en-US
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <CACRpkdagHDUz4P0Z81ZqyhJD97gfn=p1=fx1dwKTrO8J3zkPrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

19.06.2023 10:11, Linus Walleij пишет:
> On Sun, Jun 18, 2023 at 11:33 PM Dmitry Osipenko <digetx@gmail.com> wrote:
> 
>>>                       if (!label)
>>> -                             label = child->name;
>>> -
>>> -                     block->label = devm_kstrdup(sram->dev,
>>> -                                                 label, GFP_KERNEL);
>>> +                             block->label = devm_kasprintf(sram->dev, GFP_KERNEL,
>>> +                                                           "%s", dev_name(sram->dev));
>>
>> This broke device-trees that have no label property.
> 
> Which system is affected? Asking so I can inspect the DTS file
> and figure out how this needs to work.

NVIDIA Tegra2/3 video decoder driver fails to probe with this change.

https://elixir.bootlin.com/linux/latest/source/drivers/media/platform/nvidia/tegra-vde/vde.c#L312

https://elixir.bootlin.com/linux/latest/source/arch/arm/boot/dts/tegra20.dtsi#L347

>>  The SRAM DT binding says:
>>
>> "
>> label:
>> description:
>>         The name for the reserved partition, if omitted, the label is taken
>>         from the node name excluding the unit address.
>> "
>>
>> Not sure whether breakage was on purpose, otherwise doc needs to be
>> updated or there should be explicit check for the duplicated node names.
>>
>> Secondly, AFAICS, the dev_name(sram->dev) is the name of the parent SRAM
>> device and not of the children sub-nodes, hence it's now always the same
>> dev_name(sram->dev) for all sub-nodes.
> 
> Sounds like I should go back to the original approach in patch v1:
> https://lore.kernel.org/linux-devicetree/20230417-ux500-sram-v1-2-5924988bb835@linaro.org/
> 
> and also augment the DTS binding text to say it uses the full node name
> including the address.
> 
> Does that look OK to you, or will this regress your system as well?

That may work, but then seems you'll also need to update
of_gen_pool_get() to use np_pool->full_name instead of np_pool->name.

https://elixir.bootlin.com/linux/latest/source/lib/genalloc.c#L898

