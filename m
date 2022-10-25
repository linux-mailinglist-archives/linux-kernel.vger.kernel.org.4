Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CCA60CBAD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 14:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiJYMVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 08:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiJYMVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:21:36 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99D6CABE0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:21:34 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id mx8so8393124qvb.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yrilAhGGJreK8L4jo0y+OfIubyvYYXmcpdYjjv0NBzw=;
        b=vFP823FJZuCoQ/qSOuYtkMQd2VmdCUrulmNtzL1ZXynQCiDNoSwdCXGbDO/vsXvXOB
         GLEh/COj6kV401Ni86hUKFde73N9Nnysrv5Wdma5U4q/VDRlKmnT0UUog66EV4CPz9VE
         ZG4KL/5K04wupgRJp7o8WLu4PyvCpolUKv0xzxSIDDc6VQHlcGVI3Xm4yIpsaSGc1yWl
         kSJlMKbuqk6uCSbX3SmBh7DG/VZBfyxSReCuOoo5jXf/WtEBaX1DBKhLtuHlRQfwqZ/R
         u994/N/ApSm4zlTiYLwUxFDQ5q2NJEXcKfHd5eBvQERIzpeLQgfqB9qivAqRoBC9zyTq
         NK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yrilAhGGJreK8L4jo0y+OfIubyvYYXmcpdYjjv0NBzw=;
        b=iutCjLrdefvg8dZ2sP7oBRI1HMvpde8H2aAEn3wO7J0VhgHGxM0GTYUeaqioo++mtO
         R0soHLo0gHTZuiiKwVZW9eSgQnR7TbAYxv1qRY2MSdPi6xDuheqcBBP0iHxoSEykPtQL
         aO0kXZZvJ80CIRuqPVP9C9Wx7vD6rRWQyV29364XQfXKvER+gawvLYSWFjDXwmAlBUn6
         pk04yOuOA1bfYEhI2Rmc3yW26faXxKFMZs9jBpyS0S7HxQ3K7c6Xp+rRYZsl0BYhRwvm
         ptbXebWo8mxS9Si9dxCQuA/e9SLXy1/tLhVaBOgir4p9Ma9g4kxou4XVAq7HlwSdN53q
         3Kag==
X-Gm-Message-State: ACrzQf0aTyywthvfaSOfhHT4OQLEZJaDJ816djkVYI12sF+99AdTy6aM
        73QxZrtZuG/wUCJtW7otNmT8+g==
X-Google-Smtp-Source: AMsMyM4s0N1Fal+yR+QTBJMIob7ci46MXCs+VOue61R+M/I9AAZ+z1gY8tW13hXFvcnKIx6Wvt0hNg==
X-Received: by 2002:ad4:5ae5:0:b0:4b7:1bdb:d79e with SMTP id c5-20020ad45ae5000000b004b71bdbd79emr26229025qvh.25.1666700494159;
        Tue, 25 Oct 2022 05:21:34 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id dt27-20020a05620a479b00b006cdd0939ffbsm1911886qkb.86.2022.10.25.05.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 05:21:33 -0700 (PDT)
Message-ID: <857f6769-3618-0958-472b-bff57a23f763@linaro.org>
Date:   Tue, 25 Oct 2022 08:21:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4 2/6] dt-bindings: mmc: Add support for Mediatek MT7986
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sam Shih <Sam.Shih@mediatek.com>
References: <20221025074238.18136-1-linux@fw-web.de>
 <20221025074238.18136-3-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221025074238.18136-3-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2022 03:42, Frank Wunderlich wrote:
> From: Sam Shih <sam.shih@mediatek.com>
> 
> This commit adds dt-binding documentation of mmc for Mediatek MT7986 SoC

> +          items:
> +            - description: source clock
> +            - description: HCLK which used for host
> +            - description: independent source clock gate
> +            - description: bus clock used for internal register access (required for MSDC0/3).
> +            - description: msdc subsys clock gate
> +        clock-names:
> +          minItems: 3
> +          items:
> +            - const: source
> +            - const: hclk
> +            - const: "source_cg"
> +            - const: "bus_clk"
> +            - const: "sys_cg"

Drop quotes.

Best regards,
Krzysztof

