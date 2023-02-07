Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8744E68D205
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjBGJFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjBGJFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:05:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7BA2E83B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 01:05:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6DA6611FE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 09:05:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAABFC4339B;
        Tue,  7 Feb 2023 09:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675760736;
        bh=GEWXFt8xTzK3IID96iaDApfCmYmvPfeW8yICtHDyYe0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ldVXBo6jNRfqNPR1N7pN8+FkqOgjMkZq63i6c5oigcaBm4Qcs1MaqQ8PIg+pVp2st
         iOIAepOi+131xBAZw+zuuHI0H3zETS3MONIBza+8t2Up69AS5d5nDUz6DhIwxmDlym
         qRkyNlRqUFC14v4GWKi+yQvNRKby98Pcpudu+02g=
Date:   Tue, 7 Feb 2023 10:05:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] staging: vt6655: Macro with braces issue changed
 to inline function
Message-ID: <Y+IUXSO8LM53qHoJ@kroah.com>
References: <cover.1675753094.git.gurumeharrachaputi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1675753094.git.gurumeharrachaputi@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 09:40:37AM +0100, Guru Mehar Rachaputi wrote:
> This patch is to fix checkpatch warning: "Macro argument 'iobase' may be better
> as '(iobase)' to avoid precedence issues" changed to inline function. In
> relation to this, names of the callers of macro are also modified to call
> this function.
> 
> 
> Changes in v4:
> 	- Modified commit message to be clear
> 
> Changes in v3:
> 	1. Whitespace error from checkpatch fixed
> 	2. Should be applied together with changes in v2 for testing
> 
> Changes in v2:
> 	- Macros with one statement that is to call 'iowrite8' function changed
> 	to inline function as reviewed by gregkh@linuxfoundation.org.
> 	In relation to this, names of the callers of macro are also modified
> 	to call this function.
> 
> 
> Guru Mehar Rachaputi (4):
>   staging: vt6655: Add braces to macro parameter 'iobase'
>   staging: vt6655: Macro with braces issue change to inline function
>   staging: vt6655: Macro with braces issue change to inline function
>   staging: vt6655: Macro with braces issue changed to inline function
> 
>  drivers/staging/vt6655/card.c        |  4 ++--
>  drivers/staging/vt6655/channel.c     |  4 ++--
>  drivers/staging/vt6655/device_main.c | 12 ++++++------
>  drivers/staging/vt6655/mac.c         |  8 ++++----
>  drivers/staging/vt6655/mac.h         | 12 +++++++++---
>  5 files changed, 23 insertions(+), 17 deletions(-)
> 
> -- 
> 2.34.1
> 
> 
> -- 
> Thanks & Regards,
> Guru

> >From 447c10de599e3434fb6c012cdfc2cc8e4b5c839b Mon Sep 17 00:00:00 2001
> Message-Id: <447c10de599e3434fb6c012cdfc2cc8e4b5c839b.1675753094.git.gurumeharrachaputi@gmail.com>
> In-Reply-To: <cover.1675753094.git.gurumeharrachaputi@gmail.com>
> References: <cover.1675753094.git.gurumeharrachaputi@gmail.com>
> From: Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
> Date: Sat, 4 Feb 2023 04:34:38 +0100
> Subject: [PATCH v2 1/4] staging: vt6655: Add braces to macro parameter
>  'iobase'

<snip>

Do you see other examples of people on the mailing list submitting
patches as multiple attachments?

Please do not do this.

I recommend taking a week or so and reviewing the other submissions that
are sent to the list first, to understand the processes involved, before
trying to submit your own changes.

Remember, you need to learn to read first, before you learn how to write :)

thanks,

greg k-h
