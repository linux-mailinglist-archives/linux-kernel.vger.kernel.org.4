Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA3A61D8B7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 09:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiKEIXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 04:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKEIXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 04:23:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4CA2CDEF;
        Sat,  5 Nov 2022 01:23:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90EC5B8163F;
        Sat,  5 Nov 2022 08:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE29EC433D6;
        Sat,  5 Nov 2022 08:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667636610;
        bh=Wygp3yu9+6aJwzXKp1Frmtt7fJrqQAnLA7z7C02KqDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pnIqDSpVr+JSNhCcUwI2XUwjMJmAKGhhjjhG6Xx9ZcXUCjumRJHEReRKVGOkVkyff
         5RcWNWri/AierdnzBF6syrmnrPsCEPM8XeYD646k4qiV4n0gmk4QZZMzcv8dKQ/EGn
         ZsrVEMVEWVucKgtaBxXcn/bO7ZYIaDscU4q2MvnQ=
Date:   Sat, 5 Nov 2022 09:23:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 3/3] can: etas_es58x: report the firmware version
 through ethtool
Message-ID: <Y2Ydf6UxVvTe8Zmz@kroah.com>
References: <20221104073659.414147-1-mailhol.vincent@wanadoo.fr>
 <20221104171604.24052-1-mailhol.vincent@wanadoo.fr>
 <20221104171604.24052-4-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104171604.24052-4-mailhol.vincent@wanadoo.fr>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2022 at 02:16:04AM +0900, Vincent Mailhol wrote:
> ES58x devices report below information in their usb product info
> string:
> 
>   * the firmware version
>   * the bootloader version
>   * the hardware revision
> 
> Report the firmware version through ethtool_drvinfo::fw_version.
> Because struct ethtool_drvinfo has no fields to report the boatloader
> version nor the hardware revision, continue to print these in the
> kernel log (c.f. es58x_get_product_info()).
> 
> While doing so, bump up copyright year of each modified files.

Why not just stick to the normal USB interface here and not try to tie
it into ethtool?  These values are all availble today in sysfs or in
libusb, right?

What workflow wants this added to ethtool?

thanks,

greg k-h
