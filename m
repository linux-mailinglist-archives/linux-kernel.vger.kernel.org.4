Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602CC722AE9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbjFEPXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbjFEPXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:23:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DB0183
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 08:22:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D822D615B8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 15:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D18C433D2;
        Mon,  5 Jun 2023 15:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685978575;
        bh=mHGdw9dlkPnsEENd58IzHb1BqCW06VZ65UF/UTDkZz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UgUfXC0cVSJAgjjlMYtZYMVUp18Bsd+2/eleGsalGgsHxxG8wDp+cjBmSGTpFXwEX
         P1B6nhy8OrayHD2T4nm3sg/hiAPOvg9j7OQ7ij7GSz1Hf3ZlJZ2BkLjACOT0kzb4+r
         M5ik9AFMyM2WgZjASJSMKSB3i1udTnRQBU706oZE=
Date:   Mon, 5 Jun 2023 17:22:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nipun Gupta <nipun.gupta@amd.com>
Cc:     alex.williamson@redhat.com, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org, git@amd.com, harpreet.anand@amd.com,
        pieter.jansen-van-vuuren@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com
Subject: Re: [RESEND PATCH] cdx: fix driver managed dma support
Message-ID: <2023060533-reseal-glider-11e7@gregkh>
References: <20230605131009.6869-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605131009.6869-1-nipun.gupta@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 06:40:09PM +0530, Nipun Gupta wrote:
> The devices on cdx could be bound to drivers with the device
> DMA managed by kernel drivers or user-space applications.
> As multiple devices can be placed in the same IOMMU group, the
> DMA on these devices must either be entirely under kernel control
> or userspace control. Fix the CDX bus driver to acknowlege the
> driver_managed_dma flag and call the appropriate iommu APIs.
> 
> Fixes: 2959ab247061 ("cdx: add the cdx bus driver")
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> Reported-by: Alex Williamson <alex.williamson@redhat.com>
> Closes: https://lore.kernel.org/lkml/20230524134831.28dc97e2.alex.williamson@redhat.com/
> ---
> 
> I have resend this patch to include fixes, closes and
> reported by tags. We request that this fix be incorporated
> into the 6.4 release, along with the inclusion of CDX bus
> driver support.

What do you mean by "inclusion of CDX bus driver support"?  What patches
exactly?

confused,

greg k-h
