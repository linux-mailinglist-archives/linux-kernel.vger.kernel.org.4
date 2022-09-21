Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB08B5E544B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 22:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbiIUUNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 16:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiIUUN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 16:13:27 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C8AA4B13;
        Wed, 21 Sep 2022 13:13:17 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 58C482B0;
        Wed, 21 Sep 2022 20:13:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 58C482B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1663791196; bh=28ptMZUzJD0DzYp8Orj7yZu0E/3Ie5MqeiQlOIFfBPY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=AJYw5RwskVegI2+3Q6ye9XmL/Eq3fsJuP9PSfYNFvjTKgxbwcVx9y+oteaxMJreLD
         nMhcZlHGQmAyRlFRw29Gcw92p1v4dLKUT25/1NYT0bCZMaBtlZ6NFJww59tfbSGJsM
         Nw4ChwehFawM0lIFUn6haU3LDk9/J2UVyNseq6Xz2yLFsKGWuR94UiBMtCq18fg1yY
         bOrGmCgnmrj/iexRw19iiFqV+FcHlkRHiSmxiPs2ikjbmvwSGWw+CehxX+s24v3ATC
         SRBVKrMAyZejBFzH5jLv0DHqyWw4GwG40a/wFMu/nYAkZIn78SAawEGYfcdUXnWoj5
         mG3SsWCftCn4Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        Evgeniy Polyakov <zbr@ioremap.net>
Subject: Re: [PATCH] Documentation: W1: minor typo corrections
In-Reply-To: <20220828002845.7022-1-rdunlap@infradead.org>
References: <20220828002845.7022-1-rdunlap@infradead.org>
Date:   Wed, 21 Sep 2022 14:13:15 -0600
Message-ID: <87zgestrj8.fsf@meer.lwn.net>
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

Randy Dunlap <rdunlap@infradead.org> writes:

> Correct one typo/spello and remove one duplicated word in the
> W1 documentation.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Evgeniy Polyakov <zbr@ioremap.net>
> ---
> @Evegniy-
> I notice that ioremap.net web site is not working for me.
> Can you do something about that or modify the URL in
> Documentation/w1/w1-netlink.rst (2. http://www.ioremap.net/archive/w1)
> for source code examples?
>
>  Documentation/w1/masters/ds2490.rst |    2 +-
>  Documentation/w1/w1-generic.rst     |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

jon
