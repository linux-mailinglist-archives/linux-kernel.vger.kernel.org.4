Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D083568D0B5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 08:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjBGHka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 02:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjBGHk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 02:40:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272113524A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 23:40:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB164611CE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 07:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F460C433D2;
        Tue,  7 Feb 2023 07:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675755626;
        bh=ruNkRuymOOg0sWL/1aO3vcUdz3VrnPNH2mzfy2q55oA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yMfOGPJu/yELE3msXQPqv23Mv6ClILKpgZksy+4PX+wz27823FLfcO1gVd5T4Q8fL
         F8wq/WmgIAKdmtFgZA56NgszzohedD7qQoMSueWa3EjBXHOqMp8ZCO/ldtXIWdAeph
         sIDHE465xQA4DS7RUtmze02nwukZTl6ar7vUnD9s=
Date:   Tue, 7 Feb 2023 08:40:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] staging: vt6655: Macro with braces issue changed
 to inline function
Message-ID: <Y+IAZxQTkZpgD1+I@kroah.com>
References: <cover.1675753094.git.gurumeharrachaputi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1675753094.git.gurumeharrachaputi@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 08:14:26AM +0100, Guru Mehar Rachaputi wrote:
> 
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
> 

I only see this 0/4 message, no actual patch in the series was sent out.
Did something go wrong?

thanks,

greg k-h
