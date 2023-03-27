Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2321C6CA305
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjC0MCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjC0MCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:02:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF44B35AB;
        Mon, 27 Mar 2023 05:02:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D91E611DF;
        Mon, 27 Mar 2023 12:02:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E126C433D2;
        Mon, 27 Mar 2023 12:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679918549;
        bh=8QWxEZVa9spixZAb6AZBwaVfm9Ct+8WulaRetPlY1kM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RUj8mEb+hDP2W1Ni5PHbdDAA3FL3FpveTK4Stn4AIs9VSi3fgD+c/wrYsXN6BYq/P
         EghkYnk+5/9TqFUEZQ8Jv5GW40Grsg6OndBbxJS7s0gs/78U4neGYBRlsC3CRg/Voi
         yb80DBpWiTtr6cnx2ZP54s48ST1ZLaWRkgTAdnPA=
Date:   Mon, 27 Mar 2023 14:02:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     sfr@canb.auug.org.au, josue.d.hernandez.gutierrez@intel.com,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: [PATCH] xhci: only define xhci_msix_sync_irqs() when CONFIG_PM
 is set
Message-ID: <ZCGF0Q_tt5zA6DbS@kroah.com>
References: <ZCFHsSkxXAahISuK@kroah.com>
 <20230327103103.1060696-1-mathias.nyman@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327103103.1060696-1-mathias.nyman@linux.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 01:31:03PM +0300, Mathias Nyman wrote:
> xhci_msic_sync_irqs() function is only called during suspend, when
> CONFIG_PM is set, so don't define it unconditionally.
> 
> Fixes: 9abe15d55dcc ("xhci: Move xhci MSI sync function to to xhci-pci")
> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> ---
>  drivers/usb/host/xhci-pci.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)

No linux-usb?

