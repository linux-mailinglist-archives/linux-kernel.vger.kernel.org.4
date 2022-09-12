Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0346C5B5715
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 11:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiILJUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 05:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiILJUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 05:20:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CE113D6F;
        Mon, 12 Sep 2022 02:19:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 676DF6113B;
        Mon, 12 Sep 2022 09:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0DCC433C1;
        Mon, 12 Sep 2022 09:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662974394;
        bh=ytCTNUHgOKXn1eZftOJFEw86dHLh9awuaHA6Xlg3s9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i1dmA7AHqqzLb7uO6M29HFYzUeM6CIRYE007zpR7eTqxYsOtKjZWhpdM6EaupnWRI
         +4ER+3izVkznkXrtWDGyKGyK1uWcDojDLM9pZ00inxYhQ9gxAx0nxqFikFDKeB1+EL
         T5cYeZ/ouiLiVYNqrMmGSu6nIPaYSSG/5Lo6lk41QBaPDoi2ZUvZ4J82GcS0KWyDq8
         GksD+GfxaTWZaYCuHQEfQI0uG3uoe+0MkkymcS7Urnjfz83Q+0rhbFjPEo6fyj8DrQ
         4Wex9PLHHUcjX8KETMqT3yKQt7byniFtFgk2qbvWAzdMTU5SsHt0FI6iIU+y0z93gm
         Vcmj0v7MgodxQ==
Date:   Mon, 12 Sep 2022 17:19:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V4 0/8] arm64: dts: imx93: add several nodes
Message-ID: <20220912091947.GT1728671@dragon>
References: <20220905055915.3878000-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905055915.3878000-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 01:59:07PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> V4:
>   Per Rob's comment, use syscon.yaml for i.MX93 aonmix/wakeupmix blk ctrl.
>   Drop status okay in s4mu node in patch 4 per Shawn's comment.
> 
> V3:
>  Address DT maintainer's comments in patch 1
> 
> V2:
>  Add binding doc for aonmix/wakeupmix blk ctrl
>  Update compatible in patch 5 according to binding doc
>  The lpi2c binding doc has been accepted:
>    https://lore.kernel.org/all/Yw3hfcQ2JV248GIo@shikoro/
> 
> V1:
> Add S4MU, BLK CTRL, PMU, LPI2C, LPSPI nodes.
> Add GPIO clk entry.
> Correct SDHC clk entry
> https://patchwork.kernel.org/project/linux-arm-kernel/cover/20220812074609.53131-1-peng.fan@oss.nxp.com/
> 
> Peng Fan (8):
>   dt-bindings: mfd: syscon: Add i.MX93 blk ctrl system registers
>   arm64: dts: imx93: correct SDHC clk entry
>   arm64: dts: imx93: add gpio clk
>   arm64: dts: imx93: add s4 mu node
>   arm64: dts: imx93: add blk ctrl node
>   arm64: dts: imx93: add a55 pmu
>   arm64: dts: imx93: add lpi2c nodes
>   arm64: dts: imx93: add lpspi nodes

Applied all, thanks!
