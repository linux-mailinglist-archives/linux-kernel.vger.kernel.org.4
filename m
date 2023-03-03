Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFC26AA08F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 21:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjCCUYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 15:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjCCUYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 15:24:50 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4726D25B93
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 12:24:48 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id g3so15136308eda.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 12:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677875087;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X2Z27b+UScFCuRyrLv7rqfV3Hiudiqa4YUfaAz4E1nc=;
        b=L+hYotLGtz8O+I7bvl6es73wFJ1LwiS+IRcpqx1pnCZtxP5r2Cjsl7FjNB8yi15Mxw
         Hs+yn2JP/DMQe8uGXeB+rJyLjEdo/dNWw0Fl7JjsIdUwHgn3Gz5+MENAJXrhJw2N/0U0
         EtMx7VbGH2SRU4ZFNA4jlazLPiJGBHd2XNzWW2NoqayoE1uMDn7kCI2OAb7rlDnrMxk4
         tNvud9DtyxZ1Y975L1IQfF4F0Wk9a0cU+Z/S8OgGiyi4clMMLZhE1jmjRfltmiD1x2m6
         f+6KbQgJsuzu7ndG+ZSZ+6KjcGrXrKQrGi7lvGX31SiGkAfhIXVJHKffDEbjeXEWHBGM
         QN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677875087;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X2Z27b+UScFCuRyrLv7rqfV3Hiudiqa4YUfaAz4E1nc=;
        b=Gp/yyDUihD9BzZUZ+xV1J7pwbX7FAmmnkfD0Ju0QhGhF+FEtRoO7usvTpHhFPaW4I1
         LXjxy1fO0GGJ4HYSH1R9uNHW/FAzg39Zdk7ZLgy+nPdMdxVkuGZdHkVRGPxIlF8ZlWPW
         cxAhfF6r+2Yo6HU/lay66QeTnUg1ibwVfpDaz2/SmXqSk++OP7L6fqDVKbda6JVMYS8I
         xKqBHV45pm1+VjwsAqlLYmuS7vjiddG5pZJIT99nPxIvdQlinmT7VfMq7Jy7jxlWp6el
         /lndCNxC0YpCF1ExsNx8QfqVt2ErPtm/xDC5U2VnIhahkZyx1lrXByPrutZhtdySuT2v
         Gj7A==
X-Gm-Message-State: AO0yUKXwzOTy4ZgG4TLV/UwhbDTTZvP5038Ed8PtUP2WdLrd+FZMBfEC
        G0eelVhvxLnrKiNdQ7MCga80vg==
X-Google-Smtp-Source: AK7set+WR/tSvSs5yH6C1aFl1G8ggGp5jSCh4ccN9oWkb4JiV3SmZbMIlcdmtP4sam8YRYlOS2Ga+A==
X-Received: by 2002:a17:906:30d3:b0:8b1:3d04:c2da with SMTP id b19-20020a17090630d300b008b13d04c2damr3180167ejb.45.1677875086791;
        Fri, 03 Mar 2023 12:24:46 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:3321:2e91:9111:67ba? ([2a02:810d:15c0:828:3321:2e91:9111:67ba])
        by smtp.gmail.com with ESMTPSA id c15-20020a170906170f00b008c6c47f59c1sm1291067eje.48.2023.03.03.12.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 12:24:46 -0800 (PST)
Message-ID: <d529206a-ef17-44cd-1ef5-17badad711f4@linaro.org>
Date:   Fri, 3 Mar 2023 21:24:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 5/5] clk: hisilicon: Add CRG driver for Hi3798MV100 SoC
Content-Language: en-US
To:     David Yang <mmyangfl@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230303151417.104321-1-mmyangfl@gmail.com>
 <20230303151417.104321-6-mmyangfl@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230303151417.104321-6-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2023 16:14, David Yang wrote:
> Add CRG driver for Hi3798MV100 SoC. CRG (Clock and Reset Generator) module
> generates clock and reset signals used by other module blocks on SoC.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  .../devicetree/bindings/clock/hisi-crg.txt    |   2 +
>  drivers/clk/hisilicon/crg-hi3798.c            | 193 ++++++++++++++++--
>  include/dt-bindings/clock/histb-clock.h       |  11 +

No. Don't mix bindings and code.

Run checkpatch - you should get warnings for this (and such you must
fix, not ignore).

Best regards,
Krzysztof

