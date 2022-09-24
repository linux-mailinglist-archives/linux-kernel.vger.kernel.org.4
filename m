Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E7A5E876A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 04:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbiIXCZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 22:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbiIXCZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 22:25:23 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737B9124C0C;
        Fri, 23 Sep 2022 19:25:22 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id cj27so1143953qtb.7;
        Fri, 23 Sep 2022 19:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kAIcOtX2Pee9LhEaGnzGs+IdaSZgOkLNO4wiCb4Ucso=;
        b=XraJIcgPscBeqHUCVu+Hw1biP4oELUdtDSKjI63kTw6Df0KW7Xeatvvdt28oMHc4FZ
         NVqP4cyfykCLGfm9KPTJ+DsNcsG+T+DLYO1Q/oMbj/WFy1zeB+7xdtKTvKkKt40Y7rE8
         WPUvPWDYMQHjk0chkEgvkonjNW75vBsVMcU+VgrxsINOOlL9zz7b6866gWlIRG1rS5sw
         9jQV6dpl/F4NQD4q43Gw+0FyCNGNLpdLziyPHvwnyiomixMC1hjSj1Wk/0bkp1b0xh4U
         s2WVqqHa99LfDUxZ6YtdTZIKQhF6S3WjDVMnmMOvK/AjPz5tLfyRChaairN9VKbviTfi
         3X4g==
X-Gm-Message-State: ACrzQf1We+PCpT8GgNxPY3vou9v8R1twswPUV9VZEcTuVH8g4J1WW5zI
        MqAFqew8c4LLHKq5O//XMo9izwaeT9iUZw==
X-Google-Smtp-Source: AMsMyM5bkXv/+mchy5fIlKRV1VS9M641KTwtSiZoxHoHZcjwLSMgoSx03UjxsPKYtXj9fSxjgoWBug==
X-Received: by 2002:a05:622a:ce:b0:35c:f5de:3976 with SMTP id p14-20020a05622a00ce00b0035cf5de3976mr9583462qtw.437.1663986321518;
        Fri, 23 Sep 2022 19:25:21 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::2c58])
        by smtp.gmail.com with ESMTPSA id d21-20020ac84e35000000b00359961365f1sm6732526qtw.68.2022.09.23.19.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 19:25:21 -0700 (PDT)
Date:   Fri, 23 Sep 2022 21:25:22 -0500
From:   David Vernet <void@manifault.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v2 6/7] docs: Expand the front-page CPU-architecture
 section
Message-ID: <Yy5qknCcImvDLkZ9@maniforge.dhcp.thefacebook.com>
References: <20220922204138.153146-1-corbet@lwn.net>
 <20220922204138.153146-7-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922204138.153146-7-corbet@lwn.net>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 02:41:37PM -0600, Jonathan Corbet wrote:
> Actually show the entries for individual architectures, since otherwise a
> single line reading "CPU architectures" is not very enlightening.
> 
> We should really move all of the architecture directories under an arch/
> directory, as we do with the top-level directory, but that's a task for
> another day.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/index.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/index.rst b/Documentation/index.rst
> index 6d01c2e38573..5a700548ae82 100644
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@ -93,7 +93,7 @@ Architecture-specific documentation
>  -----------------------------------
>  
>  .. toctree::
> -   :maxdepth: 1
> +   :maxdepth: 2

Wasn't this changed from 2 -> 1 in patch 2/7 [0] of this set? If so, can
we just undo that adjustment and remove this patch from the series?

[0]: https://lore.kernel.org/all/20220922204138.153146-3-corbet@lwn.net/
