Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1588C6E793D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjDSMCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbjDSMCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:02:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF04D336;
        Wed, 19 Apr 2023 05:02:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A8B863E39;
        Wed, 19 Apr 2023 12:02:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF269C433EF;
        Wed, 19 Apr 2023 12:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681905734;
        bh=ZI2jxO0g5yp47daWZtUuG8EFrHfj96WR/LFnKZ1hjLo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pAEbQOf/1xQI1VyTOJz1PSQ+VH3LYyHZVQgwW6vdSWIapYNpuHnBGWX83YND9LZYc
         VHIImidFFo5bDw0bjx8PuR9fxSbJdNQGjL5dTsb/Su/WsnHxfBznW8Ka4f27Tq0KUs
         nJgwCqHes9+4bgUUdSKM/aF6gp9PvMOUeSCazXBhWS7GzjrMzMrOLlLFQaAzub6dAD
         qF/J5l4rK/+myqHayTyE1vuzp2PSAcDdgtwqSAb6g6ljbMxLsj9DoyHpGJhDH4T8bt
         t97dQBashNYWFmuVpVzrQ7I18nX3Ffsozbzn0uvalhGeNff9d2PQBC9UiAHzrLCJ4T
         6VNzkLNG+srKA==
Message-ID: <e59482e9-6d27-8e1e-82a7-51e059b6ae8e@kernel.org>
Date:   Wed, 19 Apr 2023 15:02:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/5] arm64: dts: ti: Drop bootargs
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tero Kristo <kristo@kernel.org>
References: <20230418165212.1456415-1-nm@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230418165212.1456415-1-nm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/04/2023 19:52, Nishanth Menon wrote:
> Hi,
> 
> This has come up multiple times, so cleaning it all up.
> See [1] for context. AM64 is covered in [2].
> 
> Nishanth Menon (5):
>   arm64: dts: ti: k3-am62x-sk-common: Drop bootargs
>   arm64: dts: ti: k3-am65*: Drop bootargs
>   arm64: dts: ti: k3-j721e-*: Drop bootargs
>   arm64: dts: ti: k3-j7200-common-proc-board: Drop bootargs
>   arm64: dts: ti: k3-j721s2-common-proc-board: Drop bootargs
> 
>  arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi         | 1 -
>  arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi     | 1 -
>  arch/arm64/boot/dts/ti/k3-am654-base-board.dts         | 1 -
>  arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts  | 1 -
>  arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts  | 1 -
>  arch/arm64/boot/dts/ti/k3-j721e-sk.dts                 | 1 -
>  arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts | 1 -
>  7 files changed, 7 deletions(-)
> 
> [1] https://lore.kernel.org/linux-arm-kernel/81134eb9-2b7d-05bc-3035-a47f020861a8@linaro.org/
> [2] https://lore.kernel.org/all/20230414073328.381336-1-nm@ti.com/

Reviewed-by: Roger Quadros <rogerq@kernel.org>
