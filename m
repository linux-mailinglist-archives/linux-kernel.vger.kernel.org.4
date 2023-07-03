Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E967745B5F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 13:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjGCLms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 07:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjGCLmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 07:42:46 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2166DEC
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 04:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1688384564;
        bh=YP1dIoFq8VlflriUVMMU3qavwn5qp6pssvBClxyYvGQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=DsCykzQATMth4df5hd9JAuNbqZfUnuyhtN+ih9n3EK0Y/xaBEyUiaBUwzWQVUDorv
         BysRCgszOuhJV50/oZgpF2pILY9jF1OeQV5rxB3kdnA3K9JHG11dQfR7jTNVvwvM2p
         UURZoNsXDYz2I/9gIowIX5YSE8svKKFDtLSMVp5NO36NoKBAszflMiMJIKvhqaj8Xy
         pT0maaYt95YQ3l6PyfTqzkKJeol+Shb6SOjzIGZZuhYMXrzDVZdOeK6Le7gWWWLXlo
         dDPeECVIVDrwyYlF96OQWw0R7beFHvvSLR67/fmE8yZMIeU1MOwwfV7zdSC/aIYavs
         lMJDm98iP1nFg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QvkYv5P9Kz4wZp;
        Mon,  3 Jul 2023 21:42:43 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Haren Myneni <haren@linux.ibm.com>,
        Jilin Yuan <yuanjilin@cdjrlc.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20230629124500.1.I55e2f4e7903d686c4484cb23c033c6a9e1a9d4c4@changeid>
References: <20230629124500.1.I55e2f4e7903d686c4484cb23c033c6a9e1a9d4c4@changeid>
Subject: Re: [PATCH] powerpc: Include asm/nmi.c in mobility.c for watchdog_hardlockup_set_timeout_pct()
Message-Id: <168838439191.114505.4051178096870320792.b4-ty@ellerman.id.au>
Date:   Mon, 03 Jul 2023 21:39:51 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023 12:45:06 -0700, Douglas Anderson wrote:
> The powerpc/platforms/pseries/mobility.c calls
> watchdog_hardlockup_set_timeout_pct(), which is declared in
> <asm/nmi.h>. We used to automatically get <asm/nmi.h> included, but
> that changed as of commit 7ca8fe94aa92 ("watchdog/hardlockup: define
> HARDLOCKUP_DETECTOR_ARCH"). Let's add the explicit include.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Include asm/nmi.c in mobility.c for watchdog_hardlockup_set_timeout_pct()
      https://git.kernel.org/powerpc/c/6cb44bef35ac11724ef22c5ae4f1bc607e2ef3d8

cheers
