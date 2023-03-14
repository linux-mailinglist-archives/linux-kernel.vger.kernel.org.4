Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568276B88BA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 03:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjCNCqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 22:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjCNCqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 22:46:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618648DCFF;
        Mon, 13 Mar 2023 19:46:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE18B615B7;
        Tue, 14 Mar 2023 02:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2A6C433D2;
        Tue, 14 Mar 2023 02:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678761988;
        bh=4dllyMWm4lWzU02nHN4TRbjFiPsjqPq9jzWYb8G5KwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lsbGJXe/ypWPK/pk0ZmIbjqodx3lpjiz/BTZW1A/9iNbITuyIoyz4rGBQE/XiyN8q
         DwNctJgNPyL0gow06IQ90Daw+XtDfxliwHmO9Yb6mad9VlwrfZzBOFdaAQZvV6efFh
         hcp44F9NYjDEnRgsBiRNwcbxYd90MZyfpBMTEV1WTpVsGwCmUwEPeCMiV0TwMo5YyM
         DNRg8vB2Kl1Zkl38E7zxXUmYSnNNFfUpf8pTGmkAVussURv0rYaxO4XLDUIEhM/2ut
         4WftVaWkYHLiW/4bADcO12XBq/eFVUbhexihqL9FJbw0IwCJGqYj4WyuiB6yjESucY
         oeyUUV61vXVlg==
Date:   Tue, 14 Mar 2023 10:46:20 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@puri.sm
Subject: Re: [PATCH] arm64: dts: imx8mq: Add UART DMA support
Message-ID: <20230314024620.GH143566@dragon>
References: <20230221-uart-dma-v1-1-d20483bbd49d@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221-uart-dma-v1-1-d20483bbd49d@puri.sm>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 09:04:08AM +0100, Sebastian Krzyszkowiak wrote:
> UART ports have DMA capability. Describe the UART DMA properties.
> 
> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

Applied, thanks!
