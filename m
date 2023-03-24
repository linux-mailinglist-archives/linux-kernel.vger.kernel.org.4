Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211DF6C8950
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 00:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjCXXeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 19:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjCXXen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 19:34:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FF82132
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 16:34:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j11-20020a25230b000000b00b6871c296bdso3180761ybj.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 16:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679700881;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NVqt0f/2DRo4XcbI675kTrDo1clxY/Vi3m7vjYnFwOA=;
        b=aKJeJbAPI2zvDKhOXeemI6Ck070EXJq96VyMniA/gXT6T5xmvuqc94G/eI8xpgXrsr
         mmnfq0asgxQLRWrQaMqIG8nZNZ+6ye/AaHgrfPLktSTurIeZqLky6i5qY4QAwHsj6gy+
         80xLwC+0w4a3acbjCwa5TTEI05tYUjiNO7ssXdEJfIa9o+NJ4cd3XEfElQpSKL8ACCQO
         8mEOPqTIpJsXn7SHM2qEMRw15jlNsQt/4dECNymTtE7bwbTw4kaLdcnb1YkBw1mcOOpv
         oryjp1sXBhlM/E73C0JmWRC1Vn0X4gg5fu0pyyw0iS6AsgdYu0U9n1muictDpnNYqKdI
         hfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679700881;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NVqt0f/2DRo4XcbI675kTrDo1clxY/Vi3m7vjYnFwOA=;
        b=aHLmVi6RRblT33hSRkQxTqkVJ7Pn0MLslgurYq+YwYgWNTG4UMWwk5hqBs0D2oOUsp
         VEWRJ/I+is0DZ9LcRDphWt0AqPUZVf2YQjuvx2XP465ym9tAXZMQTORtjjo/oAkbszFy
         RvjluA/gX3/biD28ZJ27+j5XqWLbxF4edekxhdA4A8lQt4ZZ+4pm6vasU2m1lraHYdnR
         +LzS05PF5Jj+BtGvZkU7JDIlBgk6pgqbJ5DG35qU7WMDSqhyv8ujY68H4IBxN3gIOhF8
         Sfi9/qfX2BbjLQYMaE/QihL7joRFMB7oy35vJHTGKRTFZTTYAQOgYJo+Khi+z4jkKQBb
         Nb8A==
X-Gm-Message-State: AAQBX9d8MIjCXrewl1IgLt//EVbG57U0rjeRhNaZ+g4wX8PlpX5Q3HY8
        NlmZVo3vlW1aW36NHUu/2aqx/1BKQvk=
X-Google-Smtp-Source: AKy350a6CE3UYLppfPzPR79Wj9dtjeq2AmDaaJvl57pOHOK2QDtwYeQk5hmIIjRhWHj9Z2WE449W47oFAKo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:18cd:b0:b74:6c88:7bff with SMTP id
 ck13-20020a05690218cd00b00b746c887bffmr2120917ybb.0.1679700881510; Fri, 24
 Mar 2023 16:34:41 -0700 (PDT)
Date:   Fri, 24 Mar 2023 16:34:40 -0700
In-Reply-To: <20230227174654.94641-1-ackerleytng@google.com>
Mime-Version: 1.0
References: <20230227174654.94641-1-ackerleytng@google.com>
Message-ID: <ZB4zkGyW7gVh9qDa@google.com>
Subject: Re: [PATCH] tools: Copy linux/align.h into tools/
From:   Sean Christopherson <seanjc@google.com>
To:     Ackerley Tng <ackerleytng@google.com>
Cc:     yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023, Ackerley Tng wrote:
> This provides alignment macros for use in selftests.
> 
> Also clean up tools/include/linux/bitmap.h's inline definition of
> IS_ALIGNED().
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  tools/include/linux/align.h  | 15 +++++++++++++++
>  tools/include/linux/bitmap.h |  2 +-
>  2 files changed, 16 insertions(+), 1 deletion(-)
>  create mode 100644 tools/include/linux/align.h

Anyone object to pulling in align.h?  I'd be more than happy to take this through
the KVM tree, which is the motivation/context (we want to use the various macros
in KVM selftests).

Thanks!
