Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E54C61E161
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 10:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiKFJnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 04:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiKFJno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 04:43:44 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8895DDF52
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 01:43:43 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b3so13056652lfv.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 01:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QDiDxLQ0rjb64xJziCsobO1Kr+/jbm6ut/9xmmhlli0=;
        b=BzwTsf7kgiD5xSMiLwVu/jxPwHD7Gndi5kHryjTT2GmoBt0IA4tVVvRxDgPyIV7rL3
         qM0Pk9ggBgD9GCw4a60aQXxCr9/RJ4gVqHcJ9vGFuKAglKI89FpK75RR7Cjvj2dO7oHK
         uQbQyIRnWkBP8NXjZUcmWdjMBthHIEie7zVKr0OyH/kdNvm09rwkxivRGEhv+6vpwRDU
         i+gMVszYcjMzdh3NYpZ58JFcOB9925VzonO6MG7+H4xl0FunZM2bR3WWinAGxGn0WRz4
         WaWJJ0vPnzNyBSLJcu7037hB8bqbmZD9BmScefbAG9w6Edhn9seedlGoadn8kXdQcRa9
         mScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QDiDxLQ0rjb64xJziCsobO1Kr+/jbm6ut/9xmmhlli0=;
        b=2ewbx6h1plx1ziVsgNhgAor1VqOMrx0hO6gmwH3sa99uQABmYhAHL2oRPH3HhNa1oy
         xyrGAgXh8vXAy1BxeTgKzMbxosHSXdRLcCbugVDfC+qa9aO0elRXv7sa3PrdfGMnoZF4
         KZDyOXD6Jt6koyPMyK7e8t3kK8mrGE3RWiVQ/deCXPXusfYRIDpVdBtioxNrJhezF84V
         Lcc9EPZiVlZ0sgymJgm0GI6o945zeMJcqCRr1F02KnieGI1bVTI/J3gW4wddhPCTvmtn
         DaaWwl2vGdd5rBRIRoURQyuzb57unytK8uOANhwZB3+OHzDAlq0suXjyhvdL1tGaJzfu
         2mtg==
X-Gm-Message-State: ACrzQf1bn4IQsnehjusLL4q7XDyQqLi+4sE5BmoFKo/JNYP1OKD3+tKT
        oxosVz2MBJcna7TxsKzlJyDbRg==
X-Google-Smtp-Source: AMsMyM6Ww2G0QMg/H+TjQIQGbrTzVi08fyHtBFt5F0Gxp4QlpNE83Y4mhpN1b2aduhsBx4VzyepJXw==
X-Received: by 2002:a05:6512:3151:b0:4b0:efed:e3a8 with SMTP id s17-20020a056512315100b004b0efede3a8mr276203lfi.650.1667727756486;
        Sun, 06 Nov 2022 01:42:36 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id cf29-20020a056512281d00b0049496855494sm627354lfb.104.2022.11.06.01.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 01:42:35 -0800 (PST)
Message-ID: <c2f891d6-97c5-1952-2591-609e2478aca6@linaro.org>
Date:   Sun, 6 Nov 2022 10:42:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/6] dt-bindings: pinctrl: update uart/mmc bindings for
 MT7986 SoC
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Sam Shih <sam.shih@mediatek.com>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221106080114.7426-1-linux@fw-web.de>
 <20221106080114.7426-3-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221106080114.7426-3-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/2022 09:01, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Fix mmc and uart pins after uart splitting.
> 
> Some pinmux pins of the mt7986 pinctrl driver is composed of multiple
> pinctrl groups, the original binding only allows one pinctrl group
> per dts node, this patch sets "maxItems" for these groups and add new
> examples to the binding documentation.
> 
> Fixes: 65916a1ca90a ("dt-bindings: pinctrl: update bindings for MT7986 SoC")
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v3:
> - squashed version from sam
> - v2 was ack'd by Krzysztof, but sams patch included updated emmc-names
>   and different structure for uart to allow 2 pingroups
> v2:


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

