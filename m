Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBBC662AFD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbjAIQRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbjAIQQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:16:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847A062F8
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 08:16:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21449611BE
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 16:16:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12184C433F1;
        Mon,  9 Jan 2023 16:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673281009;
        bh=gfjzt/DnF9JCvu8ufzPU2ZxmvixSmjjSU/gNSsjFWEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V88ClifFKaGQJE/tkgPL9sOuWJq7wM0ylZS3l3ybzyNdtm4NfkW8jwDdGDwxzWGcK
         hMLo6bdOt5emTRJxjvQ4nZD2ICBEys2A+0/T6+0vAL7E5rZXNzUxVLahb8NEAZhzHn
         XG89infn9dhpMxnJxMCibE3bFRchbex5U2Sln5zQNYHKpmcCk8RT2ZZwF0NwCCfbGX
         0mK7RdnmvDh0jQgJZk2M6Cz+TIts3+2cY6OYuK1sws9H9tfBqItsOeVhcvTsfnt20f
         DmSZbUjbJLq69nYj2iTUqkUe5BSnlLRub8vY+o0zDi3Fo3PeeefkGWKSWRpAcGfMCl
         CLyAzkdXNwoQg==
Date:   Mon, 9 Jan 2023 21:46:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v4 0/4] Minor SoundWire clean ups
Message-ID: <Y7w97fs92SL8Sg5U@matsya>
References: <20221125142028.1118618-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125142028.1118618-1-ckeepax@opensource.cirrus.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-11-22, 14:20, Charles Keepax wrote:
> Just some minor tidy ups and preparation for starting to upstream some
> Cirrus SoundWire devices. The first three patches are pretty trivial,
> the last patch which moves the remaining core over to using the no_pm
> functions could probably use some careful review.

Applied, thanks

> 
> Changes since v3:
>  - Return an error and add a WARN_ONCE if the build stubs are used.
> 
> Changes since v2:
>  - Fix up a memory leak of a buffer on the error path
>  - Added some reviewed by's
> 
> Thanks,
> Charles
> 
> *** BLURB HERE ***

oops :)

 
> 
> Charles Keepax (3):
>   soundwire: Provide build stubs for common functions
>   soundwire: debugfs: Switch to sdw_read_no_pm
>   soundwire: stream: Move remaining register accesses over to no_pm
> 
> Simon Trimmer (1):
>   soundwire: bus: export sdw_nwrite_no_pm and sdw_nread_no_pm functions
> 
>  drivers/soundwire/bus.c       |  10 ++--
>  drivers/soundwire/debugfs.c   |  13 ++++-
>  drivers/soundwire/stream.c    |  30 +++++-----
>  include/linux/soundwire/sdw.h | 107 ++++++++++++++++++++++++++++++----
>  4 files changed, 129 insertions(+), 31 deletions(-)
> 
> -- 
> 2.30.2

-- 
~Vinod
