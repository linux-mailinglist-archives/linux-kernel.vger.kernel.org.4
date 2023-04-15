Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA306E322A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 17:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjDOPyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 11:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDOPy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 11:54:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB882115
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 08:54:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAE8E60ACF
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 15:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C311BC433D2;
        Sat, 15 Apr 2023 15:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681574067;
        bh=TiEk8Zq0uD9Lcbe3ZuS8X3Zf++JSvVSRSdv/Q9bRL64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aM4KnnUe8irAUfoqIrbwUluZ0pyin9cYB9eTh5EgXCHnhF70PDboQkOFUwh7BPWBG
         r61dwPlFC9M/m9rxsPlwzjO0FLTARO9q9qi76w85LpLMpprNn5uVq/udtaAhtVNZVK
         IslBAqBzFbWkg2//EYBG1smrdlKbv4G3SepAgGfs=
Date:   Sat, 15 Apr 2023 17:54:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sumitra Sharma <sumitraartsy@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: Fix alignment to match open
 parenthesis
Message-ID: <2023041516-lushness-neurology-a728@gregkh>
References: <20230408165151.GA261885@sumitra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230408165151.GA261885@sumitra.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 08, 2023 at 09:51:51AM -0700, Sumitra Sharma wrote:
> Fix alignment to match opening parenthesis as suggested by Linux kernel
> coding-style. This issue is reported by checkpatch.
> 
> CHECK: Alignment should match open parenthesis
> 
> Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
> ---
>  drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)

You have sent a lot of different patches for the same driver, with the
same subject line, but yet doing different things.  I am totally
confused as to what is, and is not, the latest versions, so I am
dropping all of these from my review queue.

Please resend them all, as a numbered patch series, so that we have a
clue as to what to review here.

thanks,

greg k-h
