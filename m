Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2A75EFC34
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 19:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbiI2Rr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 13:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiI2Rry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 13:47:54 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881A2124C29;
        Thu, 29 Sep 2022 10:47:53 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id y141so1487585iof.5;
        Thu, 29 Sep 2022 10:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=OVAyLeF6DJrdPMl8lO8/3ceKBXeaxoIFS3xspldS0TM=;
        b=C/7go5NDsFKL/DnUezcDKoVWApyTQiix2F6aELlMHKn52xNzUURuMScVFEJIEYqNUS
         he62deuQZZsDJHVmKfMZ8Rjtd0uFCNM8XU1UtnTVD7Oa0KRs2u0k4MDBmKhNFhn8XO7Z
         sk5yM3dD7XeLEZrgEumgEuuTaLd6z8Ns88cfRbIecOXORHaqGsll19trK1L9sD78YLmL
         33s7NJfur0+9Mia/MsINHEMMLHEHhBilmmvfWuko4lLBjT5svvW3tsiy0vN67UpopGCv
         Qm/JsoBJvFf5ya2eAvH256az20TL8sWOuzPJTft6HRHr1t3n84ny7JpNzslTbz7mk4Jv
         ZAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=OVAyLeF6DJrdPMl8lO8/3ceKBXeaxoIFS3xspldS0TM=;
        b=ZTMgHIrZgVNgK5irUbcAvJw4LNgwCuE9hfSLhE/ql8Xeq1Kt1IU9zyKbbA4bVyyGUA
         OrV85XLmNRr3zRKGnaL+Ew5dCWaUSLDKuDr41qGLZllfAjr8A4RzRDwD8SxuHH4qgCE3
         04SeDWjHKqGilqzo/ktz9JpyEAwT/5qHhNewm4uVB6arrUSHFTR0OMDWPHpqytfqXE6c
         bZcWfFon2+0r78XIiL3HnrIRE7t6PgFKNRy8/fIIG8+oBGWoGJz/mDpDAScfGB4Qi0Jg
         /uf1wbLzHFf/Mi8Xhq/kk2yCoE4BVliWe8mmr6BGk7QWtwBGM42h3tmk9sQzqTV8xb8j
         JM4A==
X-Gm-Message-State: ACrzQf2vKZDjhHXAoBK1Aszse2KOQHTlS8b0F+dJClk834sD46i+9JT+
        yehvnfVI2hByieIUpnJC82uc0w4rmZ0td5UmE1k=
X-Google-Smtp-Source: AMsMyM7/CRJjv0FsTuplXs0rud/FmD6TX8EVa7AISbaNmf7fPPqX7lkc/+PwWTvAVWuwal2uBLgdmhk0sDoKWOB8lR0=
X-Received: by 2002:a05:6602:1509:b0:69b:35ba:4720 with SMTP id
 g9-20020a056602150900b0069b35ba4720mr2035091iow.155.1664473672968; Thu, 29
 Sep 2022 10:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220927160559.97154-1-corbet@lwn.net> <87mtaii491.fsf@meer.lwn.net>
In-Reply-To: <87mtaii491.fsf@meer.lwn.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 29 Sep 2022 19:47:41 +0200
Message-ID: <CANiq72mWEeg-xiZA0JSKMNqsONQT+Y7HHReix=BoXgHq+BzOmA@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Rewrite the top-level index.rst
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        David Vernet <void@manifault.com>,
        Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 5:34 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> So I think I'll go ahead and drop this into docs-next shortly.  Thanks
> to everybody who has commented.
>
> This, of course, has the potential to create conflicts with other 6.1
> work that touches Documentation/index.rst.  Amazingly, as far as I can
> tell, there is only one linux-next commit touching that file - the
> addition of the Rust docs.  We'll want to be sure that doesn't get lost
> during the merge window.  I'll be sure to include a suitable heads-up in
> my pull request.

Thanks for the Cc -- I had not seen the series yet, but it looks way better!

Cheers,
Miguel
