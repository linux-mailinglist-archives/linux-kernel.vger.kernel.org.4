Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D084F7333F7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345757AbjFPOts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345713AbjFPOtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:49:46 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA8930F1;
        Fri, 16 Jun 2023 07:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=VO5W5mFkgLXJm6gyeqxnjpMRqTtw3g3R0G84ncCKgdE=; b=ypHqV6En7mX+pLKENt2maPqGdc
        vDyiKOGPmCbVwmIJptuuNzLqUDoF76l9WKuTKUK6b2uiU+dKiNMmz1Vj2k8gGVxQVdEo8A4+aLaBu
        OMv1XAl78qNpGmLshByifOhrcY4l/sXbGuPf9CxPqizt9eFSaAv/hxg6S0H3ciCzgTSg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qAAlY-00GjHv-Sf; Fri, 16 Jun 2023 16:49:32 +0200
Date:   Fri, 16 Jun 2023 16:49:32 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jianhui Zhao <zhaojh329@gmail.com>
Cc:     hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5] net: phy: Add sysfs attribute for PHY c45 identifiers.
Message-ID: <661044f3-9447-45c7-8bda-b9f6a667385a@lunn.ch>
References: <20230616144017.12483-1-zhaojh329@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616144017.12483-1-zhaojh329@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 10:40:17PM +0800, Jianhui Zhao wrote:
> If a phydevice use c45, its phy_id property is always 0, so
> this adds a c45_ids sysfs attribute group contains mmd id
> attributes from mmd0 to mmd31 to MDIO devices. Note that only
> mmd with valid value will exist. This attribute group can be
> useful when debugging problems related to phy drivers.
> 
> Likes this:
> /sys/bus/mdio_bus/devices/mdio-bus:05/c45_ids/mmd1
> /sys/bus/mdio_bus/devices/mdio-bus:05/c45_ids/mmd2
> ...
> /sys/bus/mdio_bus/devices/mdio-bus:05/c45_ids/mmd31
> 
> Signed-off-by: Jianhui Zhao <zhaojh329@gmail.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Russell King <linux@armlinux.org.uk>

Did you read Russells comments? And Jakubs? Please don't ignore them.

    Andrew

---
pw-bot: cr
