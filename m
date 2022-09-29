Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29025EFDC7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 21:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiI2TRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 15:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiI2TQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 15:16:54 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB78122A6D;
        Thu, 29 Sep 2022 12:16:53 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 56E3D2C5;
        Thu, 29 Sep 2022 19:16:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 56E3D2C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1664479013; bh=KTYSBto0/tZx0F0EBRhLqG5yGovwkz5DROMCaYV/JeM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MqIgsVeNm1UyAK+OlOztI+JTUD+D3pexb2KSK9v/Z6AWN1NOVKJjhjkS6Pth+mfRd
         AgYIXjnYK6kZ0w8BjTBI7rLwbnWuR5eoTMVO7xOhXmLgTgr7sGaGHNRKtb5oXnk7dy
         Wfo00y6xtl8MM3+qgxF5xhwnmJ4cHKt1vFCnZ50i1liKcUYkoOvYoEQObyOTwqudOv
         EK6RhdXIHqSAbYFfHVA8aO4EvX21jD1suXMMdKPhxudL8b3W2dHh3zFKSCgPsgkr6I
         hSFFUrdhL6i49jZG0Dq16u8ZT1kuDI2nE4DanwPoMPy4HKiCI4LFYnlkNn4+84zZ2u
         GahV7nJ23NmKA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Vernon Yang <vernon2gm@gmail.com>
Cc:     akpm@linux-foundation.org, bobwxc@email.cn, hughd@google.com,
        rppt@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vernon Yang <vernon2gm@gmail.com>
Subject: Re: [PATCH] Documentation/mm: modify page_referenced to
 folio_referenced
In-Reply-To: <20220926152032.74621-1-vernon2gm@gmail.com>
References: <20220926152032.74621-1-vernon2gm@gmail.com>
Date:   Thu, 29 Sep 2022 13:16:52 -0600
Message-ID: <87wn9mgfdn.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vernon Yang <vernon2gm@gmail.com> writes:

> Since commit b3ac04132c4b ("mm/rmap: Turn page_referenced() into
> folio_referenced()") the page_referenced function name was modified,
> so fix it up to use the correct one.
>
> Signed-off-by: Vernon Yang <vernon2gm@gmail.com>
> ---
>  Documentation/mm/unevictable-lru.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

jon
