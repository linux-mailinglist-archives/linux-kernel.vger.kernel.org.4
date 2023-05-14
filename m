Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E28A701B13
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 03:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjENBmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 21:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjENBmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 21:42:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406881BD8;
        Sat, 13 May 2023 18:42:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEC3C61047;
        Sun, 14 May 2023 01:42:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60510C433D2;
        Sun, 14 May 2023 01:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684028526;
        bh=sMypGCQaQd9D3Yvbumxmupj24hQgJpNTtWFMN6so06o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Es/0XeSQpyQkMEygPRtFDbd9KcnMqZv40p70vF5spT7ijOVpy+EYq8g9/8k/1J8dY
         Z5CBVMi3pL9TzcZelYq/ZTitZi/aq2PpJCBk/W+o8aO/2BOqKXJnnn/PF0GbUzEmmX
         0njseZHzA3IYBZI2yaHUi/ZgXDYwM2zI+lN7moinMepF1jP8UbRbE5BW2BVtT8k4/P
         8KzhisglIUWVhCWc80jw216wOJ+C+4yeEtspEbXnraiHtaLGkCYbS8V9G1QASZznPT
         mYH4IxV8L2bGpO84/iDNTJOlxPX08eS1MS/KZRo3GJG9dCv10mLhPwa7ssBCLvwQK/
         kRo6mwNU15IPg==
Date:   Sun, 14 May 2023 09:41:54 +0800
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
Subject: Re: [PATCH] arm64: dts: imx8mq-mnt-reform2: drop invalid
 simple-panel compatible
Message-ID: <20230514014154.GF727834@dragon>
References: <20230326204502.80794-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230326204502.80794-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 10:45:02PM +0200, Krzysztof Kozlowski wrote:
> "simple-panel" compatible is not documented and nothing in Linux kernel
> binds to it:
> 
>   imx8mq-mnt-reform2.dtb: panel: compatible: ['innolux,n125hce-gn1', 'simple-panel'] is too long
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thanks!
