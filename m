Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0746276BD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 08:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbiKNHwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 02:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236078AbiKNHwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 02:52:16 -0500
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8920F18E2D;
        Sun, 13 Nov 2022 23:52:15 -0800 (PST)
Received: by mail-qk1-f170.google.com with SMTP id z17so6903300qki.11;
        Sun, 13 Nov 2022 23:52:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GQYzymVjANMQK9eubE/7UqEjbipDRit38pMaXnEjvgA=;
        b=rKo4zEnexncfrg0OaEtUrOP80prRt4zn7BWH7xWWFi60ybsYdSoTs/BP3MQJCWG6Pw
         eU1rKJq2c02jf/+4i6fCh1o3hj3VVqkCgMuVWcRDLlgtSgOvmyNO4tSpDSVY6Ha/LTHY
         gcAp5odvmdqma46QtF0r14Ma6GVmb8sPVtRwbvB7hxvBHx2XWhWQW07kkLve2sqRKZSQ
         zmvh+CPBX1itnUvU3kWkAka0juJ5iogHNfn36oB6K5KnIeaods2L74zmw/jcAzqJJXlQ
         Z+dyWICQ7N+qBeosDrj+dwerKPTPFSKcro+zJu44Mx8Mm2HqpW9h7AqhN3/ip5K0NINL
         eRig==
X-Gm-Message-State: ANoB5pmYp5s0gG3IX/gPXeTRPUb6beMylISGQYpc3eQnPsy/hHPVIiH1
        4/hOvbcTtzD+eK7crD0sNB1ck+tXxv8FOA==
X-Google-Smtp-Source: AA0mqf76JiElkm67RQhGobKBUs2ff5CKt19hi+ER7v4QRlEAh47enk0DbRCFu+harFhYeI54vu939g==
X-Received: by 2002:a05:620a:1a:b0:6f6:e7d1:4d1f with SMTP id j26-20020a05620a001a00b006f6e7d14d1fmr10028849qki.477.1668412334544;
        Sun, 13 Nov 2022 23:52:14 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id n77-20020a374050000000b006b5cc25535fsm5981189qka.99.2022.11.13.23.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 23:52:14 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id o70so12486109yba.7;
        Sun, 13 Nov 2022 23:52:14 -0800 (PST)
X-Received: by 2002:a25:844b:0:b0:6de:6c43:3991 with SMTP id
 r11-20020a25844b000000b006de6c433991mr10632776ybm.604.1668412333810; Sun, 13
 Nov 2022 23:52:13 -0800 (PST)
MIME-Version: 1.0
References: <20221111171202.b8b7ff671c97cb9782ad8e78@linux-foundation.org>
In-Reply-To: <20221111171202.b8b7ff671c97cb9782ad8e78@linux-foundation.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Nov 2022 08:52:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUnY_SH_WRd3MUo3MPiin8H0EhkWY_9xGFyt+7_rwOEOw@mail.gmail.com>
Message-ID: <CAMuHMdUnY_SH_WRd3MUo3MPiin8H0EhkWY_9xGFyt+7_rwOEOw@mail.gmail.com>
Subject: Re: [GIT PULL] hotfixes for 6.1-rc5
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

On Sat, Nov 12, 2022 at 2:25 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> Linus, please merge this batch of hotfixes.
>
> Thanks.
>
> The following changes since commit f0c4d9fc9cc9462659728d168387191387e903cc:
>
>   Linux 6.1-rc4 (2022-11-06 15:07:11 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-11-11
>
> for you to fetch changes up to 436fa4a699bcd1c368bea9199e22b0a1b9cf9e0f:
>
>   docs: kmsan: fix formatting of "Example report" (2022-11-08 15:57:25 -0800)
>
> ----------------------------------------------------------------
> 22 hotfixes.  8 are cc:stable and the remainder address issues which were
> introduced post-6.0 or which aren't considered serious enough to justify a
> -stable backport.
>
> ----------------------------------------------------------------

> Liam Howlett (5):
>       maple_tree: remove pointer to pointer use in mas_alloc_nodes()
>       maple_tree: mas_anode_descend() clang-analyzer cleanup
>       maple_tree: reorganize testing to restore module testing

Thanks for your patch, which is now commit 120b116208a08772
("maple_tree: reorganize testing to restore module testing")
in v6.1-rc5.

    +config TEST_MAPLE_TREE
    +       select DEBUG_MAPLE_TREE
    +       tristate "Test the Maple Tree code at runtime"
    +

There are two problems with this:

  1. If CONFIG_DEBUG_KERNEL=n:

        WARNING: unmet direct dependencies detected for DEBUG_MAPLE_TREE
          Depends on [n]: DEBUG_KERNEL [=n]
          Selected by [m]:
          - TEST_MAPLE_TREE [=m] && RUNTIME_TESTING_MENU [=y]

  2. IMHO test code should not silently enable additional features, as
     it prevents providing a test module for a production system,
     without having any other impact on that system.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
