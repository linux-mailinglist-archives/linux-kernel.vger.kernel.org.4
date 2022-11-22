Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0D1633C78
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 13:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbiKVMaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 07:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbiKVMaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:30:13 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1931E450B3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 04:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1669120193; bh=ZQVTktCaJMSJoAUilenuVtVqaVzw6QgpmXOKe+X/kzo=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=KiJWlsdEVvQG1zWCPN+LFYJETHdaHmp5LE8Awln8pzvwV4FcSs/OemxhucwgKdc0r
         ke2Rg8xLlCSIX/0GmrzDShWx9Uo8Xb4ujKzlqFPJZ8nbFHwd6HFjPgzi1kozqLjaES
         9zPcPAABagXa+cpUenkRKPziveL00gzgZPk0fJ9c=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue, 22 Nov 2022 13:29:53 +0100 (CET)
X-EA-Auth: Du6cW+R97fU19tg8ZpfTQyvMhiVbLDriT+NRPtYzKC4H6dSsFWPtqi4ukIDslkgLagjDOC+pFnGnV1YRwL4W3zGYh6ZdkLDo
Date:   Tue, 22 Nov 2022 17:59:45 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: call set_lan_gain for receiver config
Message-ID: <Y3zAucwpK9TUgrig@qemulion>
References: <Y3kONX7KhQ1GX9QW@qemulion>
 <Y3y7v1WAumU1o5na@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3y7v1WAumU1o5na@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 01:08:31PM +0100, Greg Kroah-Hartman wrote:
> On Sat, Nov 19, 2022 at 10:41:17PM +0530, Deepak R Varma wrote:
> > Value for the LNA gain is captured from the user as part of the struct
> > pi433_rx_cfg, however, the corresponding function rf69_set_lna_gain() is
> > never called to set it. Include a call to this function as part of
> > setting up the rx configurations.
> >
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > ---
> >  drivers/staging/pi433/pi433_if.c | 3 +++
> >  1 file changed, 3 insertions(+)
>
> How was this change tested?

Hi Greg,
This was compile tested only.

As per your message on the other patch for this driver, I am holding back such
patches until I have the ability to test the change with a real device myself.

I most welcome if there is any other feedback on the patches. It will help me
consolidate the feedback and react to them in one go.

Thank you,
./drv

>
> thanks,
>
> greg k-h
>


