Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41980705AD6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 00:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjEPWzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 18:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjEPWzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 18:55:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C3230E6;
        Tue, 16 May 2023 15:54:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E866B63FF2;
        Tue, 16 May 2023 22:54:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8BCC433D2;
        Tue, 16 May 2023 22:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684277686;
        bh=QrNDGnyMaSEthEcXR/IV3o6pP/XdxCB34fP/wowmY+0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pULmLRfRGs8wiCu+2uPN8y9gajJXRd8gar+WX71N7jt+jLAMnztBSpqYBU1n9phZL
         /DwsXx3xsXTeE6QxwRbm83iHnYDXi4RDRviVYoQFH4ueEsFpywvjvZ3vwTE6O+2fXV
         SbV1LJImlCRsOQaAPMU8z7T4dDG2yZ14d+9fRANyVQQq464fMMT4m/7bMDtTgZz1Yi
         H6fLIkTWFblQAuG5vEo0FhVBwRGsVR7onT3mNuwBUCvkbPYkZS8fd3n+WcDJDIPaxe
         /zNzwSVRf/CA9RPwCWTPSbeI5zqI8WWAk2h/tVRgpAsOJdhdlrELBtLrn4WiUTJg2Y
         x/J6HrxFrbgew==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0087FCE1143; Tue, 16 May 2023 15:54:45 -0700 (PDT)
Date:   Tue, 16 May 2023 15:54:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the rcu tree
Message-ID: <078c7d36-7655-4516-8552-a94eaa6051e3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230517084116.17be78d7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517084116.17be78d7@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 08:41:15AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Commits
> 
>   1d29b558483d ("tools/nolibc: remove LINUX_REBOOT_ constants")
>   09efff85e556 ("tools/nolibc: add testcase for fork()/waitpid()")
>   d9d16cc80854 ("tools/nolibc: s390: provide custom implementation for sys_fork")
>   c792624d254d ("tools/nolibc: validate C89 compatibility")
>   d7644912ea9c ("tools/nolibc: use C89 comment syntax")
>   9cd4e2eb852c ("tools/nolibc: use __inline__ syntax")
>   367742887f79 ("tools/nolibc: use standard __asm__ statements")
> 
> are missing a Signed-off-by from their committer.

Apologies, thank you, and will fix!

							Thanx, Paul
