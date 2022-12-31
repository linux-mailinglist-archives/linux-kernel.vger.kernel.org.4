Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D69265A3C9
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 12:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbiLaLrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 06:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLaLq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 06:46:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9D87658
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 03:46:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 813DF60A0A
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 11:46:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED01C433EF;
        Sat, 31 Dec 2022 11:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1672487215;
        bh=mLNAW/smzliujmTg5b8GKyjVLPSUZjsS30P+w5eM0jA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tdAjGap5Yh22z/adVbMCPUPadCUn9ZkY+5KidVfV2/DKDI9zUMU14NinbsHcDV1sk
         aH9yExfncgeDF4hTthetm1ah51CvZYAg09jmEEDv8GnNYpvW1lJZ6QAUAJfbGUOd2k
         35vMUrtJ4kmEHFZiOapSloQ0YipllTHDvqTft1C8=
Date:   Sat, 31 Dec 2022 12:46:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yoochan Lee <yoochan1026@gmail.com>
Cc:     matt.hsiao@hpe.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: hpilo: Fix use-after-free in ilo_open
Message-ID: <Y7AhLWSPE+2hnZ2I@kroah.com>
References: <20221231055310.2040648-1-yoochan1026@gmail.com>
 <Y7AHvYfZreO/G/kT@kroah.com>
 <CALQpDLfMjAE9_VtMO6e_iiPrciFNbksLQT3AB3QTGwZCNf5=sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALQpDLfMjAE9_VtMO6e_iiPrciFNbksLQT3AB3QTGwZCNf5=sA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2022 at 07:05:36PM +0900, Yoochan Lee wrote:
> Hi,
> 
> I haven't tested with a physical device cause I don't have a real device.
> I found this bug through static analysis.

Then please verify that it actually is a bug and that you have fixed it
properly.  To send patches that are broken wastes everyone's time :(

Also, you did not properly describe how the static analysis happened or
what tools reported it as is required.

> This type of bug is similar to [1] and [2].
> 
> And I'm sorry that my patch is incorrect.
> It's my first time patching a Linux kernel myself.

I suggest taking the tutorial on kernelnewbies.org and working in the
drivers/staging/* portion of the kernel first, so that you can learn how
this all works.  Do not dive in and assume that fixing issues that a
random tool spits out is even correct to do.

good luck!

greg k-h
