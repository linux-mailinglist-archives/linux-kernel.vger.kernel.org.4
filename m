Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0EB668F4E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 08:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238371AbjAMHev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 02:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241132AbjAMHdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 02:33:38 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7085E0A7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:33:29 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id q23-20020a17090a065700b002290913a521so3917442pje.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nr9ttpCswQ8apK4LORys5AV0ucvWwQG6uR6ZGlqUXNE=;
        b=ZaZpq1+TqvEhnzNB+8vjM+ioiypsU6kNEm2B4sZu5m4I/FfpmhpeZKjGDIc0rf20dV
         TMxLPUfBj/rx+f0sY+bBUucR4utaR2joBUiwUYebs3nmKq9d+BzcEFusCvCL91Ct/zUY
         /ibkI3Du7ENktVdC9p89vVcvbwtDzUVtJj3sHX+SUW10/yV21f1UQSfullUBhb5Ta102
         hNTjUAkokw6K0WUUa7GWz7NlJS2scqhupilR/U/Ep8CB0LRhQEq2b42LK937+GEgnGny
         8eTWRWEWxAIRR0AehG7nUxYQ7wd5m+1ZRUC7jxm90ezKCBqhCyN4uX5+pyRajozfB6LT
         mqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nr9ttpCswQ8apK4LORys5AV0ucvWwQG6uR6ZGlqUXNE=;
        b=4tY9uTYCLTp8qj9b85EUwpoiaFtHi0FeIuwUgMr3YM3XiYIwN8dTGLt6GAlvVjYx0W
         cQOGv+fyhmUPGtqCd8sZDh/AdCv9SGy2f5YBe2vGzgVKQcxa3CIJlCQx+lprPGQrn5P0
         6zYQpvvNzvxDg6ldUqjxwbhAHsuuLUtzRO244NQhx1oxaFoFeBpQu8LHVfjpOQg7IDu4
         TazLASQi5xxwyPNF1g1AEMJLRDvWnsRGq+0WMbfDPuh9t8Pm5iSjFsG/cXU6SzMgAZhx
         Ebqmf+gUblUjDZbalJRlQT48nSkXv5Nm6fUA7vkj2ogfnX1mEslbH1y6KdYTFJU7Z1Ua
         BDUQ==
X-Gm-Message-State: AFqh2kr8EaSJg5g0WFACXHVCqt3QZqiT4Nj/e3micSOV7rVIfcRDZFBY
        WeG2AQBpgFp6X3seumEHBY/DfBeqvxc=
X-Google-Smtp-Source: AMrXdXvoqzdRZaceDiXenPxlxL4X9EMeMiqX40DcrvohhA3eh2BRUaEnCw4OHU8SPiqJtDZKuhZhQA==
X-Received: by 2002:a17:902:9898:b0:193:1aa5:573 with SMTP id s24-20020a170902989800b001931aa50573mr9544335plp.13.1673595209200;
        Thu, 12 Jan 2023 23:33:29 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id jd9-20020a170903260900b00186727e5f5csm13367492plb.248.2023.01.12.23.33.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jan 2023 23:33:29 -0800 (PST)
Date:   Fri, 13 Jan 2023 15:38:39 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com
Subject: Re: [PATCH 1/2] erofs: clean up erofs_iget()
Message-ID: <20230113153839.000057d0.zbestahu@gmail.com>
In-Reply-To: <20230113065226.68801-1-hsiangkao@linux.alibaba.com>
References: <20230113065226.68801-1-hsiangkao@linux.alibaba.com>
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

On Fri, 13 Jan 2023 14:52:25 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Move inode hash function into inode.c and simplify erofs_iget().
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

