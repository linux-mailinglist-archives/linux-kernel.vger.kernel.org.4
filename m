Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDAA622F88
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbiKIP7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiKIP7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:59:24 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CC31AF0F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 07:59:20 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id kt23so47843259ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 07:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kMpz0htQ7/MGd5vuDayKM00Lvv56YDt4hT+zhs8g2Ss=;
        b=DxPii1rwpWX2KNM5w6aU83V4P3pvCEWJ+OmIRRU67Ed9ghnzy/dQxWPypq6nc8KYq2
         7z7ReF/5u/9goEHI9sjm6aqEfwD3Dm0+URnSHRERstVHqeWod2vS+lnqtEkfyWsAZKtk
         RbTK7hh0N0Re5P+xD3+fdpgA9OnxaGC2bHWncjxstBmqbtuEI1xxQ2WvdJ9Nde5cdEed
         OBTx0QZTjNsnnXcrsODJBHWQn5QAwF32qdWc5/k9Garax/RG6gxVZ/Irrcj3nPj4nBFR
         aUy7nvaFnOg+YVvqk+UtIGsHLPWWKo4Fup4GJZ7ULRJOzKiMKf68sAaaeC+jplrU44PQ
         LKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kMpz0htQ7/MGd5vuDayKM00Lvv56YDt4hT+zhs8g2Ss=;
        b=jzYhNzyhcKQmSXtBohpPrA8TnuSDlTqLlmLaAVgKJMyGKC015d5QtMFjUHGY4qd3wj
         iJ676Keq6B8c/awaXaleF0kqEeDJYuHn96WjnwywDZMYlUgdj1NDXWDkEbP8i7bQgsv1
         QCSp45gZl31HDcjgIbLhxlVfYYBz5IV5wkGuBw+1aTknJVAu5htMG9qchc9xtP6t+6A8
         vcnvg0kgtbfrkIc0DMlimPEBVvAfWsuw57drzmEBM86Hy40e2E+84Y9fpx9bIVQWh5QY
         obceySUxtp6R7yhLAorQwi+5ZEIf+15tCoLzfmFgJkU5sy8FLMtZm1VtWh7tICGLMeTs
         FnRg==
X-Gm-Message-State: ACrzQf0xjGoG2KRL0grgKAWqbysuomKIL2puz8Fr+G0L75B68Hj9WLA8
        Rc0yKma0026mowXBoD0HPksk+KDaVH9YuAxgnBmUFA==
X-Google-Smtp-Source: AMsMyM6KcsdIruaq2XMS8h3WG9IGI3ifDSKwPpa34n/XxwnANIIvZR1obFMCRGMiLLfgo0+LTXJDaGAweOynKOsEtMc=
X-Received: by 2002:a17:906:7048:b0:7ae:db2:f10a with SMTP id
 r8-20020a170906704800b007ae0db2f10amr1136400ejj.709.1668009558671; Wed, 09
 Nov 2022 07:59:18 -0800 (PST)
MIME-Version: 1.0
References: <20221107201317.324457-1-jannh@google.com> <3e2f7e2cb4f6451a9ef5d0fb9e1f6080@AcuMS.aculab.com>
 <CAG48ez3AGh-R+deQMbNPt6PCQazOz8a96skW+qP3_HmUaANmmQ@mail.gmail.com>
 <d88999d8e9ec486bb1a0f75911457985@AcuMS.aculab.com> <CAG48ez3UO03RRMxxj-ZAcw5vhjhPYeoN1DB82s2SAiYm-qWmYw@mail.gmail.com>
In-Reply-To: <CAG48ez3UO03RRMxxj-ZAcw5vhjhPYeoN1DB82s2SAiYm-qWmYw@mail.gmail.com>
From:   Seth Jenkins <sethjenkins@google.com>
Date:   Wed, 9 Nov 2022 10:59:07 -0500
Message-ID: <CALxfFW4RQmLf9QRdP8VUH0fZU_vUsCqXfxRtjeu6g7QvKAGOmQ@mail.gmail.com>
Subject: Re: [PATCH] exit: Put an upper limit on how often we can oops
To:     Jann Horn <jannh@google.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Kees Cook <keescook@chromium.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'll add to this by noting that it is highly oops dependent. Depending
on what locks and refcounts you had taken at the moment you oops'd, it
may not be possible to clean up the process e.g. if you're holding
your own mmap lock at the moment you oops you're liable to deadlock in
__mmput. But there are certainly empirical cases (not all too isolated
ones) where the kernel really *is* able to clean up the entire
process.
