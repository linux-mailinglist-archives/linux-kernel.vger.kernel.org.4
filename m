Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BA765CD92
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 08:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbjADHYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 02:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjADHYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 02:24:18 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44681F6A
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 23:24:17 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id o10-20020a056e02102a00b003006328df7bso20724251ilj.17
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 23:24:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XllRwVNPJewnOOdgcbNRDStbcQ4EJX1mMmPrmj8bzgY=;
        b=dyUSJ72yGhv/2cZBgMQDmfKGy+07OWAJLPSpUveSCT10bCASc43Sj8KUHj3YU3q2UE
         TSlG0g+9oYLzJmRARrxNhwWRJOCCz6cTRX51+zB5yJINCx24guR2xZyHJ0F4KZN+QFye
         e+G1uGPrHEeYd4sIYfgeQw0JsAR2poUSOoGhYhf39jPSkV5ujCRQ4gzlnFcJhXgHkcPD
         KBZWkxjSBKltxnncEXj+iRlC0C03yjg82VOI3TxS6zvoJlW5YjbBiReklIWsVu2mx2tJ
         lepimSw9StjkgUKyDaIEfM9rI9A7dZBJwzZ7xl7ivUffLCcCaOTzAeSuHuXsCinFzgtg
         Y20w==
X-Gm-Message-State: AFqh2krnw7aOUXEGEY363LS8wWv5YAXohp+MXiSdy5KaIXkxYOlhE/Zj
        8winuubnBm1qlNL1TqIK/kr5fTulFSXllv7m3nm16aAE5m4e
X-Google-Smtp-Source: AMrXdXtb5CmwO0LgDYhoePGgpzOCdx0DFM6qTaL/a4MTONEwRVcaLpCisSDwnbkXYKjAbilbbr6gzwyMnDBuQhy0m7SLaOTgfuch
MIME-Version: 1.0
X-Received: by 2002:a6b:e90c:0:b0:6e0:1f4a:f8d with SMTP id
 u12-20020a6be90c000000b006e01f4a0f8dmr3175896iof.85.1672817056667; Tue, 03
 Jan 2023 23:24:16 -0800 (PST)
Date:   Tue, 03 Jan 2023 23:24:16 -0800
In-Reply-To: <20230103233508.3915-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006fde9405f16b12b7@google.com>
Subject: Re: [syzbot] [ntfs3?] INFO: task hung in attr_data_get_block
From:   syzbot <syzbot+0ed04a03534f9788b484@syzkaller.appspotmail.com>
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

syzbot tried to test the proposed patch but the build/boot failed:

patch is already applied


Tested on:

commit:         69b41ac8 Merge tag 'for-6.2-rc2-tag' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
dashboard link: https://syzkaller.appspot.com/bug?extid=0ed04a03534f9788b484
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=157527f8480000

