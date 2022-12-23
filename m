Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDBC654FD1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 12:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbiLWLvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 06:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiLWLvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 06:51:11 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41A6D11D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 03:51:10 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 36so3169961pgp.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 03:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sjv/rRvXeISjMwkyg4jOWEP5q4M57HHzk7yPJaOOhtY=;
        b=ZpIa3DS09D5ozTUeEZeNzSvBicRKYBlwZZu7/O2+K5u9TUnLAPK+jYdhX//qFzYKQ1
         lp1K1u18zcUB2k5Wdo5kqOopWseXOCBpZBlMFA+DUQnqx2rwC1rEAiHQGcDYjn0+sFaa
         Lhck/cvE9uuTmcBqo4rW2NyEKmTGYCAM39JOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sjv/rRvXeISjMwkyg4jOWEP5q4M57HHzk7yPJaOOhtY=;
        b=CD+MBfniVZgzeeCgz81bkj8pvxoiZpBXlNmFbvTduaV/9ctjfIlkQzFHIdY16pxeFc
         xxpTaXip6zL2nQ7aqsDysmjU14CVuhFPhH/Te3kTkVN5jpk4go+xol/uK5MH6sx2uLKb
         8K3Y7daQoFKm9LhZQLzVAAczXjdB3qLSt/Zb55msnf9PU4zIUWYx6B9+agaHVr8n1yml
         LYPe1QkFK32cxJPAFckkKHnaAnxsX+dNRltNRvEjtxGsjtwMEJRR4t9VtolevOA0nM5D
         yKHtwOWTldeUAR8Hhe/JBumG4u1LRZDc6YVio71c5wCvZxpzkflvXahulFLSvZpSxPrl
         YQZg==
X-Gm-Message-State: AFqh2kocTUf3fp32QQhwT8RmlsjVERwmKJQoaVbhXgukSAXCLiZ1c1oR
        jvqOTVQHoHU16miOmGvs7Zc94g==
X-Google-Smtp-Source: AMrXdXsPk67PjFUI8adM5H88BkzcWWRaJBvouYJe9gvxHtQcPi5cLcb9STmHwmKGx7YUo2uB609Uog==
X-Received: by 2002:a05:6a00:1ca7:b0:56d:1bb6:af75 with SMTP id y39-20020a056a001ca700b0056d1bb6af75mr23752646pfw.4.1671796270329;
        Fri, 23 Dec 2022 03:51:10 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id a3-20020a624d03000000b0056ee49d6e95sm2369161pfb.86.2022.12.23.03.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 03:51:09 -0800 (PST)
Date:   Fri, 23 Dec 2022 20:51:05 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     JeongHyeon Lee <jhs2.lee@samsung.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        senozhatsky@chromium.org, minchan@kernel.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: fix typos in comments
Message-ID: <Y6WWKXUEDcq26XEF@google.com>
References: <CGME20221223040335epcas1p45bda0013a3a42f176fa137e0597fd7c9@epcas1p4.samsung.com>
 <20221223040331.4194-1-jhs2.lee@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223040331.4194-1-jhs2.lee@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc-ing Andrew

On (22/12/23 13:03), JeongHyeon Lee wrote:
> - The double `range` is duplicated in comment, remove one.
>  - change `syfs` to `sysfs`
> 
> Signed-off-by: JeongHyeon Lee <jhs2.lee@samsung.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
