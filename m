Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA472630AF3
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 04:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiKSDGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 22:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiKSDGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 22:06:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642E3B7036
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 19:06:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22559B82670
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 03:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18197C433C1;
        Sat, 19 Nov 2022 03:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668827160;
        bh=1GtXLtTjXcjach2gwnI/5JDCEaulCsRdzKd6MV1upzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g4/0HczIaVbyaHK9IqVZ896AaZK4Ti5gECs+ueSbEZ0J0XH7q/JLXKRkwSBggyDq+
         M9/kPnUtcvB1ZBrQCCUiqsbGFRuV53a6E0YPHU+3xY11OgpwOPv2qzLdJg6v0i9+VB
         Do/P8zbTl46VQtqASlbdmGcjqol/cnN3tUy3iDMHxVSPFiQU6Ixc3Z+9XNPtOB6I6h
         RoIHfTmhCgSpSnAnPVc1Od4xZHYgVMMze33JCxrASQesdmQCZhVXt2157VAXEEbtxA
         zrX6qqDUdiQHwQ5yxUDuTMqP17XMVtGojl8dfjfkaZ27NguZucQmM3i4r08sx5TjCu
         iCYVkHKww2DWg==
Date:   Sat, 19 Nov 2022 11:05:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Han Xu <han.xu@nxp.com>,
        Frank Li <frank.li@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH V6 05/12] arm64: dts: imx8mp-evk: enable fspi nor on
 imx8mp evk
Message-ID: <20221119030551.GF16229@T480>
References: <20221117095403.1876071-1-peng.fan@oss.nxp.com>
 <20221117095403.1876071-6-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117095403.1876071-6-peng.fan@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 05:53:56PM +0800, Peng Fan (OSS) wrote:
> From: Han Xu <han.xu@nxp.com>
> 
> enable fspi nor on imx8mp evk dts
> 
> Reviewed-by: Frank Li <frank.li@nxp.com>
> Signed-off-by: Han Xu <han.xu@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

Applied, thanks!
