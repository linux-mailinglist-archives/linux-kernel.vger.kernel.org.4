Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B781D65A492
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 14:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbiLaNO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 08:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbiLaNOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 08:14:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BC86380
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 05:14:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C328560B7A
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 13:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A0EC433EF;
        Sat, 31 Dec 2022 13:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672492461;
        bh=XNRMJvnnR/ANOsRJUu6Glk+gUbvgn+2ncoVIUKNjtFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XA/8HwSnkjsK3fCMK1XBjH5gzIezRCshaoWtysH4KxuWPAlCzJV462vpY/BbwKjxe
         RQURyNmaEGgEv+ao/n4VrD97GLko1OecxJTF9TfsFKsnF3MlM0jUgjBwEMq7lbBJQ8
         B5TSB7s2aLX32w3vbs95+2HJHmCv9reCylj5kjuWQMm1cqYbA9bMsdlU7ePxYNFuN3
         rgT6cI1zizvtt4LPtanhOd6bzp9v094hBJc44wrJZHB91MU8KmO/WFunOSuyNGvb8F
         T3aak0BmPpkwS1+h71CaXYeTZ5jCY0ni97LNullMNxzC0RmVmvhLe0z/o3NoJRn5Eh
         BaRFOwaq7zXZA==
Date:   Sat, 31 Dec 2022 21:14:13 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/1] ARM: imx: add missing of_node_put()
Message-ID: <20221231131412.GB6112@T480>
References: <20221208165404.1512014-1-dario.binacchi@amarulasolutions.com>
 <20221208165404.1512014-2-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208165404.1512014-2-dario.binacchi@amarulasolutions.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 05:54:03PM +0100, Dario Binacchi wrote:
> Calling of_find_compatible_node() returns a node pointer with refcount
> incremented. Use of_node_put() on it when done.
> The patch fixes the same problem on different i.MX platforms.
> 
> Fixes: 8b88f7ef31dde ("ARM: mx25: Retrieve IIM base from dt")
> Fixes: 94b2bec1b0e05 ("ARM: imx27: Retrieve the SYSCTRL base address from devicetree")
> Fixes: 3172225d45bd9 ("ARM: imx31: Retrieve the IIM base address from devicetree")
> Fixes: f68ea682d1da7 ("ARM: imx35: Retrieve the IIM base address from devicetree")
> Fixes: ee18a7154ee08 ("ARM: imx5: retrieve iim base from device tree")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Applied, thanks!
