Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F78966AB60
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 13:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjANMcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 07:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjANMcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 07:32:19 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5868A42
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 04:32:18 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id h2-20020a92c262000000b0030eebc83de4so1533546ild.8
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 04:32:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1rrH8E7z8KFr7sdSJka+xwS5NaY7jiDN7jsuk026sCg=;
        b=rD5wbIOc4xIOUwTUWfvGuM481elbL5DdPIrcrHEVW7GtMkGf+baYu5EMqudos8bz7T
         pWi6Eox8EAmXJCXCepZD67NKBPTd7E1XRZtgSOhB8cBBmvSsVl/XrZfHjiRU1ITWI4Io
         RqX8nkNyCo2ILDYOlqDPepX0Zw0uPRiVxNyG3RvTDSSOLSPAPReaMaMfx1i9V7bKfp6o
         kKIu6Fgv46x2FOXd4/zMd0cPO438BPwqeYzY29WENU7MYvW3CBkULE19jiIpuoNxxzcG
         0f5ik9GAi9z8bD99yrYdH59jfuJ3tRNGNpqaKROGoUwJnVIUarbQmWoULzadamoGarxL
         lymg==
X-Gm-Message-State: AFqh2kostESlurAZtPzqIH7vJhIzsiKLhR4Yy+/AcjNDmrcgVrF4qhUR
        6uUroAePsy1f5eXsfeNyHkCodRmgEvaIhLD7jNZyKOK8S/MD
X-Google-Smtp-Source: AMrXdXv6HNwqIuObDUPfqN+h4ASY8HHZr38ZqY5WF8kkLMoeFtB20/F6mdbhQKjqkTwhbxJfiflIOlPTWaAN+aJisVQh9XeJt5iC
MIME-Version: 1.0
X-Received: by 2002:a05:6638:389b:b0:374:25b8:6fb with SMTP id
 b27-20020a056638389b00b0037425b806fbmr9844594jav.28.1673699538194; Sat, 14
 Jan 2023 04:32:18 -0800 (PST)
Date:   Sat, 14 Jan 2023 04:32:18 -0800
In-Reply-To: <20230114114702.1311-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006f598105f2388aa1@google.com>
Subject: Re: [syzbot] general protection fault in pn533_out_complete
From:   syzbot <syzbot+1e608ba4217c96d1952f@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+1e608ba4217c96d1952f@syzkaller.appspotmail.com

Tested on:

commit:         435bf71a Add linux-next specific files for 20230110
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11e59ca6480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2de08b99ad4f49c
dashboard link: https://syzkaller.appspot.com/bug?extid=1e608ba4217c96d1952f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1686c691480000

Note: testing is done by a robot and is best-effort only.
