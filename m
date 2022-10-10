Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE0A5FA48B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiJJUKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiJJUKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:10:31 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6874056D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 13:10:29 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so7022809wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 13:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wGNDpOeLOE7OjB7U7YvgsHvvZffGfTvB2dUjZAsgtBo=;
        b=Vupn4GEXNM5D4Wr4r7BDfXIXw6xDZQbzb9I3fNBJNLoi5l8ds/Tkg8cwXCJzmPJjko
         alBcGmCc5zwkw5ONkM6qK2mMqO9JxXal5ALOmIu/ZEr56BRWFreuPGoE4pXwrXFWsCoi
         QMhj+nE1gcYH3kV4FJX0O93ZY2uGsGAHEI6y09HwYo5mwwd13sj5XJgGeuVTJSGbIlE9
         ixDhG/ZbMamNyJ3baduZdgE7NEdKV2DCnqKpbDn2emffP+E9qIOqENq3OdpIQRCev1JN
         z/xLm93S2iPbUd7YUcn3CSeUBYx1HSAhv0ydlJhUd+7KszeV4xCGDRxrT48qRl89b/ZS
         MCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wGNDpOeLOE7OjB7U7YvgsHvvZffGfTvB2dUjZAsgtBo=;
        b=sm3iy/73QwtXEN5h3JDGavHB8WwxNxQZgBJivKqgkGHAaDTWKNyLWInWbk+sn7hafk
         aGEX/DAmTVVPH56DxDLrYs+S9wOfaCrAJArMLvlUqM+HfeG4fHD6ox28NgK5Kx9IO2tm
         879nc1Fq7kUOb5Hlxq+EmoaUuI7k6KCAdaSGPSp5BAn27St47rr1Xd4ZFsVv6ELrA24v
         5shtnhB9qZEQbzQzRySstsaxCCBs9U9J3xCzaJ1hR0aFw3wOZh+4vczmwCbVIb6lgEjm
         SlKND/fZC+/FNzfWjBiUMV7i3ey7qsL7hB9iTL6Q2FQ0xrD18bW2ekhNUMNvJbrPKimc
         jUSA==
X-Gm-Message-State: ACrzQf00EiVHraLOuRgBA6QN94ou8u5C/D2fNOYMh+tXkkT6uT8mVV6i
        Lb2gZ/ztC8UyndWjVgG0+A712vG1Ak3jNpXtkqAC6w==
X-Google-Smtp-Source: AMsMyM4atS4e8o+jD0nBGHZ7ckqJ+XrPgYGnLwvGp/au332aDL7G5yx6JvjxGIt85pNZgMR5WpISOAdPf+K60wY6Uqw=
X-Received: by 2002:a05:600c:524d:b0:3b4:91ee:933e with SMTP id
 fc13-20020a05600c524d00b003b491ee933emr14293071wmb.80.1665432627707; Mon, 10
 Oct 2022 13:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000385cbf05ea3f1862@google.com> <00000000000028a44005ea40352b@google.com>
 <Y0CbtVwW6+QIYJdQ@slm.duckdns.org> <Y0HBlJ4AoZba93Uf@cae.in-ulm.de>
 <20221009084039.cw6meqbvy4362lsa@wittgenstein> <Y0LITEA/22Z7YVSa@cae.in-ulm.de>
 <Y0Rn5qzP6MjayoCz@slm.duckdns.org> <CAJD7tka2jwPnYyCmLu0T5Oq_X-LJCx7TVqLayLPS_6fOjqf93A@mail.gmail.com>
 <Y0R31xyfivqtKb9h@slm.duckdns.org> <CAJD7tkaQeFYq6prHiTiGeEyC-ka8ujAFXV--BkROJbVDaOZ78Q@mail.gmail.com>
 <Y0R7ZZ87vROrO+XR@slm.duckdns.org>
In-Reply-To: <Y0R7ZZ87vROrO+XR@slm.duckdns.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 10 Oct 2022 13:09:51 -0700
Message-ID: <CAJD7tkb6-X18Hfe9-At3vUF0NJPx75sc94YY-VRfxJE2u1CS7g@mail.gmail.com>
Subject: Re: [PATCH] cgroup: Fix crash with CLONE_INTO_CGROUP and v1 cgroups
To:     Tejun Heo <tj@kernel.org>
Cc:     "Christian A. Ehrhardt" <lk@c--e.de>,
        Christian Brauner <brauner@kernel.org>,
        syzbot <syzbot+534ee3d24c37c411f37f@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Martin KaFai Lau <martin.lau@linux.dev>
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

On Mon, Oct 10, 2022 at 1:07 PM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Mon, Oct 10, 2022 at 12:57:34PM -0700, Yosry Ahmed wrote:
> > Any suggestions for the new names though? Given that the new ones
> > would be the ones that will support both versions, I am not sure how
> > to name them differently in a meaningful way. Maybe something like
> > cgroup_get_all_from_[fd/file]() ?
>
> idk, cgroup12_get_from_[fd/file]()?
>
> > IMO, we can rename the current versions to
> > cgroup_get_dfl_from_[fd/file](), and the new ones (which support both)
> > as cgroup_get_from_fd/file(). In this case it's obvious that one
> > version specifically works on "dfl", aka cgroup2.
>
> It's kinda confusing because we've been assuming that these lookup functions
> are all cgroup2 only.
>
> Thanks.

Got it. Will send a patch shortly. Thanks!

>
> --
> tejun
