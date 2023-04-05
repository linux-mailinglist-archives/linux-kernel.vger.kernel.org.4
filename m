Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFA66D7508
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 09:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbjDEHMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 03:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjDEHMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 03:12:38 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659A626BA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 00:12:37 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id z65-20020a6bc944000000b007584beb0e28so21349993iof.21
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 00:12:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680678756; x=1683270756;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=56KxZ/sRA1+h9SvZZ/t2tZdukaXpNb16y/Z4wg0h6oc=;
        b=f62HIavtBLeLDoOrKe6/3n06EOh7Ko8msyglfRO11NjPP5mU6df4vnBeqfMLw+9ESt
         bd2RTEDauAJFOiOQBJpjT6nNpY/+9ooCu5CoxEqoQeEowMQGytGysy2ocOvpKA9kYQ0f
         NyjYvOYuQh/juRa8qTA3JxqHytnTKOmbrqpOqoArH9Va8DloFCFUyRz8OVI+CMRD0HXU
         FOcQQF0z1pJFzhgbQQ6FswNpNGT/wB+KLwVn6uOeMNnNTFhul1QkP+glU/s3OGnFrVxj
         8XxxqYV+mvFcN7Pn1wlKQhwgiDbCXgtqLfQnI9vCAUFs3waa7vGeTBIuCgyfGPJfO2by
         Sr4w==
X-Gm-Message-State: AAQBX9fMoapVDTrpAd29d12pvnzt3dG76ot2unrmgDSFPPrtban56I6K
        Ip3lmQbo4ImoqvrdENYYoHSMbGgAC1HD3Ivmlx/uT3YUIcGQ
X-Google-Smtp-Source: AKy350YH0zX/kM19KNebrW9vahqBloRe+sGWg5TdSWmQcrLe6uTh/xpv7oKFAc4mfLcdobBhE74r0rD2d0S4t4pTYDPiwxhKYAj2
MIME-Version: 1.0
X-Received: by 2002:a02:84a2:0:b0:406:6686:2e0c with SMTP id
 f31-20020a0284a2000000b0040666862e0cmr1077494jai.3.1680678756765; Wed, 05 Apr
 2023 00:12:36 -0700 (PDT)
Date:   Wed, 05 Apr 2023 00:12:36 -0700
In-Reply-To: <20230405063057.794-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000475c2c05f8918492@google.com>
Subject: Re: [syzbot] [kernfs?] WARNING in kernfs_remove_by_name_ns (3)
From:   syzbot <syzbot+93cbdd0ab421adc5275d@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+93cbdd0ab421adc5275d@syzkaller.appspotmail.com

Tested on:

commit:         76f598ba Merge tag 'for-linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=121a4efdc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9a438ce47536f0c
dashboard link: https://syzkaller.appspot.com/bug?extid=93cbdd0ab421adc5275d
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15e507f1c80000

Note: testing is done by a robot and is best-effort only.
