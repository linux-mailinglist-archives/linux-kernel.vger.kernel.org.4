Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF3C6E197E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 03:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjDNBQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 21:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDNBQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 21:16:14 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715DD30FA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 18:16:13 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id v7so15901501ybi.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 18:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1681434972; x=1684026972;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNHtFxDJlWhvI6wADsECZUb5iqPCc6WyyTDSQpHBCP4=;
        b=AGAi6TcUOpevNguQX5VZI/MKtP4++I+3zkSwEmzDDxo9XWXMyKlWljGtjFrMosS1ZO
         uZXXsmrdKYKfzjuq0gnJNKrjhb0bL2H08FOfpniz9xMFNPbB0Kz/VYjYRYAhzhD++4nX
         7nsMbZzLiTMhlpWhwuK0RE5X7x6rlS/J+nzxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681434972; x=1684026972;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNHtFxDJlWhvI6wADsECZUb5iqPCc6WyyTDSQpHBCP4=;
        b=Iu0Bm/5l7P9NRu3R0G8QqoidTfGb1cyYMHMdRPClBIVvPK67nFJu8QWO9/WkIC74Qd
         HA9s3TcjpZzEjcLMYLXQZ1UruBfkL1H01mPSBXDqsYlbS8+FmQKXsU/jYkkmqnJVJ0cd
         GP1VwUmKTXGhmIUjNM3qAUdGA9ebwo3jEmoi4DcQtC6LDDIBY67q5XsnJEP6Fid5egor
         dzDPPFY3qS6/CRtJgWEKIBIVTDv6KBpnPrSNbGXOJ0Geoiq3gnYIxoSNgtf6iFX1Gg2B
         sLK9Hwkl3z5p+u5H7ytpjW63dWsZ2J7CiD7etLcORg7ZdbawmuyvjMniM0E+ZeVHILn4
         qTgw==
X-Gm-Message-State: AAQBX9fW5gJeQTFiJy/ww0bmyRV573s1krgJyAlQxN2yBAUIvXcmRp1z
        QuXMnTVcc38TDr+JovOH4K/Cr5JcXwv9VQGtp/1Z8A==
X-Google-Smtp-Source: AKy350YBgqABe4fGYo+miNAK99kHZ/f3+4+DfdFNgd+lcx14l03CYmKrb+CqtAAvVzGRZZ5T2JuDG/+utkawrPli0/8=
X-Received: by 2002:a25:748b:0:b0:b8f:6ab7:9328 with SMTP id
 p133-20020a25748b000000b00b8f6ab79328mr977997ybc.2.1681434972610; Thu, 13 Apr
 2023 18:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230414005309.GA2198310@google.com> <CAEXW_YRm62XHtpw4Ubp7x3n9jZJNGezRp0ymOGbQ3e62mysz1w@mail.gmail.com>
In-Reply-To: <CAEXW_YRm62XHtpw4Ubp7x3n9jZJNGezRp0ymOGbQ3e62mysz1w@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 13 Apr 2023 21:16:01 -0400
Message-ID: <CAEXW_YRPk6Q92MTL7Bnr9kzJT=FHTAiEwxLU=vT+VP+TqPApew@mail.gmail.com>
Subject: Re: clangd cannot handle tree_nocb.h
To:     rcu@vger.kernel.org, ndesaulniers@google.com, nathan@kernel.org,
        trix@redhat.com, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 9:11=E2=80=AFPM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> Hello,
>
> One way to fix this could be to add this to the beginning of tree_nocb.h
>
> /* Make clangd understand tree_nocb.h */
> +#ifdef CLANGD_PARSER_ACTIVE
> +#define TREE_NOCB_H_CLANGD
> +#include "tree.c"
> +#endif
>
> And then at the end of tree.c, do this to prevent recursion:
> +#ifndef TREE_NOCB_H_CLANGD
>  #include "tree_nocb.h"
> -#include "tree_plugin.h"
> +#endif
> +#include "tree_plugin.h"
>
> Then in scripts/clang-tools/gen_compile_commands.py, we can just make
> it add "-DCLANGD_PARSER_ACTIVE" to all compile command entries in the
> JSON file.
>

Ah and even that will not fully work, because there is no entry for
tree_nocb.h in compile_commands.json to begin with :-(. However, that
also can be fixed. Here's how:

We can just add metadata to tree_nocb.h , something like:
/* clangd_infer_from: tree.c */

Then we make scripts/clang-tools/gen_compile_commands.py  duplicate
the compile command JSON entry for tree.c but for tree_nocb.h.

Lastly, we add -DDCLANGD_PARSER_ACTIVE to all entries (including the duplic=
ate).

 - Joel
