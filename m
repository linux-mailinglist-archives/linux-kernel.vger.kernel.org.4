Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FCE6C1A5E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjCTPvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjCTPuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:50:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A23D19F3A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:42:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A812D61592
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 15:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812EEC433D2;
        Mon, 20 Mar 2023 15:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679326949;
        bh=AZDfh3YjXnOORQifCX1A9Zi+Ke86D7+DHnwmz7SWMkM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LxFKTA9DCJ68FwMFyvHkg89kkx9iXcciTs2Dj8rU/ApvVRfQ/1gNcRlEm4XgNpaVD
         rRBgOobGURRC+59mb6mfS19ydozuTpxQ1q+ZRTnM9M/DClRzEpjFf6KEYXtA7MHAiI
         c2GLBSW6W1a+tQjCxtX8ZeqQvVDzGbVGYida0RNk=
Date:   Mon, 20 Mar 2023 16:42:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
Cc:     outreachy@lists.linux.dev, johan@kernel.org, elder@kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH v3] staging: greybus: use inline function for macros
Message-ID: <ZBh+3W4eTL9IMW3n@kroah.com>
References: <20230320103258.6461-1-eng.mennamahmoud.mm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320103258.6461-1-eng.mennamahmoud.mm@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 12:32:58PM +0200, Menna Mahmoud wrote:
> Convert `to_gbphy_dev` and `to_gbphy_driver` macros into a
> static inline function.
> 
> it is not great to have macro that use `container_of` macro,
> because from looking at the definition one cannot tell what type
> it applies to.
> 
> One can get the same benefit from an efficiency point of view
> by making an inline function.
> 
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
> ---
> change in v2:
> 	remove newlines added in previous patch.
> 
> change in v3:
> 	fix the patch to be against Greg's tree.

I am lost in a twisty maze of patches from you for the greybus code that
all seem alike but are different :(

Can you send a patch series of the latest changes you have made, as I
really don't know what is, and is not, the latest versions at all, so
I'm going to have to drop them all from my review queue right now.

thanks,

greg k-h
