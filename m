Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B098166665E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 23:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjAKWqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 17:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjAKWqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 17:46:20 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EA31A3AE;
        Wed, 11 Jan 2023 14:46:20 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8508C6E3;
        Wed, 11 Jan 2023 22:46:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8508C6E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1673477179; bh=chnumXMjRPxHc3+TqNhtG9dgkl5xb90Nb7uzfVeZNvY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ddRh0FhMtKZdGtV5hhz8TZ5xilzh1rQI98qIW5WNRSdWjYfmOt3nSXT47+jvumyBt
         eLjXdnkQdqgn7vFjKV9kKt76JtL88gUHsZXVvzWDUCh1DDGNC+1LjytS9ItSmPQ2vl
         Q63hfoG/x6Ovmf/4sfp0HJW4psBsfRBIsYI53ajxDYn/hnSpwP682erSvG1V1YVHXH
         K92JrbA1S9MkvbK6dE/SNBqkh7Ch7oSAryZZGV3vX/wltMMd2ioiJv4Wt2frzhpnHP
         ffQhYMlRZGOLzPlKoKUIeb0e7k2m3dvsTzQwIbM+5N06E8Zw38lcr/Bobh2YgDCTSE
         jPTli73JOUVbA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     "A. Sverdlin" <alexander.sverdlin@siemens.com>,
        linux-doc@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@siemens.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Manfred Spraul <manfred@colorfullife.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: kernel-hacking: discourage from calling
 disable_irq() in atomic
In-Reply-To: <20221223112859.937196-1-alexander.sverdlin@siemens.com>
References: <20221223112859.937196-1-alexander.sverdlin@siemens.com>
Date:   Wed, 11 Jan 2023 15:46:18 -0700
Message-ID: <87y1q8wuyt.fsf@meer.lwn.net>
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

"A. Sverdlin" <alexander.sverdlin@siemens.com> writes:

> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
>
> Correct the example in documentation so that disable_irq() is not being
> called in atomic context.
>
> disable_irq() calls sleeping synchronize_irq(), it's not allowed to call
> them in atomic context.
>
> Link: https://lore.kernel.org/lkml/87k02wbs2n.ffs@tglx/
> Reviewed-by: Manfred Spraul <manfred@colorfullife.com>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
> Changelog:
> v2: Dropped changes to manage.c because of already applied
> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/kernel-irq-managec-disable_irq-might-sleep.patch
>
>  Documentation/kernel-hacking/locking.rst                    | 4 ++--
>  Documentation/translations/it_IT/kernel-hacking/locking.rst | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

jon
