Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED9A5E8B8B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 12:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbiIXKkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 06:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiIXKkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 06:40:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEE920BE3;
        Sat, 24 Sep 2022 03:40:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 871A4B801B9;
        Sat, 24 Sep 2022 10:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA723C433C1;
        Sat, 24 Sep 2022 10:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664016000;
        bh=I67A5I8mjVbwh2+JN9FRxetNjnI93NfzbklJa40L8nk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zWadvc9DUCVpeOaizbvBSdJETDq/IepTSTz5mMujF4yHT5lMXUAqcQrjci1zMBnpZ
         C5rPu8KqJ1HsdJSFTz9U7yffKy7zZSeacRSAadGNgEwc8mMxR0zoCcg8bfXNrT80Gs
         hjytO6oQ7BuN0rG8494UVI60O7+muNaFNlTV0bK8=
Date:   Sat, 24 Sep 2022 12:39:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v1 1/2] Revert "USB: fixup for merge issue with "usb:
 dwc3: Don't switch OTG -> peripheral if extcon is present""
Message-ID: <Yy7efRy1vvGCFM+Y@kroah.com>
References: <20220923163051.36288-1-andriy.shevchenko@linux.intel.com>
 <20220923163051.36288-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923163051.36288-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 07:30:50PM +0300, Andy Shevchenko wrote:
> This reverts commit 8bd6b8c4b1009d7d2662138d6bdc6fe58a9274c5.
> 
> Prerequisite revert for the reverting the original patch.

What "original patch"?

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

What commit does this fix?  Stable trees?

you know better, I can't take this as-is...

thanks,

greg k-h
