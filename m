Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1656D5E874C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 04:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbiIXCNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 22:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbiIXCNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 22:13:46 -0400
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE2F1231F2;
        Fri, 23 Sep 2022 19:13:45 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id c6so1056592qvn.6;
        Fri, 23 Sep 2022 19:13:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EJ0UxbFCVIfpffHsja1GLbRJlGvrIDBnMxTmnSMfYtc=;
        b=fl/cBJImROv0/PFE8ZsGVW9m9Qy5LDLvErSLe/ED1cWFot767KlJoQAXoopSIeOOAL
         CB/DMGdkcY7vBO0pr02vKx3sMabG0eeCfpjilqKpze7QFdkRPKwGoAxzK5p6pW7XzN3a
         sJNC636SMOKLoz78IMNkMIAI0udImoiSclffU+/xhXEL8UZpepBsny+qdMCFEv1ymhso
         SvKS69YYFx0OjezmF+HaP2I/3w5cOAlU4boxfss9f+vilMeFq2Y3p4Qn5ZlgJUk4umSz
         TZRTkhhSelKs4fjSncrvlkJL3LEiLbVn8T9lL42CD0CJtBjgdWHbV3IywLHJZCzRK1km
         NKLA==
X-Gm-Message-State: ACrzQf2zerB4FJfM9OW4CV+bPVTY+FR+3G1Fa4olN9JdHhzYLIHf7Fpe
        TGnePgDfSxr4zn6kg0plpV8=
X-Google-Smtp-Source: AMsMyM5U5yKIcwipkJ2I/Q25vVCnXjJCQniG+8kI9hj5iN/PcvdB8JvSTB0395lD+lHFAVUi3Fr3dg==
X-Received: by 2002:a0c:f445:0:b0:4a6:9f4a:9a66 with SMTP id h5-20020a0cf445000000b004a69f4a9a66mr9431935qvm.65.1663985624407;
        Fri, 23 Sep 2022 19:13:44 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::2c58])
        by smtp.gmail.com with ESMTPSA id l3-20020a05620a28c300b006b872b606b1sm7341071qkp.128.2022.09.23.19.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 19:13:44 -0700 (PDT)
Date:   Fri, 23 Sep 2022 21:13:45 -0500
From:   David Vernet <void@manifault.com>
To:     Jonathan Corbet <corbet@lwn.net>, R@dhcp.thefacebook.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v2 3/7] docs: reconfigure the HTML left column
Message-ID: <Yy5n2RzDNvUC6DmH@maniforge.dhcp.thefacebook.com>
References: <20220922204138.153146-1-corbet@lwn.net>
 <20220922204138.153146-4-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922204138.153146-4-corbet@lwn.net>
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

On Thu, Sep 22, 2022 at 02:41:34PM -0600, Jonathan Corbet wrote:
> Use the html_sidebars directive to get a more useful set of links in the
> left column.
> 
> Unfortunately, this is a no-op with the default RTD theme, but others
> observe it.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Reviewed-by: David Vernet <void@manifault.com>

> ---
>  Documentation/conf.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index 78dd6d1e7b88..22c9d4df1967 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -370,7 +370,8 @@ html_static_path = ['sphinx-static']
>  html_use_smartypants = False
>  
>  # Custom sidebar templates, maps document names to template names.
> -#html_sidebars = {}
> +# Note that the RTD theme ignores this

nit: Should this comment end in a period to match the format used in the
rest of the file?

> +html_sidebars = { '**': ['searchbox.html', 'localtoc.html', 'sourcelink.html']}
>  
>  # Additional templates that should be rendered to pages, maps page names to
>  # template names.
> -- 
> 2.37.2
> 
