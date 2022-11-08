Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9586217F8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbiKHPVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbiKHPVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:21:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB2C38AC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 07:21:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EA5D61633
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 15:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385FAC433C1;
        Tue,  8 Nov 2022 15:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667920873;
        bh=Ig3E3BtNkG1UvTcoImrclXzJXrA+uPW4+Ymp9OZw0Ww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EFLiQsEWJ4mjLLdRMdJmUxZIxwD3v+96jSt4qs5sR+YeWVU22ahr7TFVv/MWcb5Tu
         D4STTxO2gr8LxHsarvCqKE9YY6W553yTWtNbBxQcdZsGP9+b/6bk/Gx/TUtvvFL+RW
         eidBAfoPNxslsOXISQowailiu9JlJq9znA78/Z7M=
Date:   Tue, 8 Nov 2022 16:21:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jerom van der Sar <jerom.vandersar@gmail.com>
Cc:     philipp.g.hortmann@gmail.com, error27@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: rtl8192e: space formatting fixes in rtl_cam.c
Message-ID: <Y2pz5twhWN2eJT24@kroah.com>
References: <Y2IbI8ib5+k+bVRo@kroah.com>
 <20221102200057.397-1-jerom.vandersar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102200057.397-1-jerom.vandersar@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 09:00:58PM +0100, Jerom van der Sar wrote:
> Fixed a few coding style issues in rtl_cam.c: two times lack of
> spaces around binary operators. Some other warnings still remain.
> These issues were found by scripts/checkpatch.pl.
> 
> This patch helps clean up the rtl8192e driver in staging, making it
> easier to read and maintain.
> 
> Signed-off-by: Jerom van der Sar <jerom.vandersar@gmail.com>
> ---
> Changes in v4:
>  - Reverted more double blank line formatting fixes to make the patch
>    even smaller.

Does not apply to my tree :(
