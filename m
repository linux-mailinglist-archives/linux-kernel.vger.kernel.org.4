Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B9B6CEF9D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjC2QkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjC2QkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:40:06 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6269310F;
        Wed, 29 Mar 2023 09:40:05 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9F7FD378;
        Wed, 29 Mar 2023 16:40:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9F7FD378
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1680108004; bh=paGh1OeGW3r8EjzTZ/oNzuANG8Gctu13IsDhEUo9Lz0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Ai8x34f6qzOursoDarnQXytXyMVdCGws5ssISKVbIiqqkkM4QvqPyUZZQG8Xpj8Yr
         RC8Fp4XjE09jV9aeYx4udQHkL7h+cGIcQ8RBfw0YJ5N+GOUy72zhCqFV6M6Q6ifjwa
         27fICtx0yA3vfb3C2PVos7XM3NenB5sDzC2pJ1T5hIluiiWxPJqCwcECLJNhFhRPLo
         Yiqzi4/M/SmalW8TUC+T9YmXFWSzhKcI9ktSSNpGLslZ+oxCN/y/ERQelb2qC3U9+u
         pA1sZuUW3J4xZttzkdFq/FkItKg2si2w1R2lZYI/wiljQ3JyQ+HodAwI1IC2bst2Zd
         t/zsmfcay7Y+w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2] ELF: document some de-facto PT_* ABI quirks
In-Reply-To: <c4233c97-306c-4db8-9667-34fc31ec4aed@p183>
References: <2acb586c-08a9-42d9-a41e-7986cc1383ea@p183>
 <e262ea00-a027-9073-812e-7e034d75e718@infradead.org>
 <c4233c97-306c-4db8-9667-34fc31ec4aed@p183>
Date:   Wed, 29 Mar 2023 10:40:03 -0600
Message-ID: <87edp7jyu4.fsf@meer.lwn.net>
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

Alexey Dobriyan <adobriyan@gmail.com> writes:

> Turns out rules about PT_INTERP, PT_GNU_STACK and PT_GNU_PROPERTY
> program headers are slightly different.
>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
>
> 	v2: integrate into documentation build system
>
>  Documentation/ELF/ELF.rst   |   32 ++++++++++++++++++++++++++++++++
>  Documentation/ELF/index.rst |   10 ++++++++++
>  Documentation/index.rst     |    1 +
>  3 files changed, 43 insertions(+)

I really don't want to add another top-level directory for a single
short file ... I'm trying to have fewer of those directories, not more.

This is essentially use-space ABI information; I think you should really
just drop a file into Documentation/userspace-api/.

Thanks,

jon
