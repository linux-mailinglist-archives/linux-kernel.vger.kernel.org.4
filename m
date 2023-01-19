Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B97673E5E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjASQQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjASQQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:16:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB344ED2A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:16:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B5DA61CB4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 16:16:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A681BC433EF;
        Thu, 19 Jan 2023 16:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674144961;
        bh=2VZjIzM/IkNz+5s3FswACr3/IynfQOIhCLRGMZlA3Wg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jrtbdX6SeyNAmtAMRd+GBvOHBLP706O92HpuHaBncv6V1yhMku/wFX8/UpDjOeqYi
         7ZN+phosbtGeM+MrU3kCKPtJn1B9k83OBycbQQs1pKx/VlfOo2rpSs0gyGtMaQr96u
         BrSOLW1JmF4bOYnyTNxGnlYdqYhDr/z4SoF0G0xY=
Date:   Thu, 19 Jan 2023 17:15:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Christian Gromm <christian.gromm@microchip.com>
Subject: Re: [PATCH] most: fix kernel-doc warnings
Message-ID: <Y8lsvtoSYFj/8/U/@kroah.com>
References: <20230113063947.23174-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113063947.23174-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 10:39:47PM -0800, Randy Dunlap wrote:
> Fix various W=1 kernel-doc warnings in drivers/most/:
> 
> drivers/most/most_usb.c:669: warning: Excess function parameter 'data' description in 'link_stat_timer_handler'
> drivers/most/most_usb.c:769: warning: cannot understand function prototype: 'const struct file_operations hdm_usb_fops = '
> drivers/most/most_usb.c:776: warning: cannot understand function prototype: 'const struct usb_device_id usbid[] = '
> drivers/most/most_cdev.c:301: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Initialization of struct file_operations
> drivers/most/most_cdev.c:414: warning: Function parameter or member 'args' not described in 'comp_probe'
> drivers/most/most_snd.c:56: warning: Function parameter or member 'pcm_hardware' not described in 'channel'
> drivers/most/most_snd.c:56: warning: Function parameter or member 'copy_fn' not described in 'channel'
> drivers/most/most_snd.c:404: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Initialization of struct snd_pcm_ops
> drivers/most/most_snd.c:514: warning: Function parameter or member 'device_name' not described in 'audio_probe_channel'
> drivers/most/most_snd.c:703: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Initialization of the struct most_component
> 
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Christian Gromm <christian.gromm@microchip.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> Also: what does MOST mean? Can that be added to drivers/most/Kconfig,
>     in a prompt or help text?
> Also: how about a MAINTAINERS entry for drivers/most/?

That would be good, Christian, can you send a patch for that?

thanks,

greg k-h
