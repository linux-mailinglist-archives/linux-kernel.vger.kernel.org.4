Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A52669E2E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjAMQdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjAMQdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:33:02 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E45A840BC;
        Fri, 13 Jan 2023 08:27:39 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CA082733;
        Fri, 13 Jan 2023 16:27:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CA082733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1673627259; bh=pU9jz10Yj6FJ+ekEtqzfY35kDUfLDA/OiRzYHZN4cYU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ofSPK2pdQDXsjtN/eVxvsjDFBExS7Pck0A4bGg8bWSE70d5NleKE5TJWdTe7a/RdX
         Pkzy6q3A1UZEPjMU9AJLEe9gmI8lwqvsOqbw7UxuOpOHZkDzrWpx3Hx49Pp01DnsMv
         Q9no2GCZMc3+zy/hHuRNG/PhC6gU5+FoJpkJHhBgS6qreLLc8fTd9Zc65DumvsD2SD
         ADSO4RewVAAsMOECxQJW8yP/ajpkm6N1uhLxWlQm1h9F6lo5oBVM5f/DR5Dd7+yc0t
         h6TSPKSIy7QMCSX1+RJ2XOxpObCNnr4JoPaDq10vXYy/FnFS3tQfX26vlMsgx72qZH
         CjbONptqxtzIw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the tip tree
In-Reply-To: <20230113124053.5a75633d@canb.auug.org.au>
References: <20230113124053.5a75633d@canb.auug.org.au>
Date:   Fri, 13 Jan 2023 09:27:38 -0700
Message-ID: <87358es8lh.fsf@meer.lwn.net>
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
> The following commit is also in the jc_docs tree as a different commit
> (but the same patch):
>
>   379af13b31fa ("docs: locking: Discourage from calling disable_irq() in atomic")
>
> This is commit
>
>   ac6fadf4aa60 ("docs: kernel-hacking: discourage from calling disable_irq() in atomic")
>
> in the jc_docs tree.

I'm sure I checked before applying that ... I guess maybe not.  I've
disappeared it now, thanks.

jon
