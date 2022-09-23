Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2935E789D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 12:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiIWKpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 06:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiIWKpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 06:45:34 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B00110D64C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:45:33 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id b16-20020a5d8950000000b006891a850acfso6318209iot.19
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=guRptB1aXuokekh75LtENExgpfDq4mFI/7AbvWfVv/M=;
        b=kfyEuOG/JtpDlknl9+ZUvDl6/sNIfVFX36q2guoBV45AqBTtVAAtfN9locyZKQ43o6
         7QigsHxxXXZHKMZ65/PmRiO53wD9Nupx6wN/zWNwECqfiIBSAXz1B7QNkLDyPPQ6sqGK
         INwMgytpn5fO58rJ+gHIRGUMJ6wgRbfmGj1jb/MIYAXf/yJRA58THQUnYMobyv26K8zo
         huaxoYcOBdm3W8yVutwT6L2D5gDIm0UTC6ndcgYGl0JZHJB/Q4r7kxJrbI3hAEnSedEZ
         OklgxuQCP73Vomi8XTl82iWoiJ79uebt9WK9aekmgKmzoXfonVS0qNoFwfmBGH1S1Vio
         u/MQ==
X-Gm-Message-State: ACrzQf0uhN3WHrehyTCUfQ/0c2jymGlydnuXVZ2tP2St45liFNsn/pck
        MJOSFl0LteEoxCD7mBoXvuaw6HIpYh7iMP3iQzlTsQIYDfJ3
X-Google-Smtp-Source: AMsMyM64WcmyQDU1KZt1/6qeLP738A7l/2qN8DRXfYKEQt7krYETdXMcFgefoFrCAm6ylWAxiAtyWJynE/alVTjnVwLhRvACSf52
MIME-Version: 1.0
X-Received: by 2002:a05:6602:27cd:b0:669:3d8d:4d77 with SMTP id
 l13-20020a05660227cd00b006693d8d4d77mr3683010ios.216.1663929932655; Fri, 23
 Sep 2022 03:45:32 -0700 (PDT)
Date:   Fri, 23 Sep 2022 03:45:32 -0700
In-Reply-To: <20220923102721.32425-1-yin31149@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009134ce05e955e0fc@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in run_unpack
From:   syzbot <syzbot+8d6fbb27a6aded64b25b@syzkaller.appspotmail.com>
To:     18801353760@163.com, almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, yin31149@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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
console output: https://syzkaller.appspot.com/x/log.txt?x=13c704ef080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=122d7bd4fc8e0ecb
dashboard link: https://syzkaller.appspot.com/bug?extid=8d6fbb27a6aded64b25b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1476bc18880000

Note: testing is done by a robot and is best-effort only.
