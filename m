Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3116F27D0
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 08:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjD3Geu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 02:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjD3Get (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 02:34:49 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122BA1991
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 23:34:48 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-32f240747cdso125405025ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 23:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682836487; x=1685428487;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5gdI7gxE3iB/RkQZb1CgRLtyHGYhRqooBencYpkSuso=;
        b=aT/I3B4ynVJfS+9wOIiynlLxUKlV8EM+llusUreK+acExcMr/GzUZxfAwIlsYn0Qfr
         4LQv5u3iN3CtCxEiWmtZwe11cGnn96FlCQ2wrfsyQsdkGN7FVEnpMTjTtKTu96MZk5Xq
         /xsy4fvAX/5F0T+7y1cP9drsfEySPO9poR20gZpvsF+FCrszh86IiEcqCgoI5mrNDGU4
         MonvGjc7m9bzqzVi4ouU4h1wVK/8D0m1Oz6zEkQDplD0/YxWHNrpJ+sQbE/kcQ0oZ01p
         BypzluG/qnRr04jtygpsvHdfORGlA26FUpeQ3Fy4EYyfeMKV/X3mW6hQkhXU+gksB0M1
         pahA==
X-Gm-Message-State: AC+VfDxzKBAkOdOi37RBNurGYHsMu6P3roAQVrMLXhwfSHHJxVmExe3j
        Hppin1zch+4TK21vzLb8Pgr5paCFh5IOo71UlRH80rG+5c8n
X-Google-Smtp-Source: ACHHUZ5Qra5w8UekgABOhP+XvXdv98Fl5N5w481jp0z1Mg2zqNQzdos66O3oO1MopSJMs3o+nhnt7w8kNVNFg9jUZSVcInGQV73a
MIME-Version: 1.0
X-Received: by 2002:a02:8588:0:b0:40f:9f56:2bfc with SMTP id
 d8-20020a028588000000b0040f9f562bfcmr10161497jai.3.1682836487427; Sat, 29 Apr
 2023 23:34:47 -0700 (PDT)
Date:   Sat, 29 Apr 2023 23:34:47 -0700
In-Reply-To: <ZE4L+x5SjT3+elhh@mit.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000c5ba605fa87e772@google.com>
Subject: Re: [syzbot] [fs?] INFO: task hung in eventpoll_release_file
From:   syzbot <syzbot+e6dab35a08df7f7aa260@syzkaller.appspotmail.com>
To:     tytso@mit.edu
Cc:     brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> #syz set subsystem: fs

The specified label "subsystem" is unknown.
Please use one of the supported labels.

The following labels are suported:
no-reminders, prio: {low, normal, high}, subsystems: {.. see below ..}
The list of subsystems: https://syzkaller.appspot.com/upstream/subsystems?all=true

>
> This somehow got tagged with the ext4 label, and not the fs label.
> (And this is not the first one I've noticed).  I'm beginning to
> suspect there may have been some syzbot database hiccup?  Anyway,
> fixing...
>
> 						- Ted
