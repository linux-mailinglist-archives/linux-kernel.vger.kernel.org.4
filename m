Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D6173E1E9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 16:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjFZOTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 10:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjFZOSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:18:39 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 61AB92722
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 07:17:53 -0700 (PDT)
Received: (qmail 834137 invoked by uid 1000); 26 Jun 2023 10:16:44 -0400
Date:   Mon, 26 Jun 2023 10:16:44 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Guiting Shen <aarongt.shen@gmail.com>
Cc:     gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: ohci-at91: Fix the unhandle interrupt when resume
Message-ID: <1f33966d-3bc5-4ca3-bb6c-6e1d838c57f7@rowland.harvard.edu>
References: <20230625161553.11073-1-aarongt.shen@gmail.com>
 <552b1ac6-2149-48fa-9432-49655bfbc366@rowland.harvard.edu>
 <ed353f12-7ba7-1831-2ac7-b6135b2a5abb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed353f12-7ba7-1831-2ac7-b6135b2a5abb@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 10:28:26AM +0800, Guiting Shen wrote:
> On Mon, Jun 26, 2023 at 04:04:29AM GMT+8, Alan Stern wrote:
> > This comment doesn't say why the code uses !ohci_at91->wakeup.  It 
> > should explain that.  For example:
> > 
> > 	/*
> > 	 * According to the comment in ohci_hcd_at91_drv_suspend()
> > 	 * we need to do a reset if the 48-MHz clock was stopped,
> > 	 * that is, if ohci_at91->wakeup is clear.  Tell ohci_resume()
> > 	 * to reset in this case by setting its "hibernated" flag.
> > 	 */
> > 
> 
> Ok, Thank you!
> Do I send the v3 patch after the merge window close?

You can send the patch at any time.  It doesn't matter whether the merge 
window is open or closed.

Alan Stern
