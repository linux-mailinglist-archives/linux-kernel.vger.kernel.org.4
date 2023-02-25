Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A296A26A4
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 02:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjBYBtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 20:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBYBtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:49:17 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C144667E04
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 17:49:15 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id z11so547989pfh.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 17:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FsXprsvi/YhUEqRRcjwtxL/wg4XbNep96f8DIcPmGEw=;
        b=q8EJppLt0O5T2/9CH2xtxHV9Z5taBbo4wM4eE24o9JiWVaNHPV8VUW4YT7M6rprdtP
         ehNzLP40Zn6XVfpHhPeYpf3OvHMpt8ejgKp97/cg3RV5e2wDK9nnd156IZc6Gz8ldibA
         UlhJAVF8llLRsevoFdlkLqCmvpowYc+sR2nmerRWSz2ZE8fPe52xRlUmmLdViwwBj7ak
         fUiENtFj0c452iJb0iyKw73Z4n/5dcWCB4mNR8sHqhUCYit9s/yGw7ZEC/TZH5nav8Pw
         FLPEfzPSlEsTONs2oAscLBId9b6RyFmNlcjphQX7wzvaqAy92sazTzjqTx/Tu0JU0Fz1
         dCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FsXprsvi/YhUEqRRcjwtxL/wg4XbNep96f8DIcPmGEw=;
        b=Tgl8yueNGtmgZNi9LHNurn0lxjVQ/GkyMgdrN61DyOmkYmX73JprkgDaBIeuDJljg1
         /rTtBxmen59ft6IbTy2mXCSUrIEOE+Ta18BmUHK07oXB7C30oYUwIZwJFbzrUz0Q+58j
         Y/RTatJtOTzXT5STihjWUXP1hE1JegA9O5ae2m0aGHSMakdMZ9Q4GXal3RQtAxMOETWT
         DSOSS7SxE/3XfCfkS7BiuNZ2A14bhV3V/cHXO4UgjvfojX2t/0NV/kKS/k2MFhgs37ck
         mIfLseGyV1m5bnZEPJexmKXINTkFfCPr00P6UFBky0SGQ3UrnPlBYNvvP41Cijiv/vMs
         lFDQ==
X-Gm-Message-State: AO0yUKVAe69NR4ezlulBnfQnn+YZnKSgEHoExBWJ/wS6Y0PJ6r9WKN0C
        HWUKrP7Zpz57ikKimLVFOapOJ/gQMEe23jMDdVCA/g==
X-Google-Smtp-Source: AK7set8EECIrO70bFlm0qs8tzFwXkFUhmdbhq+Zol1pwHUaugvv/K+AkqOeuRGNYr39LD11euEgKKdFPe00LrhrqnPo=
X-Received: by 2002:a63:3855:0:b0:503:253a:1da3 with SMTP id
 h21-20020a633855000000b00503253a1da3mr188284pgn.1.1677289755055; Fri, 24 Feb
 2023 17:49:15 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9txhVJ3t_3-wMdWH7F+=_BbW19NYxAnm2cceP2uHR47_5w@mail.gmail.com>
 <CAPM=9tzPxixXnRuk0Jfs2ESw-eY43H_e5_FtGbxAhRmvaByYwA@mail.gmail.com> <CAHk-=wj4ShzDcZVx07ObELz06dL7m3Ax-p014rAmxGQ3D0brXA@mail.gmail.com>
In-Reply-To: <CAHk-=wj4ShzDcZVx07ObELz06dL7m3Ax-p014rAmxGQ3D0brXA@mail.gmail.com>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Fri, 24 Feb 2023 20:49:03 -0500
Message-ID: <CA+pv=HMOXiftTEcSLeTnQLxdxxD+GushtCwO197icDYm=kPwMw@mail.gmail.com>
Subject: Re: drm next for 6.3-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 8:35 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> If you were waiting for a pr-tracker-bot reply, I think you need to
> put "{GIT PULL]" in the subject line for the automation to trigger on
> it.

Had to double check, but yes, that's exactly it:

PULL_SUBJECT_RE = [
    re.compile(r'^\S*:?\s*\[GIT', re.IGNORECASE),
    re.compile(r'^\S*:?\s*\[PULL', re.IGNORECASE),
    re.compile(r'^\S*:?\s*\[PLEASE PULL', re.IGNORECASE),
]

Link: https://git.kernel.org/pub/scm/linux/kernel/git/mricon/korg-helpers.git/tree/pr-tracker-bot.py

-- Slade
