Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57547708114
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 14:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjERMUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 08:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjERMUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 08:20:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04170186;
        Thu, 18 May 2023 05:20:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9430464E56;
        Thu, 18 May 2023 12:20:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B18C433D2;
        Thu, 18 May 2023 12:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684412452;
        bh=B2tSmJJEwLINlxxk8NveBTh3Pb3iwAg/mTfnyo2eGto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QzGOPdH6JnfBswuwfL0JlmLPJfNEjGl9HMPs24NhhL3n7wP88zBc9yiHtcwBoVlDz
         JPA60d1XU2LWG0bRD6qzSluGnLytILCFCETMMnPi0yh1YRaBff9sH3jvB09W85iSZ2
         yeNVjC4obEt8XTL1bajkLVR8wgoWIiYzxZalIbawLNuLb/j+MBNHu7ogov62Br+SnW
         fKgvQrisPk1dAKUeCGyK+UySmbeda/RLiaOxBPFYE6pqYsVhsllvP8xbDIYO8jLZKi
         GopNh57fCLWLX9vjiijuRq4Aghqe6wVWOtvahRjpjReTDZ+fMBXRJ7v0xhACDR51IK
         A5fNhVHN6dOwQ==
Date:   Thu, 18 May 2023 13:20:47 +0100
From:   Lee Jones <lee@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     pavel@ucw.cz, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] leds: trigger: netdev: NULL check before dev_{put,
 hold}
Message-ID: <20230518122047.GK404509@google.com>
References: <20230511070820.52731-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230511070820.52731-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2023, Yang Li wrote:

> The call netdev_{put, hold} of dev_{put, hold} will check NULL,
> so there is no need to check before using dev_{put, hold},
> remove it to silence the warnings:
> 
> ./drivers/leds/trigger/ledtrig-netdev.c:291:3-10: WARNING: NULL check before dev_{put, hold} functions is not needed.
> ./drivers/leds/trigger/ledtrig-netdev.c:401:2-9: WARNING: NULL check before dev_{put, hold} functions is not needed.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4929
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/leds/trigger/ledtrig-netdev.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Don't forget to run checkpatch.pl before submission.

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report

Fixed and applied, thanks.

-- 
Lee Jones [李琼斯]
