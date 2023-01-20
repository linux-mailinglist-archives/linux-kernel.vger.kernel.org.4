Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B799C674F2C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 09:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjATIKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 03:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjATIKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 03:10:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6233C3C2B1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 00:10:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14841B81FBA
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBD2C433D2;
        Fri, 20 Jan 2023 08:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674202241;
        bh=5cv0+Ljr1g2qdpIoZ6F5olFzW3UO+ZaA/5poTP5lqLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tfkjTdSHxhJ41L3KXRGGhooRUD8oKmaDGMrGOZnEB9yvex845BH4RlRGr3z18qsiH
         8hhxr/WcNsCg1TUboQqUlk1L4SDwLc+6l2sk73nlU0cCRfW1PKovOC6+V/pKKSdgA5
         l8U3AZdU77rRXj3Pq2CQLxyDN7Ne8HBtiZYyBoVuXCf7nyMlV50BfdBhMK+d5sUFSb
         rqFC4M/UWAY8PIoUOINpAFuhlhi58lVUZ1omHfiHWGGDXd0aWRpaRmdnmr8J2dB3BP
         cZA2JheS1SmJ6OzM3eqZ9Sskgsk/e684xUYpi1ehrHyV0IdBw5e4tDx6f2ZkjsSm35
         G5wmeFAlcXDsw==
Date:   Fri, 20 Jan 2023 08:10:37 +0000
From:   Lee Jones <lee@kernel.org>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     sam@ravnborg.org, linux-kernel@vger.kernel.org,
        users@linux.kernel.org
Subject: Re: [PATCH 13/15] backlight: omap1: Use backlight helpers
Message-ID: <Y8pMfXLvJfQfTex+@google.com>
References: <20230107-sam-video-backlight-drop-fb_blank-v1-0-1bd9bafb351f@ravnborg.org>
 <20230107-sam-video-backlight-drop-fb_blank-v1-13-1bd9bafb351f@ravnborg.org>
 <Y8m8CM35ku+Fuppc@google.com>
 <20230119215918.3tv5e55a5sfcpf4v@meerkat.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230119215918.3tv5e55a5sfcpf4v@meerkat.local>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2023, Konstantin Ryabitsev wrote:

> On Thu, Jan 19, 2023 at 09:54:16PM +0000, Lee Jones wrote:
> > My tools appear to dislike the line break in the Message-Id header.
> > This isn't something I've encountered before.  Is this a B4 thing?
> 
> It's more like it's a Python thing. The upcoming version of b4 will avoid this
> (by not relying on Python to do message generation).

Understood.

> > Is this standard?  Should I adapt my tooling to scan over line breaks?
> 
> This is RFC conformant, so if your tools are not able to deal with this
> situation, you should consider modifying them.

Thanks for the info Konstantin, I'll do just that.

-- 
Lee Jones [李琼斯]
