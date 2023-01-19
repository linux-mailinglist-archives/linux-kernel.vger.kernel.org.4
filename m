Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA4967319E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 07:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjASGNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 01:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjASGNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 01:13:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6696066EDB;
        Wed, 18 Jan 2023 22:12:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3B3361B16;
        Thu, 19 Jan 2023 06:12:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0BC9C433EF;
        Thu, 19 Jan 2023 06:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674108767;
        bh=A2PghEoRmSghnztcEE/zkcVqIUrtIJzjVmsfGTfu3gA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gzCXat3CmTS2VlmvwFUkJU8fmRn+GFxQqT3mThdFv03YrJ5uBPeySqF/RrEmsxhOr
         hQ9HkmeXcx0ynX7iJUSfBB3rV9pjzD4tzDMyhJeLDvLW/svcgu4On2wHNS/UGs8Q5H
         Wk4tTIQHBagoIkWZ+bw+924rIK3XKh8lwYgBbAl81nSm1Obw1JEGx5+TwMAY3L6WwC
         3/g4TmqoAeyYcSLV1bDm83sL4Lvv302LDd3JW07hJpghdsNSJKMIXrDORunbra90BS
         7hiyMLVbNeCafYE2MkiU7EHNyVL+i4v5zSvOYFRG+NL+LyBm/GOzaUM8DQRo4qjXUv
         d1aAYBiEOzvsA==
Date:   Thu, 19 Jan 2023 11:42:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>, Greg KH <greg@kroah.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sing-Han Chen <singhanc@nvidia.com>,
        Wayne Chang <waynec@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the phy-next tree
Message-ID: <Y8jfW2TTnHd3J7R1@matsya>
References: <20230119153145.598885cf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119153145.598885cf@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-01-23, 15:31, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are also in the usb tree as different commits
> (but the same patches):
> 
>   5c7f94f8bad8 ("phy: tegra: xusb: Add Tegra234 support")
>   e5f9124404d0 ("phy: tegra: xusb: Disable trk clk when not in use")
> 
> they are commits
> 
>   d8163a32ca95 ("phy: tegra: xusb: Add Tegra234 support")
>   71d9e899584e ("phy: tegra: xusb: Disable trk clk when not in use")

Ah, ideally these should go thru phy tree!

> 
> in the usb tree.
> 
> -- 
> Cheers,
> Stephen Rothwell



-- 
~Vinod
