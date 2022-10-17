Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40959601632
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 20:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiJQSYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 14:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiJQSYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 14:24:07 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1604366862
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 11:24:06 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-345528ceb87so115526077b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 11:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JkUI5JssnCLk+wBNiz00ckkGRif8NZmGGTgkXS2hWkQ=;
        b=lOU3R9v32wfppt01SdcRZ+nDOrOqv6FVKXkeODmFdFUXPexNSX2FBb4dBHnZcpBvHf
         tm66sh3zXeoKAos3Hny8IyXjXoOuw0IP+b9cnY4Iwv7jz5ElB/l/LHCdyDkevH3fnlsc
         nHEIhPn9PhMfygrC7ecOJuDBtAxxTIKaMRhMzkfbQ5mQqJUg95eizFmrWRf37SoCGcr0
         Td3rZ+ks2NPUpzx1H3kSbkV8wwDr/fZaNludoxIkFbQGeC1V9++9qJTMl5ufN2JLWON7
         7ZpDJjuCVANDUIdSLsuYtJLhst/v+/UjW+fi8GLTXuEvKLfu7QnTXoNJUnGFOoqR97B7
         H/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JkUI5JssnCLk+wBNiz00ckkGRif8NZmGGTgkXS2hWkQ=;
        b=obUpVYtKCP83E6wwmdnsW5rdajTaarzGM3lzO6AO4PNCZ5caka9oLJZYUsxO7EqMME
         v56gTIYH3Amm/3s7VK2aCSYidRTkj1vtS6aiG7L8FiYSDB47tgQSmj0bzK2AWzlWNSzB
         6vy879r+iK5Xzwy4EX7L0nGXjD8Cp2Mv3sSJm8kMgTXorkHpYKxMC40Qe/6XpbAZ0gtL
         NomP6N29D4X9uPjx9ikFTLQWs7vYQCAxAe3YDV3itpiJWEOZrJSziE5g8Y6U/6wEaZ+2
         9alUwdCVhviu6nwN8vN2o8a9VDYa9s/+5oZt75LwtTUz8whWXu9Rh5xXzAxFhCwlQUOO
         OmBA==
X-Gm-Message-State: ACrzQf04UceoO8hlb1mvE5QtuV6tCzcAIxJ/6hTrOgC171CcjuRhiUq/
        4lmj0BYC08uo5h6cUaADpcKEzBa58o4vn9sIjRIa
X-Google-Smtp-Source: AMsMyM4fhE0gIaR2IZvhXus6XhO+02VAVMEO7i7RT2XMKKg1YosP0uGFCSiMSTY8dDG9aX9RimKMVmqCwT2wbrHSSGE=
X-Received: by 2002:a0d:ebc1:0:b0:360:5a77:4d78 with SMTP id
 u184-20020a0debc1000000b003605a774d78mr10235224ywe.336.1666031045245; Mon, 17
 Oct 2022 11:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220927225944.2254360-1-ankur.a.arora@oracle.com>
 <20220927225944.2254360-2-ankur.a.arora@oracle.com> <CAHC9VhRZzU5-+65AFOK826rA0xo-nbgRK_pP05Q_zjvAQvLnRw@mail.gmail.com>
In-Reply-To: <CAHC9VhRZzU5-+65AFOK826rA0xo-nbgRK_pP05Q_zjvAQvLnRw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 17 Oct 2022 14:23:54 -0400
Message-ID: <CAHC9VhSf-HxoakRE3EU7VMpp7=6X=dvO+bRVnq0gg-mfrn5utA@mail.gmail.com>
Subject: Re: [PATCH 1/3] audit: cache ctx->major in audit_filter_syscall()
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-audit@redhat.com, eparis@redhat.com,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 6:03 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Sep 27, 2022 at 6:59 PM Ankur Arora <ankur.a.arora@oracle.com> wrote:
> >
> > ctx->major contains the current syscall number. This is, of course, a
> > constant for the duration of the syscall. Unfortunately, GCC's alias
> > analysis cannot prove that it is not modified via a pointer in the
> > audit_filter_syscall() loop, and so always loads it from memory.
> >
> > ...
> >
> > Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> > ---
> >  kernel/auditsc.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
>
> This looks pretty trivial to me, but it's too late in the current -rc
> cycle for this to be merged, I'll queue it up for after the upcoming
> merge window closes.  Thanks.

I just merged this into audit/next, thanks again!

-- 
paul-moore.com
