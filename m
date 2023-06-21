Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C255573884F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjFUPCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbjFUPC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:02:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824836EB5;
        Wed, 21 Jun 2023 07:56:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBC036125F;
        Wed, 21 Jun 2023 14:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F4AC433C8;
        Wed, 21 Jun 2023 14:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687359350;
        bh=3nkHxcMV4G3LOSAbCssJSrJUIexihpFEZqQgKvDUeHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CqgAyDxoJdQafynZ2SoPGq5a0MmcBsdIfLGtv/7i2Ekk+MpSdnbfffYp82OCQY3ox
         E7I2LTYfoJtBBWK29NZMHPKhGzvToF86eY4eT4rs4lpP7uxogTGVVV8R+w15QHuRCl
         EbWcSqR3CYVzwBha9Td+3eVBau+6U0dyzLJALG6nK9Pvi7O7qN8iG14qwE7wgnX5cm
         lxV5jFkS6uPMQ5TdGktCw8iVDsMiCdF3W6BaeuqrpZxY7ggnVsub257kSe3UkqASsf
         VWyWOFb4ZCEmOCI08EBErOp0TvmZLOeo6h55bEz7el7S+rvI5rJ7Ekwp7oYeHfp3T2
         HyiuD3nNVOlRw==
Date:   Wed, 21 Jun 2023 15:55:45 +0100
From:   Lee Jones <lee@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [net-next PATCH v5 3/3] leds: trigger: netdev: expose hw_control
 status via sysfs
Message-ID: <20230621145545.GC10378@google.com>
References: <20230619204700.6665-1-ansuelsmth@gmail.com>
 <20230619204700.6665-4-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230619204700.6665-4-ansuelsmth@gmail.com>
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

> Expose hw_control status via sysfs for the netdev trigger to give
> userspace better understanding of the current state of the trigger and
> the LED.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/leds/trigger/ledtrig-netdev.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Acked-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]
