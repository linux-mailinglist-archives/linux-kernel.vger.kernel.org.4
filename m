Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969025BA068
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 19:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiIORfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 13:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIORfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 13:35:04 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C1388DFF;
        Thu, 15 Sep 2022 10:35:03 -0700 (PDT)
Received: from localhost (unknown [89.101.24.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 94FCA77D;
        Thu, 15 Sep 2022 17:35:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 94FCA77D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1663263303; bh=72y/ZPnddY0r3jRVs/65Nl+A1xWizCASCrfFCeh0Q3k=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=IL9xHi6pT+CKuPTO6EnS8ET5GM7XapMOihWjC8vE+k45A80qbbhkzaOZvWJDYotDm
         SI+kuYUkDj3kq+TSIQPDxgLjS1Rsxz/F0uKpD9VWaxT/aHaoZYLPvzAmxPrkPCIeTj
         pbEGacT/n46fMAQAh3vYvlJNEUHuw9075nU5t9lznZxSZbS08kT5YKBgTiFzkQmCcX
         h5w5e15tuNpzYzPZ6USOlYkh2o1b+GBHe5iZQnvaVgN5PsteOWufnWN47m2bZOcM4e
         QBioFAV1Wcd2kTkilyomQVgyCaOb0RqOpLFZtjZpPykJN02KWlifHKYuLb1A0jUL7l
         gvf7Jbn5HdVnw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tuo Cao <91tuocao@gmail.com>, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        91tuocao@gmail.com
Subject: Re: [PATCH v3] docs: x86: replace do_IRQ int the entry_64.rst with
 common_interrupt()
In-Reply-To: <20220915150155.9908-1-91tuocao@gmail.com>
References: <20220915150155.9908-1-91tuocao@gmail.com>
Date:   Thu, 15 Sep 2022 11:34:56 -0600
Message-ID: <87fsgsee2n.fsf@meer.lwn.net>
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

Tuo Cao <91tuocao@gmail.com> writes:

> do_IRQ has been replaced by common_interrupt in commit
> fa5e5c409213 ("x86/entry: Use idtentry for interrupts").
>
> Signed-off-by: Tuo Cao <91tuocao@gmail.com>
> ---
>  Documentation/x86/entry_64.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/x86/entry_64.rst b/Documentation/x86/entry_64.rst
> index e433e08f7018..0afdce3c06f4 100644
> --- a/Documentation/x86/entry_64.rst
> +++ b/Documentation/x86/entry_64.rst
> @@ -33,8 +33,8 @@ Some of these entries are:
>   - interrupt: An array of entries.  Every IDT vector that doesn't
>     explicitly point somewhere else gets set to the corresponding
>     value in interrupts.  These point to a whole array of
> -   magically-generated functions that make their way to do_IRQ with
> -   the interrupt number as a parameter.
> +   magically-generated functions that make their way to common_interrupt()
> +   with the interrupt number as a parameter.
>  
>   - APIC interrupts: Various special-purpose interrupts for things
>     like TLB shootdown.

So why have you sent a "v3" the same day?  It doesn't look like anything
has changed...?

Thanks,

jon
