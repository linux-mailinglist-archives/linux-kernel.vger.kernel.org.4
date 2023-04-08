Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DFF6DBAFC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 14:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjDHMkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 08:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDHMkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 08:40:20 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6EAAD3D
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 05:40:18 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id a8-20020a921a08000000b00322fdda7261so872243ila.6
        for <linux-kernel@vger.kernel.org>; Sat, 08 Apr 2023 05:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680957617; x=1683549617;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=01pC1hdBBxREdw8MSWmfe2YpqCxfdTSyTySSDQFo/FE=;
        b=OoYTaTQj9XlVliKqouw1401B/QS7x1lJfS4bT67Vagt9p6y0DAU0bbSeoJDVDF7K3Q
         Z1qXnP18bPe3lAXyOefjfu5FFfHSTdVpeP4XQ30n2Yx+rPieCFoGQzZ+ngPnpIkO5dkL
         wi6DmllyEWU6xqZU2CFL7eOXpKvppGbSnlK8HqTsbro8Ctky1u47jBVfs2+OJl8eRjn1
         prWTTbcDGMckfuNavLvPtJRZogzlilXki9nQOg/8qe/6m8+9TP+d8XenFwC+PTf+JQXW
         iKsqUwnDMFAJlPvUpMTCz7vdvQ84j6zyHxVVCDxZCoOV9Di8yX0bWLJyoRRTijUyPITV
         kHMg==
X-Gm-Message-State: AAQBX9cRT/CHa/q0cxJm2kHdMZpBAhanSRRYhppb6BA8WQkBcbq+17Ka
        vssHxSntGsJX7TPyPt5wzpQDoU/bSGcPWnBUevwUfw0IIBvC
X-Google-Smtp-Source: AKy350ZMbhviuYEVu8MSSLRL9NS0T5WmPLf3zj+X24hcjhQM2HhShZFWK3m/sEw0Y6hwLIWMgrOePu2rRVRJSkXU5q/+zY2XWpWc
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144e:b0:317:fc57:d2f7 with SMTP id
 p14-20020a056e02144e00b00317fc57d2f7mr2814284ilo.6.1680957617681; Sat, 08 Apr
 2023 05:40:17 -0700 (PDT)
Date:   Sat, 08 Apr 2023 05:40:17 -0700
In-Reply-To: <20230408121751.1444-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000af3cea05f8d2710d@google.com>
Subject: Re: [syzbot] [net?] WARNING in cleanup_net (2)
From:   syzbot <syzbot+7e1e1bdb852961150198@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+7e1e1bdb852961150198@syzkaller.appspotmail.com

Tested on:

commit:         f3364222 ptp_qoriq: fix memory leak in probe()
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1078b369c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea09b0836073ee4
dashboard link: https://syzkaller.appspot.com/bug?extid=7e1e1bdb852961150198
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1623ac11c80000

Note: testing is done by a robot and is best-effort only.
