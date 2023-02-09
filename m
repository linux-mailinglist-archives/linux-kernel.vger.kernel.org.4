Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01034691054
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjBISeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBISen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:34:43 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62C0301AF;
        Thu,  9 Feb 2023 10:34:41 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id cr22so3003102qtb.10;
        Thu, 09 Feb 2023 10:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=424ItKXECZ1vtWn5439ntytHd7BjZUN5BpgjEhecZg0=;
        b=b2A3abpTsaM+BigvT/lYo1hRes+4v11U9ZVu4kOk4vGeav74ECqm5ZUar2qmu0ll3c
         qssEcUvRAXYU/6y1fFl3sDmkD3G52Oj9ZtKXlIrASCQeA5A/2LpOfSx1hba5+RA30iYa
         Ghle0XguCD1Y32ozfxwvUrqyQRjaUdFtdHNEp+Q+2Fhpb2IJa+GdnhF7jDBktuLrNrCv
         +yaCKmvjFfzun9tdgwOiXBGf+cqTmxi3YRqPTr4iqwKI3umH55voa3J68+Z7HWegeHfu
         ClLFIwy/4eUoNwRZd9Vi/hWWCHONvgWHDRCVKB4kItob+RU9TFGhFtoiWDHUbc+B5P2I
         knCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=424ItKXECZ1vtWn5439ntytHd7BjZUN5BpgjEhecZg0=;
        b=ZVuwL0oZGdduzXSB9Kge5s4cDxqOioYkVUXaBPSubdnaRJphfKH+8H0xV1kHZIPAA5
         tOPTFeKpLSh3ltWYLlyXFGLt/AWTiN9felj4iRuyO8gLAEFmMFMaIMStmL4rRqRQzLC8
         DN0nZ2UVIAYiTnBSesPgBdJJUcJY13GERcsAGQDx+O7xT2yQHFEZ9dGeiJsF7uKflYV5
         iPa2XFenIKIRtjgfkgh6yCW2GU+F45617WCXygcQnKJW4nQpzgLnCuIYGLSYmr0xpyBB
         qGxOLwughZqnInEasnPZCYzr7nVLzgKQc8Mbrvgfe/1zWWw7xmzn3LT6vUKzUnmiY92N
         fi1w==
X-Gm-Message-State: AO0yUKXkUXNLUeLMZAeRo3FRpOMmUCyrszvkLkuGlcOKL2smyOL6jiMx
        ccC1ni7jmPbPlCLKlsmWgpY=
X-Google-Smtp-Source: AK7set/vVP11HlyoEy8Pew6HH8WQycG3ohLKBAXNCVgCHN48gAa8V+j0T/KQJfdoNe5Az2BuDEVUxg==
X-Received: by 2002:a05:622a:1344:b0:3b6:5d23:8748 with SMTP id w4-20020a05622a134400b003b65d238748mr21968000qtk.52.1675967680909;
        Thu, 09 Feb 2023 10:34:40 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id y13-20020a05622a164d00b003b860983973sm1760159qtj.60.2023.02.09.10.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 10:34:40 -0800 (PST)
Message-ID: <ac6591f3-0420-3cd0-28b5-8b2ea333d723@gmail.com>
Date:   Thu, 9 Feb 2023 10:34:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 00/15] spi: bcm63xx-hsspi: driver and doc updates
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        William Zhang <william.zhang@broadcom.com>
Cc:     kursad.oney@broadcom.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, dregan@mail.com,
        joel.peshkin@broadcom.com, jonas.gorski@gmail.com,
        tomer.yacoby@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230207065826.285013-1-william.zhang@broadcom.com>
 <167596308461.673456.2324521897149973878.b4-ty@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <167596308461.673456.2324521897149973878.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/23 09:18, Mark Brown wrote:
> On Mon, 06 Feb 2023 22:58:11 -0800, William Zhang wrote:
>> This patch series include the accumulative updates and fixes for the
>> driver from Broadcom. It also added a new driver for the updated SPI
>> controller found in the new BCMBCA SoC. The device tree document is
>> converted to yaml format and updated accordingly.
>>
>> Changes in v3:
>> - Clean up spi-controller.yaml and update the example
>> - Drop the generic compatible string brcm,bcmbca-hsspi from the document
>>    and dts files
>> - Port the cs_change and cs_off logic from SPI core
>>    spi_transfer_one_message function to both controller drivers.
>> - Factor dummy cs workaround into a function, adjust the logic for
>>    different xfer modes and fine tune message level in bcm63xx-hsspi
>>    controller driver
>> - Replace hard-coded opcode with SPINOR_OP definition
>> - Add a new patch to export export spi_transfer_cs_change_delay_exec
>>    function in the spi core
>> - Add a new patch to include compatible string brcm,bcmbca-hsspi-v1.0 in
>>    bcm63xx-hsspi controller driver
>> - Minor coding style fix in bcmbca-hsspi controller driver
>> - Add Acked-by and Reviewed-by tag
>>
>> [...]
> 
> Applied to
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> 
> Thanks!
> 
> [01/15] dt-bindings: spi: Convert bcm63xx-hsspi bindings to json-schema
>          commit: fff948a44b44a628c81294af5498226cb66a2594
> [02/15] dt-bindings: spi: Add bcmbca-hsspi controller support
>          commit: 0ba979f995324417fd773881bc5a39910a9f2362
> [03/15] ARM: dts: broadcom: bcmbca: Add spi controller node
>          (no commit info)
> [04/15] arm64: dts: broadcom: bcmbca: Add spi controller node
>          (no commit info)

Usually we have SoC maintainers pick up the DTS patches affecting the 
platforms they cover to avoid conflicts... I suppose that is fine.
-- 
Florian

