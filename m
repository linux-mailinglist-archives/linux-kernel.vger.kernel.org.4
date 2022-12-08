Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61373646C81
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 11:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiLHKOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 05:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLHKOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 05:14:18 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B048D8
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 02:14:18 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id e15-20020a056602158f00b006e01d8fa493so466136iow.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 02:14:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ck/OJ5C04HGwxSU3fIu9gj5FXxCoIgfeJcnFIYubL/A=;
        b=XQXjPAaODB0tmeu7FzbBeu7BWayFuaJIhtKS3w4pyLsurQHbRO9UfupcaOUKLdafwH
         BlvpoSIKjfKhARvN4w1wOiHoirB8YeBKEcTeTYwtDh3TWoEF/aDZO7mLUMP/cx/rsR12
         cyjjO5yOJblTi+m+6U7B0CheV8LqzGqBAJFwirev0AngddFHRPhVhwpMubmMZ1/dvWfC
         xVKdY0e6UPdNzn+COAwR6fYb3szFUBLIPEkulXkQiPd13X3D+5GK3dTa/cp1PUYtdmUb
         +MMA1YtuOvkxwAXtBQcd6E12gn61o9kRfJZRDLzLBSm4OxcsLASON5UdUPhkOG787jG/
         eAqQ==
X-Gm-Message-State: ANoB5pnMKhfu9aMs70jZcM0SKnAlY2odlwC33qa3hutPz4MtOForA8pG
        k4ukj6ocE9U2Ihaj2k91BUZ2/hF6ye9BK6ibF6bAzH9Ch90y
X-Google-Smtp-Source: AA0mqf6aISMpQQpNt5r4gR8h07K+061CFj/N1QaIyJlQYuxylup+qxFUtL3HBYJ45CATXGAIR6MVGo5Rclaj7Sq0oVf7T5p242Tu
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4122:b0:38a:5e91:5d49 with SMTP id
 ay34-20020a056638412200b0038a5e915d49mr4772971jab.147.1670494457530; Thu, 08
 Dec 2022 02:14:17 -0800 (PST)
Date:   Thu, 08 Dec 2022 02:14:17 -0800
In-Reply-To: <20221208004858.7962-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bd8fc505ef4e4cb9@google.com>
Subject: Re: [syzbot] possible deadlock in ovl_fallocate
From:   syzbot <syzbot+38a94e1872470e3450a6@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+38a94e1872470e3450a6@syzkaller.appspotmail.com

Tested on:

commit:         591cd615 Add linux-next specific files for 20221207
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1030277b880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b2d3e63e054c24f
dashboard link: https://syzkaller.appspot.com/bug?extid=38a94e1872470e3450a6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12e0851d880000

Note: testing is done by a robot and is best-effort only.
