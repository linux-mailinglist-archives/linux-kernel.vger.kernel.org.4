Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38536E2B98
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 23:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjDNVRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 17:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjDNVRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 17:17:03 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDAB55A6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 14:17:02 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id hg12so5219888pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 14:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681507022; x=1684099022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPkvmmSyj4e4vDoidDyXobHQ8LlXiYWdlanORfc48jE=;
        b=UMTgWb1SbTr5bA6MkUojrBec3NNP1gf1qfTS6rNecbxRXPpT31TQw+oziIRhLQKOTm
         LWK9yKFKra8QAtomC9/sk8JpGSDpbFmtIeE/8jIG+QZhYdV/1/2su67vOqeJ8k99w5Aj
         KlmNLpFW6tzp2GN2E8QpNTKDRikbR23FZ7QXfEgUOjVSUzaCVkWov5H8s8Y/THw8pEA3
         wGtTlwAjJw7lSC/Bga7Lw3G6PgmIsTcwWPZHJGbUMi7x11iR7iGDr5UBFWJzJv3u0sWe
         lxBhj3oeNsoP11YJPd0gSsRu8YINIPK3aqDTf8WTNlyBEs3Pnv4Ys98b1AS7Ashz9WmY
         QvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681507022; x=1684099022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPkvmmSyj4e4vDoidDyXobHQ8LlXiYWdlanORfc48jE=;
        b=KIvZjpqCZRUaIUcQ0ZB73OmGZKn3gVaidEWouiCfHa4azjedZfi5TnAx5Hf2HLIgnR
         kNt9tCuSqKogEa3IMkTpU/zfXUkv9bw1jm3MeflrOCJHNz/V+8KIjQsFbNgc86fHEkAV
         SFAXt5VWaYK84/Io9eJJauQmZpK31hvDOt/2k9Y2zUY0c1KijGN0JEGhYcUEWUQONObM
         lIarmrnkZbWV8CYXF19FJWJVzKyZVxtc4O4C16m7CKD6luSNfLRZGDVwOuzXTQDyHwQd
         QL39O2kdHe5omxjVBp7rt/AlzEIuYTDxlYSR9T9xBKLbUgOW/J3effzXb2VOKpr0LiTG
         V/Cg==
X-Gm-Message-State: AAQBX9cs5dV167m6LQ5TA3hoYsZK1hRHtIP7C1uMrTL6A5rKjtoOBWho
        DrlZcLhTjWOy6cNAb/o+nPXMnhLRZ8kK04qlY+3etw==
X-Google-Smtp-Source: AKy350Y7I2wMdc6/0r67Vr/pOgw2zrHFBfkTPduES8B/+1mPbhzeGAM23TfAAG78L1Pmn3ZVZTrkqYUietC6/9ijZEM=
X-Received: by 2002:a17:90a:ea89:b0:247:1131:dcd2 with SMTP id
 h9-20020a17090aea8900b002471131dcd2mr7018016pjz.23.1681507022160; Fri, 14 Apr
 2023 14:17:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1681325924.git.jpoimboe@kernel.org> <683214828d8b2ad732dab1a74e858087519d8c8b.1681325924.git.jpoimboe@kernel.org>
 <20230413092409.GJ4253@hirez.programming.kicks-ass.net>
In-Reply-To: <20230413092409.GJ4253@hirez.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 14 Apr 2023 14:16:50 -0700
Message-ID: <CAKwvOdn9r96UznjbghdceDXyZxsrsvwj99Noxw=u3Ak_kBvacQ@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] objtool: Ignore exc_double_fault() __noreturn warnings
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 2:24=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Apr 12, 2023 at 12:03:24PM -0700, Josh Poimboeuf wrote:
> > +      *   - have compiler communicate __noreturn functions somehow

Could probably stuff these in some kind of "noreturn function symbol
table"/custom elf section; DWARF tags are nice but we don't always
want debug info.  (I should ask colleagues if there's anything like
this in DWARF already, perhaps for DWARFv6).

>
> This, we're going to have to do that -- because keeping that (ever
> growing) list in sync is going to be a pain in the backside.
>


--=20
Thanks,
~Nick Desaulniers
