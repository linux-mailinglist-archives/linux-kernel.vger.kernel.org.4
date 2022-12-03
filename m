Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4FE641676
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 12:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiLCLgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 06:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiLCLgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 06:36:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1771F19284;
        Sat,  3 Dec 2022 03:36:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9FCDB81BE6;
        Sat,  3 Dec 2022 11:36:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFC9C433D6;
        Sat,  3 Dec 2022 11:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670067402;
        bh=w9wDFZxKmw5YKM8njjE2stck7WPSNk4uLuV+WyhFXDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jDIEmgM/1r5+mpP6/h4XQjKsRmLD05ThylrrBdhxfpmSw2Z/ZGd4kEu1/+uaYmYsl
         rjqo+8QzDGTS/LP20wm7GsJy77BwN8FtMqqFruR772YcHhPTANIpeqYi0IGQpVyo49
         K6n/6ARMjbChc8ewWKL/uSXv5/RWHXolZa5gRBRM=
Date:   Sat, 3 Dec 2022 12:36:39 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, sj@kernel.org,
        stable-commits@vger.kernel.org
Subject: Re: Patch "mm/damon/sysfs: fix wrong empty schemes assumption under
 online tuning in damon_sysfs_set_schemes()" has been added to the 6.0-stable
 tree
Message-ID: <Y4s0x8aOxb2w+2wR@kroah.com>
References: <167006662820424@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167006662820424@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2022 at 12:23:48PM +0100, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     mm/damon/sysfs: fix wrong empty schemes assumption under online tuning in damon_sysfs_set_schemes()
> 
> to the 6.0-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      mm-damon-sysfs-fix-wrong-empty-schemes-assumption-under-online-tuning-in-damon_sysfs_set_schemes.patch
> and it can be found in the queue-6.0 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 

Nope, breaks the build, now dropped.
