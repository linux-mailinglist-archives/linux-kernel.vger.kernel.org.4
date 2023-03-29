Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB8E6CD786
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 12:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjC2KUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 06:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjC2KUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 06:20:21 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C041BFC;
        Wed, 29 Mar 2023 03:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4BF1ACE203F;
        Wed, 29 Mar 2023 10:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C58BC433D2;
        Wed, 29 Mar 2023 10:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680085216;
        bh=2LqqgQAuhpDJqVzK6AoV3SigpXXBvOupXEWHTxD3sAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h/qRrHedEYvYFj7VFVLSLBfaBUeIyogbOhdhgbz/E5D3EZxvY/3MQlAnjpUi0muDH
         64E50x+NQOZQyH+DNChlKPyiDcDWpwBdwQeh2aJCvHnUGw/k/9VpHw1HDK28Lye7cK
         RoyCZTCbqLeS51BBmgGj3JYwF1B7e4sWgNvlg68E=
Date:   Wed, 29 Mar 2023 12:20:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yu Zhe <yuzhe@nfschina.com>
Cc:     lkundrak@v3.sk, arnd@arndb.de, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com
Subject: Re: [PATCH] char/pcmcia: remove unnecessary (void*) conversions
Message-ID: <ZCQQ3Yvvb8It71zh@kroah.com>
References: <20230316084355.9195-1-yuzhe@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316084355.9195-1-yuzhe@nfschina.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 04:43:55PM +0800, Yu Zhe wrote:
> Pointer variables of void * type do not require type cast.
> 
> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
> ---
>  drivers/char/pcmcia/scr24x_cs.c | 2 +-

Sorry, but this file is now deleted from the tree.

greg k-h
