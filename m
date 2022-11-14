Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078E2628B7D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237593AbiKNVno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237644AbiKNVnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:43:37 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE4BDF2;
        Mon, 14 Nov 2022 13:43:33 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D26361C0002;
        Mon, 14 Nov 2022 21:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668462212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=me0RdSJfy0GAbogzocsMoZUSm8DRysPd4wTaSa5a5fA=;
        b=Oid0+RRzNrHRKt/r9A++VkSx3ugXlnjUxAH9BjmQzqd1USgXID4yOP5OWxb6c80MAqNVvM
        p+1QqWTt9o3AwZBGQvY/RNTJGBCvvjGJV0p9R9pHALQxt5Vgent77h4h507kSvp4L3rnE7
        EZpsfLTEhWrFj0O9Q5/FUhTQocNmI0dkzinMI61GTBrum+xSulQxoy4h7okKflhcSy7kVh
        dzyV0AQGv7mzdm2rM18CgFKehh/feouyCVXV0lU6Ak9H6+83KXNxFIHDbWyUZNkoAxh6a6
        KbNgKcNn+0jjhOaHIYwM1rKHLQvbvOz3BsvDoeNy6+8/rcBX3udTq95D9UgJog==
Date:   Mon, 14 Nov 2022 22:43:31 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: Include <linux/kstrtox.h> when appropriate
Message-ID: <166846217853.2117389.566805318530598710.b4-ty@bootlin.com>
References: <786421fd0435a32206288904a1f879436a717529.1667721637.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <786421fd0435a32206288904a1f879436a717529.1667721637.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Nov 2022 09:00:51 +0100, Christophe JAILLET wrote:
> The kstrto<something>() functions have been moved from kernel.h to
> kstrtox.h.
> 
> So, include the latter directly in the appropriate files.
> 
> 

Applied, thanks!

[1/1] rtc: Include <linux/kstrtox.h> when appropriate
      commit: 81d8865e8bea9de75be02231ddb42926509b44b0

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
