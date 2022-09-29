Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E75B5EFDA6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 21:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiI2TL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 15:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiI2TL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 15:11:28 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60721ADCEB;
        Thu, 29 Sep 2022 12:11:26 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0DE282C5;
        Thu, 29 Sep 2022 19:11:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0DE282C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1664478686; bh=AtRs6p9PVV0p7iZSTv/3A/XTlDYNnrz1n/NZHsi0NUo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MFTfuqrLi1CwXQkFi6PKyHjnwtEEOkjy6weShw/Eq0WoiWQdUt59/nfY7t6hAtRYd
         fcZF0DABcx/sz7PQ97yTIJHeOrfDwdgNZsvX4vcTOw6j1ZaGs057jaZyA1WCEGmWlm
         PPDblpxYRfZPffFKzFwK5GbTphmA2F024PpWmVSbD0S7OdoVx7F6e8k47Yf5u0piif
         9pSOeE/b6POX6Apt/5dEYEheHXHNLx527ECK0ZqS95ZURxcjRYslRL1XxDmfA0qnrt
         HbiRzUnNECkXx63K946LqtCvTuYgxupFiYfGNb3prb3s1dcgP6nBJZYn1w64xvSQR+
         0Mma51Ev5JRYw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] docs: process/5.Posting.rst: clarify use of
 Reported-by: tag
In-Reply-To: <2fc7162dfb76e04da5ea903c9c170d913e735dad.1664372256.git.linux@leemhuis.info>
References: <2fc7162dfb76e04da5ea903c9c170d913e735dad.1664372256.git.linux@leemhuis.info>
Date:   Thu, 29 Sep 2022 13:11:25 -0600
Message-ID: <87a66ihu76.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thorsten Leemhuis <linux@leemhuis.info> writes:

> Bring the description on when to use the Reported-by: tag found in
> Documentation/process/5.Posting.rst more in line with the description in
> Documentation/process/submitting-patches.rst: before this change the two
> were contradicting each other, as the latter is way more permissive and
> only states '[...] if the bug was reported in private, then ask for
> permission first before using the Reported-by tag.'
>
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
>
> ---
> Hi! I noticed some confusion in our development community on when to use
> the Reported-by: tag. Some of this apparently is caused by the
> inconsistency fixed in this patch. Ciao, Thorsten
> ---
>  Documentation/process/5.Posting.rst | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied, thanks.

jon
