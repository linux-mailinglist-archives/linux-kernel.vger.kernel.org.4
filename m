Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0925F8D1F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 20:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiJISXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 14:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiJISXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 14:23:31 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4231FCEB
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 11:23:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7633ACE0F51
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 18:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F70C433D6;
        Sun,  9 Oct 2022 18:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665339804;
        bh=HUbODNAjFv/J8iYFQl+4k2k4DSUVenA1YE+DmcAhuLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FCBKVXpL4H5gVqrgc4MAZbXfO+TkP85RbIIV62Ol6YJRAXk8UieJx707x6ncL5BlP
         Z8DuPzJF3Xny04hLXgBBYEfqPjkRRHm3b74h2Tei7hfLurCXwCQoAE/CgAd8WCO6vq
         lNXZRDYE2utUYmZSty8xH7KPxZlpJH3K1WIfKfVk=
Date:   Sun, 9 Oct 2022 20:24:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Soha Jin <soha@lohu.info>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Case-insensitive match_string and
 fwnode_is_compatible()
Message-ID: <Y0MRxgKhRVbyrTz2@kroah.com>
References: <20221009162155.1318-1-soha@lohu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009162155.1318-1-soha@lohu.info>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 12:21:52AM +0800, Soha Jin wrote:
> I am introducing these patches for the patch for ethernet driver which I
> will send later.

We can't take functions that have no real users.  Please send these
patches as part of your driver submission so we can see how they are
used and if they are even needed at all.

thanks,

greg k-h
