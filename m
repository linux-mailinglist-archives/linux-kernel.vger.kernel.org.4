Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C9F677778
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 10:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjAWJfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 04:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjAWJfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 04:35:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF6C15C8F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 01:35:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18C3060CF3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:35:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2470DC433D2;
        Mon, 23 Jan 2023 09:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674466506;
        bh=FXhXJlr+cLkMcSTugaksPHqtIC6spO4n9eSK6eK8mFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eq1xZ8mm4P8695nXM5Zew9rk/rLqzecsJA6toBtq2M8HYbFnVZ6zStftKRkK88QTu
         DAeAPumSRwibn09DyaCUehGlwhXxK1ybabz5UGDEBeJMy4RQ3qsCsIXS4s+LfsMmy1
         ZjwKASp2Jd7vLvAILfoQtH7m2owvX0m5FkYh/5Xk=
Date:   Mon, 23 Jan 2023 10:35:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Diederik de Haas <didi.debian@cknow.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: Fix full name of the GPL
Message-ID: <Y85Ux0uGYl0c//mz@kroah.com>
References: <20230122191047.58769-1-didi.debian@cknow.org>
 <Y84wk+sw/gR7gNW4@kroah.com>
 <Y85Kkax5+U4AUedT@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y85Kkax5+U4AUedT@debian.me>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 03:51:29PM +0700, Bagas Sanjaya wrote:
> On Mon, Jan 23, 2023 at 08:00:35AM +0100, Greg Kroah-Hartman wrote:
> > - You did not specify a description of why the patch is needed, or
> >   possibly, any description at all, in the email body.  Please read the
> >   section entitled "The canonical patch format" in the kernel file,
> >   Documentation/process/submitting-patches.rst for what is needed in
> >   order to properly describe the change.
> > 
> 
> Hi Greg,
> 
> drivers/staging/wlan-ng/hfa384x.h (for example) has already SPDX identifier
> that matches the verbose copyright notice below it. 

I have no context here at all, sorry.
