Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3FD6D4031
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjDCJWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjDCJWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:22:10 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E987BE3A0
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 02:21:44 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so19349809wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 02:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680513701;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UnQuvwF/ZhX13io7inQEeewhfhVgW08UzcPve6QHtQ=;
        b=Vzgr4GWWLdpJJaFC0qzHyQbHh8wW45sk0zIxUaOXaa8uztapv3s61v9/BadBdre+FN
         sHzv4+NkQDqi0wVNMn3vgo8gBk46rU57fBcqHdwRp8TsR0s3kNXEYHSSawPBt+EKNA2V
         2X88G/XT3wHdcvodEjq/06pht3oDnJrAXBpjAunZLAmYFDpSar9wIKGaKzd98cslXqgN
         P67PaTjZDYnxM5ybo5zyz3TTZO9QE/7+kLv4HDyEJn6TGjTXKKSRjpNo8outREs6z6gC
         93/NHrwV/CUpUkF5fU3ehDkAjw7OGRY/1AlsD98aPQwlI3Ph6Qn+KSMEdogImlCRAHb5
         76mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680513701;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3UnQuvwF/ZhX13io7inQEeewhfhVgW08UzcPve6QHtQ=;
        b=YewxDpxF5lRuQLCOSGremg/KfBXdByK4PgMBUDOqQOnyZGKgio7zSVoPv5xMB9RSWc
         u1mdnBJRQKHyRz4Tcp21Pe72lAGCmmrgGDGTJOit0Q3uArvvLsy5bzimUzbA4d3j1onL
         fUQDsTlX6Lz5VlZZDP/bc6CFHj2koa4NP/KqzbvgRQUDhSqoUkC947iH+ENUlaCYUt89
         kFxl2sv9CAbY1PndJKb2uUvkC53+poqgavEFPtZXL9eGKv+pZRo+1in1JWeHTx2BoxUm
         WJ+eY20xvQYY0NoLd2qv5gIODn64txx8BzZ3Tw85M91Tp27laZG2FTMB6HyqL7gdhRtc
         awsQ==
X-Gm-Message-State: AO0yUKXMMK33pv9/RK0l81onc7EChIryK1jxP1exDbxdt/tNpCewf0/6
        tbKuxjwTEy0L1wHeQ7rztqAtFpT0rGY=
X-Google-Smtp-Source: AK7set9DvIAnkA8B0JeMLxvfNRTcgsK1S97Cga6TmS3oDgHl0qqmxkjL7y7L/ZKDvg49UbkBHutmGQ==
X-Received: by 2002:a05:600c:220e:b0:3ee:a205:848f with SMTP id z14-20020a05600c220e00b003eea205848fmr24950314wml.20.1680513700825;
        Mon, 03 Apr 2023 02:21:40 -0700 (PDT)
Received: from ?IPV6:2001:660:3305:123:8aeb:8247:342b:85d5? ([2001:660:3305:123:8aeb:8247:342b:85d5])
        by smtp.gmail.com with ESMTPSA id z7-20020a05600c220700b003f04646838esm10304082wml.39.2023.04.03.02.21.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 02:21:40 -0700 (PDT)
Message-ID: <180269da-a7a3-97be-4e8e-c8b82e33d430@gmail.com>
Date:   Mon, 3 Apr 2023 11:21:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US, fr
To:     linux-kernel@vger.kernel.org
From:   Daniel Diaz <didou.diaz@gmail.com>
Subject: Possible dual license for rbtree ?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux maintainers,

This is a question about a possible dual license for the rbtree 
implementation (lib/rbtree.c).
Please apologize if it is not the right place to ask.
Thank you for personally CC me in the answers/comments posted to the 
list in response to this post.

Looking for an efficient red-black tree implementation in C, I 
discovered the wonderful rbtree utility. I really appreciate the clever 
approach of this « invasive » implementation on the top of which one can 
build his specific maps. I saw this rbtree implementation is famous and 
widely mentioned but its usage is limited by its GPL license.

Could you consider extending this license by a dual license as allowed 
by docs.kernel.org/process/license-rules.html which states the some 
individual files can be provided under a dual license including MIT, 
BSD, etc.

Would then it be possible to release rbtree under a dual license more 
permissive, e.g. MIT ?
Be sure this would be very appreciated by a lot of C programmers !

This comes down to modyfy the SPDX descriptions of lib/rbtree.c and 
include/rbtree.h, include/rbtree_augmented.h, include/rbtree_types.h as 
follows:

     SPDX-License-Identifier: GPL-2.0-or-later OR MIT

Thank you for your attention.

Daniel


