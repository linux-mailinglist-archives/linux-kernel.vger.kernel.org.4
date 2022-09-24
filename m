Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEA45E8903
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 09:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbiIXHR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 03:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbiIXHRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 03:17:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7FE138F3D;
        Sat, 24 Sep 2022 00:17:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60A76B80DAF;
        Sat, 24 Sep 2022 07:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0ACC433C1;
        Sat, 24 Sep 2022 07:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664003839;
        bh=OofynfKNUNtBce3tQD8sgtjcGFvwIJCOJYj5t820y3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sq9ekBFljOM8H2FSvks7FSE9Ybg8dzRTyD3Su72fXv/5ohNZKE2txBPUbdim/DRC1
         Cn1oQxKq1rgiYEufvWKgZgaZz53LJFtQtImRYfhCLz4Nqxd4TIEwb3YaWLUb3EGOKd
         kIPoEK0tdTfMvrMoOq+t/W09WHt4SYKr56JwHb3ixYgskmyDbmAS9ykPEYAzWoaiQ9
         cBQ3yJ2hAkXX3kjL8AgrBTktujm7vqhJQlf3rlpckiEBQX+8dyxxEZo55IHL+lFcab
         Is/bLkVGTiaHz8mpoHBXjLvlECVPpJ5Iiq0vIAeLPKMzUWTXiPX6dwePzNsBhtgui1
         0lC/kiXv50i0g==
Date:   Sat, 24 Sep 2022 12:47:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Haotien Hsu <haotienh@nvidia.com>
Cc:     p.zabel@pengutronix.de, jckuo@nvidia.com, kishon@ti.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wayne Chang <waynec@nvidia.com>
Subject: Re: [PATCH] phy: tegra: xusb: Enable usb role switch attribute
Message-ID: <Yy6u+9x/oDo4Gd+F@matsya>
References: <20220921112500.798282-1-haotienh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921112500.798282-1-haotienh@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-09-22, 19:25, Haotien Hsu wrote:
> From: Wayne Chang <waynec@nvidia.com>
> 
> This patch enables the usb-role-switch atrribute
> to have the user-space check current device role
> of otg cability ports

typo cability


You can use 72 chars for changelog rather than limiting at 50chars :-(

> 
> Signed-off-by: Wayne Chang <waynec@nvidia.com>
> Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
> ---
>  drivers/phy/tegra/xusb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
> index aa5237eacd29..220ab7719ade 100644
> --- a/drivers/phy/tegra/xusb.c
> +++ b/drivers/phy/tegra/xusb.c
> @@ -656,6 +656,7 @@ static int tegra_xusb_setup_usb_role_switch(struct tegra_xusb_port *port)
>  	struct usb_role_switch_desc role_sx_desc = {
>  		.fwnode = dev_fwnode(&port->dev),
>  		.set = tegra_xusb_role_sw_set,
> +		.allow_userspace_control = true,
>  	};
>  	int err = 0;
>  
> -- 
> 2.25.1

-- 
~Vinod
