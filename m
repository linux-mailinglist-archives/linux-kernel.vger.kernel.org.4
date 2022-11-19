Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E205630AF4
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 04:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbiKSDGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 22:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiKSDGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 22:06:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF769B70CD
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 19:06:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BD7A6281A
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 03:06:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1422CC433D6;
        Sat, 19 Nov 2022 03:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668827203;
        bh=gkw2/6jX0B2g/jnVIyOy/7gbYRi7hDts1olY8pQaCjo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SpZlXZfd7JVMeLq8YdSnimPSVEJ5lwlVUI9Gmio3lws/cPYv9uACrku1up4PNTPI6
         CPelfHVOFTmSZHsbiTJKKBpqodC3OdzNXbbcGQJ5Y+8r4RhKy7NfhOstNyDDL6yTh1
         vvt0PWt7tM3c4/MaLTdueiwtuFgtjeXCZjvi89zduD2L/sFYqV0trEiqE7U3ymdklx
         N9BCKXK8zah3Wpm9kLwLwiDWxUhMd39+LKIrnJb1y4AfQWNfzyaPNPgdHtKn2Cxsso
         KX3OZ0p0CETo+1UuY+exfRQ/xNn64rgNGiimDzi2a1qF9Izg0QrEKEISB05css0MBq
         WXn+80tHoXz1w==
Date:   Sat, 19 Nov 2022 11:06:36 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH V6 06/12] arm64: dts: imx8mp-evk: enable I2C2 node
Message-ID: <20221119030635.GG16229@T480>
References: <20221117095403.1876071-1-peng.fan@oss.nxp.com>
 <20221117095403.1876071-7-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117095403.1876071-7-peng.fan@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 05:53:57PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Enable I2C node for i.MX8MP-EVK
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

Applied, thanks!
