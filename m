Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A62723F95
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236815AbjFFKde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236820AbjFFKdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:33:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518A310D4;
        Tue,  6 Jun 2023 03:33:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82E4F61E13;
        Tue,  6 Jun 2023 10:33:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943FAC433EF;
        Tue,  6 Jun 2023 10:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686047590;
        bh=w2yqsLQWejcE0G0HxGyTDrDxmNB8K2V7XuD302ujDx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VJcTAFAicRiiXj3TwPiTFOG8wfCunRWu5CwLvPZ65gc9e2/RsfMTY31C1xwnB7TXK
         yiPaNicZEwTQ13tqWsSSFTMZ0CVnNlcBCc69phD3/GC2GikIr8jLTbc+er4S29Hrz9
         Qc6Iu26io1RTJu+jn28B4A41/lEAhsEm517VYZN4=
Date:   Tue, 6 Jun 2023 12:33:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Neel Chakraborty <neelchakrabortykernelwork@gmail.com>
Cc:     b-liu@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drivers: usb: musb: musb_gadget: replaced bare
 unsigned to unsigned int
Message-ID: <2023060659-thievish-shakiness-8412@gregkh>
References: <20230606102910.1013674-1-neelchakrabortykernelwork@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606102910.1013674-1-neelchakrabortykernelwork@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 03:59:10PM +0530, Neel Chakraborty wrote:
> Replaced code that was using bare unsigned to use unsigned int
> 
> Signed-off-by: Neel Chakraborty <neelchakrabortykernelwork@gmail.com>
> ---
>  drivers/usb/musb/musb_gadget.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Where is patch 1/2 of this series?

As it looks like you are new to kernel development, I strongly
recomomend you start out doing coding cleanups in the drivers/staging/
portion of the kernel first, as that is explicitly what it is there for.
That keeps kernel developers and maintainers of other subsystems from
having to work through basic issues like this.

Also, I recommend re-reading the kernel documentation for how to submit
a patch, this isn't the correct way :)

thanks,

greg k-h
