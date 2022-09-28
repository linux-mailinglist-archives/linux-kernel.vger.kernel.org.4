Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AF95ED48C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbiI1GQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiI1GQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:16:30 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B493B1114FB
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 23:16:29 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id e9-20020a6b7309000000b006a27af93e45so7145498ioh.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 23:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Z339FYdU9+iXNfue2zmLUxx6HUu2Sr2qDtiusHT0KhY=;
        b=cwqBd/kw20aO2RLM9c9zZQZO1Q11J6OSshg7Td/ocEYuOQD7doyQdGfCyF7kO7rWGg
         5pOL3/rcvUMCtyGdukFkb+TS7GkzUWhxwiSkTRMXwYT2PpP5jAP3g/0n6PvflMXx7J/i
         Y8/WLsufMBtl3+8x1ZHYL/+6EXhPMq5WjxVmTytwYiC2gTKkwdXxJqETIu8P4R2/ku1y
         Vz0cZIifJ9/fcahXhAOzWwtQvLoNvL5RHXW+g1IOCO+gAgxL/o0wIiVqmXy8CceTGPd3
         KrQlsVs/FjRtuN4Jl+15dxPNbHDCKWyt5fARyNjexIPprad3ScQcCFrD+6ja82P8JujP
         JQPw==
X-Gm-Message-State: ACrzQf1ZAQxKv/rLd/6RHwpx3nSXvWpknyWfT1CSk7IrRUboWpDOzBi9
        qg0LlyRdh0y4+nzH2TcCSIuf/wBR6k05u++EqE+GccN0meLo
X-Google-Smtp-Source: AMsMyM7UwJJT5yH/iid3vvJWyCpOQ2n41iNMeCecYUkoPWmZmdwPlLmvfYJB9HWXT/pIbyvnM0tR8ovSkpM/Fl2BRemSL8VKgIGs
MIME-Version: 1.0
X-Received: by 2002:a05:6638:300b:b0:341:d28e:871 with SMTP id
 r11-20020a056638300b00b00341d28e0871mr17168181jak.140.1664345789060; Tue, 27
 Sep 2022 23:16:29 -0700 (PDT)
Date:   Tue, 27 Sep 2022 23:16:29 -0700
In-Reply-To: <20220928060450.1989643-1-eadavis@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a5cad05e9b6b3fa@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in ntfs_get_ea
From:   syzbot <syzbot+c4d950787fd5553287b7@syzkaller.appspotmail.com>
To:     eadaivs@sina.com, eadavis@sina.com, linux-kernel@vger.kernel.org,
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

syzbot tried to test the proposed patch but the build/boot failed:

fs/ntfs3/xattr.c:55:7: error: assignment of read-only location '*ea'


Tested on:

commit:         e47eb90a Add linux-next specific files for 20220901
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
dashboard link: https://syzkaller.appspot.com/bug?extid=c4d950787fd5553287b7
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13898c04880000

