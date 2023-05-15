Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CDA702299
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 05:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238452AbjEODtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 23:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbjEODtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 23:49:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0137114;
        Sun, 14 May 2023 20:49:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B8A360FE6;
        Mon, 15 May 2023 03:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483ACC433D2;
        Mon, 15 May 2023 03:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684122584;
        bh=EUj7znvCGp1G8Lnb+QoBaZCBVv84NL+yeZsmz1wRgc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m7/dxqYtEmuwkdMvJxwT7Bq7Blq5x3uGDESPrtsSuWb2dUJfVmuR7WhUkfywAIMpw
         an/8ZA/lxBxa0P1TIrUyJLDqN/iqOSTtAEdAaBW2dD4wN/JJR2OQL+TfVSGu4OyLvY
         P1oBLZkWSYnayKUAqOqDuiIFGHKycYTtED62lWyA=
Date:   Mon, 15 May 2023 05:49:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_pci: remove unreachable code for ASIX
 devices
Message-ID: <2023051533-harmonize-ozone-bc72@gregkh>
References: <20230510142855.256658-1-jiaqing.zhao@linux.intel.com>
 <2023051343-cringing-junction-54f7@gregkh>
 <188db6e4-d1de-6643-f6e1-5cb3807b28ee@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <188db6e4-d1de-6643-f6e1-5cb3807b28ee@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 10:36:30AM +0800, Jiaqing Zhao wrote:
> 
> 
> On 2023-05-13 18:28, Greg Kroah-Hartman wrote:
> > On Wed, May 10, 2023 at 02:28:56PM +0000, Jiaqing Zhao wrote:
> >> PCI_VENDOR_ID_ASIX (0x9710) is the same as PCI_VENDOR_ID_NETMOS. In
> >> pci_serial_quirks array, the NetMos entry always takes precedence over
> >> the ASIX entry. So the code for ASIX devices is always unreachable,
> >> even when it was initially merged. Since the NetMos vendor driver
> >> doesn't mention such FIFO bug, it's safe to remove the code.
> >>
> >> This reverts commit eb26dfe8aa7e ("8250: add support for ASIX devices
> >> with a FIFO bug").
> >>
> >> Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
> > 
> > Please follow the documented Intel kernel developer requirements before
> > you submit this again, based on the changes that process will require.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Sorry I am unable to find this "Intel kernel developer requirements". Is
> there any link or contact where I can find this information? Thank you.

Contact the Intel Linux developer team and they will point you at them.
This is a company-wide requirement, it is odd that your normal "Here is
how you can contribute to Linux!" training at Intel did not cover it?

thanks,

greg k-h
