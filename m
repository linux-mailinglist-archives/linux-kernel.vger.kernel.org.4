Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A5367C620
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 09:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbjAZImt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 03:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236249AbjAZImi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 03:42:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C2411141;
        Thu, 26 Jan 2023 00:42:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F06BF61762;
        Thu, 26 Jan 2023 08:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44CEC433EF;
        Thu, 26 Jan 2023 08:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674722557;
        bh=Z+5NIu/i5Np3MiMi01ru5SciU6eREhcbki8VItd6gd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J5dJbPlfErrtE2d89elBQerCQiq89QmaVC8Enxqavch8CFQgw5WXwbqN59n06X1rt
         2RPyvkitDcPpxmaVV0t0yNguA3Zko2skzmGuv2KFP5gbYsF0EfUcKf/OrJwaVeXPde
         22Qb4c3buaD0SWZLoNa0LyZo+28u6A+BKT5hr8z2CMNCasbjiGP/opV1K0umgxnyws
         nuf6fW5TRl3wLZRdLn9lDZtHaL7qLhSxKgYxkqdbBwTJ//JxMNNEGt/YdiTHKJPJLd
         7ZGWkCIPuW0hO8pYIbkYRGvwTLGexfAqprporWt8naDqY7zKkrP4tHy78OZk4V2Amm
         UrQ/1N+rFKW0w==
Date:   Thu, 26 Jan 2023 16:42:30 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: power: fsl,imx-gpc: document
 fsl,imx6ul-gpc compatible
Message-ID: <20230126084228.GD20713@T480>
References: <20230120071717.138188-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120071717.138188-1-krzysztof.kozlowski@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 08:17:15AM +0100, Krzysztof Kozlowski wrote:
> Document existing fsl,imx6ul-gpc compatible used with fsl,imx6q-gpc
> fallback:
> 
>   imx6sl-evk.dtb: gpc@20dc000: compatible: ['fsl,imx6sl-gpc', 'fsl,imx6q-gpc'] is too long
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied all, thanks!
