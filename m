Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FF06AD917
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjCGITo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjCGITN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:19:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6E720061
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 00:18:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30FBE611C0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A45C433D2;
        Tue,  7 Mar 2023 08:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678177119;
        bh=iFtZJY6joyaxJ6ADt/mWBI2yiWQo/C9fw6pfP6N9mtw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N2XdzAl5RViq1vIDsUYry3s7w+QDQ7nA7dMz9JWbmuXSK1rIxMU2b/f7fHUlqYVUw
         LQQoylywLTOhH9GKkizHxrikMJHeqTlmwOdo+tsBBsRvo/3UfAPwLqCMCc9nSTtaoT
         mfmNovxjz/zeYfwVRP5EAq8lhrq3p4SUX7/LsNTo=
Date:   Tue, 7 Mar 2023 09:18:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Khadija <kamrankhadijadj@gmail.com>
Cc:     Dan Carpenter <error27@gmail.com>, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: alignment should match opening
 parenthesis in axis-fifo.c
Message-ID: <ZAbzXA5+tMaagtFj@kroah.com>
References: <ZAZSmPpB6fcozGa4@khadija-virtual-machine>
 <9543f943-759f-4e87-8f88-4eba7c1e4785@kili.mountain>
 <CACcTnM5kVTG3JaLK9mjaOO7qcXoTrb4xsg2af5Ac1ScqFfbjTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACcTnM5kVTG3JaLK9mjaOO7qcXoTrb4xsg2af5Ac1ScqFfbjTg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 01:10:17PM +0500, Khadija wrote:
> Hey Dan! Thank you for your feedback.
> Yes, the code currently looks unreadable. I am making changes and resending
> the patch.
> Also, on running checkpatch.pl on my patch file I get a warning about 75
> chars per line. Is there a way of fixing it automatically using script?

Hi,

Minor housekeeping notes.  Your email client is sending out html email,
which is rejected by the public mailing lists.  Please reconfigure it to
not do that.

Also, try not to ever top-post like this, it breaks the review process
and makes it impossible at times to determine what you are actually
responding back to.  Read some of the mailing list archives at
lore.kernel.org for examples of the proper way to respond to messages
inline.

thanks,

greg k-h
