Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B29F5E9C14
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbiIZIa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234354AbiIZIaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:30:23 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA0F1F2C0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:30:20 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id s6so9640765lfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=yc8eh2ppDZZcDWiITniWISunAPkC/g7sS7I8UZwuluQ=;
        b=zpbdWAHHJu56K2xc8KOgyLKSj8qOfxEsKQI+kac9U7+4w9tMwjeWo4o35q4Vk0jxWu
         FbJYxVRWgJkVtwq7T9/9mqc1ibZvXSE1BL9vhvk5ihjtffFKmoXmuIqq/DlEBoAdq/39
         +zsmubOMQvjhn0p6cN8frRKED8F5R883zIGZwHlfXZXzppVxgvS/L6PP1kj9bdCb53Nh
         l39isR4HHmGCNScNZfJM62TvFV1TD4e3sbDCUruQ8nZWFIfbLRM+7U4L40mrwtkPAl6b
         7qOuFZALtHXONa4Sa7O3R2cd/FPqeYwrv3nkNli9Y+F264fTFvWPpN+uGQ0xdh8ilANV
         Bn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=yc8eh2ppDZZcDWiITniWISunAPkC/g7sS7I8UZwuluQ=;
        b=ndy0h5VkGPz9wfgxaFcyS7ih++e10c6zjJjjHp4V0pFzslyYPm8+8mrqAVJtHJiFdK
         VPBdURZ4zbQMDywZGRryvrFScRtWiDs58KVOB0xaOOJ+EYmhNoF9DOKhAGC9Zz6B4Kcm
         /YeiuTE68qmOKuwsj2DwqeGHA/FEMoW/nR0N299GJ3bAnBUTG1LmBArqJrYgNOXgYkfj
         VVYDyXj1RkxKy9i/A79JUo6HdxeYqsdq3q0VBXW1KUZt25nxz5LGWMWRI4OWOSoLxWlt
         28sc6YHLOxeJzf8uQ7o58O22SP93HO9L7U1bVkXDmy2W0FGdPkOuh9s1QY56WcuUesGs
         mJZQ==
X-Gm-Message-State: ACrzQf0t36lBB04E/vKARJ7rbdZdPLo5FTYRL8eUlKzfpkVLVgS9Tdg2
        FjkzTYf0JRBIrWhs+18BCpyyYg==
X-Google-Smtp-Source: AMsMyM4Lzz4cmKCm4wv5NBgqln7unwSID9Ng2e832jbMYlUh2kXSCavmOuKZy9aDB1F8rZiWx8s8sg==
X-Received: by 2002:a05:6512:1315:b0:492:cbc8:e10d with SMTP id x21-20020a056512131500b00492cbc8e10dmr7972243lfu.41.1664181019045;
        Mon, 26 Sep 2022 01:30:19 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y2-20020a2e5442000000b0026c41574790sm2292842ljd.30.2022.09.26.01.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 01:30:18 -0700 (PDT)
Message-ID: <263a2ca5-089e-3ca5-7eea-f09c542d0e7b@linaro.org>
Date:   Mon, 26 Sep 2022 10:30:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] dt-bindings: phy: Add compatible for Mediatek MT8188
Content-Language: en-US
To:     xinlei.lee@mediatek.com, chunfeng.yun@mediatek.com, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        chunkuang.hu@kernel.org, p.zabel@pengutronix.de
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <1664180045-19095-1-git-send-email-xinlei.lee@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1664180045-19095-1-git-send-email-xinlei.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2022 10:14, xinlei.lee@mediatek.com wrote:
> From: xinlei lee <xinlei.lee@mediatek.com>
> 
> Add dt-binding documentation of dsi-phy for MediaTek MT8188 SoC.
> 
> Signed-off-by: xinlei lee <xinlei.lee@mediatek.com>
> ---
>  Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml | 1 +

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

