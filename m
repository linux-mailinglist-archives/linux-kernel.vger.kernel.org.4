Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A9D6BB956
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbjCOQPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbjCOQPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:15:18 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E81D59C8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 09:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1678896810; bh=7sl5vEcgid5Uv8r5+r80OO1sYMMmE1gpZXD1y71+Gzo=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=Qjim9Xey7D080H2YPWGAcP8sifoC0fuzBdTl+gSGH69WB14r4LlXttfxuq50greIH
         V+4Bl7aEKVpV440M0OAi6bNFYx2scTHB11UBkNtA5drOjCdrp01xlGbf9dWANFBlEX
         K5YKSMbv1lHDQ48C4UbyUE0wsiys0kLegMdQPuV0=
Received: by b221-4.in.mailobj.net [192.168.90.24] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Wed, 15 Mar 2023 17:13:30 +0100 (CET)
X-EA-Auth: Dz8ITjiWWyi3A08u1qcW/Id+VLaVyQcFZRAbA0hH3N6ZHaUg5J2tEXE5KKC/v5l4VH3KVvnNo6HQx2Dkw3sont6fHK0hcQRU
Date:   Wed, 15 Mar 2023 21:43:20 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Kloudifold <cloudifold.3125@gmail.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        teddy.wang@siliconmotion.com, sudipm.mukherjee@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: sm750: Rename function to avoid CamelCase
Message-ID: <ZBHuoGrHyWBSJcoZ@ubun2204.myguest.virtualbox.org>
References: <ZBHlycBoZ0JRwHZm@CloudiRingWorld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBHlycBoZ0JRwHZm@CloudiRingWorld>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 11:35:37PM +0800, Kloudifold wrote:
> Hi Alison,
> 
> Thanks a lot for your help, so if I send my v3 patch, should it be like
> below? (Philipp said "please make the Subject more unique", but the
> Subject could be only a few permutations of very few words, I can't see
> how it could be any more unique.)
> 
> Subject: [PATCH v2] staging: sm750: Rename functions from CamelCase to snake case
> 
> sm750 driver has sm750_hw_cursor_* functions, which are named in
> camelcase. Rename them to snake case to follow the function naming
> convention.

You may want to review similar patches submitted in the past by the developers
and get hints on how it was named then. Use it to improve your understanding,
let your own thoughtfulness prevail.

https://lore.kernel.org/?q=&a=search+all+inboxes

Thanks,
Deepak.

> 
> Changes in v3:
> - Add this changelog (Philipp)
> - Move lkp tags and link to the correct location in commit log (Alison)
> - Update the commit msg (Philip)
> - Update the commit log (Bagas, Julia)
> 
> Changes in v2:
> - Use new function names in call sites (LKP)
> 
> Signed-off-by: Kloudifold <cloudifold.3125@gmail.com>
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303110849.X24WnHnM-lkp@intel.com/
> ---
> git diff message
> ---
> 


