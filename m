Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5805A728539
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbjFHQiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjFHQiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:38:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82331359B;
        Thu,  8 Jun 2023 09:38:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3C2E64F08;
        Thu,  8 Jun 2023 16:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FEBC433EF;
        Thu,  8 Jun 2023 16:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686242297;
        bh=XEmF6qBGp6AjqZS2pEe6tYr5uN150IJ3qPE+xWoYBKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sXfvdKoNdH+5gGgxF/Lsj+zDYAUgQPESrWgLWz+sGpimJL9NxBqbtKAzl9QtkcJOr
         cX6jN7u8WOnpN9Dfrp/ZUhmzkVy2L0RAqK8Q/z06nlGYknliPhX0SjnSqvxHfnx8nQ
         F4I/vHjAz16JXjEGmdszztgfBOifxcY7PD+mKZNDF1W9/IZocpR3rE58eEPbnvrL2o
         jXf4TGnqEya8SPSb2g56Ukv3iHrVG+OVMi9cUTxBsJ/Jr57HskqsgtKxCfKEiQUERU
         Bql56CLUYyyAUJYYFRt6YAFX4vZ+EW3BQfIfd4niEs6Jg5i2woQDTD5yk4KhYg89yL
         Khsv+PUYgYTzg==
Date:   Thu, 8 Jun 2023 17:38:12 +0100
From:   Lee Jones <lee@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     pavel@ucw.cz, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] leds: cht-wcove: Fix an unsigned comparison which
 can never be negative
Message-ID: <20230608163812.GC3572061@google.com>
References: <20230531020238.102684-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230531020238.102684-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2023, Yang Li wrote:

> The return value from the call to cht_wc_leds_find_freq() is int.
> However, the return value is being assigned to an unsigned
> int variable 'ctrl', so making it an int.
> 
> Eliminate the following warning:
> drivers/leds/leds-cht-wcove.c:236 cht_wc_leds_set_effect() warn: unsigned 'ctrl' is never less than zero.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5341
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/leds/leds-cht-wcove.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
