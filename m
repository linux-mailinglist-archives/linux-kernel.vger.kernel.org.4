Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD5668DF44
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 18:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjBGRtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 12:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBGRs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 12:48:59 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29D1CA2D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 09:48:58 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5249a65045aso173119637b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 09:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JrzI39N/h1oUtp7dQNjXU/5GxHTaJKmnRqKdVD7Yatw=;
        b=McWCOwFTZSfjfKZxB2zQbrS4QvXkfcg90QiOqbpltMP0Oglux0ZDpvlb6SdGo4meHY
         Hws8k9FsUUFmExTkTohCxagc2RqKNmV/4H4ow7APIp1dKJKdgGfvukWJmUygairDR4K4
         mIjG2Nc011tAsKGcC/EGcSjwzhRIg88O72MvLQYUz7M5hnYinrFzfVp+bgQAc24AoDCJ
         8MiW0MmOLw7Z75KwcPKGUgTtVVO7U2djSFs0DZlWG3DVsZIrnbDzU+ZNy6g7D9x0ZokD
         aEuyKgBcPBLFyLcVw+atxGUpD/XCVnQsU3VnU/TwCt0VsBgtq4crP6KS1/9mZneZwR9u
         ul8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JrzI39N/h1oUtp7dQNjXU/5GxHTaJKmnRqKdVD7Yatw=;
        b=b8U+zH7MVWVPlRmDtbiurtt3kq3bo1JTnAT8BHVpdPM0t4T6wzkhR0efny0+dOg0y3
         CxJq4lrPL0pTmAmWF7Md3bXUMgvSDf9n90If9CX9UiTl8HH1oKfBmO0ktNQuTj9H1qof
         /CrW4gl9g9Fu0GVdxCNVV35eN0CorkXXhJtiM19G5c3JOlSFurI1n1W8QlehyG9uRAe3
         LvtPhySdutBu6qTQFQ0L73IAfW/vbEbgXNe+1ZnuXfZsVX/SYH5qGV/26ce++2gXKshZ
         zTOmzuh0TuSaFFUVzegfc3rDbgSsh8bIhMokrbL5HhCESWXc6kwHNaYPfGQnDVnaZF/F
         JfJg==
X-Gm-Message-State: AO0yUKVkgN7nzTDKwZHX6U/ZAtNhUYsbEJNBoR4fL8d9QAnCuJqr84fs
        YWE9TwjPE0KKglOiCCQFngGqx9ez1s7GRJkmvnaRww==
X-Google-Smtp-Source: AK7set8KT1SDSOUA1uUK383O0w+mNyRuu+DdczIn0dybdTQww4QdUEiYYR/lvikhWukuGvQ9RZ02VWGFAtdGVCdetpE=
X-Received: by 2002:a0d:fd86:0:b0:525:d3c2:7258 with SMTP id
 n128-20020a0dfd86000000b00525d3c27258mr370070ywf.175.1675792137738; Tue, 07
 Feb 2023 09:48:57 -0800 (PST)
MIME-Version: 1.0
References: <20230203192822.106773-1-vipinsh@google.com> <20230203192822.106773-4-vipinsh@google.com>
 <CANgfPd8NF88V+ddqeCBsz=NRgm-YV7nH1DwDhRsHpA_AnFBB7g@mail.gmail.com>
In-Reply-To: <CANgfPd8NF88V+ddqeCBsz=NRgm-YV7nH1DwDhRsHpA_AnFBB7g@mail.gmail.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Tue, 7 Feb 2023 09:48:21 -0800
Message-ID: <CAHVum0e+Dih_+hx2-k6Cf8V=udWkqcSKT+JoCo=8+0EMOCMKcw@mail.gmail.com>
Subject: Re: [Patch v2 3/5] KVM: x86/mmu: Optimize SPTE change for aging gfn range
To:     Ben Gardon <bgardon@google.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, dmatlack@google.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Feb 6, 2023 at 2:17 PM Ben Gardon <bgardon@google.com> wrote:
>
> On Fri, Feb 3, 2023 at 11:28 AM Vipin Sharma <vipinsh@google.com> wrote:

> > - * __tdp_mmu_set_spte - Set a TDP MMU SPTE and handle the associated bookkeeping
> > + * _tdp_mmu_set_spte - Set a TDP MMU SPTE and handle the associated bookkeeping
>
> Nit: Not sure how we got to the point of having a single and double
> underscore of the function, but what do you think about just calling
> this one tdp_mmu_set_spte and the other tdp_mmu_iter_set_spte?

I like your idea. I also don't like the single and double underscore
prefix on functions.
