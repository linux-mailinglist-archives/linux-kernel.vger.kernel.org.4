Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C74765D848
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 17:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239721AbjADQN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 11:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239866AbjADQMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:12:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3ADDDE4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 08:12:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A5ACB81732
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 16:12:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8956CC433F1;
        Wed,  4 Jan 2023 16:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672848769;
        bh=jsCTJlqLyIy20TAjZal62lzOYgk+2R8QE9cZ0NxVE1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RixBqyguCXakwUI67erIffSiXrZOU+hcW8NF7C1S+11h47KL3HFNFu1/Mmyiwcs1o
         74nL4ODYv+ogwfFFEPCcJcjV7gnYLl5u/eayHRSvjTFGEJly/kS5J0ycmr4vX7oy2B
         VGcmtTeuHZrGyOhVnwyFzZeJduyjpupVgbkq8bON3nhe3X/0UuhdbhZuMMHZcyOnic
         /J0Yq+YRCvNg6rmAVj2iHgSwsJ+E/xQQaB1e/dip74U6wGCjDG7W1NQHEWjSiiwlEr
         3C6wXenjJ9wr6TalMO9Fmxgh82encxzqz0LkyiJKsUnJF1JbnuCglRS0FI3NWoXQPJ
         KTtAC9V4HjRww==
Date:   Wed, 4 Jan 2023 16:12:43 +0000
From:   Lee Jones <lee@kernel.org>
To:     Qiheng Lin <linqiheng@huawei.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: pcf50633-adc: Fix potential memleak in
 pcf50633_adc_async_read()
Message-ID: <Y7Wle+KbwoVTgnAr@google.com>
References: <20221208061555.8776-1-linqiheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221208061555.8776-1-linqiheng@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Dec 2022, Qiheng Lin wrote:

> `req` is allocated in pcf50633_adc_async_read(), but
> adc_enqueue_request() could fail to insert the `req` into queue.
> We need to check the return value and free it in the case of failure.
> 
> Fixes: 08c3e06a5eb2 ("mfd: PCF50633 adc driver")
> Signed-off-by: Qiheng Lin <linqiheng@huawei.com>
> ---
>  drivers/mfd/pcf50633-adc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
