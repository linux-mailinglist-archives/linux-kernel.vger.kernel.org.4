Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221C4671049
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjARBm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjARBmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:42:06 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AB3521EE
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:40:35 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id e16so8199192ljn.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=shjxwHFTr8u+xtmkHSiNEPjbEsIzgwDSfE4nzs+fRNw=;
        b=KrhzIKzM90qTaCHwmda4g4cFsl9KD/JjaVWAW9LFfm+LeBPGK+w21ZswOITVgiHylo
         ptD30erVVRaaMvBV70Q5d90mX31U4KJx2G0Mj2aSs2d/MOEZui38RCFdN0BHcDD1HBwG
         wOL571cyO7AqTCv9OCQL9NPt5xEcQDLVTPG5h9Bj3jN65oluDS5vesZ2+aL4F6GYE8H9
         r7KvAN9SLmZ8FrgjYXvZEuvmREvJfuTAIqA/yaZGvOMNMJh2lxa5/7wAlpKqMGrF+rjU
         a0c+qckd2+VRljzCqy8o+TqH/c6wWDDFCPySuOufEFTCc3aHD9dkx9ZHr6YaBoeAJ53s
         bPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=shjxwHFTr8u+xtmkHSiNEPjbEsIzgwDSfE4nzs+fRNw=;
        b=Z+lmKhty/Z0P3ZM72PqvD6JYW6tzqa7vjKDAKrAC7dNPhL1fCvgDzzon+q2reU2XXr
         U/tH36rDGW3KpnUTB0bg22TwAZd7NauA4PqoVcyzRJaBK4CGGm4Qg/lIZNtHx9aSRCT8
         O/BlE/Kj1S0qaKaY3F5oI5ALZW6VmjvjvP54+jcKixSGqKGOXZHjHxLL5tq/aI6El7SZ
         kVoYY7KgVCt2mmQLBbv5I+hsSP2uF85AeAmEq9yLptLZ9T23I2mlLPgWz/b3wbGJqOOf
         +Lse3TrhSu8yK0hYOTpEtzUjxhh7hRNXu56PPp10n34ef7DmezTXQ/DHiRKzj2ZF83f6
         vI4A==
X-Gm-Message-State: AFqh2kq6yZHVzbvBZ13eZh+0X6u92StJbYZS12vjO7mBr9xUQ4wLq0RH
        eCwHfXF5o06vuETHSpqrzkJ2JN2bAU/SqP6Tm3o=
X-Google-Smtp-Source: AMrXdXvAwUPKSzfj4epK+2tmhQyLB90xdP0y1j/zdjuaZQlH0y9EFMPG4XSSGEHCVXPsQ+wyBLtGhrlRml629G+FY/Y=
X-Received: by 2002:a2e:a4a4:0:b0:27f:7ee5:8424 with SMTP id
 g4-20020a2ea4a4000000b0027f7ee58424mr278315ljm.114.1674006027132; Tue, 17 Jan
 2023 17:40:27 -0800 (PST)
MIME-Version: 1.0
References: <1673943112-8620-1-git-send-email-zhaoyang.huang@unisoc.com>
 <20230117161731.ab69c2352a62a0693570cf70@linux-foundation.org>
 <CAGWkznHKJF1hiVTS2gAxgywnGz4T9u8UQtDV_Oj7r3cWqM5=nA@mail.gmail.com> <20230117173145.867a06c1585728da1e9b6a54@linux-foundation.org>
In-Reply-To: <20230117173145.867a06c1585728da1e9b6a54@linux-foundation.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 18 Jan 2023 09:40:03 +0800
Message-ID: <CAGWkznEusXRmi=ZEOvfK8qRfe+aKWa3X-bLG28=XoeGZ5umeuQ@mail.gmail.com>
Subject: Re: [PATCHv2] mm: use stack_depot_early_init for kmemleak
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
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

On Wed, Jan 18, 2023 at 9:31 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 18 Jan 2023 09:25:48 +0800 Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
>
> > On Wed, Jan 18, 2023 at 8:17 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Tue, 17 Jan 2023 16:11:52 +0800 "zhaoyang.huang" <zhaoyang.huang@unisoc.com> wrote:
> > >
> > > > Mirsad report bellow error which caused by stack_depot_init failed in kvcalloc.
> > > > Solve this by having stackdepot use stack_depot_early_init. Extra Kconfig also
> > > > done by moving kmemleak stuff to mm/Kconfig.debug.
> > >
> > > I don't understand - what was the reason for the Kconfig change?
> > The items related to kmemleak are moved from lib/Kconfig.debug to
> > mm/Kconfig.debug
>
> Well yes, but why?
It was suggested by Vlastimil in a previous comment. It makes more
sense to have kmemleak's source code and Kconfig items under the same
directory.
>
> Is that related to this bug fix?  If not then please let's have that
> change in a separate patch.
The moved items are updated for this bug fix.
>
