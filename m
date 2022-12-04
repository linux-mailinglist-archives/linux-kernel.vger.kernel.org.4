Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DD1641FF5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 23:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiLDWDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 17:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiLDWC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 17:02:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9D46572;
        Sun,  4 Dec 2022 14:02:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B552560F0D;
        Sun,  4 Dec 2022 22:02:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6282C433D6;
        Sun,  4 Dec 2022 22:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1670191376;
        bh=677D2kFy1xPNEUHBeKIr1d1GxJT9gHfHHm6YiInMw+U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qxK+ZVA8m7sjSl4M8OLNCJyhsmKqRA2NzSOMi2/gic9zVcYaHqcLu4zMR+/DVh1FQ
         syO0trhAGgYt8Ks3aGoHtVKADLu5xNgR5zdgYzHMsZqBUncF5e0PxStEfk+vgcxOd0
         E69ZRWLerXLB0C2WFjwRl4t7sLtpV4GVVFNGJ1NM=
Date:   Sun, 4 Dec 2022 14:02:55 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-bys missing for commit in the
 mm-hotfixes tree
Message-Id: <20221204140255.cb57ed220fcb917fe78e4e47@linux-foundation.org>
In-Reply-To: <20221205074938.3191e5d7@canb.auug.org.au>
References: <20221205074938.3191e5d7@canb.auug.org.au>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Dec 2022 07:49:38 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> Commit
> 
>   3649d3bcf64d ("kselftests: cgroup: update kmem test precision tolerance")
> 
> is missing Signed-off-bys from its author and committer.
> 

I didn't trim at the ^---$ correctly.  I guess we should check for more
than one "^---$.  
