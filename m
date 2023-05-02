Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1704E6F48BE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 19:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbjEBRAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 13:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbjEBRAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 13:00:20 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB132D4C;
        Tue,  2 May 2023 10:00:18 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 95EA531A;
        Tue,  2 May 2023 17:00:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 95EA531A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1683046817; bh=1AbkLk6UX+pwPQNRr2RCax9VOJKlnmdHEgpuN2PUXao=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=HvSHQY73J2twY6BnMPgyeDbVN24Sk3eCxTbFt9K15V7EAWVzBZxF+xLvyWoFiWIyX
         8NNPtKlm/GLt4g8/Jx0fPLndmYyzBuT2LKWPOsgcd0UlXY1ueHIAtphMCZux7lSsi8
         eCWsH2gKc3syIuTGIJIEOTWA02iCYjxFYmRVRagclXxZIb9aGjLxBsXVKJWg/P7Kij
         U4D9Ab+UuyuUs0WnUzIyw+nJiHBNovWlYPPZGZehEfbcqrzxYQv/dlGoPEXko/cbvl
         mBfKYJbG00G8hZOtHwTElbgSF22U0J7xY6JLlE/EWh2u35TUSXdGCwj3sXGyc+p3zs
         VoICWAVOGQHxw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     =?utf-8?B?5pmP6ImzKOmHh+iLkyk=?= <yanyan.yan@antgroup.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        =?utf-8?B?6LCI6Ym06ZSL?= <henry.tjf@antgroup.com>,
        =?utf-8?B?5pmP6ImzKOmHh+iLkyk=?= <yanyan.yan@antgroup.com>
Subject: Re: [PATCH] Documentation: update kernel stack for x86_64
In-Reply-To: <20230328072537.20188-1-yanyan.yan@antgroup.com>
References: <20230328072537.20188-1-yanyan.yan@antgroup.com>
Date:   Tue, 02 May 2023 11:00:16 -0600
Message-ID: <87r0ry7jof.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"=E6=99=8F=E8=89=B3(=E9=87=87=E8=8B=93)" <yanyan.yan@antgroup.com> writes:

> Commit 6538b8ea886e ("x86_64: expand kernel stack to 16K")
> expanded kernel stack for x86_64 but left the wrong documentation,
> update it.
>
> Signed-off-by: Yan Yan <yanyan.yan@antgroup.com>
> ---
>  Documentation/x86/kernel-stacks.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

jon
