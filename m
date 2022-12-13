Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBE864B5C9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 14:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbiLMNLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 08:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbiLMNLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 08:11:43 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EECB39
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 05:11:42 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1322d768ba7so12429564fac.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 05:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KAw/HCOljVHgj+BBWaxcjEK33owb4M1DkrrbLVmLoWw=;
        b=huP9rr/HVBP83fyB5N0+LBuYlVDBMGfGd0YBRQ4/4AFRAeLmOs4Og3i5XmVF8mmlEX
         7EPJuq3Xbso7e6GI43D/lRf+iJ5rkJiG5+nefMhsYQs14eDHzptdKOldM4XMNuzviaWA
         kSMnBbItB9vK3OAJR5X3LzRX8gEb7BFUTbWholDpApRN+jTwyMShFBqpEYBZK5NISJxz
         d0FJFN/53cs2d1AeBdXx/tRJ3RgG0ZrpJ6Dlu0qnwu7QYgugeUwb0wccamiQbrJrMsNo
         KIsTrPv8v3FYyeDj5q/Su9i8u/eE6kNf75zOkWaIY/BUOYRkIFMYRlry+0wQlB92db+a
         GGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KAw/HCOljVHgj+BBWaxcjEK33owb4M1DkrrbLVmLoWw=;
        b=N+8eG3x6b0hJwhIXi5Ro/ar/tAkN/KqsanEWQJcRn777DnEmYptkUGHVuESYJKJKM+
         eZGG+8m4AAUBv8zYmM8Tlc1PRT/Q4IeCyQ80NqFLnKf4MuD8msjrSCP/7eofUU3E/JN+
         RAqqPCYIAjstuSELurKLdLJFju262T3Wi/ObLTSIaTlTTEInS5xgN8AzAm+Tbb3UujO9
         HSPai182AoNw+77hq/LCNYia+mMHxyXL6FEXuhtJS2GltE7rr9CQN64b6FHNoT5SWl1l
         Mmbmd5i3TVcIHpqUoKbB9BKyqVwNowbDLPKkphDue4FK9kDClIzdaZsaOkNToXYUZpx4
         QMoQ==
X-Gm-Message-State: ANoB5pnNWmphiUNZhjZvzRJ4abOAaAt8KQj1e3U9HP1bP+yvRm3KdFPH
        lyBem2cmR6Hkfndgv+GUq8M=
X-Google-Smtp-Source: AA0mqf7CvJyz4hNxxj1V2XFszbFqjehvMX2RByXvUqgCfMIC1sz0dQEr9fd8J34Uh7OdunpfXPNHRQ==
X-Received: by 2002:a05:6870:6b97:b0:144:8103:8e88 with SMTP id ms23-20020a0568706b9700b0014481038e88mr10411248oab.5.1670937101949;
        Tue, 13 Dec 2022 05:11:41 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ep41-20020a056870a9a900b001447602267esm1361026oab.41.2022.12.13.05.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 05:11:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 13 Dec 2022 05:11:40 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mainline build failure due to e240e53ae0ab ("mm, slub: add
 CONFIG_SLUB_TINY")
Message-ID: <20221213131140.GA3622636@roeck-us.net>
References: <Y5hTTGf/RA2kpqOF@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5hTTGf/RA2kpqOF@debian>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 10:26:20AM +0000, Sudip Mukherjee (Codethink) wrote:
> Hi All,
> 
> The latest mainline kernel branch fails to build xtensa allmodconfig 
> with gcc-11 with the error:
> 
> kernel/kcsan/kcsan_test.c: In function '__report_matches':
> kernel/kcsan/kcsan_test.c:257:1: error: the frame size of 1680 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]
>   257 | }
>       | ^
> 
> git bisect pointed to e240e53ae0ab ("mm, slub: add CONFIG_SLUB_TINY")
> 

In part that is because above commit changes Kconfig dependencies such
that xtensa:allmodconfig actually tries to build kernel/kcsan/kcsan_test.o.
In v6.1, CONFIG_KCSAN_KUNIT_TEST is not enabled for xtensa:allmodconfig.

Downside of the way SLUB_TINY is defined is that it is enabled for all
allmodconfig / allyesconfig builds, which then disables building a lot
of the more sophisticated memory allocation options.

Guenter
