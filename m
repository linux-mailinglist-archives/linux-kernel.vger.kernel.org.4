Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3166620DC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236803AbjAIJC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236995AbjAIJB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:01:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E70D2DF0;
        Mon,  9 Jan 2023 00:54:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A67BB80C93;
        Mon,  9 Jan 2023 08:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1109C433EF;
        Mon,  9 Jan 2023 08:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673254478;
        bh=deTyYnPUnHVIPeYpi/7VoxYIKHkZH1Xp/uL8xINTh1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JOL2evPFHikyCG2MO1sq/wJfcDKa3bVR47+ezAq/WC58gQ6Oj1HL4jwaJk978L9e1
         x+yOZK+rbFyMqEwGYBo73NaL3M8lNI1WUMUVpErPOd12r47CuagoqSqzmOpwNx7wPJ
         3cBuSnmtx8GpAh8wcR5LDqvGk7GgBQHnHLwnIZVGjLVyOnX75P6Gi9X9b5AZg7NscS
         Rp87hPJS6lmBRAdM3zKTWDZnB8XKXCw0ePaqyxnBROjAyJN31To4Tj3UMHMLp0boRR
         D5mNc00yK/dR4q3Mqgt7mMHuLRLqOx8hbPytcT0nq+RatOi6kUOxVgFEXrOH6P4qw2
         Sh85sp/IuqyOg==
Date:   Mon, 9 Jan 2023 16:54:33 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm64: defconfig: select i.MX ICC and DEVFREQ
Message-ID: <20230109085432.GJ18301@T480>
References: <20230104105754.1219877-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104105754.1219877-1-peng.fan@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 06:57:54PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX ICC and DEVFREQ driver is required for i.MX8MP normal boot,
> because the BLK CTRL power domain driver requires QoS configuraton.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks!
