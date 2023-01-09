Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FCA663225
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237970AbjAIVCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237819AbjAIVBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:01:14 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B5813DCB
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:56:09 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id o7-20020a17090a0a0700b00226c9b82c3aso11090455pjo.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k77roXZTKEa1bW9MMBlu0nb8dRHFWkQI4epay3x27MU=;
        b=CGg0P2AbUZkyGt7JVy15IUwgYNiwHKNpuHK4sbKDRxzpEnSHIUIVUG1crw2skaHRzO
         8fKoa2lJUBsqWgBn3n1wQbkoT6CjRtdskVjHzY9lgpzwxtTNWRMQjDs5Ivw8aY3yTWAW
         tVjsB5cF9ZpGG/15u1rgsnch2EJhSHA4QG3HqIK5jKkHg1WPnwP6Xx/q9oEqkgke/2cJ
         cmyTO1GhMTg859Nd4qBZYUTx5Tvd88rZhjGuaZR3o//tANk8tuSDY9ven5Vp48m9ns59
         Uq0Tk6wvGMFlZqzfwpqQObJkN5Aq++f3NTAXiukQ4HjTHYQbZJWNY31z8JN46GAJyo40
         E3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k77roXZTKEa1bW9MMBlu0nb8dRHFWkQI4epay3x27MU=;
        b=NGJBbzhW0Ht3P4YeNd7afaTtEREFYNMCdgWyn+unhhez8PCmDOzBa2zeTtgjN9p6/L
         VP82eD66dUX+Hx56ZO96ak8+8N3MBXuRBKG6vnRfeIH858k/g1xDVNMhOv9yRj+RFWSn
         o59LoIzKSygXVw/s9Ix2hxyy+UbJ8yMZZvWJ3KSLUsCWWnwlqiTqdScAS7AZf5yNxKEO
         a7vSsFIqH7MePWiQ12swsb9qQzhZP9wwTaBkPB1XFOTWJTc6L1ypl9B308Jug8KI+1+O
         VXd9IAema7aflOUUuttKyCIXU6b4QbRmWa8/ZPLEp2rQKFSxR9wFpmd9R8sJ2bzJNij6
         3WHw==
X-Gm-Message-State: AFqh2krDT7smg99Hjt/oRxZj52K9VD7Xu4j8L5TryRJQIlBWEd9sBEyj
        yrcyytfLfh5qY+kdAOvJg31NKS1xEwXF4VJacsYaUw==
X-Google-Smtp-Source: AMrXdXvDm6dBr45GZwR8ZZacfwEY/hvFmIphJjWyEmyM7/WIajTWRzT+myD3k0Dip/lFV7Z3NNuiG+lA09+rqzxqYSY=
X-Received: by 2002:a17:902:a407:b0:189:f899:bc23 with SMTP id
 p7-20020a170902a40700b00189f899bc23mr3757452plq.33.1673297768779; Mon, 09 Jan
 2023 12:56:08 -0800 (PST)
MIME-Version: 1.0
References: <20230109201837.23873-1-eliasfleckenstein@web.de>
In-Reply-To: <20230109201837.23873-1-eliasfleckenstein@web.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 9 Jan 2023 12:55:57 -0800
Message-ID: <CAKwvOdnYkmadAhiwFAFuZwhABT4vE_urtDafA2pqP7=yt8795Q@mail.gmail.com>
Subject: Re: [PATCH] kconfig: fix typo (usafe -> unsafe)
To:     Lizzy Fleckenstein <eliasfleckenstein@web.de>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 9, 2023 at 12:19 PM Lizzy Fleckenstein
<eliasfleckenstein@web.de> wrote:
>
> Fix the help text for the PRINTK_SAFE_LOG_BUF_SHIFT setting.
>
> Signed-off-by: Lizzy Fleckenstein <eliasfleckenstein@web.de>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  init/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 7e5c3ddc341d..57c8d224ea4c 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -776,7 +776,7 @@ config PRINTK_SAFE_LOG_BUF_SHIFT
>         depends on PRINTK
>         help
>           Select the size of an alternate printk per-CPU buffer where messages
> -         printed from usafe contexts are temporary stored. One example would
> +         printed from unsafe contexts are temporary stored. One example would
>           be NMI messages, another one - printk recursion. The messages are
>           copied to the main log buffer in a safe context to avoid a deadlock.
>           The value defines the size as a power of 2.
> --
> 2.39.0
>


-- 
Thanks,
~Nick Desaulniers
