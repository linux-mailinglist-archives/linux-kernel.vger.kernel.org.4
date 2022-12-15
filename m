Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC1364D9BF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 11:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiLOKuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 05:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiLOKuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 05:50:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EA22B274;
        Thu, 15 Dec 2022 02:50:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43C3461CE0;
        Thu, 15 Dec 2022 10:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E34C433EF;
        Thu, 15 Dec 2022 10:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671101430;
        bh=0tc8CxRTfC5rdugzN4jzLVxBoOycbgCTK5F8bKMJ9OY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gs66ooJqpNjWolvbm7j/gPGp2jEb3N7H2wVX6UJetNFK1WnUOkkN3qd4/eB+oKB+N
         oxIDFCMbDoiYgr3MBRrD1w9q7mfd8YTCWP7ILz0G9qZYMQQ1gPke3rGO/AJysQfmv9
         yWmg1sQbS2rquL30Vbo1p01cHJZhp44oNrHj08Bc3VfZvcu1G1SBjEUfP2I0Irj9cI
         +pwycLOXOAWHiVjzS6KAXcAfftp9FcBD5Nv0AZVWriuHrfH+mXDAeX7P+tLkYmjDpv
         D8ToXT0NLnIm08NoZz2/keL79quD3qMtxaHCpLpXK0gQeoOoV//hpvXCaJb5iEMpyV
         Q+DN86iI3Z0gQ==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1p5loq-00CpAU-89;
        Thu, 15 Dec 2022 10:50:28 +0000
MIME-Version: 1.0
Date:   Thu, 15 Dec 2022 10:50:28 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Jagan Teki <jagan@edgeble.ai>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kever Yang <kever.yang@rock-chips.com>, kernel@collabora.com,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: Re: [PATCHv6 3/7] arm64: dts: rockchip: Add base DT for rk3588 SoC
In-Reply-To: <CA+VMnFzMgOC7sgcpQ7nZx2gaJfqqvRu8RxETguaBHN1Lg_nG_w@mail.gmail.com>
References: <20221214182247.79824-1-sebastian.reichel@collabora.com>
 <20221214182247.79824-4-sebastian.reichel@collabora.com>
 <CA+VMnFzMgOC7sgcpQ7nZx2gaJfqqvRu8RxETguaBHN1Lg_nG_w@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <9a3cf2f1567f2a5990ed6dea9d6a5669@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: jagan@edgeble.ai, sebastian.reichel@collabora.com, heiko@sntech.de, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org, chris.obbard@collabora.com, benjamin.gaignard@collabora.com, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kever.yang@rock-chips.com, kernel@collabora.com, yifeng.zhao@rock-chips.com, zhangqing@rock-chips.com, sugar.zhang@rock-chips.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-15 10:45, Jagan Teki wrote:

> One nick with dtbs_check,
> ethernet@fe1c0000: Unevaluated properties are not allowed ('reg',
> 'interrupts', 'interrupt-names', 'power-domains', 'resets',
> 'reset-names', 'snps,axi-config', 'snps,mixed-burst',
> 'snps,mtl-rx-config', 'snps,mtl-tx-config', 'snps,tso', 'mdio',
> 'stmmac-axi-config', 'rx-queues-config', 'tx-queues-config' were
> unexpected)

You did read the cover letter, right?

         M.
-- 
Jazz is not dead. It just smells funny...
