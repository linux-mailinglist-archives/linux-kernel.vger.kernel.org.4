Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439DD63B431
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 22:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbiK1V0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 16:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbiK1V0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 16:26:31 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D4C2611C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 13:26:30 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id e15so6894247ljl.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 13:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MqF/vPvGSRlnkNfRE7ZwgV461GzDRthCdVTW17k8+Mw=;
        b=mFVndKxRlcrXGjtS8xbEr3frusXRA87L62kMxR0t4bAP32KtgWOXjO4s8yB66IohOZ
         IaGKC4ygwy7PubIVkQrFRPOGl1mNVuPGGE37Hue2/7cK8QS6dDHyclrpFJPRffunpmYO
         UgnKNq92E7j8VltxxbCJgHfrSkqwLqmZorHeFkhJH0Qn8zjdVJS7FyGqXD4qvEiwqyuO
         TrGp01tdnnIxjFDJi79+neICv6z613z9QCA8MuvzYDCfgc0LuOmkidnpKnK/MdlTcFFy
         lzbdSnrS7wcLxRvXMCwZO4QRnoa/mfoQWBKrHGPYDiHf1M4glbL9IUJCQ0p8C84i28bW
         R+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MqF/vPvGSRlnkNfRE7ZwgV461GzDRthCdVTW17k8+Mw=;
        b=wH95rzP5k9VEuN2rQ84y+2/HHzdPMsv4krxUbSl0wsJRShvGa1ezH0+uRd1PGqcZia
         Fx8AiBeoIGXsUrz+lnmQgePPQvHXJAzHRhoDO+YIk7ZKQMAHMViRp/EXqK5PqRR7Xobn
         z8RmNES/uO09APVyHa5Cy7/VFIJQa7I36lzGWnxEaqwtPJ13+MGTM4h82TmKLCdnnlwS
         3MPiZzC6k+sXh5PjanKQ46WgCNnKkYR5lKq+OOK+ou5lGYZ+6OVBM+E7IesWmLx0Otmj
         j+ol47xyLZo2eqACvTGLGv8Q3P9huFz+TWNUDBc3grcb6gPzF2jllj29I8NfdlINfMzi
         VdHQ==
X-Gm-Message-State: ANoB5pmts3jkiuzCZ9iujYi3EtyDgziiAfw++4jgAYcQOWxZ+rR7xGrY
        dMVbWvxWEpl23XuRDroArtSNlA==
X-Google-Smtp-Source: AA0mqf7vdeGSIbvyyOexOobx6plSnYLm1oLzAIJDc/j+i13vpXyW0KfgLOM1Pn5yGdLNZjLAjsK0cw==
X-Received: by 2002:a2e:b80c:0:b0:279:78b7:fbed with SMTP id u12-20020a2eb80c000000b0027978b7fbedmr9025436ljo.308.1669670788999;
        Mon, 28 Nov 2022 13:26:28 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a18-20020a194f52000000b00494643db68fsm1877720lfk.81.2022.11.28.13.26.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 13:26:28 -0800 (PST)
Message-ID: <94e94d0d-c786-accc-089e-e7aa56331b2f@linaro.org>
Date:   Mon, 28 Nov 2022 22:26:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 2/9] dt-bindings: clock: Add SM8550 TCSR CC clocks
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20221128122820.798610-1-abel.vesa@linaro.org>
 <20221128122820.798610-3-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221128122820.798610-3-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2022 13:28, Abel Vesa wrote:
> Add bindings documentation for clock TCSR driver on SM8550.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> Changes since v2:
>  * dropped the allOf clause
>  * changed comments in bindings header to mention TCSR CC clocks
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

