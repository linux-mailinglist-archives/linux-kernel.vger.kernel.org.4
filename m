Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BFA609820
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 04:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiJXCOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 22:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJXCO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 22:14:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51342DED2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 19:14:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDCE960F98
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 02:14:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC996C433B5;
        Mon, 24 Oct 2022 02:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666577665;
        bh=kHPSCAbZORyH0ev4XBvQydhrlLgY6qm31vjdGV8AlbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qvOgMiBIS8b8Ez31hV5gkLK9X3dQzCH4QyI2TlJqB6Ljjoa2J3cF33tNR3BYB4YIl
         SuYudKuVMhJAhSklxliW/xohxLhloGkXmmfzp39SIOpwewFfAlSptzIdNUs40Bvbd2
         xzQmMxuHWPxuOoSKfR6nb4hEVA0KyEVtSfbxFG5vz2Afh1L8R6iUy89NPQ2jdJkOZt
         8Ra8KD5GnxTcq65R4EaL5E3xg87ws/gPs5RManKrE9Pj117nlR9KdPwN3Fm9v5uo0C
         KpjhlEu3nQ9Rp1RtIf68THI29ypnv7Bq0ULEZNTev9hsNO4miJgDWjPEmJfjIfOeh1
         M8dKCzCtoGyHA==
Date:   Mon, 24 Oct 2022 10:14:17 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     imx@lists.linux.dev, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Zhou Peng <eagle.zhou@nxp.com>, Ming Qian <ming.qian@nxp.com>,
        Shijie Qin <shijie.qin@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] firmware: imx: scu-pd: add missed USB_1_PHY pd
Message-ID: <20221024021417.GA125525@dragon>
References: <20220930183426.1130641-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930183426.1130641-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 01:34:24PM -0500, Frank Li wrote:
> USB_1_PHY is not defined in pd driver on 8DXL.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied both, thanks!
