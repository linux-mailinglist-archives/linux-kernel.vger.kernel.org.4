Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9892968B3B5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 02:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjBFBUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 20:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjBFBUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 20:20:22 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E801716F
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 17:20:20 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id r8so10598653pls.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 17:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPaIaDTpiZnSt1wjJurYQXRLG6/rtxljaG75dz1yn+Y=;
        b=XZelh4mntu6EgzfRSEYgaThUVQAQr44uPQzXztYXf3DyMZSJDEtZRM+saOb8NlYdM7
         r+qQIeOGyOo1Lt+Zqc5gjNK7f3BRjcXXJXH15neUe5lyMLzDCLbIelZmWKDVEBUNliLR
         lYvg873e4STTTbx52pfo1vLzXFeGbbfONXcAdGs1jt/jHv9qTR+LP2itFHnFI65nAzpi
         HTqa0RCcB9wvCfbUO7YU8sdnn5pI8Dxh8lwKZ2CkBN3E5Bw5ZLJiZ1y7WSKAN3eqVkPz
         a8qABQvsekqu3iwQHUQQW2BAnxoyzAIW+iYirS2EeC1qj2xhs23Fm/oi5fKixYVdHZmj
         GziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPaIaDTpiZnSt1wjJurYQXRLG6/rtxljaG75dz1yn+Y=;
        b=6FH9V+3mVZYrEKB/bVHtgx/bUuda1HSTvvYqUv2mJRM0URo67JTm6GKi+kiCV+e3uZ
         2ekjl7RjpJK+2FrS1TYKYveFPZuuOgz2W1TCy2Zyc3+WCDKFl05SeeIDaSHCSzttTdXO
         crzYJyVeRDqs+t+8amHAkJmHUMPNK+aKOKNHz8o9ET4BMeJ8w3pJOn+2uut4QXgdEF1W
         knET5Xc15c93P+zKZntYcMCYXYi7Ks/f2e0DEzoRtMGDAQa4UNmXkdJfO49lAXHihnNl
         t44A9UWvqmZBr6KHhlVVnkPGaWa7aRjQsId1KkDoFJ4mVJkrIoRdLwMJyuUzeCr0P/XF
         4TQQ==
X-Gm-Message-State: AO0yUKWXrqWcxbbsv3ZKdo2rhvYxeBy6b8wAnBhTGUXVmuaa9HjKPQzH
        SOdxT3mvIgYSHFoz1qawqhvBQnB9dUQ=
X-Google-Smtp-Source: AK7set9/HPDdL+PIdw4nlH3G0SSgKQgrmMsrUDuXM0Iz+pxkCtCT55/WsoNAmyifKqhRD0M1UBl+Xw==
X-Received: by 2002:a17:90b:3881:b0:230:af67:b847 with SMTP id mu1-20020a17090b388100b00230af67b847mr3129279pjb.31.1675646420024;
        Sun, 05 Feb 2023 17:20:20 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id f3-20020a17090a8e8300b0022c08b63564sm5144670pjo.52.2023.02.05.17.20.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Feb 2023 17:20:19 -0800 (PST)
Date:   Mon, 6 Feb 2023 09:26:00 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>, huyue2@coolpad.com,
        zhangwen@coolpad.com
Subject: Re: [PATCH 5/6] erofs: get rid of z_erofs_do_map_blocks() forward
 declaration
Message-ID: <20230206092600.00003c68.zbestahu@gmail.com>
In-Reply-To: <20230204093040.97967-5-hsiangkao@linux.alibaba.com>
References: <20230204093040.97967-1-hsiangkao@linux.alibaba.com>
        <20230204093040.97967-5-hsiangkao@linux.alibaba.com>
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

On Sat,  4 Feb 2023 17:30:39 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> The code can be neater without forward declarations.  Let's
> get rid of z_erofs_do_map_blocks() forward declaration.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
