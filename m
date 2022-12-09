Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF811648764
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiLIRNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLIRNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:13:09 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2E326AA4
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:13:07 -0800 (PST)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1p3gvo-0001Cy-Ii; Fri, 09 Dec 2022 18:13:04 +0100
Date:   Fri, 9 Dec 2022 18:13:04 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/1] ARM: imx: add missing of_node_put()
Message-ID: <20221209171304.teg463mwnteigmmp@viti.kaiser.cx>
References: <20221208165404.1512014-1-dario.binacchi@amarulasolutions.com>
 <20221208165404.1512014-2-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208165404.1512014-2-dario.binacchi@amarulasolutions.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Dario Binacchi (dario.binacchi@amarulasolutions.com):

> Calling of_find_compatible_node() returns a node pointer with refcount
> incremented. Use of_node_put() on it when done.
> The patch fixes the same problem on different i.MX platforms.

> Fixes: 8b88f7ef31dde ("ARM: mx25: Retrieve IIM base from dt")
> Fixes: 94b2bec1b0e05 ("ARM: imx27: Retrieve the SYSCTRL base address from devicetree")
> Fixes: 3172225d45bd9 ("ARM: imx31: Retrieve the IIM base address from devicetree")
> Fixes: f68ea682d1da7 ("ARM: imx35: Retrieve the IIM base address from devicetree")
> Fixes: ee18a7154ee08 ("ARM: imx5: retrieve iim base from device tree")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Reviewed-by: Martin Kaiser <martin@kaiser.cx>

Thanks,

   Martin
