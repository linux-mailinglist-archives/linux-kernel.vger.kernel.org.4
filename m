Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E75652E2D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 10:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbiLUJEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 04:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiLUJER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 04:04:17 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB21B9FF6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 01:04:16 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id r6-20020a92cd86000000b00304b2d1c2d7so9736169ilb.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 01:04:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ia4dJITgQv0bYAFEjbhJvQ4iASXrHbDprdY2PuEPXho=;
        b=xNHT/uMm33D3qvB4uxOrQ6OgV4JuroGIub18x2e2hpIXfQxWgQTv3/LZXSCdeO5mgB
         S/NbiffEte0qKy41SVWwAxwJteAOukOeKhQ9dhkQMWy993D7/gsOLVzqXEchSSEtADm0
         GhDPR5GQTVHQIW//wf1oKErmmEZHYwyI9LqfEbyb82rnNW2BwQSD9vtq9MWVZ3NHHvfM
         nUHaOgGpA8hccTj/2sprzOyPWM5/rMytTzzfnmLjOuHCbOGJGFTk2ZwsJu/BadcrFodM
         sCGXsKEBEAVjfQhDHw7qab2R04zLZwzUNja5gdL9LVCGUwR96Y8xc7buH+1oAe3H+JH5
         M/Sg==
X-Gm-Message-State: AFqh2kojpnyj+vU1Thm4kZLFlhFjw9znHDpSSQe+guqMX9iJoWN0lfn+
        VIPNlWfzeXk74iucgqmkOt1GaMAkP4X78xYkNqCyTOGdiVf4
X-Google-Smtp-Source: AMrXdXtMpTcOIxU50ZfMZW6MV95T7PVHS6tNn/AnpqOhH6B0O2gJj3giuH3QVrwkD8QOaLdzrJfZOldbg/Mz/O/jDq53ZWc3alZ8
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3465:b0:38a:66d5:f599 with SMTP id
 q37-20020a056638346500b0038a66d5f599mr62164jav.274.1671613456040; Wed, 21 Dec
 2022 01:04:16 -0800 (PST)
Date:   Wed, 21 Dec 2022 01:04:16 -0800
In-Reply-To: <20221221072129.1698-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003fcf9105f052d60d@google.com>
Subject: Re: [syzbot] WARNING in io_sync_cancel
From:   syzbot <syzbot+7df055631cd1be4586fd@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+7df055631cd1be4586fd@syzkaller.appspotmail.com

Tested on:

commit:         b6bb9676 Merge tag 'm68knommu-for-v6.2' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=12e09a08480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8ca07260bb631fb4
dashboard link: https://syzkaller.appspot.com/bug?extid=7df055631cd1be4586fd
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17a06d8b880000

Note: testing is done by a robot and is best-effort only.
