Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E8A62781E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbiKNIt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbiKNItZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:49:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BAF13F8C;
        Mon, 14 Nov 2022 00:49:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9988AB80D1C;
        Mon, 14 Nov 2022 08:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098A6C433C1;
        Mon, 14 Nov 2022 08:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668415761;
        bh=/QzUFljXoJhTjmUgRPnur7acq4R1l8evJRFwDjdzdpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BNEhNDn+WkFjLIx7U/8ssLtRl3Xo57rK/6ekbxK89pSQDZ/BG3liclMoyMWXiSEax
         CsmBAl/S7u3Ir4l6PZeykx58ZWXgua/MT5i7wMPxgIFPrOKSJUmdBH4HuvO7cje6IS
         mo0B60Ddm3E2mA3Fu+ylexMuC7clFi+DCj445QJX38e99kuUtsq5m5ulI9XaZ9k76H
         Ogx4f+2E7qlTUiNYMrNJuikCkCtbVC0ggXC68KjtzNocJkYBLS9eMMi9w40tO8pDtz
         gYpX+4lC6dZpM3AI/150xS+QezyewtQVMsoCNhNaXr69ntpKACSHCOTb9Xo0hL1ES1
         hhHWZomijy0Lw==
Date:   Mon, 14 Nov 2022 16:49:13 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        festevam@gmail.com, han.xu@nxp.com, imx@lists.linux.dev,
        kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shenwei.wang@nxp.com
Subject: Re: [PATCH v2 0/6] add adc0 flexspi lpspi to 8dxl evk board dts
Message-ID: <20221114084913.GU2649582@dragon>
References: <20221111154742.2753318-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111154742.2753318-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 10:47:36AM -0500, Frank Li wrote:
> Add adc0 flexspi lpspi and adc to 8dxl evk board dts
> 
> Change from v1 to v2:
> 	split SOC and board change to two patches.
> 
> Frank Li (6):
>   arm64: dts: imx8dxl: add adc0 support
>   arm64: dts: imx8dxl_evk: add adc0 support
>   arm64: dts: imx8dxl: add flexspi0 support
>   arm64: dts: imx8dxl_evk: add flexspi0 support
>   arm64: dts: imx8dxl: add lpspi support
>   arm64: dts: imx8dxl_evk: add lpspi0 support

Applied all, thanks!
