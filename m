Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD435696F57
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 22:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbjBNVZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 16:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbjBNVYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:24:44 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEF22CFCF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 13:24:33 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k9-20020a25bec9000000b00944353b6a81so1616205ybm.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 13:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hEcVIMvG9yiLGQ7yL2dMbIxVRJjfiraajEKz9YRnmwc=;
        b=stBFlXGMBpLXEMGP+A5HDLlzOo/VqEEpVRD6dPu2S69FUOW1+jatHj+xAlVNyNgRst
         kZ6S6qtOnvmg9SSeL9feCU/tTFzJienpYNF7eQVZiZzcCIZHtgfv77dEXLWhl9bNi8Ro
         O8I903X3OAgKsrs/jjszGFWemIIz1AbLw6PwlWtHMVcxle6+GST8TmXUx38oRxPUXr9w
         lua7lBjPr2ZP8RllYAQG8otCNkUYolCzfH4/A6DqLRNFWR6bzOODH8nWghUnqP37UUAt
         /bq265eUYxH7yhxqy7qHIraS1jl2UzC4uJWTW3BfAvqsHyCq4y1jgXFbnPZscSAa0hef
         i9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hEcVIMvG9yiLGQ7yL2dMbIxVRJjfiraajEKz9YRnmwc=;
        b=EYTRGJBLagT3phZxuIjtB894XwBaljTrchwsIcat6sV6DQN2SI5JJyeWX7EfzPhc2/
         BonwlVy9Rw/tQ6aSZoXAAPFr6DHkjoQhcYMwcoiju0D3Gk3jIxzFR/ID3OrZc6FfXFvj
         1+g+wLYdF667K5HnfLCMafSTDv/gafoaNEdkmL1ZGTQV0jndccpF7FDEXb7097cbCM4K
         KBDCbjYuO60gIN59CRe2NBabl2CMXtDMqbaxsP2Apn43uj56AZwgiILIhXKS7Jz2BMbh
         7IK3+EiptmlSlEK5f6HE0cIEKGu+ebY5fNY6GEjUD9D2onrZN9PY/Lw7b4La1y8T3jhC
         /lYQ==
X-Gm-Message-State: AO0yUKX04RhlNBROYWxKcSv04TvMuaMNAFARh7YR8LQk2LSWWYJuksCi
        wYpiP4Kkleg1d3qFcSWUW3hZlsl8GGp/358U
X-Google-Smtp-Source: AK7set/S5jWby/Wn6YLGRxTgowQe+yYBkLF/u4giGyVur6aeQCzfkY36ZoyctyfxI8gIR+cqgZccLmAtuzw69fbx
X-Received: from zenghuchen.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2448])
 (user=zenghuchen job=sendgmr) by 2002:a5b:381:0:b0:8f2:bff4:f074 with SMTP id
 k1-20020a5b0381000000b008f2bff4f074mr9162ybp.190.1676409872359; Tue, 14 Feb
 2023 13:24:32 -0800 (PST)
Date:   Tue, 14 Feb 2023 16:24:29 -0500
In-Reply-To: <202302141029.2CS1z9de-lkp@intel.com>
Mime-Version: 1.0
References: <202302141029.2CS1z9de-lkp@intel.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230214212429.1157315-1-zenghuchen@google.com>
Subject: Re: Re: [PATCH] i3c: update dw-i3c-master i3c_clk_cfg function
From:   Jack Chen <zenghuchen@google.com>
To:     lkp@intel.com
Cc:     alexandre.belloni@bootlin.com, jesussanp@google.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        markslevinsky@google.com, oe-kbuild-all@lists.linux.dev,
        zenghuchen@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Intel kernel test robot. This patch was meant for i3c tree.
And I have submitted a new V2 patch which replaced max with max_t to do the type cast.
