Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778166A1FB5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 17:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjBXQdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 11:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBXQdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 11:33:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAA5113FA;
        Fri, 24 Feb 2023 08:33:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE1AEB81C09;
        Fri, 24 Feb 2023 16:33:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7C4C4339C;
        Fri, 24 Feb 2023 16:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677256418;
        bh=r+QmHGXSRAzLUtka8pO7V6MJ8CWU8Jyr3L5RYr942vw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nP5yDR9qbH9D9PN2d1qnqVBhmPyQ1ewPb0L/XxWu8jLmAw408CzmsVgC+BWpQT4zt
         jDQGFAXLXUWS3jRarN0EwFJTz0Naja2KFmrILgIko5y8dEJ+mLZ0255PNZSayxqON4
         mGOQ7Auvj0BPD2pEng5lQ3LIcKkJsPcsK7VkyyxA=
Date:   Fri, 24 Feb 2023 17:33:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     void0red <void0red@gmail.com>
Cc:     mudongliangabcd@gmail.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: udc: replace kzalloc with devm_kzalloc
 in mv_udc_probe and add a check for this allocation.
Message-ID: <Y/jm3yk4oiFQLhNq@kroah.com>
References: <CAD-N9QVTxUSiCnprnXw=i4NVWbKFg2dZrkB0rqV2E4jzPeXAeA@mail.gmail.com>
 <20230224143148.60-1-void0red@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224143148.60-1-void0red@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 10:31:48PM +0800, void0red wrote:
> From: Kang Chen <void0red@gmail.com>
> 
> This driver uses the unified memory management api, so replace
> kzalloc with devm_kzalloc to avoid a memory leak and add a check
> for this allocation.
> 
> Reported-by: eriri <1527030098@qq.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217081
> 
> Signed-off-by: Kang Chen <void0red@gmail.com>
> ---
> v2 -> v1: replace kzalloc with devm_kzalloc

I see 2 v2 patches on the mailing list, how am I supposed to know which
one is correct?

Please fix up and resend a v3.

thanks,

greg k-h
