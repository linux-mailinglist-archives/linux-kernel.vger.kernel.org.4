Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A185E8127
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbiIWRxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbiIWRxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:53:20 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C3412E43C;
        Fri, 23 Sep 2022 10:53:19 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id c11so521190qtw.8;
        Fri, 23 Sep 2022 10:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NJsiFZ5EkaqkYkdQzgbiH8ipS+OzqKKEfbtsstj+7NI=;
        b=yUAlKfPu8Dl9BWqxru2vrKitzXubSaxiFHxSe4kOzwJxEhaggG+l46w+2IVM51N2DX
         +b/43STWIHPaxoU9drMmn8NSGN+HjFZjLnp3cCRpk9IlAXReZ3CFvuwC7uEBycubmcDt
         NyXHnjwOwj/uUkSEYl3UezxHqQBAUqCSbU2EIO+hx8gpM9dSvV/IzyjgMA1jWzPbGqlL
         7lyvkqNE17kivYnFH6m2f4kVfeUgLB92Z4wOdWX2THqVfOth9jW29xlieyKkGchiFDy1
         olLRP4iQDHy/OXcPiY376tFQzR7StrCAM0Uo/olAG/skz0fC5eI/dT/DxLG2FJ89Yz2+
         KzXA==
X-Gm-Message-State: ACrzQf0OQICtz76RoIuA/MDjT0qo3E0sgzJyRHJfufW4/TY0aq+ihwzf
        QzlAgKkUo4uN8UOD0zOKsFL/EBHagRQ6og==
X-Google-Smtp-Source: AMsMyM4vSLkmesqxkMZjsSNxC6AuBsXciBgMbI6Cd2BkylQ+6SPIT8UmeMNOiz1gWjmmhk7RtPkbeg==
X-Received: by 2002:a05:622a:284:b0:35c:f655:9cd3 with SMTP id z4-20020a05622a028400b0035cf6559cd3mr8255520qtw.595.1663955598598;
        Fri, 23 Sep 2022 10:53:18 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::2c58])
        by smtp.gmail.com with ESMTPSA id c12-20020a05622a058c00b0035bafecff78sm6357589qtb.74.2022.09.23.10.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 10:53:18 -0700 (PDT)
Date:   Fri, 23 Sep 2022 12:53:19 -0500
From:   David Vernet <void@manifault.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v2 1/7] docs: promote the title of process/index.html
Message-ID: <Yy3yjxs4Ylwpn2ue@maniforge.dhcp.thefacebook.com>
References: <20220922204138.153146-1-corbet@lwn.net>
 <20220922204138.153146-2-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922204138.153146-2-corbet@lwn.net>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 02:41:32PM -0600, Jonathan Corbet wrote:
> ...otherwise Sphinx won't cooperate when trying to list it explicitly in
> the top-level index.rst file
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Should the commit summary title say:

docs: promote the title of process/index.rst

In other words, s/html/rst

Otherwise:

Reviewed-by: David Vernet <void@manifault.com>

> ---
>  Documentation/process/index.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
> index 2ba2a1582bbe..d4b6217472b0 100644
> --- a/Documentation/process/index.rst
> +++ b/Documentation/process/index.rst
> @@ -5,6 +5,7 @@
>  
>  .. _process_index:
>  
> +=============================================
>  Working with the kernel development community
>  =============================================
>  
> -- 
> 2.37.2
> 
