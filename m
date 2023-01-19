Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79229674599
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjASWMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjASWLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:11:21 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E0DDF969;
        Thu, 19 Jan 2023 13:48:41 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 94E04359;
        Thu, 19 Jan 2023 21:48:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 94E04359
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1674164919; bh=ag6HUaimVZm7NlwVzt7zlfh9xPGOVrD3YGEZy6w1pxY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=rRCgOdVoOA364MGoPS9OHm0VgZxQKFA28+OfLVSZkhompQtWJW+4KZz4HwkUBpZa0
         KWvKVy20BJVDy+diY8PcAKuLIDtssj1LRHIfdNq77fE8b6LjJNzclCJWKMq81eUooX
         3j1iYSd+SwdXTN3aJRNm/MmBBM61clLCuvvpwh2JcwWy59dvltgfftDmNeviUeekG1
         zcvJvW18J+tABW3AZEaVBkynueSMUd00heepyCjEuuuP/oJT2bnQrg3AzYychozqz8
         VRd6Hy3elMoNwTWq02MwCNu0O8QlWqRCj75TAXAj1lf6RKyCCKgDNUp7mbzqQsN2ew
         ZZrGnTo94k76g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jakob Koschel <jkl820.git@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the jc_docs tree
In-Reply-To: <20230120083419.1fff9149@canb.auug.org.au>
References: <20230120083419.1fff9149@canb.auug.org.au>
Date:   Thu, 19 Jan 2023 14:48:38 -0700
Message-ID: <87ilh26vrd.fsf@meer.lwn.net>
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

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> Commit
>
>   6b25b190a9a3 ("docs/scripts/gdb: add necessary make scripts_gdb step")
>
> is missing a Signed-off-by from its author.

Sigh...my tooling is supposed to catch that...  Patch dropped; Jakob,
would you like to send me a properly signed-off version?

Thanks,

jon
