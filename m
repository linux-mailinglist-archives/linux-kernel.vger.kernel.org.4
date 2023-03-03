Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4271D6A952E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 11:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjCCK2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 05:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjCCK2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 05:28:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3580913D73;
        Fri,  3 Mar 2023 02:28:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C534C617C3;
        Fri,  3 Mar 2023 10:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36983C433EF;
        Fri,  3 Mar 2023 10:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677839316;
        bh=5kbDWtQ60xaDKyCuDwoQpaTm2/dAHCdgPw74+ZNABnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FQPbyh+8AyQ5SupqwB5sqZ9/Se78jOSNddTvVnfM5kBBUYcY1BSTGd9z31opOW7a1
         R6jnqNXwcNhAfCJB2aFB7k/T8gbKHQ89MEjuo+54iZcrZBXgppRmdxxkZZVXtgK55R
         9ESpxSC0RP/ZtBuzDqRDsXUBcP3kccdeNuUMhKALHnZHcfw/lG0mzsWpAnJF+yucSj
         VFw0/kwmdXSgG7/6XpaommBus+Q1uS8WbvBwn/wd9U7Z/s/U1MuLq8cM9shfC8uam4
         AIc7S0NpTXcDRlp0XIDfnZKPRAqWbVrzd92b55FIYkJomoHKtU4XTTfrytkmbh2p9j
         NqAWIqhr9dQ/g==
Date:   Fri, 3 Mar 2023 10:28:32 +0000
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v1 1/2] leds: lp8860: Remove unused of_gpio,h
Message-ID: <20230303102832.GP2303077@google.com>
References: <20230215170403.84449-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230215170403.84449-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2023, Andy Shevchenko wrote:

> of_gpio.h provides a single function, which is not used in this driver.
> Remove unused header.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/leds/leds-lp8860.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
