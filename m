Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07994727F5B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236023AbjFHLrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236568AbjFHLqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:46:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F832D78
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 04:46:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F316164CCF
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 11:46:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA8FC433D2;
        Thu,  8 Jun 2023 11:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686224778;
        bh=+0dyr4lC27Y7mQZWAwyeDXZTOlrPw8hFLVixUSBYIdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hzd7Pq6Rxcm3HodDZIL5xtHYGJHt3PX4Vzwt9O1h4ec7cq+hkTdL9CrQCHtptvgz9
         +W9EQtdfmshTN+m4MAl/WHRZ/QT+2iRAdPX208TLO2Sywfg2mWIqDlIiLMuH8gMImx
         3mr1i1ydxPI0EkmAMSO/gjlHbYhTbZw6Meesinhy83qCADry6hsiiOVP+CIuy2g3X6
         cb2FDOarlFB57ibZ0gHYim0/sWNyFYyyNko4PyfwRGoatBYviGSEHc41O+QqBnHg4q
         PL8oMF74tw8USh43AB5pDKdAahtV+jvE5dQmy7oV96/wava/afxafXzxouPKwugyP2
         V95e2slZPoimg==
Date:   Thu, 8 Jun 2023 13:46:13 +0200
From:   Simon Horman <horms@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        hawk@kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] tools: ynl: Remove duplicate include
Message-ID: <ZIG/hX09UKccKFO7@kernel.org>
References: <20230608093036.96539-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608093036.96539-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 05:30:36PM +0800, Jiapeng Chong wrote:
> ./tools/net/ynl/generated/netdev-user.c: stdlib.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5466
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  tools/net/ynl/generated/netdev-user.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/net/ynl/generated/netdev-user.c b/tools/net/ynl/generated/netdev-user.c
> index aea5c7cc8ead..1883a658180b 100644
> --- a/tools/net/ynl/generated/netdev-user.c
> +++ b/tools/net/ynl/generated/netdev-user.c
> @@ -8,7 +8,6 @@
>  #include "ynl.h"
>  #include <linux/netdev.h>
>  
> -#include <stdlib.h>
>  #include <stdio.h>
>  #include <string.h>
>  #include <libmnl/libmnl.h>

This duplicates:

- [PATCH -next] tools: ynl: Remove duplicated include in handshake-user.c
  https://lore.kernel.org/all/20230608083148.5514-1-yang.lee@linux.alibaba.com/

So lets focus on that one.

In all three very similar patches were sent in a short space of time.
It's better not to do that.

-- 
pw-bot: reject


