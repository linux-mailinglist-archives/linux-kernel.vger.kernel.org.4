Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD2668B084
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 16:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjBEPLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 10:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBEPLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 10:11:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075681E1F2;
        Sun,  5 Feb 2023 07:11:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95BCD6066C;
        Sun,  5 Feb 2023 15:11:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E43C433D2;
        Sun,  5 Feb 2023 15:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675609867;
        bh=zg3f33jEKWaqsclyMmhyvxPPRiKJwiClxq2jNy9p15Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p44DreWERKL5UGyU9nDKk1vYwYhh44zXttPcvoenB0XQrc5k+mMk5uyrkudBowUEb
         3LuWPfvGVtmlmWeKkiHpi6A5zQn8QQWWS0qnxI1ibS/JUcEkZfM9+dKBdAUUcSzObK
         mjWFqo8I6UA4lk3FUFm7nuCoVt+kedapgLKqlL8wTxM/jcrLn0aAz46thlUyThk0uK
         QK3+2njp9AQadymZBida8lPHJRpCtsRl+KNpQmXfFGnk50ZS8DVn05wie49ouHzoPf
         F0fct6fY/1/dpJtN3JjgNA1ePbsoJEGteLo78BGKUynFXI+VfEud0j5yit/tGfgLcw
         XxSkkUFTHUKew==
Date:   Sun, 5 Feb 2023 15:25:08 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrew Hepp <andrew.hepp@ahepp.dev>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: temperature: Add MCP9600 thermocouple EMF
 converter driver
Message-ID: <20230205152508.778b010a@jic23-huawei>
In-Reply-To: <20230112190551.4d9ac5f6@jic23-huawei>
References: <Jonathan Cameron <jic23@kernel.org>
        <20230108234503.2803-1-andrew.hepp@ahepp.dev>
        <20230112190551.4d9ac5f6@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2023 19:05:51 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun,  8 Jan 2023 15:45:04 -0800
> Andrew Hepp <andrew.hepp@ahepp.dev> wrote:
> 
> > From: "Andrew Hepp" <andrew.hepp@ahepp.dev>
> > 
> > Add support for the MCP9600 thermocouple EMF converter.
> > 
> > Datasheet: https://ww1.microchip.com/downloads/en/DeviceDoc/MCP960X-Data-Sheet-20005426.pdf
> > Signed-off-by: Andrew Hepp <andrew.hepp@ahepp.dev>  
> 
> Driver looks good, but now I realise we don't have a device tree binding doc.
> 
> Please add one for v3.
> 
> Note that the binding doc is describing the hardware, not what the driver
> currently supports alone, so include the 4 (or 6?) interrupt lines (and interrupt-names
> as any random subset of them might be provided) + VDD regulator + anything else I've
> not noticed in my 10 second look at the datashet.

Hi Andrew,

If you aren't going to get to this sometime soon, feel free to say so and
I might write binding docs for it if I get time.  I'd rather do that than
lose a driver over some docs!

Jonathan

> 
> Thanks,
> 
> Jonathan
> 

