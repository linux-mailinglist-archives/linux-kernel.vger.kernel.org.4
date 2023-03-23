Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47E96C6F2E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjCWRfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbjCWRe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:34:59 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4CD23C41;
        Thu, 23 Mar 2023 10:34:35 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6969F60A;
        Thu, 23 Mar 2023 17:33:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6969F60A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1679592819; bh=PdZ3mvwus/QAx+ru7XpTafVFhQSTGrOihpwidIHItF4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=R+FA+IS3U97T/01V+b6/Q5DfrhCbW0CGh4dh7Qmi1C5pCQTFRdmHD4XMhGn0X+PI1
         8W4ZY55wAlpAB/xK4zLfSDZMmnydMWD/s2sa41tB+s2nulm8GJusS94swihKH0SQh9
         UVxfSN2ZfneuRHFTv+bALANCU+DebzAI7Ol5E9OUrA455CYF3LSmBCoCLeIo9fN5/f
         /omXybV1YtnRfxK7b/FX5h4Xa31h8JmQDRDDqxxCwfF52+C4EHC7CjycwwX3V4q0rQ
         OtaltcQv8HXqLwGfv1cuhoI+8J+BGte/FuCWuCBq97FItQdoIS4OjKC6dJSe3rcTQt
         wD1mjKGM1684Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: Re: [PATCH] doc:it_IT: translation alignment
In-Reply-To: <20230319134624.21327-1-federico.vaga@vaga.pv.it>
References: <20230319134624.21327-1-federico.vaga@vaga.pv.it>
Date:   Thu, 23 Mar 2023 11:33:38 -0600
Message-ID: <87bkkjcqz1.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Federico Vaga <federico.vaga@vaga.pv.it> writes:

> Major update for maintainer-pgp-guide
>
> commit e4412739472b ("Documentation: raise minimum supported version of binutils to 2.25")
> commit 67fe6792a7fb ("Documentation: stable: Document alternative for referring upstream commit hash")
> commit 8763a30bc15b ("docs: deprecated.rst: Add note about DECLARE_FLEX_ARRAY() usage
> commit 2f993509a97e ("docs: process/5.Posting.rst: clarify use of Reported-by: tag")
> commit a31323bef2b6 ("timers: Update the documentation to reflect on the new timer_shutdown() API")
>
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
> ---
>  .../it_IT/kernel-hacking/locking.rst          |   5 +
>  .../translations/it_IT/process/5.Posting.rst  |   6 +-
>  .../translations/it_IT/process/changes.rst    |   4 +-
>  .../translations/it_IT/process/deprecated.rst |  29 +-
>  .../it_IT/process/maintainer-pgp-guide.rst    | 346 +++++++++---------
>  .../it_IT/process/stable-kernel-rules.rst     |   6 +
>  6 files changed, 214 insertions(+), 182 deletions(-)

Applied, thanks.

jon
