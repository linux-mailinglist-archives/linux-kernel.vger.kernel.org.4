Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115985EDFE6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbiI1PO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbiI1POy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:14:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C81A186D0;
        Wed, 28 Sep 2022 08:14:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 300E1B820E8;
        Wed, 28 Sep 2022 15:14:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDA7C433D6;
        Wed, 28 Sep 2022 15:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664378090;
        bh=j4MTq8XKmTOIp5nLD8d82j9ZRDpTwibKtIYU/NIMiG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tKcZD0BKHk3qFJRLj+DaUPcvek1xD0xv8vfIWEktQnd+Ay2R1HsEt60yi3dZMJD2N
         +55vdM5NGRHxy+gxEJ4pJaZQXhsZiENw0e34Ljs9n4fuF5IF+2bNtw7WkYcAzkJPW1
         PAZvWufZukhGuRJ6vBSHb1RNge9jSfslj83yuq0xLdpNfBCYKrUt5y/s2EdlbntZLl
         w/sBlnxJ6wlytk7TFoeoHoMrapxAW3nTGVRSHf3tPb93Ck3ePmYLGfJ+NJIvpeN2Fr
         JHNf51Ahg0g8YPkJpd6jlf78nMCiHvKZzBZ9YLDtCRlneSEDOzrXIZf3qEJ7O5IItm
         fce9Ej22PULhA==
Date:   Wed, 28 Sep 2022 16:14:44 +0100
From:   Lee Jones <lee@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Tony Lindgren <tony@atomide.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mfd: twl4030-irq: add missing device.h include
Message-ID: <YzRk5Cqlbx5pGdZ2@google.com>
References: <20220927154611.3330871-1-dmitry.torokhov@gmail.com>
 <20220927154611.3330871-2-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220927154611.3330871-2-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2022, Dmitry Torokhov wrote:

> The driver is using "struct device" and therefore needs to include
> device.h header. We used to get this definition indirectly via inclusion
> of matrix_keypad.h from twl.h, but we are cleaning up matrix_keypad.h
> from unnecessary includes.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> v2: added Andy's reviewed-by
> 
>  drivers/mfd/twl4030-irq.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
