Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00F76B1F81
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjCIJKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjCIJKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:10:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B85265BE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 01:10:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E1D5B81BF2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 09:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4411C433EF;
        Thu,  9 Mar 2023 09:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678353003;
        bh=B6FKE/jSQi4/bSDONFJFsvuKCW4GcIgn++eqxrymCN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kSakZWr5jQsAavM69tLBS/We5d9P14qRKjPiu2mTLR7ykHONJd7jk+hisQnBhcKNX
         HaW6/I2s/j7VhPmwBa8MUs1wERO4/4XgmMtJL0dQAJd18IqgNaPk0Wws8/Pt5VcPC/
         +nKBFPFd0v4iWERpr02j4K3BUnTpvNB9meUlMYc8=
Date:   Thu, 9 Mar 2023 10:10:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        paskripkin@gmail.com
Subject: Re: [PATCH] Staging: r8188eu: Fixed block comment
Message-ID: <ZAmiaJT0wJkZq8dc@kroah.com>
References: <Y+8p7Hyaf4LhO/Sw@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+8p7Hyaf4LhO/Sw@khadija-virtual-machine>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 07:17:00AM +0000, Khadija Kamran wrote:
> Fixed block comment by adding '*' in each line. The Check message was
> shown by using checkpatch.pl script.
> 
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_br_ext.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)

This driver is now deleted, so this will not apply for obvious reasons.

thanks,

greg k-h
