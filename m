Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE5F659B57
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 19:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235551AbiL3SSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 13:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbiL3SSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 13:18:05 -0500
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB7A1C410;
        Fri, 30 Dec 2022 10:18:04 -0800 (PST)
Received: by mail-io1-f53.google.com with SMTP id v2so11481486ioe.4;
        Fri, 30 Dec 2022 10:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CA5uU9xfc2kQPK+mg/5jhRujnxjVswB27Z1UxXXBvOg=;
        b=IOnT3arSosPv6g+bxwJH8QgDvWwxxeY5FBbGiyFQJt7ZRVDfilNmhdu8ZQzYlwGXRG
         sw5ssD/t5lXjBiB2pVsjHcQto5r5tCyG1L6MOfnbxg3ZFcCRagK2+oZ2ld+Em6cpAQba
         OkUCPTlQ4ZBHPJfwjBKsu5e3id7CRz13LdvClsWcfNFAunCXfb1kPPhrdEF7tCfDOc5P
         +CB+bbrkHWIdpKyIKCAZtUBvCsf+M2AwVHnzAdeggp5GwQhKvGuaer6OIIY/jxZt57bW
         JboMbhlh5Ln/LLlbzNp0ceHj96CT4FstFqCx9gj4lv/7Lp01hX3Cr9iUxIo0+yKu++Nl
         8TaA==
X-Gm-Message-State: AFqh2kotaxVg/AXacJwgJv2cgff6glhQhbR6uKC2HqA6JDZQameiyiEc
        PT0QNq8LF+gAvMDLx3Z4CuUF4AXWHmuTCkkpSYc=
X-Google-Smtp-Source: AMrXdXtvG/+juumm/OZ/6Xk91ooHhF3lK0NDpHretXH3t7gCzczen11e1APu8EEbwu9uQ62YiVCVqPHZpEtSMwIgIyo=
X-Received: by 2002:a02:3b4f:0:b0:39a:98b:480e with SMTP id
 i15-20020a023b4f000000b0039a098b480emr2485950jaf.125.1672424283499; Fri, 30
 Dec 2022 10:18:03 -0800 (PST)
MIME-Version: 1.0
References: <20221223142419.3781410-1-ammar.faizi@intel.com> <20221223142419.3781410-3-ammar.faizi@intel.com>
In-Reply-To: <20221223142419.3781410-3-ammar.faizi@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Dec 2022 19:17:51 +0100
Message-ID: <CAJZ5v0jAy6YmGwZ3QBrgGf4O0xmkF=K=cS71gB0S_0GBC0kLfg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] ACPICA: Silence 'unused-but-set variable' warning
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux ACPI Mailing List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPICA Mailing List <devel@acpica.org>,
        LLVM Mailing List <llvm@lists.linux.dev>,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 3:24 PM Ammar Faizi <ammarfaizi2@gnuweeb.org> wrote:
>
> From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
>
> @num_carats is used for debugging, passed to the 'ACPI_DEBUG_PRINT()'
> macro. But this macro will expand to nothing when debug is disabled,
> resulting in the following (clang-16):
>
>   drivers/acpi/acpica/nsaccess.c:295:6: error: variable 'num_carats' set \
>   but not used [-Werror,-Wunused-but-set-variable]
>         u32 num_carats;
>             ^
>   1 error generated.
>
> Move the variable declaration inside the else block to reduce the scope,
> then add '(void)num_carats' to silence the warning when debug is disabled.
>
> Cc: LLVM Mailing List <llvm@lists.linux.dev>
> Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>

ACPICA changes require (at least) a pull request to be submitted to
the upstream ACPICA project on GitHub.

If such a pull request is created, please resend the Linux patch with
a Link tag pointing to that pull request.

Thanks!

> ---
>  drivers/acpi/acpica/nsaccess.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
> index a0c1a665dfc1..d73d052c5b3b 100644
> --- a/drivers/acpi/acpica/nsaccess.c
> +++ b/drivers/acpi/acpica/nsaccess.c
> @@ -292,7 +292,6 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
>         struct acpi_namespace_node *current_node = NULL;
>         struct acpi_namespace_node *this_node = NULL;
>         u32 num_segments;
> -       u32 num_carats;
>         acpi_name simple_name;
>         acpi_object_type type_to_check_for;
>         acpi_object_type this_search_type;
> @@ -394,6 +393,7 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
>                                           "Path is absolute from root [%p]\n",
>                                           this_node));
>                 } else {
> +                       u32 num_carats = 0;
>                         /* Pathname is relative to current scope, start there */
>
>                         ACPI_DEBUG_PRINT((ACPI_DB_NAMES,
> @@ -406,7 +406,6 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
>                          * the parent node for each prefix instance.
>                          */
>                         this_node = prefix_node;
> -                       num_carats = 0;
>                         while (*path == (u8) AML_PARENT_PREFIX) {
>
>                                 /* Name is fully qualified, no search rules apply */
> @@ -449,6 +448,7 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
>                                                   "Search scope is [%4.4s], path has %u carat(s)\n",
>                                                   acpi_ut_get_node_name
>                                                   (this_node), num_carats));
> +                               (void)num_carats;
>                         }
>                 }
>
> --
> Ammar Faizi
>
