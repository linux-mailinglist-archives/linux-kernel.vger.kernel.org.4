Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657C75E727F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 05:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiIWDh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 23:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbiIWDhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 23:37:22 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A56E2376
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 20:37:20 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id r12-20020a92cd8c000000b002f32d0d9fceso7096922ilb.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 20:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=5ze3YQW5N0TmNeATfGMitJ0JVafKh+S3YbktO/jFZ5s=;
        b=qlGrDadNXgr5fNxY7FYomUcIozo706Nx3+fXOpDE/O+9rWW63EENJJGHwfh6m4gmFQ
         QUHB+Vhb/JgQqY3My13KNHfb0MOxZ0J2+uNYELA2PqPENQ12elEjADKvZ3MduVpRWxgD
         M29tudQkqKLnuAMvvSpGFfdWexqX5YAYjQoFaAzU9ADVhiQyQPgvgV7/3EWFhFTpHDsy
         2T6oPoXbgfUrneI4SWoMTTAte0fTDZNwTHJnv7SQC+FRosViZAT9K2NAWddr+ELXTXz6
         vMcfI4W3U0p5MlLRssmGDDCR7zECamHGy0EbttNeR2esH+FI2n8WT/OnYl0UtOUc9EfZ
         dthw==
X-Gm-Message-State: ACrzQf0IqcHa2wQRDBUimBS0m/jVxx3oVqCjU0UQYkiEgr1lzg65qCmM
        dYjdB+ECGsMKzTgG09yeSn/KxnD73tEckIa7tAduTJYz6njl
X-Google-Smtp-Source: AMsMyM7yB4yE29iDKfFCHHb5VnJzUZh6ETwiKi/ZaQnBsVlm7oEzx38br16XR/PW7MyFBVryjMKD5YTofJno6sZwT/BeA0sEEywl
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144e:b0:2f5:412e:7d1b with SMTP id
 p14-20020a056e02144e00b002f5412e7d1bmr3270199ilo.196.1663904240191; Thu, 22
 Sep 2022 20:37:20 -0700 (PDT)
Date:   Thu, 22 Sep 2022 20:37:20 -0700
In-Reply-To: <20220923031722.3744-1-yin31149@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002d50a505e94fe5bd@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in run_unpack
From:   syzbot <syzbot+8d6fbb27a6aded64b25b@syzkaller.appspotmail.com>
To:     18801353760@163.com, almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, yin31149@gmail.com
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

Reported-and-tested-by: syzbot+8d6fbb27a6aded64b25b@syzkaller.appspotmail.com

Tested on:

commit:         bf682942 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=15dcd888880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=122d7bd4fc8e0ecb
dashboard link: https://syzkaller.appspot.com/bug?extid=8d6fbb27a6aded64b25b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1476e5b0880000

Note: testing is done by a robot and is best-effort only.
