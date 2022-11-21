Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201AE6328CD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiKUP6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiKUP6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:58:32 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E615AB8F9E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:58:30 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id e11so7601116wru.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=boaL5U5lHjDH+ZC332huvtClKnKW6p97RRdnw48BP4Q=;
        b=YFMj3EFl4YLM9B1jLsh4rtQRLCxY723arRHQ+vczimYMzxZIy10TxqV9Q9LVCTDry8
         jJj5G1poLBa/OFvvTO1IYolMO+5kHAGX0DKEfh6uiGqrnQS2Qlalx78uWuvCRjJF+G/H
         V5yQrkwlG2sbvajRyrNVNUQmOLUKQ7R4PMjrs9Dn+MiytJnCCeuJwxr3DPYkF4SPGpnd
         2980r946NDUkycp3wbdSOSnV9Sf90G541gmkPYHR8ifkGYiDhmXuz9xAQoKGv4w0kWWl
         WrzDX5GByDf+sLBAU4xAIP00nunrVpKjflbbb2z2DFE8nE1qRuxwnKA33htu7RMo1dNq
         YScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boaL5U5lHjDH+ZC332huvtClKnKW6p97RRdnw48BP4Q=;
        b=S276+bCmGDw26PJYXdGuF0K4WxvzFikVhz6ZX/VMrdQ4NYLOlJTnUM1mIg3rK+4ioL
         uaV+TK9ByOOkMy0SUh80muA3ZmAhU8x2F3Ssa25KXrR3PEBAAzUs+jKT8LoXfrGf0pdC
         vhgUcMympuQb1cZ3wS1YJUoBNrVHKhuYCTpNr3EMuLka1cYxbJMtJ71isuayNcIMoLb2
         Ru+7ZQFjGQDLp20UN6O+Nh4dBWUtVMuRjX7hogwsU8xz6EAAiPZTLrqL7XY90Nste2M1
         E5ZQ8XMkmP6icbC8/kok/JzVjaKK7nlmT7/B2Zl05+9mKXKyw/WZKXNOuSe9dAKbUSGy
         sg2w==
X-Gm-Message-State: ANoB5pnmuTNDiiiLkb4yUBJ3V3bQT4z4Y63+kulAMSTCcF2If/OOHqSB
        VZeZVtdFZZMyY2GU9R2AxcbRxA==
X-Google-Smtp-Source: AA0mqf4+dUpe//QvM1kAIjVKsxybn3o5eGV9dbBAKWQ/+uyuAWO3EgwP5bvG4vDdaIa0hXIKdFB9dA==
X-Received: by 2002:a5d:6b46:0:b0:236:56a6:823e with SMTP id x6-20020a5d6b46000000b0023656a6823emr11465977wrw.495.1669046309483;
        Mon, 21 Nov 2022 07:58:29 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id k18-20020a05600c1c9200b003b47b80cec3sm20025676wms.42.2022.11.21.07.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 07:58:28 -0800 (PST)
Date:   Mon, 21 Nov 2022 17:58:27 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 0/6] clk: imx93: fix and update
Message-ID: <Y3ugI0+hS7OrWaMW@linaro.org>
References: <20221028095211.2598312-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028095211.2598312-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-10-28 17:52:05, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> V2:
>  Update commit log for patch 3
>  Add comment for critial clock for patch 5,6

Applied all. Thanks.

> 
> patch 1 is reported by Dan and marked as fix
> 
> During our development, per updated reference mannual and design
> information, correct enet and drop tpm 1/3, lpit 1/2.
> 
> The TPM/LPIT patch 3,4 are not marked as fixes, there is no user,
> so update binding and driver both.
> 
> Patch 5 enable HSIO root always on
> Patch 6 enable sysctr always on for cpuidle
> 
> Jacky Bai (2):
>   clk: imx: keep hsio bus clock always on
>   clk: imx93: keep sys ctr clock always on
> 
> Peng Fan (4):
>   clk: imx93: unmap anatop base in error handling path
>   clk: imx93: correct enet clock
>   dt-bindings: clock: imx93: drop TPM1/3 LPIT1/2 entry
>   clk: imx93: drop tpm1/3, lpit1/2 clk
> 
>  drivers/clk/imx/clk-imx93.c             | 38 ++++++++++++++-----------
>  include/dt-bindings/clock/imx93-clock.h |  4 ---
>  2 files changed, 21 insertions(+), 21 deletions(-)
> 
> -- 
> 2.37.1
> 
