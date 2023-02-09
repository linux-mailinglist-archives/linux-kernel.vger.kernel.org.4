Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF284690089
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 07:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjBIGn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 01:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBIGn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 01:43:56 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB06FF1E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 22:43:55 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id v3so695092pfn.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 22:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hs5x5ZXIhdGFgr27gK1Fnt9bHwiJLKk/0eSe/qe4EPs=;
        b=Zh3cJnADwV88ZfVwg11BjlChbhuXKDMUWljHWWwW3PLnA36YyGkK6lKN4cGgNS6s3K
         YiQgKamc9nWJMRtj2rJZf+qd1coYXR9Dy2A/jqnTLQiay+ez9X+L4mp3+Jsoiavqokul
         E7Vli2MqyiPij5nKMCzIBb276Nblog1wB4dLVuCafs/luaj6xOC4necOr5hnNl+XYnmq
         3LEDlHNxOOj9c9+BrRWpi1kUP3abXVz8IiS+st9D5QVkWTyhCfet5HJSBV8uI7bxUmH8
         93XjwLO1lWr9xuD3R6K7CyTccqG7UlTBbeQ6GcAASIE0SvxEG5gaPgRaFOz+5G1bqul9
         iWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hs5x5ZXIhdGFgr27gK1Fnt9bHwiJLKk/0eSe/qe4EPs=;
        b=5sqE6S4GLBzFHr2yOlvdC4bOVBNu4b35lJKUXGIeUPfMSNwzLurvjQFhjqH4I/uc7l
         XCDXxGaCte2c84dkBga5w66TmTvsJs6l0z4xbqQaZcYwDeuFa2MN4bN0118qPpkLBkup
         joxc4giT6XRYtPZfJBIuwstJPbH5BcIiYFdOaxURSR6Ka57dPEoS0xYW+f+ybYCidCze
         BhvPYN9EjJUHwdPkfy2bxVpp6ZpPOPk2SzqxFzReEw6nBHY+ktlfbucx/kIdREc8QbXd
         UK2/AhVIzJ/iXOGWaQ4IzqhbhUP07n1oMErgQL9BSkKG5BGmi+qh5p2ZQB+aqgyNJaSr
         y71w==
X-Gm-Message-State: AO0yUKVxH2siMbvcpp9sBda9DRh5wFmrSZrN8yShttQmmutENbX5TPBW
        hvb/B2qlPMnZXTdOUpMq7YU=
X-Google-Smtp-Source: AK7set/bLwfODp+rXdNMQ//IstT8odfHG6zlIr7tAOavPqRnwJ9VKzxmO7BmI6As6KbbwsnxbnlCZA==
X-Received: by 2002:a62:19d0:0:b0:5a8:455a:694f with SMTP id 199-20020a6219d0000000b005a8455a694fmr4222900pfz.4.1675925034750;
        Wed, 08 Feb 2023 22:43:54 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id x47-20020a056a000bef00b005a817ff3903sm582401pfu.3.2023.02.08.22.43.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Feb 2023 22:43:54 -0800 (PST)
Date:   Thu, 9 Feb 2023 14:49:38 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     xiang@kernel.org, chao@kernel.org, jefflexu@linux.alibaba.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        huyue2@coolpad.com, zhangwen@coolpad.com
Subject: Re: [PATCH] MAINTAINERS: erofs: Add
 Documentation/ABI/testing/sysfs-fs-erofs
Message-ID: <20230209144938.0000408a.zbestahu@gmail.com>
In-Reply-To: <20230209052013.34952-1-frank.li@vivo.com>
References: <20230209052013.34952-1-frank.li@vivo.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Feb 2023 13:20:13 +0800
Yangtao Li <frank.li@vivo.com> wrote:

> Add this doc to the erofs maintainers entry.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d0485b58b9d9..7d50e5df4508 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7745,6 +7745,7 @@ R:	Jeffle Xu <jefflexu@linux.alibaba.com>
>  L:	linux-erofs@lists.ozlabs.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
> +F:	Documentation/ABI/testing/sysfs-fs-erofs
>  F:	Documentation/filesystems/erofs.rst
>  F:	fs/erofs/
>  F:	include/trace/events/erofs.h

