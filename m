Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19E460F00C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 08:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbiJ0GWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 02:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbiJ0GWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 02:22:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB6F1211F4;
        Wed, 26 Oct 2022 23:22:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D43ACB824D1;
        Thu, 27 Oct 2022 06:22:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC0CC433D6;
        Thu, 27 Oct 2022 06:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666851767;
        bh=6mJ1W9P4oq1/bk00TWEGkE8xP6EVak/Fno3x0CpIAxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yRPMHWkBimQ09PJQ7sMIO3ph8LX20IE+QkxsK0scqZ/8LNYnlqjzVDJBbO9u0ut8o
         dIEkS0YqQH5oMQjmnNOx58lfMdcpdk1SIxf7h0Piqdkn1w+ViDuXyVtVyM3n01i09F
         g3GbT56VUJCSpcO5g7nmU9gbM8WjBn5YMjHe1K+k=
Date:   Thu, 27 Oct 2022 08:23:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Albert Wang <albertccwang@google.com>
Cc:     mathias.nyman@intel.com, badhri@google.com, howardyen@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@google.com>
Subject: Re: [PATCH 2/3] usb: xhci-plat: add xhci_plat_priv_overwrite
Message-ID: <Y1oj7TlC93oOKyB7@kroah.com>
References: <20221027004050.4192111-1-albertccwang@google.com>
 <20221027004050.4192111-3-albertccwang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027004050.4192111-3-albertccwang@google.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 08:40:49AM +0800, Albert Wang wrote:
> From: Howard Yen <howardyen@google.com>
> 
> Add an overwrite to platform specific callback for setting up the
> xhci_offload_ops, allow vendor to store the xhci_offload_ops and
> overwrite them when xhci_plat_probe invoked.
> 
> Signed-off-by: Howard Yen <howardyen@google.com>
> Link: https://lore.kernel.org/r/20210119101044.1637023-1-howardyen@google.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@google.com>

Again, no, I do NOT sign off on this submission.

Also, you did not sign off on it, yet you forwarded it on.  That's not
allowed either, and makes this whole series not even able to be
accepted, if it were a valid set of changes :(

Please fix.

thanks,

greg k-h
