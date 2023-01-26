Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0478F67C14C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 01:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjAZAEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 19:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjAZAET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 19:04:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E820E4EF6;
        Wed, 25 Jan 2023 16:04:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FB83B81C5C;
        Thu, 26 Jan 2023 00:04:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE4AC433D2;
        Thu, 26 Jan 2023 00:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674691456;
        bh=BajN1pxrudZpRdEhuGKUBOCccXIvYPrPYcb1OtJdFLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OtvNGAAwAGzi28U9znQYqCrk+liVRmWCmqgdGIo4h3LlWB3Qi3mQspDwNR9rCl5m4
         wQBbUKRkxg1kWORw3ro/na+hxD42GC6WNsSWYKZx56krN7KrSeFMTxXythA/PJqrej
         igss1JAC/qjprNF7VUwTS+EY08KN6ra4Gji/5CJAOw5tgAk13sKv5eT1jsjpEXqmhi
         SMw/HuPvhTtBifGSDPSJCr3aSNmKQ3xUeNihDza4/caPwCeiB61BTMM/vaXCtZFTdz
         pq2Swwci7RWy6qc/9EGE8U9IYAOZn8wCxYqiG+ZRxgmPBUZLcfgNbk5BN8IpayFiIu
         mwiMOBo55Ihrw==
Date:   Thu, 26 Jan 2023 08:04:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx: e70k02: Add touchscreen
Message-ID: <20230126000408.GK20713@T480>
References: <20230107123621.1944420-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230107123621.1944420-1-andreas@kemnade.info>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2023 at 01:36:21PM +0100, Andreas Kemnade wrote:
> Add the touchscreen now, since the driver is available.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Applied, thanks!
