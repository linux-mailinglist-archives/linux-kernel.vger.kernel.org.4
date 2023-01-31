Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7131682A78
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjAaK11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjAaK1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:27:25 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DF31C5A3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:27:24 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id k6so15580590vsk.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7vPWeuf5HEeoiMZZem+4HAgZK7oUQUzCNRu6zAcOzxQ=;
        b=d0QrZt2/YokTvL+hDJBgelYaAy0J8SP4K8EMhc7chajopVJ9Nlio3w/CDpncsH4Ifv
         sXi0w3X6ifBjZLUcxB6DqgCOuPBqbJaiD4LGHa5do04ro4Ji9OERaEiQ7kRc93FKqq3l
         YbL20Z3EKSJvSGdRN47iqu3rp+i5HjuIbniRcZAotqel9EoP0PiLa/Hnu81vF66YPS/h
         1P+xxYdjk2eDFlVcD/DzefKACWL3tuMXUfR8ItaZmx2qHLkZytKuaqhMR/uPnq+lLXkv
         fpAKfDxb94xyP6dfwFmYlzOY2Ey1PgtRP0Pwt2a8vOXJxkwK7gl7hyusI+hrqpxQJi/A
         R71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7vPWeuf5HEeoiMZZem+4HAgZK7oUQUzCNRu6zAcOzxQ=;
        b=dd0uxLUlATrSRuS+wD+uNh9EjWYy35NGZxlpxPJY4PUGMj57Qjc+Yo7w0Wl7isLzVc
         pzbjkBZKlLwF0BBWovsSoPPantchVR5xveboMdh4LR33V0PRlLoLE8uoDvz162DY2kI9
         s84w+2tq+XIicK0n5U646wn+dLqrG7ndHWsduprb9vEyvTsNgwVIrjs6XzakWWsppWMG
         mEN6L7Cd4SRse/VHm2grAL+6D7cb/jNXlLpQY9+Unms7tMXuJ3brXmFFTCeeJYHNwRpU
         o3R9TasR0cyD1z7dQRLksmTXU6YLgmT9gzb5mlZIaw0W9J6XWV8Aaldy2ZENGFKP3Jaf
         mWaw==
X-Gm-Message-State: AO0yUKUDmpbipqA6j8t46p6eV/GjXuBVa9hhg3aSdZ4t9CjNo+sdnE0L
        yFe7fs0hr3fN+KiHPZNeti8h7k5BMpvdX297vvzp6A==
X-Google-Smtp-Source: AK7set/igvas3mHgDrpV7OmNmqQ41Qn7hSdNp8uv7LS9rdA5j+x7iEyRDrkHXIf/QsJD6u4sr1RPaSXxtGwUbyVpql4=
X-Received: by 2002:a05:6102:3237:b0:3f4:eee1:d8c4 with SMTP id
 x23-20020a056102323700b003f4eee1d8c4mr1110810vsf.19.1675160844015; Tue, 31
 Jan 2023 02:27:24 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675111415.git.andreyknvl@google.com> <cb34925852c81be2ec6aac75766292e4e590523e.1675111415.git.andreyknvl@google.com>
In-Reply-To: <cb34925852c81be2ec6aac75766292e4e590523e.1675111415.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 31 Jan 2023 11:26:48 +0100
Message-ID: <CAG_fn=VPVrp8BW=QpN63o40NSuJCd0P5aJee4gBod7JUgoQ4ig@mail.gmail.com>
Subject: Re: [PATCH 04/18] lib/stackdepot, mm: rename stack_depot_want_early_init
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 9:49 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Rename stack_depot_want_early_init to stack_depot_request_early_init.
>
> The old name is confusing, as it hints at returning some kind of intention
> of stack depot. The new name reflects that this function requests an action
> from stack depot instead.
>
> No functional changes.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
