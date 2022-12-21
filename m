Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49D36532E2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 16:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbiLUPHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 10:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiLUPHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 10:07:03 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AEF22B00
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 07:07:02 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id f34so8702376lfv.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 07:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nXHfNUaNPuVa1Udkb7Ct+xGCUATGWGV9FO609P79yWk=;
        b=Ee0H9qiZHOqKL3li1jBzUyaziFcgOvcRiEbMtC47CW5az4T11Si7rtZg666S5Fw6U/
         VDZlNkEvITErFgzfPrgDkoAYnZFcAt37qFAHZrNyenSkz77OGMEzEXWQfcVG3PP3AZB8
         13eHcid8PwHa3TqdveJdRAzIiHkJq9KWV8PxAS+Yd36I9X+gwY+qAXuIBZOa54RboVwY
         LSmIDK/6N9QREJIxoLvxa4GlDYrkDjwpveL6fgpEq8BlNvt1SoPIeqiN+mUFn6Lc9NL9
         nmMI6QN6cbMPCZUjV4pzE8lVC7pm+mtibsxWu3JPaGkJrCv8UZWXZcmYAC7aMGXVdNpt
         x53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nXHfNUaNPuVa1Udkb7Ct+xGCUATGWGV9FO609P79yWk=;
        b=Y5y4FA48PuMiy4N9tivrK6H2Q5YIB+xLeGsW+9n7Ves+Oe3VZm1nEkla9ATNYeppa6
         Hgc3GwbQqMZQD08IOW/nUjMw0QJEebNO06Dtp3PNtB9Pv9PQh5TxMGqijxRHaZaFVFul
         iZggVS2luznQj0N9u29u9lZ6B17dx7VMSDNY4/FRk5T8QUvRKsLr+ZwcMS3oljiYSNid
         sZyG+IXpqQH/On53SsbGfGu88XOByZmGxLMRJNMLZVXXirMfkfJ1sCKyU1WzR5wuA/J2
         tl+zd+gGiPxzkbqIE28Iuu/RhKyTxwovOQdknhdvH5OaDVOx23PYYbz99/EkFsZtDwxk
         RRMA==
X-Gm-Message-State: AFqh2kqPSFtMh6HVEgeOB/1qlA8A7K/EiG70lqEixJw1zQTlH56ta5+Q
        c0GGbGFwv3tHrTdg5N1xdkdZ0A==
X-Google-Smtp-Source: AMrXdXscXH6TKv4+JWL+cSlNXlcAiowOZWm12TFZDG5PTlGD3gdIlidFAA3zEusvmWeqvU1rTrh65g==
X-Received: by 2002:ac2:4bd4:0:b0:4a4:68b9:66b7 with SMTP id o20-20020ac24bd4000000b004a468b966b7mr709486lfq.2.1671635220653;
        Wed, 21 Dec 2022 07:07:00 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d4-20020a056512368400b004a47e7b91c4sm1845446lfs.195.2022.12.21.07.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 07:07:00 -0800 (PST)
Message-ID: <0ea140a8-b872-7341-a15a-4feecc69e480@linaro.org>
Date:   Wed, 21 Dec 2022 16:06:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 1/2] arm64: dts: rockchip: Add EmbedFire LubanCat 1
Content-Language: en-US
To:     Yuteng Zhong <zonyitoo@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, DHDAXCW <lasstp5011@gmail.com>
References: <Y6MP74TUp50yt6wZ@VM-66-53-centos>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y6MP74TUp50yt6wZ@VM-66-53-centos>
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

On 21/12/2022 14:53, Yuteng Zhong wrote:
> From: DHDAXCW <lasstp5011@gmail.com>
> 
> The LubanCat 1 is a RK3566 based SBC, developed by EmbedFire Electronics
> Co., Ltd.
> 
> It has the following characteristics:
> - MicroSD card slot, onboard eMMC flash memory
> - 1GbE Realtek RTL8211F Ethernet Transceiver
> - 1 USB Type-C port (power and USB2.0 OTG)
> - 1 USB 3.0 Host port
> - 3 USB 2.0 Host ports
> - 1 HDMI
> - 1 infrared receiver
> - 1 MIPI DSI
> - 1 MIPI CSI
> - 1 x 4-section headphone jack
> - Mini PCIe socket (USB or PCIe)
> - 1 SIM Card slot
> - 1 SYS LED and 1 PWR LED
> - 40-pin GPIO expansion header
> 
> Signed-off-by: Yuteng Zhong <zonyitoo@gmail.com>
> Signed-off-by: DHDAXCW <lasstp5011@gmail.com>

This also needs fixes (SoB order, full name)

Best regards,
Krzysztof

