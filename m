Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EED6339C3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbiKVKWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbiKVKV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:21:28 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCEFD7B;
        Tue, 22 Nov 2022 02:20:42 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B42BB3C0F8C;
        Tue, 22 Nov 2022 10:20:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a305.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 149133C0A9D;
        Tue, 22 Nov 2022 10:20:41 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1669112441; a=rsa-sha256;
        cv=none;
        b=l991j0ndctJJAKL1CVEFkMOfzSlZbXoH4aEl45t+N1uBz+AoZM1z7jfRm//9LSbSHJvWoF
        XzFkbnMVzACZm7nHJsFzo9z/zvwFsrlOMDgyseEN7hvNBsuHCKIfGrAAAi5/E26ZA8uE7z
        PTpuBb4s7yxk9BwUXwibZiDvLZCxRIqXsyfGYumANtU+z0Qn4B/a2yaMOx+gRjFrDrDxDT
        bQv/OemMdBEFv/s21+cH+nPiPCsCJsy2VSa1KVFO1HSRbLvnPGyfl/sIgUoIqrs+ilMOpU
        M/Z+JwnslOxXc2wOdKVfHlOChRuMVzD8EgiiWSIgX+uZY5L/9EQUc+EoE4BXdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1669112441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=qiPhbkwAI/xsCItHsFRuVip1BIcjDwn1WOh9E0WKWWA=;
        b=kjTb1EHAOocHKzoSaje4LBfxjDyL6VuYdhVcYqhUDiUKcPKtFDklNTBuvNuBY2Fc6Dd1Ju
        u17lmk1LjdA3lifCpK34jDej+ASHl6DpkCufC6KiVixeqDOzY0sXmmw8NcS2DmtVZxOme1
        adYylYcFjatCWzuWTqnH22zOAkfR215L8ygV++Ho30+4QNpgmRvNOQY9DTVvI4N/qydn3w
        xCPOjsjk+URGWc7eQng8ZvC0CPBRhLVdhymW0XI1cECjBmLVAxWTZ2ef63MRtQ5r3S8kqw
        ocyzxqfyCvhM9m8KqtG5cLXyDl5dFXX9sjnu2eWmw1VtRezGl+HC/c2Y2JU7ww==
ARC-Authentication-Results: i=1;
        rspamd-64c57ffbcf-gmhf8;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=siddhesh@gotplt.org
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|siddhesh@gotplt.org
X-MailChannels-Auth-Id: dreamhost
X-Vacuous-Robust: 5419300679b2401a_1669112441516_4245864710
X-MC-Loop-Signature: 1669112441516:1950271019
X-MC-Ingress-Time: 1669112441516
Received: from pdx1-sub0-mail-a305.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.179.81 (trex/6.7.1);
        Tue, 22 Nov 2022 10:20:41 +0000
Received: from [192.168.0.182] (bras-base-toroon4834w-grc-23-76-68-24-147.dsl.bell.ca [76.68.24.147])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: siddhesh@gotplt.org)
        by pdx1-sub0-mail-a305.dreamhost.com (Postfix) with ESMTPSA id 4NGgJ71dRvzSB;
        Tue, 22 Nov 2022 02:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gotplt.org;
        s=dreamhost; t=1669112440;
        bh=qiPhbkwAI/xsCItHsFRuVip1BIcjDwn1WOh9E0WKWWA=;
        h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
        b=wJxTewb1A8WOR3hcBGdT/BQJa4rCcOq2EPVtOuauuy4Nn1tL60H1eWIEZt0ztOo9f
         6qVD+rx2fNDVRlpaK8+lITQ+H1ZxUdeIvfuS7vtAy9PMaMc4eKK7SXzt/jC3U6oVEp
         SU2LOHhwikC3m+Qu+9zf8BiCkOkjtZKoYagndAeU4FdapikRsUGEdESeiT4S4iLjrJ
         uc+6UyEyG+aM5ONt/TM7PO/eK2ZXcff42739Jr0uCyCYnQe+epC8KJcphDPpR2OTZI
         5t+/Qd0LlOvaaY21NpGfVH6DRlWVgfOfiaoehn8YZdmObYYuQ7n91xleGrzYENC74/
         jpjLBabVpnvrg==
Message-ID: <0da67f73-dd73-7e6d-74c2-14aec5d79902@gotplt.org>
Date:   Tue, 22 Nov 2022 05:20:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 4/4] fortify: Use __builtin_dynamic_object_size() when
 available
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org
References: <20220920192202.190793-1-keescook@chromium.org>
 <20220920192202.190793-5-keescook@chromium.org>
From:   Siddhesh Poyarekar <siddhesh@gotplt.org>
In-Reply-To: <20220920192202.190793-5-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-20 15:22, Kees Cook wrote:
> Since the commits starting with c37495d6254c ("slab: add __alloc_size
> attributes for better bounds checking"), the compilers have runtime
> allocation size hints available in some places. This was immediately
> available to CONFIG_UBSAN_BOUNDS, but CONFIG_FORTIFY_SOURCE needed
> updating to explicitly make use the hints via the associated
> __builtin_dynamic_object_size() helper. Detect and use the builtin when
> it is available, increasing the accuracy of the mitigation. When runtime
> sizes are not available, __builtin_dynamic_object_size() falls back to
> __builtin_object_size(), leaving the existing bounds checking unchanged.
> 
> Additionally update the VMALLOC_LINEAR_OVERFLOW LKDTM test to make the
> hint invisible, otherwise the architectural defense is not exercised
> (the buffer overflow is detected in the memset() rather than when it
> crosses the edge of the allocation).
> 
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Siddhesh Poyarekar <siddhesh@gotplt.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Tom Rix <trix@redhat.com>
> Cc: linux-hardening@vger.kernel.org
> Cc: llvm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   drivers/misc/lkdtm/heap.c           | 1 +
>   include/linux/compiler_attributes.h | 5 +++++
>   include/linux/fortify-string.h      | 7 +++++++
>   3 files changed, 13 insertions(+)

Hi Kees,

Circling back on this, I noticed that all but this patch got pulled into 
Linus' tree.  Is there a reason why this has been held back?

Thanks,
Sid
