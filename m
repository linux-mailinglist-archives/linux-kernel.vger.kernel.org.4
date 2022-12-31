Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC5F65A4A7
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 14:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbiLaNZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 08:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiLaNZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 08:25:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D38B4A3;
        Sat, 31 Dec 2022 05:25:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 962C560B8F;
        Sat, 31 Dec 2022 13:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF85C433EF;
        Sat, 31 Dec 2022 13:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672493101;
        bh=5PZPgJEHktYRM/SPSh0nVBX31Neelz4nDGmyzaBTmME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VcpGpEnKlMOFN6PPzrYgB/NdvxWt5L9UGKIrB23YV/jr4lyNxwzbZgeDFuD9+Z/X8
         hSt/055NezQFRS+RJPsf5yAkSei3HAL5ToxIS2ggfAQKsgy2q6TzgLjSbaN83RE3iI
         Iu7ZZo80eAp7zGuf1L7ZFQ6Tcas9y4Ma0RjE9MrmE3bFqNOic1cg5UpX2usrt5kskK
         B9As6kQiCfUNTDvT5dw9mxFhpQi/CYUPBc7tCv4JGk1bvD57Lm+DUmgMbAyLwAl7nI
         7HsApOrzq/ngQzQqc5o6Pb7C4Z2Q8AKI5PRngLNySb0+TgJQ8phErfbQRrwp/c4NoI
         KjA+EbsDMTq0w==
Date:   Sat, 31 Dec 2022 21:24:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Bough Chen <haibo.chen@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jesse Taube <mr.bossman075@gmail.com>
Subject: Re: [PATCH v4] ARM: dts: imxrt1050: increase mmc max-frequency
 property
Message-ID: <20221231132451.GE6112@T480>
References: <20221214163817.55909-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214163817.55909-1-giulio.benetti@benettiengineering.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 05:38:17PM +0100, Giulio Benetti wrote:
> According to i.MXRT1050 Datasheet usdhc supports up to 200Mhz clock so
> let's increase max-frequency property to 200Mhz.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Acked-by: Jesse Taube <mr.bossman075@gmail.com>

Applied, thanks!
