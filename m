Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFBB73884B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbjFUPCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbjFUPBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:01:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E8165AA;
        Wed, 21 Jun 2023 07:56:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AAD661539;
        Wed, 21 Jun 2023 14:55:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E27C433C0;
        Wed, 21 Jun 2023 14:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687359317;
        bh=XmUJrXEv6FpzPmLHQQVKfx65ofQ5ze4boTYNspgJr0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kYY4WwazOEzAfa9uKMwIbqFeb+IwrNPKg0dDGTL6E7G6rgUqeA0xh8V/X/BLAsJhV
         XDXyL+NFeKMO2zqsjJ1rcizAgnq1s7xYwvZT4mLYs1F1FmPSKv0RW/NjLyP+PNCv+0
         QwEryrNC1YNYuoZsGXdEIc5G4hpbgicTWFN36uW9/MZXO+XenFgx0etsg+4rFu6vs0
         VF3r7OeijylkG4EdhEFUXQcL8ih80xDn/M/Y8htSzcG9/mqw62TfHt9Aw2tjf7uvMh
         m5PPoUII+bQqsaECsXCOVfgaw0EOp4mDPJ9/4Co35eUq4hgbL9IWgpdGUxUwHcPZay
         tT30H/lAr7EkA==
Date:   Wed, 21 Jun 2023 15:55:12 +0100
From:   Lee Jones <lee@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [net-next PATCH v5 2/3] leds: trigger: netdev: add additional
 specific link duplex mode
Message-ID: <20230621145512.GB10378@google.com>
References: <20230619204700.6665-1-ansuelsmth@gmail.com>
 <20230619204700.6665-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230619204700.6665-3-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2023, Christian Marangi wrote:

> Add additional modes for specific link duplex. Use ethtool APIs to get the
> current link duplex and enable the LED accordingly. Under netdev event
> handler the rtnl lock is already held and is not needed to be set to
> access ethtool APIs.
> 
> This is especially useful for PHY and Switch that supports LEDs hw
> control for specific link duplex.
> 
> Add additional modes:
> - half_duplex: Turn on LED when link is half duplex
> - full_duplex: Turn on LED when link is full duplex
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/leds/trigger/ledtrig-netdev.c | 27 +++++++++++++++++++++++++--
>  include/linux/leds.h                  |  2 ++
>  2 files changed, 27 insertions(+), 2 deletions(-)

Acked-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]
