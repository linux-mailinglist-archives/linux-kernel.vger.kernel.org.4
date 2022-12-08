Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F756473BD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 17:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiLHQB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 11:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiLHQBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 11:01:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FE15E9FD
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 08:01:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A70CD61F80
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 16:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7446C433D6;
        Thu,  8 Dec 2022 16:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670515283;
        bh=YlO69Sc0M8Hc8I5mYxw/iz45w3vbyvj2NPmlRe3hG4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=diXhpftUYUNVV/xIU+zq/ngEF+033EtYdp0LlZUDACKMnR8/ChR42F8SMRWIyIOe4
         Vt8EV2+2sQJglWj2gP7yrDYXyf0E3MA0eMeumH4n75T3W+M6AXdKvQz62ca9stccxA
         MFYhVmHa0N9CI+blJQvgdyciE9cQI2myvEk5CpEg=
Date:   Thu, 8 Dec 2022 17:01:20 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matt Jan <zoo868e@gmail.com>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v3 1/3] staging: vme_user: add the spaces around the "*"
Message-ID: <Y5IKUMH+mq++Kx9s@kroah.com>
References: <20221208140531.3840-1-zoo868e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208140531.3840-1-zoo868e@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 10:05:32PM +0800, Matt Jan wrote:
> Add a space around the "*" at vme_bridge.h to clear up a checkpatch
> check.
> 
> Signed-off-by: Matt Jan <zoo868e@gmail.com>

This series never showed up on lore.kernel.org, why not?

It seems like you are spoofing the gmail.com address?  Or is something
else going wrong on your email side?

thanks,

greg k-h
