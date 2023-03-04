Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678FD6AAA98
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 16:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjCDPBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 10:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCDPBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 10:01:51 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB49CDD0
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 07:01:48 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 09DD52D3;
        Sat,  4 Mar 2023 15:01:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 09DD52D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1677942107; bh=Dy3GMJRCcyJI6flIQ6mIYDtYEv3aWSWcRGCgUowv2Rc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=naRwBbQzG1kwwJ21J40qVZTI8uIci9CRvtvnRtX4kryQ88YsVjkB2ssyHWqhiINDb
         r40RzJCUH3QABRQb6SCbp3n1wm9QkZXDTDaKwHj/xmwYeIaZGK1uG569JwhmESNw9k
         V7TyQvCOuZ55Elel3BalijV7IryhfBaJN0H8X/UVIuziEGQO75//+S3TruMQxxHLpp
         DMPjutwh+N014T9/VP+L9sOtfHZzkd669656xssvcc/Oegqq1XXepF0VRSsN5EATUb
         h10Jdz2h1S7QWjGErBIULPBDEqQ4DWsr+sy9CdZmnIf3dNYAKQ9aTf1LKb1cxqq7S2
         eu+EjFUCYeTcg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Wei Wang <wei.w.wang@intel.com>, arnd@arndb.de,
        akpm@linux-foundation.org, keescook@chromium.org,
        herbert@gondor.apana.org.au, josh@joshtriplett.org,
        jani.nikula@intel.com, jgg@mellanox.com, dmatlack@google.com,
        mizhang@google.com, pbonzini@redhat.com, seanjc@google.com
Cc:     linux-kernel@vger.kernel.org, Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v1 2/3] Documentation/CodingStyle: do not use data type
 names as variable names
In-Reply-To: <20230304041932.847133-3-wei.w.wang@intel.com>
References: <20230304041932.847133-1-wei.w.wang@intel.com>
 <20230304041932.847133-3-wei.w.wang@intel.com>
Date:   Sat, 04 Mar 2023 08:01:46 -0700
Message-ID: <87mt4szhk5.fsf@meer.lwn.net>
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

Wei Wang <wei.w.wang@intel.com> writes:

> Observed some merged code uses "bool" as variable name. This is
> confusion either for the reader or compilier. Add a rule to have
> programmers avoid using data types as variable names.
>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  Documentation/process/coding-style.rst | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 007e49ef6cec..6d7f4069d55d 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -356,6 +356,9 @@ specification that mandates those terms. For new specifications
>  translate specification usage of the terminology to the kernel coding
>  standard where possible.
>  
> +"bool", "int", "long" etc. are specific names for data types, C
> +programmers should not use them as variable names.

It seems you found one place where bool was being misused.  Fixing it
was certainly the right thing to do, but I'm not convinced we need to
add clutter to the documentation for this.

Thanks,

jon
