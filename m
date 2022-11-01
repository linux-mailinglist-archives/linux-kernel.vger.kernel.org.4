Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F4D615136
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 19:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiKASDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 14:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiKASDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 14:03:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FEC12AB9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 11:03:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCB86B81E95
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 18:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857CFC433C1;
        Tue,  1 Nov 2022 18:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667325792;
        bh=pxSo9hVqAhSTWjdj5bUbjVfB5nZy/0Gn4TlVQXlbfSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1TUGAXGLccW4U1c0GxDsN4qduMWTHoEtQBNoqYvdGcqeOzj6NZ5i92YzrLtq0NWZN
         fbi3+uw8GZtkdROg0y9D/MEsw1sbL8ojsuHD0c5yP3XQ+1C/vlwZHCXXB26a+kqDLq
         vtocC6gKXFJrAEi+PtDzw3o7CmQ8QYZwXPfdxUzk=
Date:   Tue, 1 Nov 2022 19:04:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     UMWARI JOVIAL <umwarijovial@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [RESEND PATCH v3] staging: most: dim2: hal: aligning function
 parameters
Message-ID: <Y2FflTSQEdPFCh4H@kroah.com>
References: <20221101105727.GA162791@rdm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101105727.GA162791@rdm>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 01:57:27PM +0300, UMWARI JOVIAL wrote:
> To improve readability, start the list of
> function parameters on the same line as the function name.

Odd line-wrapping, please fix.

> Issue reported by checkpatch.
> 
> Signed-off-by: UMWARI JOVIAL <umwarijovial@gmail.com>
> ---
> 
> Changes in v3:
>     1.Updated the commit message to well explain the  changes made 

What were the changes in v2?

Also, why do you have "RESEND" in the subject line?  This is not a
resend of the v3 patch, it is the first time we have seen it.

thanks,

greg k-h
