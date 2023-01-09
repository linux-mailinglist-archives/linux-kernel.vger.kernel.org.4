Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33DF6620D2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbjAIJBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236870AbjAIJAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:00:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD201839C;
        Mon,  9 Jan 2023 00:52:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A88E60F64;
        Mon,  9 Jan 2023 08:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89118C43392;
        Mon,  9 Jan 2023 08:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673254342;
        bh=ON51W0KW3eubukMtXSLrXoIkB71m/gu6sk3xJBg5bP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NiCtskm5xptM8PGSCN/NbW+t9fajk2ysvFtfkmhlYlR/z4iycpoelroCAknkSjKlp
         Qyq/TIHLTuGRm0xvEdoy4o5N06L7zE1FqgBQ4ktz9RdoTG+bH2YknMAXwh9sigOA0o
         580Z/yVMlet2pxtU4w7l/4hUK2HxqDj6TjUsi0VZ2D1P9eA4jiRG6WVDRmXpOAZVyr
         40mW1VCaEpCvyREGnnRDdGqtzcJAQsgvLp9Ke0klZViwTM5RwHf8/yMp8rtSccu41K
         oEYKwlnqVKqhCXvlchth1CfXBnHGuiWCK5V1PvMtFoQOaIiYdWW3f+4K2TtXQmnvLT
         GPPTuSfy3sNpw==
Date:   Mon, 9 Jan 2023 16:52:15 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2 0/5] binding: imx8m: add IOMUXC GPR
Message-ID: <20230109085214.GI18301@T480>
References: <20230104002545.3473598-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104002545.3473598-1-peng.fan@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 08:25:40AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> V2:
>  Update nodename to syscon in patch 3
>  Add A-b/R-b tag
> 
> Add binding doc for i.MX8M, update dts to match binding doc.
> This is effort for ARM System-Ready 2.0 certification
> 
> Peng Fan (5):
>   dt-bindings: soc: imx: add IOMUXC GPR support
>   arm64: dts: imx8mq: correct iomuxc-gpr compatible
>   arm64: dts: imx8mm: correct iomuxc-gpr compatible
>   arm64: dts: imx8mn: update iomuxc-gpr node name
>   arm64: dts: imx8mp: use syscon for iomuxc-gpr

Applied all, thanks!
