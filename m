Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E08261FDC1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbiKGSkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbiKGSkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:40:04 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A5A18E39
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 10:40:02 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id u11so17664169ljk.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 10:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zu8Huj0bPMNsIqjTrIRXl4tf9CZ1yQ2L0lxIAXL9iVs=;
        b=gBzEObADVp5mtqxgk+lzuUPqMxxAL9wosa04e075/qjVZ6gNiviehxXI/wwbI+DxHR
         BNPEqlSI+gtimj4nm2oFGHs1nboOysYSyuV4oaMazFVnwBv9XnghnFfK/ixI9XsKUAUW
         Goz9k+U86atux9bLF8z+y1AOfXbAIoPzNbh+gSEfNLredoBbJyqZwQcE4OiIZRtAnv/a
         rTI2p9KyriA6/E5DG/niYmrgeI5Qb5ZOBeRK6KS59pxJBdTVjxRDZyvolbf077VpICjt
         kxhvzP3kOs5BY/nmjrJ8LRpeW6uEPM/B+9MpIMiNr8qFANxTmRb38Vvwadd9sVq8Mi7s
         wvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zu8Huj0bPMNsIqjTrIRXl4tf9CZ1yQ2L0lxIAXL9iVs=;
        b=lbyHTzDDibqTSbXM8cbgourh27g0tP4WYsMuZjiZhgyhC6Iewr3hQ0DzU2M+59OG6B
         dFcl+V/i/qG3cDutNq8Um0AMTrEVuWd9BsVMM+rZnLIfF7SYHsQT/3eYN+Yp/XIB6zzP
         GucJwsCHfdztEtUa2mAroP6QLJjJZcDWFqCKeUTiw9RkIdX2IoFBIDhFB1f67zZDymOO
         uD/bI+KVQ1OsEqTFwikmchE+tjKAgUvWZ+pLO+YD3BRTTIWgjFD2mrygaNDKGr+vEwYk
         kzG7oUgrC4XpuQWPx5FS8XocNc/G2y8XeKO4lFPFGFwk7IUh500LK0HZyECtRLaNt+23
         galg==
X-Gm-Message-State: ACrzQf3iIsokiCoutB7U64AXlyr4tKJu+TAReGpKCJkFcqNL5jKJ8daa
        zPvvPUdPYYgZoUa7y7SXrxgOxg==
X-Google-Smtp-Source: AMsMyM4QyMCFiYp6kD2IUfKXFyDf1b18akD1Z4DGlZsS3MTzqmC+0aBlDgaBeRfmZITKdcqgY0tZvA==
X-Received: by 2002:a05:651c:c6:b0:277:c75:e295 with SMTP id 6-20020a05651c00c600b002770c75e295mr5586206ljr.228.1667846400799;
        Mon, 07 Nov 2022 10:40:00 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id p25-20020a2eb119000000b002770fb5722fsm1376743ljl.123.2022.11.07.10.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 10:40:00 -0800 (PST)
Message-ID: <b5f881b7-1f59-623a-a126-d7827dec85fe@linaro.org>
Date:   Mon, 7 Nov 2022 19:39:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/2] dt-bindings: i2c: renesas,rzv2m: Fix SoC specific
 string
Content-Language: en-US
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Wolfram Sang <wsa@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
References: <20221107165027.54150-1-fabrizio.castro.jz@renesas.com>
 <20221107165027.54150-2-fabrizio.castro.jz@renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221107165027.54150-2-fabrizio.castro.jz@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2022 17:50, Fabrizio Castro wrote:
> The preferred form for Renesas' compatible strings is:
> "<vendor>,<family>-<module>"
> 
> Somehow the compatible string for the r9a09g011 I2C IP was upstreamed
> as renesas,i2c-r9a09g011 instead of renesas,r9a09g011-i2c, which
> is really confusing, especially considering the generic fallback
> is renesas,rzv2m-i2c.
> 
> The first user of renesas,i2c-r9a09g011 in the kernel is not yet in
> a kernel release, it will be in v6.1, therefore it can still be
> fixed in v6.1.
> Even if we don't fix it before v6.2, I don't think there is any
> harm in making such a change.
> 
> s/renesas,i2c-r9a09g011/renesas,r9a09g011-i2c/g for consistency.
> 
> Fixes: ba7a4d15e2c4 ("dt-bindings: i2c: Document RZ/V2M I2C controller")
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

