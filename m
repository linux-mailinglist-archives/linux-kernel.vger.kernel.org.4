Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF486A7A17
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 04:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjCBDfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 22:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjCBDfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 22:35:24 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013CF36453
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 19:35:21 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id D2F544248E;
        Thu,  2 Mar 2023 03:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1677728119; bh=XntsFOuZW9EokA7P5o8/kS/05TnqCestwaz1ek9MS4o=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To;
        b=C5awr6rG2rTbwRyewM+f42lUZ4SMwFrrQoNaa0bwRCcIvxElUf+ZTBE6qxULDyuiH
         FeSpVWCfdg/AXlIYyKumYoJ8qRWqyxR7hF6O+AXFquofPkzvlMBBT48gPWoLQL3J8P
         H+CcrPcmScZmtEQlPMSPP/LtEiyosn03OG2F7/izC/P9dGzSgwTKQfgCzblaMDbGq5
         0giZPRcleInF8zSabl+P0/3WS8O7a/Hm4kX254O+CWzDWmgaPKP8G9s2rR1eIws8+a
         I0iuvWeyI30jY93e6Yjf6HW1fCrSzOJAU4SngAWTzljs5eV1fPCnkgPLsGZsMKwEKd
         AeI1nfQ3AdeSg==
Message-ID: <c1bf62a2-e381-c796-2219-17a578987a76@marcan.st>
Date:   Thu, 2 Mar 2023 12:35:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Richard Acayan <mailingradian@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Asahi Lina <lina@asahilina.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Michael Dolan <mdolan@linuxfoundation.org>
References: <Y820a/niMYtHfe8k@radian>
 <58a5ad01-dbfc-04a7-2234-c57bb627ee84@marcan.st> <Y84K1N3fzz/J4Pxa@radian>
 <6d96fb3c-9027-c612-fca4-e22c7c19186f@marcan.st> <ZAAVuo81E3XA6/LS@radian>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: Linux kernel DCO
In-Reply-To: <ZAAVuo81E3XA6/LS@radian>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2023 12.19, Richard Acayan wrote:
>> I agree that this should be changed (for many reasons, I could write
>> about this at length), and as I'm sure you can imagine, such change
>> would probably have to be a coordinated push with buy-in from several
>> kernel stakeholders. So I would appreciate it if you don't turn this
>> into a public discussion at this time, and let us figure out how to deal
>> with it when the time comes.
> 
> Sorry to bother you, but what happened?

An offline discussion happened ;)

> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=d4563201f33a022fc0353033d9dfeb1606a88330
> 
> Two Acked-by's are a bit underwhelming for a coordinated push with
> buy-in from several kernel stakeholders.

The patch is by Linus, it's acked by Greg (who originally introduced the
"real name" wording) and by Mike (SVP of Projects & Legal at the Linux
Foundation, i.e. a lawyer). What more do you want?

Things don't always happen as one envisioned, but now the problem is
fixed either way. Linus ultimately gets to write the rules on this,
there's no need for more acks.

> Of course, it's easy to call this naive and ignorant. I accepted this
> explanation and respected this request to not turn this into a public
> discussion until the time comes. Now, I wonder if this patch was written
> and applied later than it should have been because we misunderstood the
> kernel contribution process as an aristocracy for this specific case.

Ultimately the reality is that enforcement of the "real name" rule has
been wildly inconsistent and some subsystems (like DRM) have always
accepted pseudonyms. The original wording was misguided and conflated
names with identity, leading to the eventual divergence of opinion on
how it should be enforced. The subject came up offline, and now the
official wording has been changed to match reality (i.e. that what the
kernel actually wants is knowing who people are in an abstract sense of
trust/continuity/reachability, not their "real" name whatever that might
mean).

- Hector
