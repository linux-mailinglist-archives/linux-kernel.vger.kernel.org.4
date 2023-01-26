Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7CF67CA2D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 12:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237317AbjAZLlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 06:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236303AbjAZLlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 06:41:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AB53401E;
        Thu, 26 Jan 2023 03:41:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55D71617AA;
        Thu, 26 Jan 2023 11:41:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFFDC433D2;
        Thu, 26 Jan 2023 11:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674733262;
        bh=qfPOMQevseGKzABgISEcHtF7Q+YV2186ncy5J7RmObY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ryhKIv0NE1kuQ5Aohznk405P8vNiHaF4shr7HjLkY8LmXXbH6vq+sTwRUU/VpPhfe
         iDJTaYfAzWXQw4cbmZ79Sj+we6BSe7YQVh7doSFZiZgvYuu94UJjmVDYt7aiyOuw3/
         6Jmefv+7eb/JtIXs0ZUaGCnIbG5X9F9TcqOhdbRx8IpgJaNJVKD3NRdyGi47W214+l
         DLQB6YGs3FrZqMe6HpmF6Yo8YM0qUeEBKllufkYksphNFpe9R/wW8r6CfXT8Y4RcsY
         +aHwdkjVi7dj4ruaeQXTo70D/nJaSuXRuy/XIxe09zP7YLlfy7WVfxrv/WGirxn/jt
         1yg9M/q7Gs6VQ==
Date:   Thu, 26 Jan 2023 19:40:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: imx: use generic node name for rave-sp
Message-ID: <20230126114054.GI20713@T480>
References: <20230123151555.369881-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123151555.369881-1-krzysztof.kozlowski@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 04:15:54PM +0100, Krzysztof Kozlowski wrote:
> Use generic "mcu" node name for rave-sp node, as recommended by
> Devicetree specification.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied both, thanks!
