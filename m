Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C726612140
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 10:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiJ2IFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 04:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiJ2IFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 04:05:25 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0DD18E26
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 01:05:22 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id bx19-20020a056602419300b006bcbf3b91fdso5604191iob.13
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 01:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q9wscaXbXxpLFuTY2ImLX52MTeS60mFdqsZh11dpuKo=;
        b=l83K1/Db9DQqK7CE2GNEgqpKXLFBjTNiVFN+/9KYPArNwttt43U3PRWpGtK9fufiqS
         S1hwOva7oABJhX7A60nxIkNmZB/XI0v1S6oTF6jauBHKmSMdrLkK2Ts9w8kx1Ibf05UQ
         1YK4iMQwvWfMrMUfS6zy3FxVKc0sJgXhoGpgBZUSH+JcSS8xr+SNrgDUmPMQKAhqrxpQ
         teMHEtRzWqKespmtgLvLcr/dfzy4em5sVPcF6JHgjzpQSO37+sJTWLhBwq5TfEYI7aNh
         Vls3QwdF+QaIYiXOOepGa0O+PCTN8bbQ6no+0gbO7RU8g1s+FT0y+91zyi09K9/FH9ea
         +Dow==
X-Gm-Message-State: ACrzQf0hqszZK8Iy6S4CY22OjRa1x5rMbhX6Yn8oNnfUMxy1UBnDercC
        G6tUugUSftgQmJYeMi4i7FwF5eAsTZxeYXCYUFLLfSCyT1/2
X-Google-Smtp-Source: AMsMyM5bYQ7ZhQeZgeze1DL1tZY15SmERk/7bCvPVQLSqfYYMppt7tzpJhi2I/GvBUkpTy7AVvfrRam5U8TQawFky10Yi6i+1vw+
MIME-Version: 1.0
X-Received: by 2002:a6b:7004:0:b0:6bc:6ccb:aac0 with SMTP id
 l4-20020a6b7004000000b006bc6ccbaac0mr1545057ioc.128.1667030722034; Sat, 29
 Oct 2022 01:05:22 -0700 (PDT)
Date:   Sat, 29 Oct 2022 01:05:22 -0700
In-Reply-To: <20221029073104.3494-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000442cc05ec27d626@google.com>
Subject: Re: [syzbot] kernel BUG in dnotify_free_mark
From:   syzbot <syzbot+06cc05ddc896f12b7ec5@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+06cc05ddc896f12b7ec5@syzkaller.appspotmail.com

Tested on:

commit:         247f34f7 Linux 6.1-rc2
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1228bb86880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d3548a4365ba17d
dashboard link: https://syzkaller.appspot.com/bug?extid=06cc05ddc896f12b7ec5
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=137b6716880000

Note: testing is done by a robot and is best-effort only.
