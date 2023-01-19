Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7D36743D3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 21:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjASU7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 15:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjASU4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 15:56:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41554ABE6;
        Thu, 19 Jan 2023 12:55:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4144861D23;
        Thu, 19 Jan 2023 20:55:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA2CC433EF;
        Thu, 19 Jan 2023 20:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674161751;
        bh=xZ6Bug35jWQEeuhTYSGsgV5E/9QoXjQ6Eai9bCr/Ybc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gfbySevRGutAIKS2Ihui+viMJCz3AGRyITxe2jBrn99vLlvnP9KTeH2ybudk8HM+B
         OHDOhBeABKh179g/2mc+NzeS/ynVAMS3EPlV9ko/kL+5WaQj9R3TofHhstFuc7EDw+
         tDBjIEuSxJV0HtDCP20XZjb+F+gUDienByhsq2vRV2rAXTMREm83xDZ092Sox7rTuX
         s5l6+SQIK1YmiG5p871Cbd1pJ8jLhjCC9Gs4WsD/zlm8V7BkRNrnTvIbNuFf40SMD5
         k/NIDucp2f6kZ+5ZBteI2PHVYgFp1gtqfmjugqLu/4U9AVZfE+SjS4JrA1KjhJFz8v
         hYQ4wiVmknR+A==
Date:   Thu, 19 Jan 2023 20:55:47 +0000
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v1 1/1] leds: tca6507: Convert to use
 fwnode_device_is_compatible()
Message-ID: <Y8muU0dG42BQFeb4@google.com>
References: <20230119175150.77250-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230119175150.77250-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2023, Andy Shevchenko wrote:

> Replace open coded fwnode_device_is_compatible() in the driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/leds/leds-tca6507.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
