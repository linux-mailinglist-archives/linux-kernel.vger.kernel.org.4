Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8896A6D8C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 14:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjCAN4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 08:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCAN4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 08:56:39 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C993E09A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 05:56:37 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pXMwY-0006od-Vh; Wed, 01 Mar 2023 14:56:30 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pXMwX-0007JQ-Rd; Wed, 01 Mar 2023 14:56:29 +0100
Date:   Wed, 1 Mar 2023 14:56:29 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Jindong Yue <jindong.yue@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, l.stach@pengutronix.de, peng.fan@nxp.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 0/7] soc: imx8m: Support building imx8m soc driver as
 module
Message-ID: <20230301135629.pvif7opx6whguwod@pengutronix.de>
References: <20230301130557.3949285-1-jindong.yue@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301130557.3949285-1-jindong.yue@nxp.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23-03-01, Jindong Yue wrote:
> This series adds support for building imx8m soc driver as module.

...

>  drivers/soc/imx/Kconfig           | 2 +-
>  drivers/soc/imx/imx8m-blk-ctrl.c  | 3 ++-
>  drivers/soc/imx/imx8mp-blk-ctrl.c | 5 +++--
>  drivers/soc/imx/soc-imx8m.c       | 1 +
>  4 files changed, 7 insertions(+), 4 deletions(-)

the serie lgtm now, feel free to add my:

Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
