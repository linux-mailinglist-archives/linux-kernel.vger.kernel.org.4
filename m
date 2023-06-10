Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7370972ADA0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 19:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjFJRK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 13:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFJRKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 13:10:54 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5062D7E;
        Sat, 10 Jun 2023 10:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=6/ljHa1TetfsMxIoQmiJpKoOzClakUJOlS+VDPzR2rY=; b=srVZBakSpNNQn5PW8fikii/viR
        cQvMUcdwiz8e0BBzSGPdHWzwnSkyfYlT3qGFSkBexJYzGzmnlqWH8ENxcfWyXEE9rWgI5CDxaOs23
        4LY28r9gJENQWA+qUzzLrOrbs+mnkUXwc425rrZ4YGK5DcT0ZnEkwjWiABrxjt8jCK8Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q826t-00FRzd-RI; Sat, 10 Jun 2023 19:10:43 +0200
Date:   Sat, 10 Jun 2023 19:10:43 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jianhui Zhao <zhaojh329@gmail.com>
Cc:     hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: mdio: fix duplicate registrations for phy with c45
 in __of_mdiobus_register()
Message-ID: <b4d6eb7c-513a-4767-aedc-8d1b6ffd831f@lunn.ch>
References: <20230610161308.3158-1-zhaojh329@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230610161308.3158-1-zhaojh329@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 11, 2023 at 12:13:08AM +0800, Jianhui Zhao wrote:
> Maybe mdiobus_scan_bus_c45() is called in __mdiobus_register().
> Thus it should skip already registered PHYs later.

Please could you expand on your commit message. I don't see what is
going wrong here. What does your device tree look like? Do you have a
PHY which responds to both C22 and C45?

Thanks
	Andrew
