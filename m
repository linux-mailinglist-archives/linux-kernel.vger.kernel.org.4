Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BE36BD136
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjCPNqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjCPNqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:46:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9021ECB067
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:46:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99CFC6203C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 13:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077F3C4339B;
        Thu, 16 Mar 2023 13:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678974365;
        bh=aRvWgyv0Zx566/2TKRR+EO1gynyRkcqvdQZrPtBHHG0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=neKN+sfVZNQ2Kr0wpYMex+SywlPMFnxYsg8lm6H7pk9tjYGEDMJcT59h5m/Ewx3EB
         wxC26HhIbuvvsbxR3hy63kz/eRI0H0NfYjKcsUfiKW1zX34R7KWVzrYYIlbiJPI/Vf
         biBY+8qY/1mGKXTAojTvEKM/PX7ST7wProMmkJJ58b0DkfdCZvWNtjGerfwY8Q9ZFa
         MZinRY552NeDiBw24tSYr4lZIbOcaGcFOn2VFlOkK3RlBQqaU8OCU6zuiVcuXxySYh
         fT6tXi8JH6yIBTrjXlLSovdUliMm9R0sIMg+0Be6b89URk9FmsQ7BUJ/9/2MPHte1p
         2N7Nfwfcb0viA==
Date:   Thu, 16 Mar 2023 13:46:00 +0000
From:   Lee Jones <lee@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RESEND] mfd: Remove .enable() and .disable() callbacks
Message-ID: <20230316134600.GO9667@google.com>
References: <20230308091257.2404932-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230308091257.2404932-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Mar 2023, Uwe Kleine-König wrote:

> With commit dd77f5fa97d3 ("mfd: Remove toshiba tmio drivers") the last
> mfd driver that implements these callbacks is gone and since commit
> 652719b1003a ("w1: remove ds1wm driver") the last user is gone. The
> corresponding functions mfd_cell_enable() and mfd_cell_disable() are
> also unused (since commit 0ca222c81977 ("leds: Remove asic3 driver")).
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/mfd/mfd-core.c   | 26 --------------------------
>  include/linux/mfd/core.h | 12 ------------
>  2 files changed, 38 deletions(-)

Applied, thanks

--
Lee Jones [李琼斯]
