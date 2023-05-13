Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B8F70162F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 12:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238250AbjEMKcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 06:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238195AbjEMKcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 06:32:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50630199;
        Sat, 13 May 2023 03:32:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3E1A60E55;
        Sat, 13 May 2023 10:32:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91DBC43442;
        Sat, 13 May 2023 10:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683973931;
        bh=I6n/Wl4AyJXEMoZSIpmwZ/P5E/Hax6wd2nxD+SdjZTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=duAM9D1jOgQ2rE/m65/Q/JIqlaRQOUxwjyXWf6bAxasoa7oPSYI+dzjX/aa5Z5OjZ
         uvhi0WAx4hMkDjqZEuF8Q5QicQuMUbm4RQC+GI2zDhP9PEmQKTaQSMTBmpl4p66Iwz
         auiHVrXsBH0FcGnzbd3Qty4vKcOfu0M9NgJDfH/c=
Date:   Sat, 13 May 2023 19:28:08 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_pci: remove unreachable code for ASIX
 devices
Message-ID: <2023051343-cringing-junction-54f7@gregkh>
References: <20230510142855.256658-1-jiaqing.zhao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510142855.256658-1-jiaqing.zhao@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 02:28:56PM +0000, Jiaqing Zhao wrote:
> PCI_VENDOR_ID_ASIX (0x9710) is the same as PCI_VENDOR_ID_NETMOS. In
> pci_serial_quirks array, the NetMos entry always takes precedence over
> the ASIX entry. So the code for ASIX devices is always unreachable,
> even when it was initially merged. Since the NetMos vendor driver
> doesn't mention such FIFO bug, it's safe to remove the code.
> 
> This reverts commit eb26dfe8aa7e ("8250: add support for ASIX devices
> with a FIFO bug").
> 
> Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>

Please follow the documented Intel kernel developer requirements before
you submit this again, based on the changes that process will require.

thanks,

greg k-h
