Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4DC669588
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 12:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjAMLaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 06:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240334AbjAML3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:29:51 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63008B53E
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 03:19:37 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id mp20so4954738ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 03:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nNpoWQlOxVCjJNH1/tWYzE33AytIwBJrxcIw+MQAk1E=;
        b=YAc09V0LuRBCbE9h978g2eWv0ESqP6iDhWXWiOscMziFrCnja1+oAglJvYPWVXDyep
         XnO+MwuT5Ni/nHQCK7FFduQEUsnuvZAYGSK9/yXWTieTtQHtpzzTVA1Ml55m7VmWx+6P
         zRAHT+4BEEdL4DuvH6N76tG9ubYIa2nC+/SyiBjNTB/QvLy/Ht16vTaHzU21TNNWDF3W
         yqo2S6QLzNOSk0lYNkTLXTJDC2Lo334xt+c13cr7mlnKkn/BDwY9ugO573ETe1C10mhb
         F5U35mauKmu0s76EfuaWK1vLqXfytEy/OI65pMShir1XBDs9PP0RyWsXN/sPkE+qxNgk
         KN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nNpoWQlOxVCjJNH1/tWYzE33AytIwBJrxcIw+MQAk1E=;
        b=E9zYDEbDSjXlc3AUj+MZQr10Z2ChKV6SVkpVhG/E9pBpqhBbYfhKT5PRQRjjnbjFCy
         OC/xpuC+Fv7Q3bJaVTZa8LzcTPyF3tG/z18vcwWhszhHEX8lW2SEGlXAhai8GWol9Jh5
         LVwQT/ntORYDXSBMrEw27dtjAmoLucMRGQo8AtnGyu6QKNfJZb/RYRINc5ltpS+nnsM7
         +0wStyynNe7E+wBDL840xNWJhqaVvicnh8kcsQpGEZI44Sm+D7saim0b4ZTZDa6zBNsl
         Aqc4rc9G92CDU0BuF/O6N6cAFQC4xFLyIDVb92LeCTbub9zpo5B1EoOLPGpfYvdirBvn
         5qVQ==
X-Gm-Message-State: AFqh2krU0wv0eX0il7aFk52QICtCaJzn29tHI0shBVdg2MfQzqoAL/l7
        34mwq4iMDmEzXT5liVtuFCbkPQ==
X-Google-Smtp-Source: AMrXdXspYZjcBS1Yz9eGU+zh+BZTR4yIsg9PI+y6cZKg1n5HF52+7JotiGtPdug5EZcV7LcflFtXKQ==
X-Received: by 2002:a17:907:6d26:b0:857:b916:94c1 with SMTP id sa38-20020a1709076d2600b00857b91694c1mr17660684ejc.61.1673608776266;
        Fri, 13 Jan 2023 03:19:36 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906059100b007c16f120aacsm8356105ejn.121.2023.01.13.03.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 03:19:35 -0800 (PST)
Message-ID: <a5d1bb62-1fbe-1ab9-b93d-f17d4b7f229f@linaro.org>
Date:   Fri, 13 Jan 2023 12:19:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] clk: loongson1: Refactor to add devicetree support
Content-Language: en-US
To:     Keguang Zhang <keguang.zhang@gmail.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230113110738.1505973-1-keguang.zhang@gmail.com>
 <20230113110738.1505973-3-keguang.zhang@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230113110738.1505973-3-keguang.zhang@gmail.com>
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

On 13/01/2023 12:07, Keguang Zhang wrote:
> This patch refactors Loongson-1 clock driver.
> - Use CLK_OF_DECLARE() to declare the "early clocks"
>   required by of_clk_init()
> - Merge clk-loongson1b.c and clk-loongson1c.c into one driver
>   because most of the differences between them will be moved to DT
> - Add set_rate callback for ls1x_clk_divider
> - Update the Kconfig/Makefile accordingly
> - Update copyright
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
>  drivers/clk/Makefile                   |   2 +-
>  drivers/clk/clk-loongson1.c            | 348 +++++++++++++++++++++++++

No, this is not a refactor. This is removal and re-add. NAK.

One change per commit, this is unreviewable.

>  drivers/clk/loongson1/Makefile         |   4 -
>  drivers/clk/loongson1/clk-loongson1b.c | 118 ---------
>  drivers/clk/loongson1/clk-loongson1c.c |  95 -------

This is not explained at all. You are pushing some crappy vendor code
here instead of merging with upstream code.

Otherwise, explain the drop of directory. Why Loongson should be special?

Best regards,
Krzysztof

