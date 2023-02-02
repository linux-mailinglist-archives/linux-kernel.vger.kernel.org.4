Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBF0687612
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 07:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjBBGyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 01:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBBGyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 01:54:01 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01584193EC;
        Wed,  1 Feb 2023 22:53:59 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4ECD1C14;
        Wed,  1 Feb 2023 22:54:41 -0800 (PST)
Received: from bogus (unknown [10.57.12.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BDCC3F71E;
        Wed,  1 Feb 2023 22:53:56 -0800 (PST)
Date:   Thu, 2 Feb 2023 06:53:53 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg KH <greg@kroah.com>, Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the driver-core tree
Message-ID: <20230202065353.x7wclzdeui4xylle@bogus>
References: <20230202121224.54425afd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202121224.54425afd@canb.auug.org.au>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 12:12:24PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are also in the scmi tree as different commits
> (but the same patches):
> 
>   ecaef469920f ("cacheinfo: Initialize variables in fetch_cache_info()")
>   d931b83e62b1 ("cacheinfo: Make default acpi_get_cache_info() return an error")
>   921e672dee91 ("cacheinfo: Remove unused check in init_cache_level()")
> 
> They are commits
> 
>   7646b6682b41 ("cacheinfo: Initialize variables in fetch_cache_info()")
>   2ebcd557e000 ("cacheinfo: Make default acpi_get_cache_info() return an error")
>   b73679f891d8 ("cacheinfo: Remove unused check in init_cache_level()")
> 
> in the scmi tree.

Now dropped, sorry for the trouble.

-- 
Regards,
Sudeep
