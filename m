Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992C4659401
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 02:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbiL3BPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 20:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbiL3BPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 20:15:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAC317E06;
        Thu, 29 Dec 2022 17:15:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56EA461A05;
        Fri, 30 Dec 2022 01:15:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5A1C433D2;
        Fri, 30 Dec 2022 01:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672362929;
        bh=McTqHvRN41xTwEv99dreqL22zrTU3o6TLQAedEBl+9Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JXIK0oV7z1wgRm9u7ktIkrBFaN6psz8iJqLOfPIofVJjOgtOeaxcZrmZsQWho4N7S
         ZZhWlqzUXgKWpBeVoRGylUrqtnboVLd3TyEcF0MvsXio+te+GkbQ31X7/lxb4V3sTG
         6UOkk/yrhXwNMAYBheVZyF2iTsYKMWhRqLqgKut+rM+yPaIrxOdmx1hxF6QvNT1JRn
         2urMttcMWn11M/quHLlEIRCX0PJpwYc6zHdYRX6o2oW/jyiiOZYXAELi0VGUOIYZJ9
         HwgCWYmA8kmXmRbOKKORl3OIpyQ5QMuD85+lC2S7hnTa88BV0N/yNJ1jDLMhLB13On
         Xrav6WbVoW5qg==
Date:   Thu, 29 Dec 2022 17:15:28 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Biao Huang <biao.huang@mediatek.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <macpaul.lin@mediatek.com>
Subject: Re: [PATCH v6 0/2] arm64: dts: mt8195: Add Ethernet controller
Message-ID: <20221229171528.510b7a37@kernel.org>
In-Reply-To: <20221228063331.10756-1-biao.huang@mediatek.com>
References: <20221228063331.10756-1-biao.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Dec 2022 14:33:28 +0800 Biao Huang wrote:
> Changes in v6:
> 1. add reviewed-by as Angelo's comments
> 2. remove fix_mac_speed in driver as Andrew's comments.
> 
> Changes in v5:
> 1. reorder the clocks as Angelo's comments
> 2. add a driver patch to fix rgmii-id issue, then we can
> use a ususal way rgmii/rgmii-id as Andrew's comments.
> 
> Changes in v4:
> 1. remove {address,size}-cells = <0> to avoid warning as Angelo's feedback.
> 2. Add reviewd-by as Angelo's comments.
> 
> Changes in v3:
> 1. move stmmac-axi-config, rx-queues-config, tx-queues-configs inside ethernet
> node as Angelo's comments.
> 2. add {address,size}-cells = <0> in ethernet node as Angelo's comments.
> 
> Changes in v2:
> 1. modify pinctrl node used by ethernet to match rules in pinctrl-mt8195.yaml,
> which is pointed by Krzysztof.
> 2. remove "mac-address" property in ethernet node as comments of Krzysztof.

Please make sure to CC netdev@ on the next version of the patches.
