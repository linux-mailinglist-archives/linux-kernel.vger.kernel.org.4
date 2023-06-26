Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBD173E365
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjFZPdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjFZPdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:33:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73F5191
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:33:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63F7960EC7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 15:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF18CC433C8;
        Mon, 26 Jun 2023 15:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687793600;
        bh=yEVa3byRcwCEWZyYOjUH9dmGEQ76cScIcpdgusw0i5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PVGkO/78bWNtfPKVNH8r4UQSqGuPR16DBRdBpUI/ZGjiHSDtldqv1SHrdP0QHmnp5
         2c63dACMVeJHfqRUhEiU40a22E6S9YIZrfbi2NFIFQWjmBABVfXAOMxETl8xKRMP3P
         bBMo74L7Pmwp3Is+3q4yDLyv4a3Bd6vr68CY/EbU+h3ZyxNKZwuxk5MRxcHVcXmqqL
         L/YD+tcR/1ETaDjx4PhOGIaQAWbQUnD7kjRfwFK7Z9oXLxYS8JSSIvpfBfzeVKqCpg
         axqe/UP0REC+icO/qgq7Pn+PFmbyyKJ1c0O7q4GPK9nhfG8gm7SppvGjM7OCF7mjVA
         AWdVOFUoSFAjA==
Date:   Mon, 26 Jun 2023 16:33:15 +0100
From:   Lee Jones <lee@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Julien Panis <jpanis@baylibre.com>,
        Okan Sahin <okan.sahin@analog.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] mfd: Switch two more drivers back to use struct
 i2c_driver::probe
Message-ID: <20230626153315.GC10378@google.com>
References: <20230626091941.557733-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230626091941.557733-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2023, Uwe Kleine-König wrote:

> struct i2c_driver::probe_new is about to go away. Switch the driver to
> use the probe callback with the same prototype.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/mfd/max77541.c    | 2 +-
>  drivers/mfd/tps6594-i2c.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
