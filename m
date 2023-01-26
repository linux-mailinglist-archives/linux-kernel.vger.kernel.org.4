Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E2467C232
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 02:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbjAZBI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 20:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjAZBIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 20:08:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76079233F4;
        Wed, 25 Jan 2023 17:08:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14E65B81C20;
        Thu, 26 Jan 2023 01:08:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AD6C433D2;
        Thu, 26 Jan 2023 01:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674695301;
        bh=qDLxqcxro8Fb/iD8e6CZqTljSHVUsR/DwIvQVMcR+VA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iza+lXHYFIfstRuQjaClV3jxV3xo/N5qIqrqSVXiUAyW4FxDH3bjSwLAQkNDr6sAG
         lSm3FbVgJJ1Cd0heiqm/JSNHR0fYIbZVvJsq3sUkjeMhExUOT9HocLp5PVjh0PsBbt
         u7XIfeppAmoqIIV2eg3PlctppWI7iTM9/XePrAHdAPVuMB8HQnOAQFihAOlnWdIrs5
         z7GUPoOE/wyf/pexogLzuK404biwRaxa0IGxBE4gxBidffkrbW1+GC2eHJHqK+FcXL
         SCw8a65d6ue5yPYjUxo/aJgGQLdcemU3cNkl/qc/mHbj7zKghe9Sp7Jprib7b1CvBW
         h9AFnTntSfIBw==
Date:   Thu, 26 Jan 2023 09:08:13 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Pierluigi Passaro <pierluigi.p@variscite.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, marex@denx.de, peng.fan@nxp.com,
        marcel.ziswiler@toradex.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        eran.m@variscite.com, nate.d@variscite.com,
        pierluigi.passaro@gmail.com
Subject: Re: [PATCH v2] arm64: dts: imx8mm: Fix pad control for UART1_DTE_RX
Message-ID: <20230126010812.GP20713@T480>
References: <20230115213503.26366-1-pierluigi.p@variscite.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230115213503.26366-1-pierluigi.p@variscite.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2023 at 10:35:03PM +0100, Pierluigi Passaro wrote:
> According section
>     8.2.5.313 Select Input Register (IOMUXC_UART1_RXD_SELECT_INPUT)
> of 
>     i.MX 8M Mini Applications Processor Reference Manual, Rev. 3, 11/2020
> the required setting for this specific pin configuration is "1"
> 
> Signed-off-by: Pierluigi Passaro <pierluigi.p@variscite.com>

Applied, thanks!
