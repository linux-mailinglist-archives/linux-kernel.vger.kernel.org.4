Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562EF6B8C6A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjCNIDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjCNIDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:03:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA96F199E6;
        Tue, 14 Mar 2023 01:03:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6569BB818A1;
        Tue, 14 Mar 2023 08:03:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52ECEC433D2;
        Tue, 14 Mar 2023 08:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678781025;
        bh=HMA4luAOJ/JpqUqTMoMg4ekpqnwd90vDR6GH0nvHhn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z2FoqGbcWqIE8LWSD3s+tB4+oR4bv2S/9QBykbMB0He3oekVDLFBKfaZAh9QUPRSx
         v6hQSdzc/LVM8yJ8WWFKlcuq6WvRBSfzTEiUzeN2owwQVtkKb+ODArA48Ue6KmXu/Z
         oaoLvY2t21fdc4FuYlk2zGbf8CJZzuUVcpyxm00s=
Date:   Tue, 14 Mar 2023 09:03:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] spi: docs: adjust summary to CONFIG_SYSFS_DEPRECATED
 removal
Message-ID: <ZBAqXXGnqJmySgkM@kroah.com>
References: <20230314075609.5232-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314075609.5232-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 08:56:09AM +0100, Lukas Bulwahn wrote:
> With commit 721da5cee9d4 ("driver core: remove CONFIG_SYSFS_DEPRECATED and
> CONFIG_SYSFS_DEPRECATED_V2"), ./scripts/checkkconfigsymbols.py indicated
> an unresolved reference to the config SYSFS_DEPRECATED in the SPI summary
> documentation.
> 
> Simply, delete the sentence referring to the removed config there. Also
> update the documentation, as these sys/class entries should always be
> symlinks, as the commit message of the commit above suggests.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Mark, Greg, Jens, please confirm that these sys/class entries now always
> are symlinks. That is simply my guess after reading a bit on sysfs_deprecated
> also changed compared to the normal setup, but I am not the expert here.

They have been symlinks for years, the only subsystem that the
CONFIG_SYSFS_DEPRECATED logic still modified was for the block
subsystem.  So your change looks good to me, thanks for doing this:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

