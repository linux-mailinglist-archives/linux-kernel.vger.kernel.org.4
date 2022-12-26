Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F4E6563B8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 16:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiLZPKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 10:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiLZPKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 10:10:37 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C8FC2E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 07:10:35 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id f34so16225486lfv.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 07:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7/4vIavePf24Y5E57dKW/d4hKpsKl8TaQWv7+5+2RYA=;
        b=uU4NHW77ug4oYnSdjBRbFvuzXnFN63F8yeG9pj6NH7aJVhTbS4e7dxcFGCN8HHZVM1
         V65lyagghCGGJ3HVjxvAavDeGCMx5HvZ0AJn8hf6DtzlkDMl+gTXKKHalhydWZrJn2M5
         ehW6YjmbvfgbxTDEQYwxVpS/qYb3Bn2lFodjt4AtEBBgh0rFkhu4sderjj/o85npV6n0
         hEoJcKCFLBDIqz7d6M6h+56FFDhaQ7HWnb/tZ8m6muhQzVsatdNaz+maDwwuKqInKOeo
         AJJuWfDEQapXrp7uYwlypWbZm2IA9OVRJTzoN62ESBfi0KqLnLOnun5XnU6evA471Oyq
         glRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/4vIavePf24Y5E57dKW/d4hKpsKl8TaQWv7+5+2RYA=;
        b=wR7tvKByBV1y2qkmoa1HkOr6PR3mhcR/M7HgoJThaDpIQHj54hRpl8CuCKUh39G8wc
         IUfi/Ans2ae8iS6ZSABphUcJkA5vwZzC6GVaWcb1rs9sUfwc4fkucdbnh880n95NxsRw
         B47QyZZpWV/um0QzVPyzNn/8toTGCR8aVbQmPTOVrs059d50tqOOkfiEDnYBjOp537pG
         l22pzse5CV1hAOTZkIFBE8piJzVrv7EeqgGd/ltsyUR87ayPcJ4HlqTSefR4hiCq/d48
         afgQKuQwjyzWkMnY+WOU0udi0xElhpDX9gG4l4SJtrDyYZDcUjEhDoEW9W75TS/OOAEY
         49ig==
X-Gm-Message-State: AFqh2koNIApi0WXmbs+rt19QW/tJAXNVVxCo7NEHKmyHdx1Rfa+FHWgB
        OTGcaa0SgHNRInA0lMlq8IRKeQ==
X-Google-Smtp-Source: AMrXdXsU88kmLp0G5KL5khCv7pOiaZv4YSBEkD5kb5OBp7DxQ2BF4lkzmUlTHHQIaUMmgUmLWPo+Cg==
X-Received: by 2002:a05:6512:3e24:b0:4cb:c11:d01f with SMTP id i36-20020a0565123e2400b004cb0c11d01fmr455333lfv.22.1672067434220;
        Mon, 26 Dec 2022 07:10:34 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v21-20020ac258f5000000b004cb09fd48ebsm370872lfo.149.2022.12.26.07.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Dec 2022 07:10:33 -0800 (PST)
Message-ID: <af5a7b65-9917-58d2-315e-71e902826a54@linaro.org>
Date:   Mon, 26 Dec 2022 16:10:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] arm64: dts: fsd: fix PUD values as per FSD HW UM
To:     Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alim.akhtar@samsung.com, s.prashar@samsung.com,
        pankaj.dubey@samsung.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20221129095529epcas5p31acfecd374b59cddd2e67d2efcdd86b4@epcas5p3.samsung.com>
 <20221129095516.89132-1-p.rajanbabu@samsung.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221129095516.89132-1-p.rajanbabu@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2022 10:55, Padmanabhan Rajanbabu wrote:
> PUD values used for UFS, SPI and UART are not reflecting
> the default values recommended by FSD HW UM. Therefore,
> changing the same to comply with HW UM recommendation.
> 
> Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
> ---
>  arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi | 14 +++++++-------

This patch does not apply, please rebase on my for-next or linux-next
(once released).

Best regards,
Krzysztof

