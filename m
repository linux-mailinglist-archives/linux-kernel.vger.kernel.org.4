Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B36565A494
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 14:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbiLaNPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 08:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235673AbiLaNPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 08:15:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6C426C;
        Sat, 31 Dec 2022 05:15:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0ABC960B7B;
        Sat, 31 Dec 2022 13:15:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877E4C433EF;
        Sat, 31 Dec 2022 13:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672492534;
        bh=+fyQelX2YEkwKk/R0gb/pu3oskuUU7fmVffXDjvUYNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y7gPL1hOX+jZ9NR0Cp3jOKa5EVDUe8pNzGJYCYH27Ypqjk3u2gsFtQW964N6fLnq0
         uJgtx+hqq2NjORfrlx6LtlOPpbTnylxnOj/T2kH/lW3/h7SKz/z5d6SxtUIC88iWzP
         Xm2rxgJPJudfSR+gy5OvPd8R9nZZGATX7AOsa+nCsedUm0UnoasF1yckzRdiB/qHwP
         LWJ5GgAUkM1WXK3h5s9dtfmCMC8uexYYBpbQzWCvn8AIy4823xEZvM8jpOoPUgJsvS
         SZ5fT00BMsdDBrONggielz98C7Eej38i9zSY1frVAVgHJJLb1mBzVyIe9PmuWDTTRk
         xhIEg+PYV2zXg==
Date:   Sat, 31 Dec 2022 21:15:27 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8dxl: drop 0x from unit address
Message-ID: <20221231131526.GC6112@T480>
References: <20221210113345.63912-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221210113345.63912-1-krzysztof.kozlowski@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 10, 2022 at 12:33:45PM +0100, Krzysztof Kozlowski wrote:
> By coding style, unit address should not start with 0x.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thanks!
