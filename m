Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E226D6192D6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 09:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiKDIfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 04:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiKDIfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 04:35:50 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8447126574
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 01:35:49 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id j130so5001431ybj.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 01:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mUpvDHPp/KQbmUJ+TdnjII/BPksPsXvuEN05nH99p+w=;
        b=MzqadLxIR9b6+LEJJ6HNsij9urCh0GbULmcpnN6dT5y91ETH4PNxDwJn56S2GxQLvz
         ugMDI58sSH4xeUjXIHk3xGmoUp4Kb9Ir9KT9YYkbLVbAjpF7vUunAUDxOJSaK6lSNFQ1
         4wRLynn7XKYZ5g3N1wOl0lZCc+rwXJA3axPgZbsV0ymxMJEjh2/ewOeyFOLEYAu3jX5R
         1rB/oyzOEJ183FqFCmVDuRkDrBlfcROOq4HwqCUsoogizfDfrJFpRfb3GPpNH9oGEbyI
         GbgICsAfSveF0MO/15ZLaapvsewpeGSKCUxDYSLY5ypcK1eaDegEA86YGIazXmWb5GS9
         57oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mUpvDHPp/KQbmUJ+TdnjII/BPksPsXvuEN05nH99p+w=;
        b=vc1uGXB1oDJkdjvg4EpwNWuVD7o4Lt5mG4PLcg5b8eFdwrRWmPNAcnPIfcI/KhnI2E
         22wwpw8U0uJAK8b8iHYBrL5IWPvZw8Z+SsWONbygwOjs0JTktU4j7KHohBwkcI4AhGQD
         AUoMcXWSzPcphBsfrCfDedFmwYTR9KBNHL5lAG+pNqEqlzj4MtFVeAQ/us3uFVK3LdeU
         Psic63XfCp6B8Oh07hNBo+L3exFLqjFq574pf0qOBKbMsxKCnrJ3RtvRLiyeQd/LBqD/
         TorbG+5RlMdGdlUV9E8VCGEjBH0R8BEG3hdMnNa1XfH+Ox+pB7vp5Uv5mvgQuiUNqMW6
         E7xw==
X-Gm-Message-State: ACrzQf1Xzn4vlu3htmFvZjEATYwI9niG4IaJZk5Ehm370yhnLOw2vx/5
        6I+h8E6UYhLoE/vdgj8MWa7UjJjeRnklIHBcoUA=
X-Google-Smtp-Source: AMsMyM6fG11B5iuPoqPwVLezhYfdgTc8yZq6qpMJjcuzWv4SacXQUbPlVZCOSNMseNsaIUVKR0dVYW6yukdbq16/f1E=
X-Received: by 2002:a25:6854:0:b0:6ca:29fd:b6ea with SMTP id
 d81-20020a256854000000b006ca29fdb6eamr34035095ybc.318.1667550948644; Fri, 04
 Nov 2022 01:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20221104070523.60296-1-liaochang1@huawei.com>
In-Reply-To: <20221104070523.60296-1-liaochang1@huawei.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 4 Nov 2022 09:35:37 +0100
Message-ID: <CAKXUXMxi_aqnvCmYjakQzoYvYqqwrvMnFt-czLV1iUnO0TnScg@mail.gmail.com>
Subject: Re: [PATCH -next v2] checkpatch: Add check for array allocator family
 argument order
To:     Liao Chang <liaochang1@huawei.com>
Cc:     apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
        linux-kernel@vger.kernel.org, bagasdotme@gmail.com,
        pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 4, 2022 at 8:08 AM Liao Chang <liaochang1@huawei.com> wrote:
>
> These array allocator family are sometimes misused with the first and
> second arguments switchted.

Just a nit:

s/switchted/switched/

But probably you actually mean "swapped". I think there is a slight
difference between the two words, "switched" and "swapped". And here
the arguments are swapped. Note: I am also not a native speaker.

For the implementation change:

Acked-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

How many new findings are now identified with this extended check on
linux-next? Could you run checkpatch on all files of linux-next and
share the new findings? Then we can do a quick scan if some instances
should be immediately fixed or some janitor should follow through with
such a task.

Lukas

>
> Same issue with calloc, kvcalloc, kvmalloc_array etc.
>
> Bleat if sizeof is the first argument.
>
> Link: https://lore.kernel.org/lkml/5374345c-7973-6a3c-d559-73bf4ac15079@redhat.com/
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> Acked-by: Joe Perches <joe@perches.com>
> ---
> v2:
> 1. Acked-by Joe Perches.
> 2. Use lore links in Link tag.
>
> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 1e5e66ae5a52..a9a9dc277cff 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -7128,7 +7128,7 @@ sub process {
>                 }
>
>  # check for alloc argument mismatch
> -               if ($line =~ /\b((?:devm_)?(?:kcalloc|kmalloc_array))\s*\(\s*sizeof\b/) {
> +               if ($line =~ /\b((?:devm_)?((?:k|kv)?(calloc|malloc_array)(?:_node)?))\s*\(\s*sizeof\b/) {
>                         WARN("ALLOC_ARRAY_ARGS",
>                              "$1 uses number as first arg, sizeof is generally wrong\n" . $herecurr);
>                 }
> --
> 2.17.1
>
