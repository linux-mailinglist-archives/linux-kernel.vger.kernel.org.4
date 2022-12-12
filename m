Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D116264A4B4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 17:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbiLLQXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 11:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbiLLQXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 11:23:46 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BDDB487
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 08:23:44 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id f18so12641847wrj.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 08:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=skttEob0n5ms3kMAByFrLQW3zkqp/+QIY0dBc1aa3Lk=;
        b=hjm9ApF88/H+7K+4UfJDqo9B0Z51C8ij1q3pJrAIPs0mL0VU1iqqDoIzuWQvRQp888
         MGP7eBjUSMJ3Qsp0UFkfgvuidFmh7E5b9Z8U20GQRByJCDJ2i8LFS4cQ7RHOFYwDBcAz
         LcXYIRT3qKQQ/946VyorpMsZgGJ7TISxFMNlW/145PpA8+E8bznOuWiS5zCkK/aboqJ7
         WyxuRu1mqc+KLRXJlAAlawB/uWepKlfacYmYhsB6oxUfvbS/Gl3/nDSSjmgQpA58VGS9
         l17gdelo2rpcZJZZsRjeYys7sq8tJOB7zemBvb3jE1HQA2Akr1/F+mBCfHvEyTJnnDNu
         nKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=skttEob0n5ms3kMAByFrLQW3zkqp/+QIY0dBc1aa3Lk=;
        b=F1KtXNVAPN2IDjxmvSuc3tZiBYFk4sjTtGIKnYWv0duLx5S2SHHhuUtS/xtQP4ow+1
         Uoq2mJqM7xTD9J/Zx0o7ycZDxz8NRUGbZtwXkGrhmwmibGegPWDyOBL+Ag+k0ulG8IGU
         X9hU7ToD51V5x4TklRLLt0AkqpF5qp8OXTagHI/0oVfaVs5v9DRrwKScuZVJIQa+lJMu
         HmFZlxcEjbxm8k03VagORxKI61lwTJ/0sPfD7f7qXrXQjhqNn1wmI64QMyXJXtWjHbjO
         cy2LYyucuu+qh2buEtiiVZpK3yoLDEPi+CHZFTibxvs2IaLVmv5WDkQyVpGP7MwTN1Uk
         R6QQ==
X-Gm-Message-State: ANoB5pkaxQUGuHAMQlcgqsF0QLMR0zN13UPZlaFHI91lecNEPEOWqwmk
        b8bJ8SFeBRvsiPtX1He38dbDOyVGaAFp94TsIgYlul3PfBp8NA==
X-Google-Smtp-Source: AA0mqf7Z78gmJGHb0FBNJw5hIvZjVMLUtAnv9f4mwcykB5QHpoCfVWHwXq+pycHiZvQ3iBYOk0QBLNJoRsyNJlyaA+A=
X-Received: by 2002:a5d:4b45:0:b0:242:1ade:1145 with SMTP id
 w5-20020a5d4b45000000b002421ade1145mr28734639wrs.483.1670862223208; Mon, 12
 Dec 2022 08:23:43 -0800 (PST)
MIME-Version: 1.0
References: <20221205175140.1543229-1-nphamcs@gmail.com> <20221205175140.1543229-4-nphamcs@gmail.com>
 <Y5UbhBTB2nSMN4UD@ZenIV>
In-Reply-To: <Y5UbhBTB2nSMN4UD@ZenIV>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Mon, 12 Dec 2022 08:23:31 -0800
Message-ID: <CAKEwX=NwUPShF3zud7kn_gyd4BZy8S6xzm6iFuw0eW=o=3A8nw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] cachestat: implement cachestat syscall
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, kernel-team@meta.com
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

On Sat, Dec 10, 2022 at 3:51 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Dec 05, 2022 at 09:51:39AM -0800, Nhat Pham wrote:
>
> > +     if (!access_ok(cstat, sizeof(struct cachestat)))
> > +             return -EFAULT;
>
> What for?  You are using copy_to_user() later, right?

Oh I didn't realize copy_to_user() would suffice - mincore also
has this check:

if (!access_ok(vec, pages))
       return -EFAULT;

(even though it also has a similar check with copy_to_user),
so I just erred on the side of safety and included it. If this is
redundant, I'll just remove it from the next version.

>
> > +     f = fdget(fd);
> > +     if (f.file) {
>
> It would be easier to read if you inverted the condition here.

Oh I think I tried

if (!f.file)
       return -EBADF;

here, but there are some mixing-code-with-decl warnings.
If I recall correctly, the problem is with this line:

XA_STATE(xas, &mapping->i_pages, first_index);

which is expanded into a declaration:

#define XA_STATE(name, array, index) \
struct xa_state name = __XA_STATE(array, index, 0, 0)

It requires a valid mapping though, which is
obtained from f.file:

struct address_space *mapping = f.file->f_mapping;

so it cannot be moved above the if(!f.file) check either...
