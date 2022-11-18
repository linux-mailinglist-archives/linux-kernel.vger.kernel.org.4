Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55B462FA4B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 17:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbiKRQac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 11:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241341AbiKRQa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 11:30:28 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCC993726
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 08:30:27 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id k84so6234027ybk.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 08:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LK8nJnDEBy2sbP90xfZU43QkEi075IC0lRWwF2/ommc=;
        b=cSWcuLp1i5SXT4W0eT+DaCZmd+4fwdZC/g2FcmkpwqGXzDF8yHep2wVJXeo5Zxx1F1
         zpiL/cRwBOrMCt+SmHBG/9nlDqApzLnqEG2j8rISK6VXNXpNI4STjc3ZPuNA5iPYrlLa
         X+CMgAc1gHIKwUI1lYaojam4NB3kAxn5luQBg91B71m6OFdpOUxeVoq6dvik09xBUUEf
         p6ymx1r/TsU6r2OS9cske1uHGlx2NhcQp9sqbT148ezhq9/oil+oLsMBT+czkDuWWgkZ
         r7ZZhuMQehOPDbS3DiuCQKUIhoQAVOcTbuxtAY3E+7ZH6eNm14F68St4stuYsi22WA5k
         2eTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LK8nJnDEBy2sbP90xfZU43QkEi075IC0lRWwF2/ommc=;
        b=tPKdI/HVbZKdUX/oWk8yG2Wmcn6q8sQRlEtponT7p1d4NBlCRuqTJ2US9GpD50o9xI
         6RpJ2q5OZRwqAcVnGFcUeT8NBPUL0DjMhOONMWyTMTFwEjUd5fyjSP93mDcj2LCcfv/K
         JUWfpc3AsPqCzNr35LSYC6diWWezkduvigoQJLstid26UQu2y+1RpgVNzBe2igkEbve/
         uPliJrjwjzCaDldzjqAGtsnNo6fQczWH2e+FAzGnoeKNMnJAuuyKaDKZBuStw9xEfh+s
         8uEnaMrZ1IQOqpsF62LwhL7r2VEJHjMzTSziAbFfCGl33xs5GiFk2QxPwImP0CbP/XjZ
         xz1g==
X-Gm-Message-State: ANoB5pmtl488ilQxGHfcYJ0GlP9uWBhWL7cOHSyllpKDb/V476trLBSZ
        hrDkS7pOlejkYT/KvZJ60ZyxlVDHuhCqLPf8WbrLrg==
X-Google-Smtp-Source: AA0mqf5f/DZ43uBpWY1mdbPp05jzS7GJ6mBPu3cXOx4W1Tg83PlBeU7EsYfRHWXCAEspl6oicmMA0bSSAUzRyKUxqLA=
X-Received: by 2002:a25:3458:0:b0:6cc:c17:27e6 with SMTP id
 b85-20020a253458000000b006cc0c1727e6mr7074317yba.245.1668789024220; Fri, 18
 Nov 2022 08:30:24 -0800 (PST)
MIME-Version: 1.0
References: <20221117043247.133294-1-yosryahmed@google.com>
In-Reply-To: <20221117043247.133294-1-yosryahmed@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 18 Nov 2022 08:30:12 -0800
Message-ID: <CALvZod4=WgJsxcoMyuFqrqgqsLKguC2Dvy0mwupYPp94UPhX7Q@mail.gmail.com>
Subject: Re: [PATCH] proc/meminfo: fix spacing in SecPageTables
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Sean Christopherson <seanjc@google.com>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
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

On Wed, Nov 16, 2022 at 8:32 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> SecPageTables has a tab after it instead of a space, this can break
> fragile parsers that depend on spaces after the stat names.
>
> Fixes: ebc97a ("mm: add NR_SECONDARY_PAGETABLE to count secondary page table uses.")
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
