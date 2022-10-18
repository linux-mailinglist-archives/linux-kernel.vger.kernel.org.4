Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7842B6025A0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiJRHXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiJRHXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:23:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CADAC3B6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 00:23:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B612161488
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCC9C433D6;
        Tue, 18 Oct 2022 07:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666077789;
        bh=JPGHG5zkqU6Z1dRwnjFoLJV81JU7wC6GSDxUae8QoFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PYEZZ+ulUaHxGOXP1Tk4vBK/V+U7x7y67GVHBnkfwaYOsV2ye00WUYkQPrZdSRPYR
         OTuKK7xYhjWIjpnjKqLKnguyu3e3JQjxdZjW0EwV3jZs07XWfC+exjTn9ptYFq0A++
         VpdvbN39la7+xG6AmnK5SBL6Ukahy4vPZftSg+GqyRYdNduzB7iGrj1aQizQAwLOd/
         9gA+R0ycrA4Gc/WSX9vrqwRXHBIg5t9teQJRn7D4U0n0YYWzrMEXKx2fg/Rp7SRFOo
         4GWr919l8dr/gQjml8FiwRRTIt048r5C6sh3ncpSfTg0B5vxa65Vty5+qhYF1oEGji
         XTSRbNIRrfpqQ==
Date:   Tue, 18 Oct 2022 08:23:03 +0100
From:   Lee Jones <lee@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, torvalds@linux-foundation.org
Subject: Re: [PATCH] Revert "mfd: syscon: Remove repetition of the
 regmap_get_val_endian()"
Message-ID: <Y05UV9i9GW9WOptn@google.com>
References: <Y0GZwkDwnak2ReTt@zx2c4.com>
 <20221008154700.404837-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221008154700.404837-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 08 Oct 2022, Jason A. Donenfeld wrote:

> This reverts commit 72a95859728a7866522e6633818bebc1c2519b17. It broke
> reboots on big-endian MIPS and MIPS64 malta QEMU instances, which use
> the syscon driver. Little-endian is not effected, which means likely
> it's important to handle regmap_get_val_endian() in this function after
> all.
> 
> Cc: Lee Jones <lee@kernel.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Fixes: 72a95859728a ("mfd: syscon: Remove repetition of the regmap_get_val_endian()")
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/mfd/syscon.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
