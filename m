Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42F162D43E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbiKQHj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239400AbiKQHi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:38:28 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B93333
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 23:38:25 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id g4-20020a92cda4000000b00301ff06da14so749029ild.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 23:38:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=beK/RyAk6JMkokDhacR9sWsAak3KfcE5cJn8YM9YfXo=;
        b=PMOzDPmgc9T/KMcqe8yG2RQtAU4auJvQoi2+CCZtsyAQtHobqWDEMjSWeEL1dwd2KF
         G0tzVlOmZJCFPbYcSFFfhQ2y1qQmu82Bpf/cPCSdpI952+b8ud36oabpPOeAPxQ423Cr
         Wnn6evn9G5vqEJKiYEc4cEEPC/wCDwdmNuexUEAWuOOIby53OL1tHXxwFfFQMliLpmwC
         XxF9MRlAxCVJR1YLR9yoWXDVhL5262Zvf9dgQ8zid26C0fVGgsqkB0Gz2sQkX4ENgHGL
         C3KCg+tTc84+4UpxFoDC4SmsFYrunrOUC97VmhdEqgl6XmTApY/ClMHIrIQTQ/a6rM2p
         /WHQ==
X-Gm-Message-State: ANoB5plFQ2Oiwdeg157gZggwWhhcD8yOwsPa8ncL9iKgMO+kCbIw9fzY
        lYfuP5vZJnP67Y3NwVAdjcGkga9J40uZsm63YcblfPueA6lN
X-Google-Smtp-Source: AA0mqf6KcZ7V5KSlcCipv6hNa7VXJbrwjKNrfSYMmThk4YG0+KXiIgRXF3ox37o1GKkbV07cWLnNqqMkkhOTwt0qKjuxFhTESGuS
MIME-Version: 1.0
X-Received: by 2002:a02:190a:0:b0:376:1ab0:7bd5 with SMTP id
 b10-20020a02190a000000b003761ab07bd5mr565688jab.8.1668670705193; Wed, 16 Nov
 2022 23:38:25 -0800 (PST)
Date:   Wed, 16 Nov 2022 23:38:25 -0800
In-Reply-To: <000000000000f2b07b05d5dc87cc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a15e4a05eda5ac1f@google.com>
Subject: Re: [syzbot] general protection fault in fscache_free_cookie
From:   syzbot <syzbot+5b129e8586277719bab3@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, dvyukov@google.com,
        linux-cachefs-bounces@redhat.com, linux-cachefs-owner@redhat.com,
        linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        mudongliangabcd@gmail.com, nogikh@google.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is marked as fixed by commit:
fscache: fix GPF in fscache_free_cookie
But I can't find it in any tested tree for more than 90 days.
Is it a correct commit? Please update it by replying:
#syz fix: exact-commit-title
Until then the bug is still considered open and
new crashes with the same signature are ignored.
