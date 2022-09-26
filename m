Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F07D5EAC82
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiIZQaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiIZQ3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:29:45 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 305987FE50
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 08:18:28 -0700 (PDT)
Received: (qmail 410830 invoked by uid 1000); 26 Sep 2022 11:18:27 -0400
Date:   Mon, 26 Sep 2022 11:18:27 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
        mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix: add XHCI_SPURIOUS_SUCCESS to ASM1042 despite being
 a V0.96 controller
Message-ID: <YzHCw2FP+CdDK62Y@rowland.harvard.edu>
References: <20220925172236.2288-1-jens.glathe@oldschoolsolutions.biz>
 <c1857a88-2303-43d7-5539-37afd2401a12@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1857a88-2303-43d7-5539-37afd2401a12@linux.intel.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 02:31:42PM +0300, Mathias Nyman wrote:
> Hi
> 
> Thanks for the patch, some small changes still needed:
> 
> Include subsystem in subject line, something like
> usb: xhci: Add XHCI_SPURIOUS...

And don't forget to include a revision number inside the []'s on the 
Subject line for all revised submissions.

> On 25.9.2022 20.22, Jens Glathe wrote:
> > only if it reports as a V0.96 XHCI controller. Appears to fix the errors

It would be nice if the first sentence (not to mention the later ones) 
of the patch description actually was a complete sentence.  I realize 
that lots of commits don't bother to do this, but IMNSHO they ought to.

> > "xhci_hcd <address>; ERROR Transfer event TRB DMA ptr not part of
> > current TD ep_index 2 comp_code 13" that appear spuriously (or pretty
> > often) when using a r8152 USB3 ethernet adapter with integrated hub.
> > 
> > Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> > ---

Likewise, for resubmissions don't forget to include a quick description 
here (just below the "---" line) of how the resubmission differs from 
the earlier versions.

Alan Stern
