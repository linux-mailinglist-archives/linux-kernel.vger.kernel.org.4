Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E908733B1B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 22:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344544AbjFPUnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 16:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjFPUnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 16:43:01 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AA83AA3;
        Fri, 16 Jun 2023 13:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=SjGeG/Asq80tJKRYYzdJI4qDQRsSpZV+gFFdzpK1g0s=; b=PpkZYdnk5hkg+VheE1FMkc3EE4
        kXtXJE/Yw+ptoAALI0cjlgA0UfEF/qAaTxU22zZmt230iXsb1wO/+qV4FWVaHLAJl95+eM5mlsw1B
        xcPSyWtDKrRo5PnnhW5Cd1R9IM4c0OsBpU6/8wYyiF154/AhQqQwIAgJCnfBNZu2NcwI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qAGHU-00Gl3l-0O; Fri, 16 Jun 2023 22:42:52 +0200
Date:   Fri, 16 Jun 2023 22:42:51 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        richardcochran@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, sebastian.tobuschat@nxp.com
Subject: Re: [PATCH net-next v1 04/14] net: phy: nxp-c45-tja11xx: add
 *_reg_field functions
Message-ID: <ff1999c4-f80d-480f-a26e-6951d36c9f8b@lunn.ch>
References: <20230616135323.98215-1-radu-nicolae.pirea@oss.nxp.com>
 <20230616135323.98215-5-radu-nicolae.pirea@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616135323.98215-5-radu-nicolae.pirea@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int nxp_c45_read_reg_field(struct phy_device *phydev,
> +				  const struct nxp_c45_reg_field *reg_field)
> +{
> +	u16 mask;
> +	int ret;
> +
> +	if (reg_field->size == 0) {
> +		phydev_warn(phydev, "Trying to read a reg field of size 0.");

I would actually use phydev_err(). 

> +	if (reg_field->size == 0) {
> +		phydev_warn(phydev, "Trying to write a reg field of size 0.");

Here as well.


    Andrew

---
pw-bot: cr
