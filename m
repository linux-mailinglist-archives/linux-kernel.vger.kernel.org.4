Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBDC5EDA3B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbiI1Ki7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiI1Kiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:38:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4365593515
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 03:38:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F79BB8201E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D19C433D6;
        Wed, 28 Sep 2022 10:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664361532;
        bh=B6NJe4aAWOz6+MDkLUXS9xLX6IDEdKvtpsCfh1WOick=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nckNkWnr1oV8lQfiyX9Q7sDEP6610nzipriJfXIGq1dnU7CtvyCAdmy+Yrstf3RIG
         yqaMU0i8mEO+fVf8dnak07ih+peeZvEHZKeFbqMKWeSkAvzlMDxuVG3aK+DYsf0FBO
         mI0AlNnBO1dqKfpIzZOWXpOBDuAhAbMS/99aEOx/kbx8TIxfQ00U+xBh5y6oAWT4Wc
         VH1Y93qUXH2zPy+3EymaAmF29RZoUuXiBmRXYqcyoFSLXU0jRfed2tGjc1LFz6XCjl
         Mi1bISSLJaTCAneu9UjBbuwVgsZJInVZTlbImekZK3LKrcN6tvosYIcm4XwdmNjcxh
         0RvUYOONmGNKQ==
Date:   Wed, 28 Sep 2022 11:38:47 +0100
From:   Lee Jones <lee@kernel.org>
To:     Jens Hillenstedt <jens.hillenstedt@ise.de>
Cc:     support.opensource@diasemi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: da9061: Fix Failed to set Two-Wire Bus Mode.
Message-ID: <YzQkNy3D1vcqOH8B@google.com>
References: <20220915092004.168744-1-jens.hillenstedt@ise.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220915092004.168744-1-jens.hillenstedt@ise.de>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Sep 2022, Jens Hillenstedt wrote:

> In da9062_i2c_probe() regmap_clear_bits() tries to access CONFIG_J
> register. As CONFIG_J is not present in da9061_aa_writeable_ranges[] probe
> of da9061 fails:
> 
>   da9062 2-0058: Entering I2C mode!
>   da9062 2-0058: Failed to set Two-Wire Bus Mode.
>   da9062: probe of 2-0058 failed with error -5
> 
> Add CONFIG_J register to da9061_aa_writeable_ranges[].
> 
> Fixes: 5c6f0f456351 ("mfd: da9062: Support SMBus and I2C mode")
> Signed-off-by: Jens Hillenstedt <jens.hillenstedt@ise.de>
> ---
>  drivers/mfd/da9062-core.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
