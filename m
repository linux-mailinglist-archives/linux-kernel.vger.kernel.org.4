Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4326248C6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiKJRz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiKJRzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:55:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F83A49B6E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:55:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C24661CEC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 17:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CE2C433D6;
        Thu, 10 Nov 2022 17:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668102952;
        bh=CTPc7GJJpXw0Vxaq/XVPzHblpTmqjkySDCW8SrYmcjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XfchRy0awdaBkdGy+LQ01THWaRDoDxPkqleXzMwL8CuBgNJegbGfKFgKfL1eQAGr1
         CxAV+j+aLZwq+XHx9PKM8YFkl0gka7xmGUhty/WQ43aKDHiGi1e9XQInkens652N/Y
         pzd+S6sPMfsqq/l/QmzeeGKzNnkBTxpj8DRVdnQ8=
Date:   Thu, 10 Nov 2022 18:55:49 +0100
From:   'Greg KH' <gregkh@linuxfoundation.org>
To:     Soha Jin <soha@lohu.info>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        'Wende Tan' <twd2.me@gmail.com>
Subject: Re: PING: [PATCH] platform: use fwnode_irq_get_byname instead of
 of_irq_get_byname to get irq
Message-ID: <Y207JTskpwEUTD7X@kroah.com>
References: <0E39B15006ADC205+02a601d8d4f8$a00a09e0$e01e1da0$@lohu.info>
 <F789F6E98A6F9BF5+1d8501d8dc56$74036f70$5c0a4e50$@lohu.info>
 <Y0O5//6A3VvT7S5Z@kroah.com>
 <07EF40D2C259BC45+249601d8dc76$f05f03c0$d11d0b40$@lohu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07EF40D2C259BC45+249601d8dc76$f05f03c0$d11d0b40$@lohu.info>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 03:07:19PM +0800, Soha Jin wrote:
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Monday, October 10, 2022 2:22 PM
> > 
> > It's the middle of the merge window, we can't do anything until after
> > 6.1-rc1 is out, please relax and wait for that.
> > 
> > And what is the rush here, what is broken without this change?
> > 
> 
> Got it, just wondering if there anything I could improve in this patch,
> since I have not got any feedback. The bug just affect named interrupts in
> ACPI, which seems not used widely and not in a hurry.

Your patch is corrupted and can not be applied :(
You could have tested this by picking it up from lore.kernel.org and
verified that it worked.

Please fix your email client and send a new version.

thanks,

greg k-h
