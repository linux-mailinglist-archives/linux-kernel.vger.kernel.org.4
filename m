Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8FC74F2A9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbjGKOuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbjGKOuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:50:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F81910EB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=LuincKCh71Ix7zuJVb18mEfg43fpXyye4wMaOH+zIZE=; b=jURIujookBu6Fi2EowTX/CJCwY
        YJoMSIHyawJl3wBKSRSQAjDxgKQdHJupH+uMjPYirKhLbC65gm+0uiHrTEWHBqty1evga/u7V0kiB
        Gme0bujXeKWGmfKgN7g0vMH52ajuRoG2S9HaVpULhlKvGRPcNWtHdzoa2z6aAUONbhD+ddLFRFRqZ
        gFO65VoTbJBwLRbpphLLKQqHGc48Na89qGx+kqGwHVpAgDXS0Km4oK1cS5QwE7ynyW1TUFmr86THe
        yxUj5dKwPg+Lvc6hSlm2IAa65qaqRXJQqL1QbrqssuTUr0zAOfO7ASp2pX/W7r74HIuPzWT52JaBe
        t/9LonKw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJEgw-00FBci-3B;
        Tue, 11 Jul 2023 14:50:15 +0000
Message-ID: <23267466-dc1e-5f39-ce6c-45f0f61f281c@infradead.org>
Date:   Tue, 11 Jul 2023 07:50:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] workqueue: Fix cpu_intensive_thresh_us name in help text
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
References: <5fc042e1d3c5d63b9367a1e1587dcf6b548087ff.1689071768.git.geert+renesas@glider.be>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <5fc042e1d3c5d63b9367a1e1587dcf6b548087ff.1689071768.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/11/23 03:38, Geert Uytterhoeven wrote:
> There exists no parameter called "cpu_intensive_threshold_us".
> The actual parameter name is "cpu_intensive_thresh_us".
> 
> Fixes: 6363845005202148 ("workqueue: Report work funcs that trigger automatic CPU_INTENSIVE mechanism")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  lib/Kconfig.debug | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index c8371502b4b2e678..5da00849edebafdd 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1200,7 +1200,7 @@ config WQ_CPU_INTENSIVE_REPORT
>  	help
>  	  Say Y here to enable reporting of concurrency-managed per-cpu work
>  	  items that hog CPUs for longer than
> -	  workqueue.cpu_intensive_threshold_us. Workqueue automatically
> +	  workqueue.cpu_intensive_thresh_us. Workqueue automatically
>  	  detects and excludes them from concurrency management to prevent
>  	  them from stalling other per-cpu work items. Occassional
>  	  triggering may not necessarily indicate a problem. Repeated

-- 
~Randy
