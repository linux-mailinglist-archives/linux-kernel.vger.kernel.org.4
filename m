Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4BD67B55B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbjAYPDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbjAYPDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:03:09 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC5E6A53;
        Wed, 25 Jan 2023 07:03:08 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso1497306wmq.5;
        Wed, 25 Jan 2023 07:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yfWdzu6Jy0H8uDig3qe6ACmj2V9/h17QhbhZo7BKH7E=;
        b=cI1mXGkJLYER/ZJi9t/+AHck3Yah8mGRVwZp0/76273lf7Ynm5xxqsS7JLt+BVVe3c
         HkxuSSvwpzr9LFsGhaVV/7NH2m2QjVyAA6V9fsfcQwDJ6yEEZhZ66HI3XtDDMX68RyGi
         YPuoU8hGgZBB6F02I2ZPRQzs9ngItsOztAa5TjqA+SQKfV0zLToxLL9hJwCbFSIRvkL4
         zM4t2VIrx3GANES2h2FcA06x/vezbKO6Wuj3CsIV1OFcClUarXruDzPgRnTv4oja67Vu
         ye3wGs1rGBFJtfsXUEAmis6nsuM06D48goC9uig9ecQR21/3ZUcYErW3OZgruBoCTTRa
         Dovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yfWdzu6Jy0H8uDig3qe6ACmj2V9/h17QhbhZo7BKH7E=;
        b=cuJWX2HeHe/yFPhjfXPxQ8C06wIbr1lqkIxBB66JyqxbwmJgU8DX3fBPJxCRY8P0Sp
         UlTPDfL6WOzrVLU0xOkV3eyyZ4wg0pZr1oelTwjp7kqxz6ZCPKVcP3WM65BcfYNDnmZe
         wWgpKhs/4lMsp8JPYQ+Ich0jFt6BMS6DkxsBuTffygiOjLpCKb1kiF68SjBaJo69/+Pe
         LEmY7P2xcY9yKTql5pLoqKXHqAX2GgRnLWKjK0Xz3iKTY0rnUhcNy5obLBQbkR3Es2pi
         AGLPQJ9/ECOE/pZHjGOCP1nuhX6b8b0hHDXBZT0pxBPZYyDNYlv969vJq+84p0/MJFIb
         xZ5g==
X-Gm-Message-State: AFqh2kpKMkxTKIi/su2l6UAtM3ratl5hVTLIRkbSzqV2PWJVF1wW80lF
        6yGYYlW/fopq/enIoI3X7k4=
X-Google-Smtp-Source: AMrXdXvUC9/EK8F+PQGipzAvBuGEdz3EBeT7BdfudzdynpMsuxG8jwmJtal7UnZ8Wu187kmSSlYrXg==
X-Received: by 2002:a05:600c:54eb:b0:3da:2090:d404 with SMTP id jb11-20020a05600c54eb00b003da2090d404mr32457602wmb.18.1674658986986;
        Wed, 25 Jan 2023 07:03:06 -0800 (PST)
Received: from [192.168.1.135] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id f1-20020a7bc8c1000000b003c6bbe910fdsm2530943wml.9.2023.01.25.07.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 07:03:06 -0800 (PST)
Message-ID: <e6e91635-b8ce-787a-96e6-dd8b066f8c0a@gmail.com>
Date:   Wed, 25 Jan 2023 16:03:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 0/5] arm: dts: mt7623: relocate gmacs, mt7530 switch, and
 mux phy
Content-Language: en-US
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Frank Wunderlich <frank-w@public-files.de>,
        erkin.bozoglu@xeront.com, Sean Wang <sean.wang@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>
References: <20230120205318.519493-1-arinc.unal@arinc9.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230120205318.519493-1-arinc.unal@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2023 21:53, Arınç ÜNAL wrote:
> Yeia sou!
> 

γεια σας!

Whole series applied, thanks!

> I initially just wanted to submit the phy muxing patch for BPI-R2 but after
> looking around the bindings, I decided to do a bit of a cleanup.
> 
> The main takeaway of the cleanup is that the MT7530 switch is actually a
> part of the multi-chip module on the MT7623AI SoC. I'm moving the bindings
> for this switch to mt7623a.dtsi so they don't need to be defined on every
> device with this SoC. This should ease it up for supporting more devices
> with MT7623AI SoC on mainline.
> 
> I don't know if there's a pin wired for interrupt. The switch is going to
> work with polling for the time being. Folks from MediaTek, feel free to
> fill me in on this.
> 
> I've tested phy muxing on my BPI-R2. DTs compile fine.
> 
> Arınç ÜNAL (5):
>    arm: dts: mt7623: add gmacs to mt7623.dtsi
>    arm: dts: mt7623: add mt7530 switch to mt7623a.dtsi
>    arm: dts: mt7623: change mt7530 switch address
>    arm: dts: mt7623: mux phy0 on Bananapi BPI-R2
>    arm: dts: mt7623: enable flow control on port@6
> 
>   arch/arm/boot/dts/mt7623.dtsi                 | 14 ++++
>   arch/arm/boot/dts/mt7623a-rfb-emmc.dts        | 86 ++++++----------------
>   arch/arm/boot/dts/mt7623a-rfb-nand.dts        | 86 ++++++----------------
>   arch/arm/boot/dts/mt7623a.dtsi                | 74 +++++++++++++++++++
>   arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 22 +++---
>   arch/arm/boot/dts/mt7623n-rfb-emmc.dts        | 13 ++--
>   6 files changed, 147 insertions(+), 148 deletions(-)
> 
> 
