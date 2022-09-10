Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B5E5B4448
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 07:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiIJFgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 01:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiIJFgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 01:36:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9B09877D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 22:36:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7A836097C
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 05:36:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0919C433C1;
        Sat, 10 Sep 2022 05:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662788190;
        bh=MhHDDT4ENasb4odd4tIu3aDa2mJibAA7zIz/n+Uw8jI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MjetwlTdcEyI5RXHv8u2aFGo8yYC3YdTOH0B7zHnAu4O6FYVgotJzICM7KrwwXHxV
         WOcUW7xhSdsBDHW0gZE1e6mJkB4nnNccF/guIhdGAXqAYIWZn33e2PV9dib0SquTtw
         pGrIgy3T/5oYBW2vaiyO7+Md2j65UacLf8/f9gxM=
Date:   Sat, 10 Sep 2022 07:36:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Burak Ozdemir <bozdemir@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: Fix string form declaration
Message-ID: <YxwidHdwPz2yUAP4@kroah.com>
References: <631b5aa8.170a0220.9378b.124a@mx.google.com>
 <YxuASm/KA6iFrKu4@kroah.com>
 <CACAQkfXH4smoY2v28DOZ_0uf_2=e8iEDSFbEbTMhU0JPuteOPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACAQkfXH4smoY2v28DOZ_0uf_2=e8iEDSFbEbTMhU0JPuteOPw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 10:50:57PM +0000, Burak Ozdemir wrote:
> I have been  analyzing todo tasks from `Kernel Janitors Projects` and saw
> the following task
> 
> From: Jeff Garzik
> 
> 1) The string form
>         [const] char *foo = "blah";
> creates two variables in the final assembly output, a static string, and a
> char pointer to the static string. The alternate string form
>         [const] char foo[] = "blah";
> is better because it declares a single variable.
> 
> That's why I changed that char * to static const[].

I'm sorry, but I have no context here at all for what this is in
response to.

Remember, some of us get hundreds of changes each day to review, and we
have the short-term memory of a squirrel.  Always include proper context
in an email message so that we know what is going on.

thanks,

greg k-h
