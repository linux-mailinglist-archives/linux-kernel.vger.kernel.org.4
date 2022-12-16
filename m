Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D33864EA69
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 12:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiLPL31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 06:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiLPL3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 06:29:25 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B415B5AA;
        Fri, 16 Dec 2022 03:29:24 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id i187-20020a1c3bc4000000b003d1e906ca23so979240wma.3;
        Fri, 16 Dec 2022 03:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GpaZuAjuThZlRnxKVIKAQ0qtHdJgyrsxdPIII0CXp90=;
        b=mtPEMKQHC49rkYm08SN7j+aZwE8oH/Dfcl0zxcEud0XrB9fRQY8dX8IcspXsHJId6n
         kWEXzbqtkYKTFLxjBX8o+I4YntjcX/ZjlAw/zpZ7Zdqku6PiWDARV4Oeba/tqCHMqz3V
         9sDZYIP5TAGVL7oz9KzO6lQbYnM9j8KYANcD+mgCqJIVUY3a7U6V/5tWaN5r9f3+ub9Z
         +q3hSddbuiGFqQj49l/oKfjfDMeeOmzhMhrHHLBr5zePDXKzRjWzXUThyhRBRc6baFka
         fAlkrjxFUQdPqWjR9E1hi65AzC7mreNFqYgr26gvOS1K0jC9v29OK2wdAjcQknXfAgbe
         NI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GpaZuAjuThZlRnxKVIKAQ0qtHdJgyrsxdPIII0CXp90=;
        b=mH0vurqq4p4EcFEdrsSXQq1lSePjSbZgxLAidQoL5WfR/v8QY3+PUHnizeASwoG+en
         LNBvWzg9EA9bDYdiCJdthxRPjcaXpccOGxc1Wq6GNZwf2lwB1M/Q0oWXCAx0jJY9am+x
         FEwwXgmACobhKJeQghp153PHP/xIZHs2/SAKqD0MfAo2/glPEyRbYMkTP3YjXu+2n2aG
         dH44wYBVS9JhDXlYAly01kTT8+JaSAoQZbWP8VaOOlAviVhD+wfAxxPP6goLdOoz4w9S
         id07rZT2tGKd000/3o1IsHhiv0XODVT6Nz6C1XX74S5YSmUtskj9m8twvfxCWhz9Iz6E
         TWkA==
X-Gm-Message-State: ANoB5pkjZybgV+fuK4xY3mf024PS7RMMKI9YQOhatobJci/v8r/vjmNo
        HIf3ISgOmGp9OM1zG2SWOmY=
X-Google-Smtp-Source: AA0mqf50vgGgC0E+2Bl73SKnO7Rm9G5Kboue3lmjZtVDqghVtmFE3ITyL4Y94fjiMAmnbOWmSCsVCQ==
X-Received: by 2002:a7b:cd17:0:b0:3d2:2d2a:d58f with SMTP id f23-20020a7bcd17000000b003d22d2ad58fmr12911627wmj.2.1671190163034;
        Fri, 16 Dec 2022 03:29:23 -0800 (PST)
Received: from [192.168.1.132] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id q14-20020a1cf30e000000b003cf6a55d8e8sm2256748wmq.7.2022.12.16.03.29.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 03:29:22 -0800 (PST)
Message-ID: <ec30d7c3-39af-197b-58df-440dcdb27a36@gmail.com>
Date:   Fri, 16 Dec 2022 12:29:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 0/4] arm64: dts: mediatek: Fix systimer clock description
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>
References: <20221201084229.3464449-1-wenst@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221201084229.3464449-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/12/2022 09:42, Chen-Yu Tsai wrote:
> Hi,
> 
> This series fixes the clock description for the systimer block. The
> systimer is fed by the main 26 MHz oscillator, and internally divides
> the clock, normally by 2.
> 
> However this ended up being modeled in various incorrect ways, such as
> the clock divider being in the TOPCKGEN block, or as a standalone 13 MHz
> oscillator.
> 
> This series fixes the description of the systimer clock input in an ABI
> compatible way, i.e. the clock rate of the input clock remains the same
> at 13 MHz. The clock is now modeled as a divide-by-2 fixed factor clock
> being fed by the main oscillator.
> 
> An added benefit is that in Linux the systimer no longer requires the
> main SoC clk driver to do an early init dance.
> 
> Please have a look.
> 
> The next step would be to fix up the systimer driver in a backward
> compatible way and have it read the divider value from hardware.
> 

Whole series applied, thanks!

> 
> Regards
> ChenYu
> 
> Chen-Yu Tsai (4):
>    arm64: dts: mediatek: mt8183: Fix systimer 13 MHz clock description
>    arm64: dts: mediatek: mt8192: Fix systimer 13 MHz clock description
>    arm64: dts: mediatek: mt8195: Fix systimer 13 MHz clock description
>    arm64: dts: mediatek: mt8186: Fix systimer 13 MHz clock description
> 
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 12 ++++++++++--
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi |  8 +++++---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 12 ++++++++++--
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 11 ++++++++++-
>   4 files changed, 35 insertions(+), 8 deletions(-)
> 
