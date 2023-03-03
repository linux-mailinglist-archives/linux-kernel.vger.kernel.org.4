Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CAC6A9541
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 11:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjCCKbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 05:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCCKbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 05:31:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF58215C97;
        Fri,  3 Mar 2023 02:31:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5EF5CB8184E;
        Fri,  3 Mar 2023 10:31:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17719C433EF;
        Fri,  3 Mar 2023 10:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677839464;
        bh=od4SwU9z5YhxhVTwcYhCIaqUNLllVWb3OXK2CfxC0ok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SzCH4hsJtSo4Atqqkw/zESbpVxfuwKSkcuBtigBOE52EEeAJZ9vF41O4CKdpZVZK+
         Q681S0LbL800yRFMqmVBH6dgtlfAj+BWy4bIzwlj3QkIcnMU60Fi/ahHWw7X7vkyHr
         cQSNit0dJOSQkaJj2hEQ4AdqYKSWm+vtFFCKUkFO0GxD74o+8gydkWmIKW8KBOqL9+
         XiUtF74EvNsgBNXkauOjLODuJVuBwgLWvcLVQm1By3UFij/9M4/9MECBKEjZb5qVa/
         NAgC0xBhllPRR0h6YrGG8P1W3xm8/vBmo77n7QctHGR3PiYi+H0eKCKiRoLkVC0o+g
         zFy3YAmL2IeOg==
Date:   Fri, 3 Mar 2023 10:30:59 +0000
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v1 2/2] leds: lp8860: Remove duplicate NULL checks
Message-ID: <20230303103059.GQ2303077@google.com>
References: <20230215170403.84449-1-andriy.shevchenko@linux.intel.com>
 <20230215170403.84449-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230215170403.84449-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2023, Andy Shevchenko wrote:

> gpiod_*() API check already for the NULL, no need
> to repeat that in the driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/leds/leds-lp8860.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
