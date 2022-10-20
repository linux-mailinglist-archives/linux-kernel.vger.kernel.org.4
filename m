Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE306058BF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiJTHgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiJTHgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:36:36 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA48171CF9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 00:36:32 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id y13-20020a056e021bed00b002faba3c4afbso19575591ilv.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 00:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=beK/RyAk6JMkokDhacR9sWsAak3KfcE5cJn8YM9YfXo=;
        b=WkfUS8OlQaXyocO9VEUtZVuyYjnSLcBSgREkrJz4sWNWHTd4Vy1Ust1Q0tnB6yjrB0
         KBs2L4kGRI93tt4zPjNRJRucjmjnQDUtleJ2Q/G+9MaqIu1h48Y+dgyxCDOfvBQkkiUs
         ah3qC9+OQFnbaNCE05xjPk+lWp84lR0bYD6SExZ45uOeK6aFG9sp2G6epXszB81DD/sW
         E/Ue/Mz34M/d1DYrZ0A2psa0jVTJcu+CsNtbJw89F7kUqqbZu9CWmG03gRyLMSOQ+ItP
         3hHzr7BoOZ3DG6ZfipVfjS2vNPMKWaxQtNGVTzw8lhLagmqQNUOFMLXYwsObwwnhpt3e
         rigg==
X-Gm-Message-State: ACrzQf3HAD+8MEYlHUmiOZcUlnCwsf+vSyscZIJR0CsRzaPRefCUMQc1
        CHqJw5sHnTWzzi9dRnbGfBvot6flC9AAnodwFAMBAA55+EA2
X-Google-Smtp-Source: AMsMyM6lPwgj4Q3DvjBnp+fA4UBjMmmzDlSR0FOvw5VDPgORiz2X3QYKE3lMgf1h1krXbr1FvKl8b7UL+ome8+zH7iGCIHYV/akz
MIME-Version: 1.0
X-Received: by 2002:a92:d28b:0:b0:2f9:95e5:fae6 with SMTP id
 p11-20020a92d28b000000b002f995e5fae6mr9067829ilp.313.1666251391412; Thu, 20
 Oct 2022 00:36:31 -0700 (PDT)
Date:   Thu, 20 Oct 2022 00:36:31 -0700
In-Reply-To: <000000000000f2b07b05d5dc87cc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ab16105eb726264@google.com>
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
