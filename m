Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A215B6DE710
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 00:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjDKWQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 18:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDKWQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 18:16:25 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35862D66;
        Tue, 11 Apr 2023 15:16:23 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3ACF95BF;
        Tue, 11 Apr 2023 22:16:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3ACF95BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1681251383; bh=Xy0dZT1rdMUeYpg6CvHH6iNq30131ZGhBo/yP3hbRsY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ffgKhGW8CsRXJ/jRO8MhiLY41BlR9AMwAnlUdvvu7F7jRRFspqklgzEXLufSXzc+2
         4QcZgGo1psBTSFtWkeR3pxVBtdVjHZ+3mAChaEjS26pLG7PepVPRAc6AJE9Nzj4lQ+
         rAsk/ogOAxRFEw/N73VKHvrjtFEIa5hVLhPwt9gwNxCbnCWSKuTJWDd4f189oZ0zhO
         ilQ6KcZ6MldnxusWwOJ/yvpFnsbUaluS1eHFFYS0VQ4U02hki3ixo1xxG8zfOaivgc
         i2kuJpqs9RaMpa37czCzlVQIVKwr5a41mkaJorn/8vieyfoxvZiWr0YoJ1wzZdO38r
         2EQPyDf6qOXbw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Takahiro Itazuri <itazur@amazon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the jc_docs tree
In-Reply-To: <20230411151613.20bfd5ea@canb.auug.org.au>
References: <20230411151613.20bfd5ea@canb.auug.org.au>
Date:   Tue, 11 Apr 2023 16:16:22 -0600
Message-ID: <875ya2awuh.fsf@meer.lwn.net>
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
> The following commit is also in Linus Torvalds' tree as a different commit
> (but the same patch):
>
>   5562030968d7 ("docs: kvm: x86: Fix broken field list")
>
> This is commit
>
>   fb5015bc8b73 ("docs: kvm: x86: Fix broken field list")
>
> in Linus' tree.

Oops, I got fooled by the additional versions coming after Paolo
responded.  I'll disappear my copy.

Thanks,

jon
