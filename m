Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA796D7F4E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238085AbjDEOZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238471AbjDEOYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:24:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E23A30FF;
        Wed,  5 Apr 2023 07:24:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A8EE6235B;
        Wed,  5 Apr 2023 14:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF69C433D2;
        Wed,  5 Apr 2023 14:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680704684;
        bh=VuszIRZjrFoiCDqPfatPyKfoKS92mshcOivZVbeM40I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mIm6mcw3P1L8lQ/jLcijpaoe9FWGP4c+4B9JIoKSws1KHmFxvmdQ1/3wvWTIIuDVg
         /sClo0QHSla2woEs701PRXX9D183T04ofu+wxEHTSosmNIh3qumMZ2wg1ab25y4WVP
         yVclJNfC6JF6YpIKbTM6Gqx/9cT7qiJ00S5XhmOcdtmLODPEdzz3aFeU9NazRLib4d
         fBcY6JLSUfPjAJ8WxxvIdocc1lbdDdXkB7ngcALp0WSSnCHzCAMDgXs6fPsDr1RU2n
         nbZban9AS+p5sQIXQxCitLOektvabAu2wZltcntxhxBbFdf5cd3T9ZufP5wBZUqCAT
         fhl+og/NvubZw==
Date:   Wed, 5 Apr 2023 22:24:35 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, marcel.ziswiler@toradex.com,
        laurent.pinchart@ideasonboard.com, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mm-verdin: correct off-on-delay
Message-ID: <20230405142435.GG11367@dragon>
References: <20230328061905.1989856-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328061905.1989856-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 02:19:04PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The property should be off-on-delay-us, not off-on-delay
> 
> Fixes: 6a57f224f734 ("arm64: dts: freescale: add initial support for verdin imx8m mini")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied both, thanks!
