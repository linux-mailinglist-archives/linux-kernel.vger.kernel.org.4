Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1585A6C445C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 08:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjCVHu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 03:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjCVHuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 03:50:52 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970CA5BDB5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 00:50:48 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id o12so69160351edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 00:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679471446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5AdmVjcvz1/yCt2UekFt3nmmLHzuFXFt3bw5QTUpRmg=;
        b=Ong+tjrl1kElrSo25R80+eYY7gyjS21weUf7Tmo9+I9bCkc1dMGdWHoY/ueZEFJkD7
         S10DGo34JW0RdUrf2w71ggMb7Pc+Fg12C0vp1cC3EnZ55yJS0fEPYvvNUu7ykcQGlReV
         XvkggfXPJ8JKFQCyT4O50XI/7tg8NkMELNhJnqRkgT/LBB3AHtG/2VP17jLi1ZD1VCd7
         LSYXhzpc98c5ud/+Ww2rJ+MARxsc4E0Yn7wAYMdxFCuXOWCkCdCFazPHQEBigQEztEFQ
         D2cZKrxWskR7sNVGLnA4a7vFiWoiL3k0NDyQ+E54//6MHGNGnmmpurUQ/m9hz58sva0m
         k1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679471446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5AdmVjcvz1/yCt2UekFt3nmmLHzuFXFt3bw5QTUpRmg=;
        b=L7IufLSi6tG2JVv3u32EBvG3sVMZCmJLETnhfMzb/WHPNQRZZFLXonsVB4wKLt/FRT
         TdbMMamReyMYca669RYpLNs+GkOl0UK7EzweaWVz6K+sdhMd6HKA+4+uhSn/umsT6NHS
         X4ognTdrhAdaFWVhFafTMU3SjeR9Fg2M4KXopi5RzrSZCffB5UoOMR3zfitVC/BMQo+o
         QObySLSULGqTOpBYQn9y0qmJAdpO2nESDmvwM6B8XeFld0F+oIc1RWRL6Yro/kuwx51p
         jSf8YnfV2reogiqkKnY6ACdzhifW/Id9SGusmt7MPymPi6P4r/Os4/RHOVHhdgTvL+1I
         FusQ==
X-Gm-Message-State: AO0yUKV9weR9HjKybkN7YcFvFZMPO8enN97v0JgiPc/VwueTmB+T8L6Y
        4Yju5hZ/svGaklJg36KOJj8=
X-Google-Smtp-Source: AK7set944h2QkdgHk0raczdce/k/+S/C6qqg7EsqCHlU2CG8ATrJisTfH2Nl3ExtjzPeRmw/k7+2AA==
X-Received: by 2002:a17:906:55c9:b0:932:e6d5:bd7c with SMTP id z9-20020a17090655c900b00932e6d5bd7cmr6960071ejp.20.1679471446407;
        Wed, 22 Mar 2023 00:50:46 -0700 (PDT)
Received: from andrea (93-41-0-79.ip79.fastwebnet.it. [93.41.0.79])
        by smtp.gmail.com with ESMTPSA id z17-20020a5096d1000000b004aee4e2a56esm7250886eda.0.2023.03.22.00.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 00:50:46 -0700 (PDT)
Date:   Wed, 22 Mar 2023 08:50:42 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Leonardo Bras Soares Passos <leobras@redhat.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND RFC PATCH v2 1/6] riscv/cmpxchg: Deduplicate cmpxchg()
 asm functions
Message-ID: <ZBqzUplarOxIXrvN@andrea>
References: <20230321074249.2221674-1-leobras@redhat.com>
 <20230321074249.2221674-2-leobras@redhat.com>
 <ZBpPms0PGv4sWR1Y@andrea>
 <CAJ6HWG46-an3r3WH+n8mHHge8SjqgMbohjTmmk=_EXVmwKZSeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ6HWG46-an3r3WH+n8mHHge8SjqgMbohjTmmk=_EXVmwKZSeA@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Though I'm not really a fan of macros depending on local variables with
> > "magic" names, can this be avoided?
> 
> You mean __ret, __rc, __ptr, __old and __new ?

Indeed, the wording was from coding-style.rst


> If so, yes, we could add them to the macro signature, but it would
> become quite big with not much to gain. To reduce impact it could be
> something like:
> 
> +#define ___cmpxchg(lr_sfx, sc_sfx, prepend, append, ret, r, p, o, n)
> 
> Is this a possible fix?

I believe that'll do it, open to other approaches.

  Andrea
