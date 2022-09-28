Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2580F5ED538
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbiI1Goh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbiI1Gmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:42:36 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FF11CE915
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 23:42:29 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id b5-20020a05660214c500b006a43c89e0bdso7255017iow.22
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 23:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=mCAycv/Xy8xJZQu88o3XutTjchef/QceVazHc9+w6Y0=;
        b=JIkGBsxmX7RlJuZPsY5h6qJdU0bQlnVsjEA5jQ7ZirnR4iYpbQp39/Fm9eK3De52Kf
         WabF6Js6/QFWiw/IgXp6dHw33fE3oji5ljLkXV37nAWFhk8Q7XGEBddyee99Lm62OeSq
         hm+W15QgHsmj04yEYzFRyoOaoPsJ+UqAlrBoVjEv3r7ANDq9gTAyqWOx8TWjDTZfXAya
         pGLXzOfbB2m/AiurJtKfyyQ7l68UQqWzSqESVnXmjfaPs0XXhEhw877y/5D7uRgFOE+x
         cuSytzgsKTTN6gy49dyMc21198y6fly19lGac/I5lZ6UcaFJHz2p6mluUPZ8Yd+LDmBZ
         aGjw==
X-Gm-Message-State: ACrzQf0orTN3EzBgxH1Z2s/GXGb8S2eYzh5TlAMEHiVIpFRh/nKnxSZO
        BBu5t9AncR6dA06haatU3VRzUGhlqUYE2d2EQaRz9sqJ1hvF
X-Google-Smtp-Source: AMsMyM4DfLdICAOA2S6B6fikVbD+urWF4EmrLSJ0xmqBCbRBNc38ZmCHgNKUb2QlywRbBZV1PqJ60OQESrJMUu8jEQa4EtbCv0AW
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19ca:b0:2f6:b3c5:4aaf with SMTP id
 r10-20020a056e0219ca00b002f6b3c54aafmr13456567ill.251.1664347348209; Tue, 27
 Sep 2022 23:42:28 -0700 (PDT)
Date:   Tue, 27 Sep 2022 23:42:28 -0700
In-Reply-To: <20220928062932.2003766-1-eadavis@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000079174905e9b7107a@google.com>
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

fs/ntfs3/xattr.c:60:14: error: too few arguments to function 'size_add'


Tested on:

commit:         e47eb90a Add linux-next specific files for 20220901
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
dashboard link: https://syzkaller.appspot.com/bug?extid=c4d950787fd5553287b7
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16a32d40880000

