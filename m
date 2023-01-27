Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACFC67E879
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbjA0OlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjA0OlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:41:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D1179217
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 06:41:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39A5EB820ED
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:41:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7709BC433D2;
        Fri, 27 Jan 2023 14:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674830466;
        bh=0pDWFm7JWeQuGLfQOAkcZioh02NWwT5ih8ETkFGkHeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mMYoVhYHU6HXPbvnyDwznPH+Db3qHNZbDa7SOIbcXGsgkyJY/OhVLHYe+w07DXkO2
         ckSOIWLn36zY+3i+8A1ORgsBuBfCbPRkYwZy7CF5372f6Lg5ftjhNB4HLGkKE+APry
         tl+CyKl1EokRP0X12AvsUb7CfFd+KBZSmHB/Jk2qdMukQOoYljotQFoeyUXY5vUOvo
         rktO+rOG4hlCfZ56mg84lssvTKu/IawYxjlOxrMDuUALqK3yJfiB4qk5gWaF8zURiT
         +pDkT5LQ1eQ6EnVUgB7GUiMgHk+f73JgFq5NH+1iNNQMEUASJPrWTDei5cYZJdyTYq
         AX+9b9cJtPmyw==
Date:   Fri, 27 Jan 2023 14:41:02 +0000
From:   Lee Jones <lee@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: Remove .enable() and .disable() callbacks
Message-ID: <Y9PiflfjkinCXfHn@google.com>
References: <20230126152429.580539-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230126152429.580539-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2023, Uwe Kleine-König wrote:

> With commit dd77f5fa97d3 ("mfd: Remove toshiba tmio drivers") the last
> mfd driver that makes use of these callbacks is gone. The corresponding
> functions mfd_cell_enable() and mfd_cell_disable() are also unused
> (apart from the leds-asic3 driver that cannot be enabled any more after
> the above mentioned remove and will/should be deleted, too).
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/mfd/mfd-core.c   | 26 --------------------------
>  include/linux/mfd/core.h | 12 ------------
>  2 files changed, 38 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
