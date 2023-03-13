Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A297A6B7028
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 08:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjCMHcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 03:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCMHcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 03:32:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244B33E088;
        Mon, 13 Mar 2023 00:32:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF1F0B80DFD;
        Mon, 13 Mar 2023 07:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67F8C433D2;
        Mon, 13 Mar 2023 07:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678692760;
        bh=lpu6jMEeem4WeajO2We6FypBaAuvGZz3i43Q0SFJxf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KqCUQC6wTTJoNIiAzQp+ewdDpEXNDMRCJj+kHlxLWEkmH88F9HXsE3EWfR634hwtx
         82Y1sR6u25JHQh+zjhRzyC2pgYLqxpHoYb3UPDR9F+3nTzXl6FuN7DlAj9hhz3SLT2
         1+AoScevwp4Ifn4wFLI4Xf6vpHL228WMiAg+Wi9ek6cWSkmXanPSPEsxcivpNm5G7y
         afIE0M44n0B9BzBYn5k/js32ItdWApBWyLTY2FMFhc5vhO+sJ9+zWvVBEeoj2Ywlo5
         xRM0icbAIR1L4jaF4xOTx+/5CmfQwJxGgsM42nOBAA71VYZzrt26qb3Ok4DLgxLii5
         ZT9IyTaoerLYw==
Date:   Mon, 13 Mar 2023 15:32:32 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64: dts: verdin-imx8mp: add pcie support
Message-ID: <20230313073232.GJ143566@dragon>
References: <20230208065947.24195-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208065947.24195-1-marcel@ziswiler.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 07:59:46AM +0100, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Add PCIe support on the Verdin iMX8M Plus.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Applied both, thanks!
