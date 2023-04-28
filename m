Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A76B6F17A7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 14:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjD1MYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 08:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjD1MYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 08:24:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505ADE54;
        Fri, 28 Apr 2023 05:24:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4A4760C25;
        Fri, 28 Apr 2023 12:24:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2EBC433EF;
        Fri, 28 Apr 2023 12:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682684660;
        bh=bJ4kd4DhI0XWEY91KoBUmIja7FGFyv2ovxrLHacsvhU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EjttAvDmLcZc2GIi/5FZLJYLdTppIaJdQIrj2NzUaFToF2L28MefxXkANc45kLJoZ
         MuuIZCqWvO5w1v+F90iFdjXCbd5Nikhi6P19iXMKsoQALbBIFuf1m6ak70hsBV9eeM
         jD2Gsi5uaAkEGPUKPFIJdZaAimeGCpaRPI/Okirvfv8OLfJlcHM3x1ru5ibGMhRHHn
         5gyoydSK6maApOFU/QIc+sqh0Oqa7vOzrUWc6FLeADEfzyEsPmIGbq8CCxZwYVNEDj
         v5NMpiqe3rDGiSBylp+HOx0WMbxIN7Yx0IZdT0PedHy/kKnrDIylhYNNYSAj5S9E//
         sCbNOLG1m6kCg==
Date:   Fri, 28 Apr 2023 13:24:15 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Costa Shulyupin <costa.shul@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] docs: redirect from old arch to the new one
Message-ID: <20230428132415.0d0f5a03@sal.lan>
In-Reply-To: <20230427101241.1273752-1-costa.shul@redhat.com>
References: <20230427101241.1273752-1-costa.shul@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 27 Apr 2023 13:12:39 +0300
Costa Shulyupin <costa.shul@redhat.com> escreveu:

> Due to a recent reorganization of 'CPU Architectures', the links to
> the documentation from external resources were rendered invalid.
> This is a common challenge when attempting to make changes
> while maintaining backward compatibility. To address this issue,
> a commit has been made which uses sphinx extension to seamlessly
> redirect users from the old location of the page to the new one.
> 
> 
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  Documentation/conf.py                 | 8 +++++++-
>  Documentation/sphinx/requirements.txt | 1 +
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index 37314afd1ac8..514bfe6a8166 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -55,7 +55,13 @@ needs_sphinx = '1.7'
>  extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include',
>                'kfigure', 'sphinx.ext.ifconfig', 'automarkup',
>                'maintainers_include', 'sphinx.ext.autosectionlabel',
> -              'kernel_abi', 'kernel_feat']
> +              'kernel_abi', 'kernel_feat',
> +              'sphinx_reredirects',
> +]


Besides Jon's comment, if we add something like this, please make
such extension optional (in a similar way to what we do for 
sphinx.ext.imgmath), as this is only pertinent on websites meant
to provide  the Kernel documentation.

> +
> +redirects = {
> +     "arch.html": "arch/index.html",
> +}

I suspect that maintaining a list of all redirects here can be
painful, as, from time to time, we see documentation churns.

We should likely need some script to check what renames happened
since a previous Kernel version, generating it automatically.

Again, as this is something that only applies to websites hosting
documentation, IMO the best would be to have a separate file
("conf_redirects.py") included on conf.py, that will be
auto-generated by a script that would receive, as input, the
initial Kernel version where redirects should be preserved.

Regards,
Mauro

>  
>  if major >= 3:
>      if (major > 3) or (minor > 0 or patch >= 2):
> diff --git a/Documentation/sphinx/requirements.txt b/Documentation/sphinx/requirements.txt
> index 335b53df35e2..0b067e985edb 100644
> --- a/Documentation/sphinx/requirements.txt
> +++ b/Documentation/sphinx/requirements.txt
> @@ -1,3 +1,4 @@
>  # jinja2>=3.1 is not compatible with Sphinx<4.0
>  jinja2<3.1
>  Sphinx==2.4.4
> +sphinx_reredirects
