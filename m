Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5BC6E8681
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 02:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjDTA3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 20:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjDTA3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 20:29:04 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3A493;
        Wed, 19 Apr 2023 17:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=5yBauOdq8viUa9lLMEObdRAGHMji4WfrQuS4S9VpZIs=; b=J3ctjCNyOn0/dxo4WZA0tvvadk
        Ic+PPu/wwILtaoAbfe2Ab3W/x5CIEtgW7Dt+SnOylZzXXf5/lddS4nseQ9EO33CBuoumgrYbJ/Gic
        O50uiRMs/7W4PBDItGFT/6V973ng/R061keharVF9XnJX7LQ829rsu2qA+3NhiUx8qH8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1ppIAW-00Ajqi-6m; Thu, 20 Apr 2023 02:29:00 +0200
Date:   Thu, 20 Apr 2023 02:29:00 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Martin Schiller <ms@dev.tdt.de>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] leds: trigger: netdev: rename add namespace to
 netdev trigger enum modes
Message-ID: <32857e95-930d-420e-9b2a-c7a1c49e6441@lunn.ch>
References: <20230419210743.3594-1-ansuelsmth@gmail.com>
 <20230419210743.3594-4-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419210743.3594-4-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 11:07:41PM +0200, Christian Marangi wrote:
> Rename NETDEV trigger enum modes to a more symbolic name and add a
> namespace to them.
> 
> Also add __TRIGGER_NETDEV_MAX to identify the max modes of the netdev
> trigger.
> 
> This is a cleanup to drop the define and no behaviour change are
> intended.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>  
>  static ssize_t netdev_led_attr_show(struct device *dev, char *buf,
> -	enum netdev_led_attr attr)
> +				    enum led_trigger_netdev_modes attr)
>  {
> @@ -169,7 +165,7 @@ static ssize_t netdev_led_attr_show(struct device *dev, char *buf,
>  }
>  
>  static ssize_t netdev_led_attr_store(struct device *dev, const char *buf,
> -	size_t size, enum netdev_led_attr attr)
> +				     size_t size, enum led_trigger_netdev_modes attr)

These whitespace changes should not really be in this patch. But...

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
