Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3E56E98FB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 18:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbjDTQAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 12:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDTQAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:00:14 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ECAEB;
        Thu, 20 Apr 2023 09:00:12 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 95FEE732;
        Thu, 20 Apr 2023 16:00:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 95FEE732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1682006412; bh=mJzimVUMeK7FWJXoeSikmvMYJtBYf8XIKcnzjDNAvQM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=epZ0YaXgNrjxJY6mTTHds7laH/ty2NnwMXUARaFHUOWiy417W2x6GralpRAEroD7Z
         yqwnXlh/Bwe8F6sP1WJqHWR2Dj535qrf4lk21oyL2jVeLotvsT0uSFb/kfTXrhFVYC
         aPfggOuI0lT5vwBM/Nv5ZMOfVIr/+ez5A++ZVNzRl/CxUiwqWHVWmjqT55+GUCuH3G
         b4P1psKLFBUOIfW5r/XerXJRGCebTpMD6wmWew9h6b82rUWIkhykcIRwkfCb0EnfLf
         cGUPChn0xFXRvoaoh5Yyq0/gUyYU7+8saX2gyhYcvXVCZlqNLQAoIdRfwjXsUExl70
         UsF9iiAs5Ql9A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Alain Volmat <avolmat@me.com>
Cc:     Alain Volmat <avolmat@me.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: arm: remove stih415/stih416 related entries
In-Reply-To: <20230416185349.18156-1-avolmat@me.com>
References: <20230416185349.18156-1-avolmat@me.com>
Date:   Thu, 20 Apr 2023 10:00:11 -0600
Message-ID: <87jzy6tugk.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alain Volmat <avolmat@me.com> writes:

> ST's STiH415 and STiH416 platforms support have been removed since
> a long time already.  This commit updates the sti related documentation
> overview to remove related entries and update the sti part to add
> STiH407/STiH410 and STiH418 platforms which are still actively
> supported.
>
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
> Patch once sent as part of serie: https://lore.kernel.org/all/20230209091659.1409-2-avolmat@me.com/
> Sending it individually.
>
>  Documentation/arm/index.rst                |  2 --
>  Documentation/arm/sti/overview.rst         | 10 +++-------
>  Documentation/arm/sti/stih415-overview.rst | 14 --------------
>  Documentation/arm/sti/stih416-overview.rst | 13 -------------
>  4 files changed, 3 insertions(+), 36 deletions(-)
>  delete mode 100644 Documentation/arm/sti/stih415-overview.rst
>  delete mode 100644 Documentation/arm/sti/stih416-overview.rst

Applied, thanks.

jon
