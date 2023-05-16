Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3857046C2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjEPHoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjEPHoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:44:10 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831C619BF
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:44:08 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9659443fb56so2161832966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684223047; x=1686815047;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=knTSlcHxUZPKa0wlQrVdNwYp/jYVO/YuubSx7u5s0Ls=;
        b=TeUx4gZf5l8kCwUOpM3vraO/dpj8ZKCYeYC+UyukIKK8PhquXj1z5nXdDveJhllDzO
         BshJCjDBpjIFmHTSgQMbK5nlvJAj8qy5TSkVLti6rcNcETEJTJE/DNmYT9Iy1phRyozY
         faALNzW2VFnPuBdXLSVjWQnJz23wFRiGnXXR38lifJWFxZH/jTUb2deWHS1k8grOCVRr
         EUg5ANaFvAjuLMay07f9PvRLefzzI/xLgt5I3M1vL2j9AXIEzNyxZNqKJTMhd2FOBIUX
         Obi1b3phqJj6B5VQX4/s7Z0cV+Wz4/wTYkrCtvm0rEgjG3FL94F9w8KmJVAS+nG+VQ8E
         qsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684223047; x=1686815047;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=knTSlcHxUZPKa0wlQrVdNwYp/jYVO/YuubSx7u5s0Ls=;
        b=HFn5hxNIepOMbRHNHxNbKFKAYoDvK/euqQ5QLx2Q+F25QDzypYUgbwenUS42O8CPNT
         1dvJv2noVmYM5kujaQQ6XUCbhXtJK/loEaNVeh6U1/gXTYfoko5I6bucyt2Emub8zQYn
         v01hIlmKlH/kZ06c1NCAGqeDxIQrgNtkRimA1tHnFB/2a/oYHsx300BqCeydXAdP7W/6
         pn9KepLmbS93W7rGlQhviWmx174J93Gf/OsDkWEgGPniNHwTqlMgdx4p9s5bsVDwbzci
         9SnDi8Gd9eu5zUA6zWW35RA23dXqAHdXjOVszmXbxLtMzBrtP7LUNKwh9JPaMYsYFB16
         l7Eg==
X-Gm-Message-State: AC+VfDy6AqLN1m3n2lwD9EW2LPX6GjGiC16MSRL3jJgQ4Be8dIPRl5os
        MOZMy86aPS0CUlYhDWHnd/udVg==
X-Google-Smtp-Source: ACHHUZ5Xc/3fLyfIt7CaeI8B9CHN4J4ETHB21vbWYlJ+ZxGKEsCjykxYrKvyB93jjVhaoBslUozBAw==
X-Received: by 2002:a17:907:3daa:b0:96a:1cbf:3dcc with SMTP id he42-20020a1709073daa00b0096a1cbf3dccmr25286333ejc.54.1684223047014;
        Tue, 16 May 2023 00:44:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:4d4a:9b97:62e:1439? ([2a02:810d:15c0:828:4d4a:9b97:62e:1439])
        by smtp.gmail.com with ESMTPSA id n12-20020a1709065dac00b009663cf5dc2fsm10674369ejv.66.2023.05.16.00.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 00:44:06 -0700 (PDT)
Message-ID: <0a70fd40-fcf6-7297-8464-a23d3981afc3@linaro.org>
Date:   Tue, 16 May 2023 09:44:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/2] dt-binding: cdns,usb3: Fix cdns,on-chip-buff-size
 type
Content-Language: en-US
To:     Frank Li <Frank.Li@nxp.com>, shawnguo@kernel.org,
        Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "open list:CADENCE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     imx@lists.linux.dev
References: <20230515162053.2825405-1-Frank.Li@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230515162053.2825405-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2023 18:20, Frank Li wrote:
> In cdns3-gadget.c, 'cdns,on-chip-buff-size' was read using
> device_property_read_u16(). It resulted in 0 if a 32bit value was used
> in dts. This commit fixes the dt binding doc to declare it as u16.
> 
> Cc: stable@vger.kernel.org
> Fixes: 68989fe1c39d ("dt-bindings: usb: Convert cdns-usb3.txt to YAML schema")
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

