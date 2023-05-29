Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD365714C82
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjE2OwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjE2OwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:52:19 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28FDEA;
        Mon, 29 May 2023 07:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=oPDTzj8X9h6ry+BUfp74vEAP/HJy+DV44qS7NxZNi/8=; b=DW0CDPZ88Mk8//oqYTW32FSDGa
        BRDRM2wVEabL4p6V9HNDVxmqOl1vFdBf+N5v7ZEFlLiueMwDQT20guuGrRfYwxuc/nfTGUmhKpP7J
        xgA8ijAk0izy+t+kW4jS3/1M9DY8tcY/8v5E8K0BC9v9d73eO/UAP7LF7HWPBZglIq/Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q3eEA-00EEhk-J0; Mon, 29 May 2023 16:52:06 +0200
Date:   Mon, 29 May 2023 16:52:06 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-leds@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [net-next PATCH v3 03/13] Documentation: leds: leds-class:
 Document new Hardware driven LEDs APIs
Message-ID: <8f171eaa-86c9-42de-88d9-a0dbc9baeb7f@lunn.ch>
References: <20230527112854.2366-1-ansuelsmth@gmail.com>
 <20230527112854.2366-4-ansuelsmth@gmail.com>
 <ZHRd5wDnMrWZlwrd@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHRd5wDnMrWZlwrd@debian.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 03:10:15PM +0700, Bagas Sanjaya wrote:
> On Sat, May 27, 2023 at 01:28:44PM +0200, Christian Marangi wrote:
> > +     - hw_control_set:
> > +                activate hw control. LED driver will use the provided
> > +                flags passed from the supported trigger, parse them to
> > +                a set of mode and setup the LED to be driven by hardware
> > +                following the requested modes.
> > +
> > +                Set LED_OFF via the brightness_set to deactivate hw control.
> > +
> > +                Return 0 on success, a negative error number on flags apply
> > +                fail.
> 		   "... on failing to apply flags."
> 
> > +    - hw_control_get_device:
> > +                return the device associated with the LED driver in
> > +                hw control. A trigger might use this to match the
> > +                returned device from this function with a configured
> > +                device for the trigger as the source for blinking
> > +                events and correctly enable hw control.
> > +                (example a netdev trigger configured to blink for a
> > +                particular dev match the returned dev from get_device
> > +                to set hw control)
> > +
> > +                Return a device or NULL if nothing is currently attached.
> Returns a device name?

How about "Returns a pointer to a struct device ..."

    Andrew
