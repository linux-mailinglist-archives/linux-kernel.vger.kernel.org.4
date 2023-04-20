Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B426E8660
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 02:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjDTAYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 20:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjDTAYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 20:24:37 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F83C55B8;
        Wed, 19 Apr 2023 17:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=mcxMLoOSxa9iG2qrU2U3SP+Kgb4DGNYXioW8zTMtMdk=; b=ZkAuIjKUTViUBpoT8l84FA2kea
        m91ZQDYEu7bu8LGCd3or9f5Vo7mIXgXD6tsHRjmL/hs7nZAhGHdfMjrKBqUUQiFmjKAkPG6mmQDqt
        8x71FVHcs1bUsGA/IKPloF8TQxELxrxu2JfWKGU7fsuri/TeiGSrhI5O0BxcTNSQap+Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1ppI6B-00AjpF-Qz; Thu, 20 Apr 2023 02:24:31 +0200
Date:   Thu, 20 Apr 2023 02:24:31 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Martin Schiller <ms@dev.tdt.de>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] leds: trigger: netdev: drop NETDEV_LED_MODE_LINKUP
 from mode
Message-ID: <ddc69dfc-cba2-400c-860e-5ba8353bc590@lunn.ch>
References: <20230419210743.3594-1-ansuelsmth@gmail.com>
 <20230419210743.3594-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419210743.3594-3-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 11:07:40PM +0200, Christian Marangi wrote:
> Putting NETDEV_LED_MODE_LINKUP in the same list of the netdev trigger
> modes is wrong as it's used to set the link state of the device and not
> to set a blink mode as it's done by NETDEV_LED_LINK, NETDEV_LED_TX and
> NETDEV_LED_RX. It's also wrong to put this state in the same bitmap of the
> netdev trigger mode and should be external to it.
> 
> Drop NETDEV_LED_MODE_LINKUP from mode list and convert to a simple bool
> that will be true or false based on the carrier link. No functional
> change intended.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
