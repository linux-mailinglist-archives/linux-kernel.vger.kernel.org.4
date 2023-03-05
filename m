Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7C16AAE79
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 08:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjCEHU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 02:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjCEHUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 02:20:25 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D1B12051
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 23:20:24 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id n42-20020a056602342a00b0074cde755b99so3796316ioz.16
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 23:20:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0UvtJxk7SEbcLwhl0edmz46rUXI/DZJLfPEQ9/grmDM=;
        b=oI7oU1Hhvp/PHyy3rkhRtKqsXzej913k/t+pZL51ZhulVBsoWtcXZgUL1olefxS6rd
         amPESuZ2V8Tn8vH8zC+Tukf8JD5g7c9xHj4EaACza8/KMiK+jRo9r+hwuCr+hbx4o0Jt
         lwztZ2pODODpvu7Z02tvurzUxxVBxLGQYXSVaQS0LDxotceNa2qnI+SNL2aOl8pqwaW5
         v8Pma3fDdJFRw/rpNhOEe3Zc59SN/nI0Ufaed+jJpLncV8YqiP5wqrRzEQuD0hfAH0Ji
         unkaed8qaeVy+/UdJbB5X9wtuh6Oyn05DBTAOWhzzg6Kudn8VGCWbMVLSmrVaqZqOKXB
         bP5A==
X-Gm-Message-State: AO0yUKU4P46GsHPLdDydaqpOiecAtOADT7apxu+VzcHziprad8JUeDcZ
        BuxYCEjS8LIAA8m8NtKqLSq8KKwrg9cJJ7dfDYscTElasggY
X-Google-Smtp-Source: AK7set/9DGUrj0FCK53MRy0FLH8PcAA5D62h8RO9tIxx3yl2o752GUzn7ObuuN2IER/vdVOhmW1aR1I9h2KJxo8K32TfRyY9qTwa
MIME-Version: 1.0
X-Received: by 2002:a02:94ab:0:b0:3ad:65e:e489 with SMTP id
 x40-20020a0294ab000000b003ad065ee489mr3313991jah.1.1678000824269; Sat, 04 Mar
 2023 23:20:24 -0800 (PST)
Date:   Sat, 04 Mar 2023 23:20:24 -0800
In-Reply-To: <20230305065750.2841-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001041d605f6220386@google.com>
Subject: Re: [syzbot] [mm?] possible deadlock in collapse_file
From:   syzbot <syzbot+534d1c3c0c08473dc853@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+534d1c3c0c08473dc853@syzkaller.appspotmail.com

Tested on:

commit:         1716a175 Add linux-next specific files for 20230301
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17dc4f74c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e4da7f0aef5d2eb8
dashboard link: https://syzkaller.appspot.com/bug?extid=534d1c3c0c08473dc853
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16b227b0c80000

Note: testing is done by a robot and is best-effort only.
