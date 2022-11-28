Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0BA63B490
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 23:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbiK1WCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 17:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbiK1WCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 17:02:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677D91BEAB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 14:02:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03743614AC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 22:02:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BB5C433D7;
        Mon, 28 Nov 2022 22:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669672924;
        bh=pl9ZG4quKKMMXfDxoF/Izq6FMKP7JPEKUG99JP6uVp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QMwIWUzh33F0tItOAKKNud+vIZ/TFaaOEr9p2xZOGog50kPo0/MnTexm/MIUV7oMU
         9mdfVmVNEGhlYjhsxVx3YA7V2P2J2OAiPZiG4leZdGQYmuWycv0gPejHF1QlVIEGJv
         yBFmVt3alG8DnC96k016aY2HGsMMBaeTDrcOY/HZBTwA6N13/+ZTsYW5OMi5KVzrmW
         jIbx9ktczqHB2zAHlm7T9Tzve2HWfKGpFR92Jm/P//ybN4Nkh9XqimD976CQ5c22ZN
         JQr+vpJ6vxV3pMLEMS0162WVykkBjf3MZI9yYD/haVNoc9ovjTKO2fHpwHt+d2VKdD
         IW/04PsAK1ZQw==
Date:   Mon, 28 Nov 2022 14:02:02 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: Add f2fs bug tracker link
Message-ID: <Y4Uv2tuHerLvJdLl@google.com>
References: <20221128035150.30787-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128035150.30787-1-frank.li@vivo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you don't mind, let me merge this patch into Chao's patch, since both
are same topic.

On 11/28, Yangtao Li wrote:
> It's better to use bugzilla.kernel.org for reporting bugs.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  Documentation/filesystems/f2fs.rst | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index 6e67c5e6c7c3..67e1f3e86f32 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -25,10 +25,14 @@ a consistency checking tool (fsck.f2fs), and a debugging tool (dump.f2fs).
>  
>  - git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git
>  
> -For reporting bugs and sending patches, please use the following mailing list:
> +For sending patches, please use the following mailing list:
>  
>  - linux-f2fs-devel@lists.sourceforge.net
>  
> +For reporting bugs, please use the following f2fs bug tracker link:
> +
> +- https://bugzilla.kernel.org/enter_bug.cgi?product=File%20System&component=f2fs
> +
>  Background and Design issues
>  ============================
>  
> -- 
> 2.25.1
