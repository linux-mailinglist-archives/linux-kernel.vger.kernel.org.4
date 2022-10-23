Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FC36091FE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 11:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiJWJXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 05:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiJWJXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 05:23:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C5865011
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 02:23:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10CE260B1B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 09:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F17C433D6;
        Sun, 23 Oct 2022 09:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666517025;
        bh=jymHjhhcHThu88x6l61+VHbViv9rllMkuBMWAMwY4Eo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oW+hp71wfZquQUROmHlswggUg67Z4EPbdbU2k4Wc40H/KRZcGypAOdi4Rx1lp03xL
         pDGHMWRw3pfPGdtrnjH2/NbSVixZ2ga1FQKJSpSNn9AB89mOIwLM6PEWDkN0RqEq8v
         6jJZb+QOY43xYpIZ8YuwOzK9+oJEAVNZ7G299ZjkkuBKADAOrnFXLIdiPkkfcn01fI
         KX1hBXO0DZNEWRazCbyIqwz/Ju77iFMOGMBe+/HIxv244HPfrugjvGm6Lsg4oTDZIj
         +0T8yT2nCb8jTA/UL+6uBuZC8kng7ABhK5v7uC7nObTw298RvZCMJY/gMdTrx6sYbU
         T7uX+2Kk19b8w==
Date:   Sun, 23 Oct 2022 17:23:38 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v3] soc: imx: imx8m-blk-ctrl: Defer probe if 'bus' genpd
 is not yet ready
Message-ID: <20221023092338.GB125525@dragon>
References: <20220919121302.597993-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919121302.597993-1-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 02:13:02PM +0200, Benjamin Gaignard wrote:
> Depending of the boot sequence 'bus' genpd could be probed after imx8m-blk-ctrl
> which led driver probe to fail. Change the returned error to allow
> to defer the probe in this case.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Applied, thanks!
