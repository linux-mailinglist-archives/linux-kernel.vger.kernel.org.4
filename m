Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EF1714734
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 11:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjE2JmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 05:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjE2JmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 05:42:00 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F978E
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 02:41:58 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64d24136663so2090834b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 02:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685353318; x=1687945318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZwleT5IqdSnB0eE2Q5xce5TQ8K2d57jgpMbOyCxpLY=;
        b=IZtVbX4jJlsx2tmnt54Epk31v5BBQwPiFTdN9jPbJqFgiheK7o7BqixtGfVKh5L8lZ
         delKKE0URJsJCw/66VjLngG7R8DseCH2uikm69RT4MLiLnvqvufuTn8f5Oil+FAnG9uh
         cMruROIze+0Dx3IX8nf+VR1gh9BfQtEOgZERBJnONb5yr+IB1X/9KzOQd04zc0o9ZcAm
         DjeddI+Axw0Hfn+uDJQEONKpPQm8QQrEnntY2i0DLRt3sQMahP1En/rJaxRhRk832cv2
         hB+KmSTrHMu04C+K39Axd6JeTUo9mqt/Aemsgj+lswOf0vfmanlHsmn3Ya2UuuUqy9ed
         7lvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685353318; x=1687945318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZwleT5IqdSnB0eE2Q5xce5TQ8K2d57jgpMbOyCxpLY=;
        b=hb/Zr2aqhWoukLTPbuzdaeoIJvTmnITh5eM0Ynkuna4Zc3fItSstitvqbmCul8mQ9S
         da0Zi2+UKFPcalMkjLEIThp4gTdmKZLa1Z7rDWA1C2Hke+TcB6NsqDee7kCxT0x9N5Ya
         8tRopJggXK6EulIbbLXYIFkPEngWUpfsbL73TAuR5kqsI9M0KxYc6E8re4S/EJ47Kq6D
         wY0VPi7kGlQWJhNMebW96lQF0QnznZRomc1aIJi9ekOc4zkkjtO5FQ9zsO1fctnoWWxq
         sUgHE3CuC451KZV4QXlHoFn/GmUMXqHuysCZeqEeRAvnKibNwDXt+FJWOWoEuQ4zScaJ
         v6rQ==
X-Gm-Message-State: AC+VfDxYrlAak4Y+HbdY/IptMU/p9qvypCzRg+xeuFEstjHmmQL3/L7k
        DfeI6MZCcL1/IjWjqCdNAUg=
X-Google-Smtp-Source: ACHHUZ6EsnTgielr6QKFKeMl27FoI7NJAsi6CJKjqr8Sk97EEcee4809r0MkYypHO0LnY2+MTaYQvQ==
X-Received: by 2002:a05:6a20:4306:b0:10b:2ba5:ca66 with SMTP id h6-20020a056a20430600b0010b2ba5ca66mr8726828pzk.20.1685353318327;
        Mon, 29 May 2023 02:41:58 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id i14-20020aa787ce000000b0063b8ce0e860sm6430131pfo.21.2023.05.29.02.41.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 May 2023 02:41:58 -0700 (PDT)
Date:   Mon, 29 May 2023 17:50:07 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        huyue2@coolpad.com, zhangwen@coolpad.com
Subject: Re: [PATCH 0/6] erofs: random cleanups and fixes
Message-ID: <20230529175007.000007c6.zbestahu@gmail.com>
In-Reply-To: <20230526201459.128169-1-hsiangkao@linux.alibaba.com>
References: <20230526201459.128169-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 May 2023 04:14:53 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Hi folks,
> 
> These are some cleanups and fixes for the compressed part I'd like to
> aim for the next cycle. I will send several versions if there are more
> patches available.  This ongoing cleanup work are also for later folio
> adaption.
> 
> I've set up a stress test for this patchset at the same time.
> 
> Thanks,
> Gao Xiang
> 
> Gao Xiang (6):
>   erofs: allocate extra bvec pages directly instead of retrying
>   erofs: avoid on-stack pagepool directly passed by arguments
>   erofs: kill hooked chains to avoid loops on deduplicated compressed
>     images
>   erofs: adapt managed inode operations into folios
>   erofs: use struct lockref to replace handcrafted approach
>   erofs: use poison pointer to replace the hard-coded address
> 
>  fs/erofs/internal.h |  41 +-------
>  fs/erofs/super.c    |  62 ------------
>  fs/erofs/utils.c    |  87 ++++++++--------
>  fs/erofs/zdata.c    | 238 ++++++++++++++++++++------------------------
>  4 files changed, 156 insertions(+), 272 deletions(-)
> 

Reviewed-by: Yue Hu <huyue2@coolpad.com>
