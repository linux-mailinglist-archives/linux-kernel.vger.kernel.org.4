Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FAA6614DF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 13:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbjAHMAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 07:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjAHL77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 06:59:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A35DEE3B;
        Sun,  8 Jan 2023 03:59:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D642FB801C1;
        Sun,  8 Jan 2023 11:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9548BC433D2;
        Sun,  8 Jan 2023 11:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673179195;
        bh=n9qaVCDzfZFhHJOQk59pKEdS/j+mHkgVmtKThVkVBZA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rTiDGlJ6cGQtwt6fvojOOEWgwdnZJwugIonw01B80UkfGPr6Ee8yWrFvF9NAji6ym
         k0mDRuRSFjqtMjQzxLPhQVPMPE4EK3xpvhzjq43MSkmLdJcBJz+nrMNDibplkk4x+K
         zslcHqiKWP9ehniW0tSanmBfS3AXQq2d4cnKfMqjF37f5cSs+rjEWAEUEyGJhmMFdG
         h5PWlirCPtN6S09iI5Bqmd/aQbQNpZhtMuGfJXLGLwieJ9vzf3HxI9U3RqfVzwNt0Z
         GuM0jsQqbzZ4iSXY8CQAAdZpF1dqjzzgeq9uNdDNZ1iZGd1v18VuXSDRW/+Q3kRB/z
         SS/NRJLNB3XuA==
Date:   Sun, 8 Jan 2023 12:13:23 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 0/3] iio: adc: ti-adc128s052: Some refactorings
Message-ID: <20230108121323.0118abe3@jic23-huawei>
In-Reply-To: <20230102173450.29882-1-andriy.shevchenko@linux.intel.com>
References: <20230102173450.29882-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  2 Jan 2023 19:34:47 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Refactor driver to use newest API and drop ACPI_PTR() which is rather
> useless.
Applied.

Thanks,

Jonathan

> 
> Changelog v2:
> - united two previously sent series into a single one
> - dropped for now the endianess patch
> - fixed compilation issues (Jonathan, LKP)
> 
> Andy Shevchenko (3):
>   iio: adc: ti-adc128s052: Switch to use spi_get_device_match_data()
>   iio: adc: ti-adc128s052: Drop anti-pattern of ACPI_PTR() use
>   iio: adc: ti-adc128s052: Sort headers
> 
>  drivers/iio/adc/ti-adc128s052.c | 54 +++++++++++++++------------------
>  1 file changed, 24 insertions(+), 30 deletions(-)
> 

