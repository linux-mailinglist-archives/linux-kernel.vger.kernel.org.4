Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453E36E35C9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 09:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjDPHgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 03:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjDPHgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 03:36:18 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971B719AE
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 00:36:16 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-504fce3d7fbso2933678a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 00:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681630575; x=1684222575;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KT6ds4r+t0E7ayy20d8041ijDjDVcqQYBYne/WH971Q=;
        b=ZUefnxGf3uwiTnwbQHt23i0ynkK3Ie/1dRfIVfuL/Haj85OqjPvhUh4/yySsNsjyYk
         NrGnkGvDUJlehsGN3KdDp8ohqT3pcNw84cH0pnBgjBL9xCqUz4pYqJQP7+YJw/mZ88dU
         i3QL+NfsOE9AqtjAFkBmK6GzQVWgLjpm+2O/PH8X9jgoG/qErLBaowOCv0iH8ZxkJIzD
         Te4gb7n+602eGxt+mZppFpXXKpGEQPZgQvBBxQqIiov2iVs/5gxOqemfjZoK8q+E/BRt
         rTe6nGDQRg8+KpYE37v91yOotTit4tmGIw290XOdbRNaaco7MczRMMLZiJEzWXfIkTht
         TFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681630575; x=1684222575;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KT6ds4r+t0E7ayy20d8041ijDjDVcqQYBYne/WH971Q=;
        b=NUtnHVFSFv8hTad0b7Tsn05ots7w+oH2V1klZGbMXVy+q3AgNoxKRIiz1AWK5d3eo8
         jy9Sig33AuJplSwo0XSqBAvKnR3B1BLYkNslB9d18tV7SDvSv53DWi1IoLb1HL1ifISi
         AjGT3HtV1FyNkmowSeLb8B7WuUxPFRXCVtgraClNBIxcLjITnHfVAJl7UNyPUoMzv4r8
         9yBUipr88KTCYD7xq6r8HA862MivH2v4M1SzbEtPh456uFHpKqJvDLmHcGAqyCFEEw3J
         Rt6KV/cGZcLFNFDbia4CyjTMum0fxlCaC4Xnx1fMK6HzooEwVBqm3eAYAAQdoOL8k2yG
         e6og==
X-Gm-Message-State: AAQBX9eb/ExnlVgQYvhXFK7pqrJlynsY677hRkOUZ9EeN1C4IYxrj9rj
        NSK+plooWnY4KIDJZRnJzwP7UQ==
X-Google-Smtp-Source: AKy350Z2aww6ueQ2QXHv9VW/GbvbBi6FPFiYc7YAz5ZKFZ8NlNMWifqWm2wp7e/PC8O1NSVBC0fDYQ==
X-Received: by 2002:aa7:da8f:0:b0:504:9ae7:f73b with SMTP id q15-20020aa7da8f000000b005049ae7f73bmr12695250eds.2.1681630575085;
        Sun, 16 Apr 2023 00:36:15 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:29dd:ded4:3ccc:83db? ([2a02:810d:15c0:828:29dd:ded4:3ccc:83db])
        by smtp.gmail.com with ESMTPSA id p25-20020a17090635d900b0094e75d3ba1bsm4756890ejb.131.2023.04.16.00.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 00:36:14 -0700 (PDT)
Message-ID: <05fbaaf6-3e0d-5d42-0645-587d8555065a@linaro.org>
Date:   Sun, 16 Apr 2023 09:36:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC v2 3/3] binding: mmc: hi3798cv200-dw-mshc: convert to
 YAML and rename to histb-dw-mshc, add compatible of hi3798mv200
Content-Language: en-US
To:     forbidden405@outlook.com, Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     tianshuliang <tianshuliang@hisilicon.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        David Yang <mmyangfl@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230415-mmc-hi3798mv200-v2-0-1d274f9b71da@outlook.com>
 <20230415-mmc-hi3798mv200-v2-3-1d274f9b71da@outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230415-mmc-hi3798mv200-v2-3-1d274f9b71da@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/2023 19:13, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> Hi3798MV200 has an extra clock, also document it here.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  .../bindings/mmc/hi3798cv200-dw-mshc.txt           | 40 ----------

I got multiple, unthreaded patches from you, so I don't know which one
is correct. Anyway, I responded to one of them. Entire feedback applies
here as well.

Best regards,
Krzysztof

