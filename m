Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDBE6B34F0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 04:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjCJDro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 22:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCJDrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 22:47:42 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897E3EDB4B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 19:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6MitYSSpfp0F6LhqPjn+i0RMAWOkpL3ZzPSPzlzMYGY=; b=k8xJ3pNOqTHsvBT3Lnl/ajhEeQ
        xaxalEMFZVTYJEJcNCb/REpqdvybnQacdqHKgY9h2HI3tofGWh1j7guuiBYD0SIrtN9TcsYz/LKaN
        cGcOZLZpPbtsLseF7D0OG5i9x4ZJ9xBdoVdj4Kfl3K5odD1evMH+QYMkThz8APOZkGQgcnv2/b76y
        7gDxj1B4m6hghX3AlfpxKBnPnQeFYym8Z5qkirZi3PkME6vx1CQMTpXDSmjZ5SiD9xkJK6aZ7u44z
        nEmcfbq8Alkd8GGDyQXDuUiIc11/CiG+et5xHD1PXfNYQ3Pv3fC4HqNkQJRLZALBIEXisnWY2F0QJ
        pC0DqhTg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1paTjG-00FCku-1m;
        Fri, 10 Mar 2023 03:47:38 +0000
Date:   Fri, 10 Mar 2023 03:47:38 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] fs: prevent out-of-bounds array speculation when closing
 a file descriptor
Message-ID: <20230310034738.GJ3390869@ZenIV>
References: <20230306185450.1028235-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306185450.1028235-1-tytso@mit.edu>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 01:54:50PM -0500, Theodore Ts'o wrote:
> Google-Bug-Id: 114199369
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
> 
> I had sent this a while back, and failed to follow up when it
> apparently get missed.  $WORK has been carrying this (or the
> equivalent) as an out-of-tree security patch since 2018, and now some
> folks are now nagging me about why hasn't this gone upstream yet...

Applied (#fixes), will go to Linus this weekend.
