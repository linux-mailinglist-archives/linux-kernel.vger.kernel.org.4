Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8EC65A911
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 06:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjAAFgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 00:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjAAFgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 00:36:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB7DDF3;
        Sat, 31 Dec 2022 21:36:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3572C60D2B;
        Sun,  1 Jan 2023 05:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9E5C433EF;
        Sun,  1 Jan 2023 05:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672551371;
        bh=OiGw7H+3t1JqIDP+SXlEbOxp37gN2aAx8D0aRSDOYQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MBg8VgFoWYsZ50xLq0Y+VEHjrY5GzVJ/lL7oI2tbh74Uwucx5DkoiTb5HrYtBhQ/u
         4NSMXtyX8fjVwTCw7mdQ4qpV/XjKJyAsI0jAxZ5bjCAxXh6wUzoQ69JDMOfiaXf6qr
         Z4JKaQbJ+Kz6qsFCLqfp8FsvaUtrpgccEgh3EDBCHXWtEkKiiRuzSXgKBtM44umRD1
         UEEDVvdO/u3qzhddql3GS5oOg3ZDjawzM6O6n2Sgm5CHtWPLvrFFnES8gE1Qqwq80+
         DIQsfc4LxQA9hmm6tK6JppfR8DExDAdpZAgXkYjJbz4VLENqFBDwm3oDQ+417Gu0zO
         JkXyVKYmOoa/Q==
Date:   Sun, 1 Jan 2023 13:36:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] ARM: dts: imx7s: correct iomuxc gpr mux controller cells
Message-ID: <20230101053604.GB6112@T480>
References: <20221223030433.17345-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223030433.17345-1-peng.fan@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 11:04:33AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Per binding doc reg-mux.yaml, the #mux-control-cells should be 1
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks!
