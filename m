Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A38762E46A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240528AbiKQSj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234929AbiKQSjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:39:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA507C471
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 10:39:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0778460AAF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 18:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48BDC433D6;
        Thu, 17 Nov 2022 18:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668710362;
        bh=siyVl9+nQ1dss4qd5h7wPMTVP1rPGA7j7/8Tws5BI8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aynITZQeTzel1M0PE0Gt7nJq7/ZtM1rOqLek/twE5PGPZMkEvZW6u9PY7kgZAmNHh
         D1W0ftxgDDJEy1NbPTuwodDwKEvGxdQJ1u++b3DucN6ztYoCozqToqZ0dfWt4tIOMi
         bWKmLzDpTHNmsDQaFluIFy5tJPs8T8a63SFj4PFg=
Date:   Thu, 17 Nov 2022 19:38:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Subject: Re: [driver-core-next] vmlinux.lds.h fix (corrected)
Message-ID: <Y3Z/w29imUu6MpN+@kroah.com>
References: <Y3XU59mj80wvTD6Y@kroah.com>
 <20221117171633.923628-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117171633.923628-1-jim.cromie@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 10:16:31AM -0700, Jim Cromie wrote:
> hi Greg,
> 
> Im not quite sure what went wrong with last rev.
> Im intrinsically noisy.  Its hard to fix permamently.
> 
> 1st patch restores basic BOUNDED_SECTION wo header reservation.
> 
> 2nd redoes the HEADERED_SECTION idea with separate macros, so it cant
> affect the basic case.  I havent actually used this yet.
> 
> I should have stared at this patchset longer before sending.
> sorry about that.

Worked better, thanks, now applied.

greg k-h
