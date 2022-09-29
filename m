Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BBF5EFCB3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 20:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235725AbiI2SIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 14:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235631AbiI2SHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 14:07:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AF91C5CA2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 11:07:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEE9B62127
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 18:07:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F1EC433D6;
        Thu, 29 Sep 2022 18:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664474863;
        bh=oRlM0d1Ye3JuL8HAuq8Hd8XbHoSkXkhpcxLhMXtUUvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QeAhE2f34jJxJ6nokIOW2MsVXr1JUj5HVlzsuNpPUuIXfhLHap91qhNMjyU33tObb
         pEOv4s74y6hmWTxcuCe6ZOQRHbhTCzy3SyNvkLX80ZCmHpLmHsPSsHcbZrbewGD985
         jwQOt/h6K/KIM5K8+nwY6dP1BeQ+K5fB+xKFp+5ipYRQQBUXXcbAGJlOF+OwQWrvDb
         iEZReK3mwpCWOeiDj15sAPS/EedtqxEI6PCPnJzjQk/45LfE6EwNMAvlfOVH9rEgol
         bwmMh7e07rfEy99IQ5XUua4BS2ZuSJ7sbuBUT02fCFz8xFsmY5brMoS1vJrYmaem66
         KnYpKFlEg/cCg==
Date:   Thu, 29 Sep 2022 19:07:39 +0100
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 1/1] mfd: syscon: Remove repetition of the
 regmap_get_val_endian()
Message-ID: <YzXe66n3IRbDBwxS@google.com>
References: <20220808140811.26734-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220808140811.26734-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Aug 2022, Andy Shevchenko wrote:

> Since the commit 0dbdb76c0ca8 ("regmap: mmio: Parse endianness
> definitions from DT") regmap MMIO parses DT itsef, no need to
> repeat this in the caller(s).
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/syscon.c | 8 --------
>  1 file changed, 8 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
