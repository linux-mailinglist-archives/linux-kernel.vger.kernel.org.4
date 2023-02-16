Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B412698B79
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 05:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjBPEwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 23:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBPEwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 23:52:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40096422F;
        Wed, 15 Feb 2023 20:52:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDB76B82591;
        Thu, 16 Feb 2023 04:52:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97EDC433EF;
        Thu, 16 Feb 2023 04:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676523169;
        bh=qVVzcCSbDY1tKnyjoCCz1adpsr2TzUeHRx6BetLpm4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aKA46E1fjlBaA+Ill9G5FzhZor7ggG0zYVfiSe0At4ia6HyJQ8GBFD12RoOI9zcXv
         IQ+82Hb7p8oXeM7PTcgkbyJAbhKJYda1YmId86XrVMsn+pRauEwDrw/Ffd1QpKGwbd
         JSuFPvPICAverN+B8U5akrYEeFD5KU7u5fU4UU1U=
Date:   Thu, 16 Feb 2023 05:52:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jesper Juhl <jesperjuhl76@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        linux-media@vger.kernel.org
Subject: Re: [Paatch] [staging][atomisp] Remove unneeded version.h include
 pointed out by 'make versioncheck'
Message-ID: <Y+22naE0azHHF0nY@kroah.com>
References: <4b9f2443-3360-bdb0-c4d4-7687db333d0a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b9f2443-3360-bdb0-c4d4-7687db333d0a@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 01:57:45AM +0100, Jesper Juhl wrote:
> > From d0b9a59ac1bc69523b5cc8b2bab0b0e0b4bd0ab6 Mon Sep 17 00:00:00 2001
> From: Jesper Juhl <jesperjuhl76@gmail.com>
> Date: Mon, 13 Feb 2023 02:52:24 +0100
> Subject: [PATCH 05/12] [staging][atomisp] Remove unneeded version.h include
>  pointed out by 'make versioncheck'

Why is this in the body of your email?

> 
> Signed-off-by: Jesper Juhl <jesperjuhl76@gmail.com>

We can not take patches without any changelog text, sorry.

thanks,

greg k-h
