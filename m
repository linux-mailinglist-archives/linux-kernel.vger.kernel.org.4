Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08923639393
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 04:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiKZDJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 22:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiKZDJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 22:09:08 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC2C4219C;
        Fri, 25 Nov 2022 19:09:07 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id md8so932491pjb.4;
        Fri, 25 Nov 2022 19:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jm7SkMwJcW69v3DJrnuWVfW9s2kOEhPZwY/ZWH70rQw=;
        b=gBAL6WyH7nqXR/MJyG/bs8HzFdnr2mssjLcYWUSeSccbRxiGgH1JQxcwpbslaqN4lf
         Km+gkJa3NFi6e7HOHDkzxdp/3JAzQVjbI6T/yO6WgNGU3nM1vIOzlSYcI01H1LvildB0
         ytDXtw+WWqS8ybJmQRn21bOfiRlrfWNR1RD7iUns6TkywD7+HmTY3OHIuDwwU34n2nyJ
         m4jqASc+zQ6XzR+lPza6vJYRVv3zkHhNHEsaOt7IRpVADux0w4O9EkCno0SV1WC2JUi+
         YXQdwQD/ydW/v/VvIoXyKY4d9JU3Z6ZHaZQ9MuiktJ09RoA0X+rdq0//grHPsB+jNhWN
         OPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jm7SkMwJcW69v3DJrnuWVfW9s2kOEhPZwY/ZWH70rQw=;
        b=yFMdsZcECjTyTINdk/VPZ66xKXHi3PvbkMLfNrnodGVXFHg8JepqaajeLDDOGNB2Fw
         ++1D2//HXdcJLlYkGNQ6Ad9Qdxwb1V34rAKCJ9WOgQpmZ0sI5Pg5dGG6RLgJR38nR47t
         /DppyEPysg2UCc7g/IRDTgY+VDesajBrMCq1BVZL4GHzpAhUPDXwjxPgZmO0Ve54+XBS
         q5XVnXg51RM2zfxnpkr5xZa2HQY8V2CKAVUJhxa+Mjh2llkZjQqoU72lPzS65UxJVtGc
         zDOk+1DLj3VT4Eo0E7qFB2T6PLQEkjMsQ/BcCgxmsQrdmgghF45DQrY/s00D/OYVlKl/
         XxHQ==
X-Gm-Message-State: ANoB5pkGyFd6tqtOmUGgyHsS/Xn1MLP5Gx3L2Ko2HJTgOF4mRtYfePeJ
        NiV0WOUiE7h9ffOZFLZnqqE=
X-Google-Smtp-Source: AA0mqf5PKM10OAMFR35H/8PnkS7VIf3XWDab2BDtoyb5KviZQcW4W7qZ5KR2BJ8ruQSHa5akAmHTwg==
X-Received: by 2002:a17:90a:7e8a:b0:217:f784:689a with SMTP id j10-20020a17090a7e8a00b00217f784689amr44343289pjl.0.1669432147339;
        Fri, 25 Nov 2022 19:09:07 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id j4-20020a17090276c400b00186b3c3e2dasm4119117plt.155.2022.11.25.19.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 19:09:06 -0800 (PST)
Message-ID: <5689fac5-9ea9-a631-8ed0-a68dbbbe2466@gmail.com>
Date:   Sat, 26 Nov 2022 12:09:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     bagasdotme@gmail.com, frederic@kernel.org, jiangshanlai@gmail.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        mathieu.desnoyers@efficios.com, quic_neeraju@quicinc.com,
        rcu@vger.kernel.org, rostedt@goodmis.org, sfr@canb.auug.org.au,
        Akira Yokosawa <akiyks@gmail.com>
References: <20221124062204.1932-1-thunder.leizhen@huawei.com>
Subject: Re: [PATCH v3] doc: Fix htmldocs build warnings of stallwarn.rst
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20221124062204.1932-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 24 Nov 2022 14:22:03 +0800, Zhen Lei wrote:
> Documentation/RCU/stallwarn.rst:
> 401: WARNING: Literal block expected; none found.
> 428: WARNING: Literal block expected; none found.
> 445: WARNING: Literal block expected; none found.
> 459: WARNING: Literal block expected; none found.
> 468: WARNING: Literal block expected; none found.
> 
> The literal block need to be indented, so add two spaces to each line.
> 
> In addition, ':', which is used as a boundary in the literal block, is
> replaced by '|'.
> 
> Link: https://lore.kernel.org/linux-next/20221123163255.48653674@canb.auug.org.au/
> Fixes: 3d2788ba4573 ("doc: Document CONFIG_RCU_CPU_STALL_CPUTIME=y stall information")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Tested "make htmldocs" on top of -rcu tree's dev.
Resulting stallwarn.html looks much better!

Tested-by: Akira Yokosawa <akiyks@gmail.com>

        Thanks, Akira

> ---
>  Documentation/RCU/stallwarn.rst | 56 ++++++++++++++++++---------------
>  1 file changed, 30 insertions(+), 26 deletions(-)
> 
> v2 --> v3:
> 1. Add "Link:", "Fixes:", "Reported-by:".
> 2. Remove a orphaned pipe (|).
> 3. Change ". ::" to "::"
> 
> v1 --> v2:
> For the case that both colons need to be deleted, change "::" to expanded
> form or partially minimized form.
