Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBDA617C96
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbiKCMdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiKCMdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:33:21 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22565BF40
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 05:33:20 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id s2-20020a056e021a0200b0030087a59cf9so1457250ild.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 05:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mnUN7fIuCQoJ+XiEFwmHiqHSLrPUPpAusWBh9u/mzIo=;
        b=r+5GsekW1EjTJiKmQFMu1Y9GpTM14Lh6+ytONIJDg6qG/hUSl55o0cLmU6qYdRP9O5
         QXuAF2Q++hhU0PsC68l3SjeNkK8jDGxIT6FjSgJ1gbhjEgo7waD+ljlXecLukOZqB1Hw
         /xKgf6XNCv10gxYFWljodcGk10pb8OPGLtYZEBkejDgGDAv5huhAzyt3U9Wy5RbDo6Pk
         SiTxCpgZM8TMegxbYPMsGPNPln3BZRWGRUL2tgsfGeBr75SloPpIxIRYAXxY2n9N+Iri
         m6bau8P0x8VHLNm4fpuaZjrdxtLI/OMJJRZJ+5J/+hMNdKOI5q7yooj9jA7LGNc2OruF
         qS9A==
X-Gm-Message-State: ACrzQf3s3I0kIxf7q+j7S6tnyEz1l3v9/GzlXP/pGNp2VKZzgsS1qlOQ
        X2Dh/tPyfOg6CcHP7YzzfYeg52AYqgeD5/z1+dQnMD/pkFxX
X-Google-Smtp-Source: AMsMyM5PAizC1EMPqrdKv3ybZGrrnmHku63OOgaDBIuNOiZlSrVZCl7ExjNWJnH0h5Jqd0PjJ0vyhL7m1CP/3kqBeRmClEY2m+yx
MIME-Version: 1.0
X-Received: by 2002:a6b:7616:0:b0:6c3:c8c2:ba34 with SMTP id
 g22-20020a6b7616000000b006c3c8c2ba34mr18065317iom.126.1667478799483; Thu, 03
 Nov 2022 05:33:19 -0700 (PDT)
Date:   Thu, 03 Nov 2022 05:33:19 -0700
In-Reply-To: <20221103120829.504-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000083884305ec902941@google.com>
Subject: Re: [syzbot] possible deadlock in static_key_slow_inc (2)
From:   syzbot <syzbot+c39682e86c9d84152f93@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+c39682e86c9d84152f93@syzkaller.appspotmail.com

Tested on:

commit:         a2c65a9d net: dsa: fall back to default tagger if we c..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12379ab1880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
dashboard link: https://syzkaller.appspot.com/bug?extid=c39682e86c9d84152f93
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10379ab1880000

Note: testing is done by a robot and is best-effort only.
