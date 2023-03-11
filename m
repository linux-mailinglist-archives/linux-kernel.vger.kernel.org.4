Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1D36B5E25
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 17:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjCKQyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 11:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjCKQyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 11:54:36 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id D36D8BDEE
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 08:54:34 -0800 (PST)
Received: (qmail 684076 invoked by uid 1000); 11 Mar 2023 11:54:33 -0500
Date:   Sat, 11 Mar 2023 11:54:33 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Yaroslav Furman <yaro330@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uas: Add US_FL_NO_REPORT_OPCODES for JMicron JMS583Gen 2
Message-ID: <7f670cac-aa36-4bb9-a2b1-4451e4e85fab@rowland.harvard.edu>
References: <20230311123418.16272-1-yaro330@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230311123418.16272-1-yaro330@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 02:34:18PM +0200, Yaroslav Furman wrote:
> Just like other JMicron JMS5xx enclosures, it chokes on report-opcodes,
> let's avoid them.
> 
> Tested-and-reported-by: Yaroslav Furman <yaro330@gmail.com>
> Signed-off-by: Yaroslav Furman <yaro330@gmail.com>
> ---
>  drivers/usb/storage/unusual_uas.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/storage/unusual_uas.h b/drivers/usb/storage/unusual_uas.h
> index c7b763d6d102..e4ff28ba93e5 100644
> --- a/drivers/usb/storage/unusual_uas.h
> +++ b/drivers/usb/storage/unusual_uas.h
> @@ -97,6 +97,13 @@ UNUSUAL_DEV(0x152d, 0x0539, 0x0000, 0x9999,
>  		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
>  		US_FL_NO_REPORT_OPCODES),
>  
> +/* Reported by: Yaroslav Furman <yaro330@gmail.com> */
> +UNUSUAL_DEV(0x152d, 0x0583, 0x0000, 0x9999,
> +		"JMicron",
> +		"JMS583Gen 2",
> +		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
> +		US_FL_NO_REPORT_OPCODES),
> +

The new entry should be inserted in the correct location, according to 
the ordering by vendor ID and product ID.  (Hint: 0x583 > 0x567.)

>  /* Reported-by: Claudio Bizzarri <claudio.bizzarri@gmail.com> */
>  UNUSUAL_DEV(0x152d, 0x0567, 0x0000, 0x9999,
>  		"JMicron",

Alan Stern
