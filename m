Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDDB5E892C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 09:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbiIXHcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 03:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbiIXHcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 03:32:23 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82973B6021
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 00:32:21 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id b9-20020a6be709000000b006a469cf388eso183407ioh.19
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 00:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=smF9HOdC+2VyuIQusJkqLf0ZxepoTAJJv1ZHTIKRl8M=;
        b=IBkK9yrCWtnZ5vnnAkP8IwcgTVteTqNri3xBm3QF3udnNrJfkdaSsDGyXqGXwhksur
         lonOwU5+ieuC5/M2hwVYapVXJznPwP+4MHdiChsm2B85FCpJthVHvhIO4eQ97z/9bkhO
         s9M9ZqB6XdoolborjA38JqwifPRAe26gliw9u/89o988YRxv5XWiD/078YeRtXZPWaNK
         lBoZuM8pvMZv9hXE2tUGVaohh0ot3enygXA/yBGWiRJQTwfou63WJqBU1YucLKNK//ak
         uGSS0pTTJUXrWUZGg6dLWTahE5lO3v2hQrx43ckqlOvyG/bGldaIbdWEBP9Rvq4fgYpu
         58Bg==
X-Gm-Message-State: ACrzQf1mIwszflENGVZk238Fc2+7Fpl+LCgo0wBlKQhiuQsTWMDgJg01
        fIPGxjApdFsyg8Bz8zRrBcX2THnnrtsc5JWykV/sLD7u2B98
X-Google-Smtp-Source: AMsMyM5dpGDWio+1+8ELwAvfIQQcmtxpvjqTNwVl62gZuxZPf/+C54q/yGdRRt2kmcIH9d9supA+klcDz9KQHyEup54tWf+JEwPc
MIME-Version: 1.0
X-Received: by 2002:a6b:670b:0:b0:6a0:d9db:5ae5 with SMTP id
 b11-20020a6b670b000000b006a0d9db5ae5mr5283649ioc.62.1664004740784; Sat, 24
 Sep 2022 00:32:20 -0700 (PDT)
Date:   Sat, 24 Sep 2022 00:32:20 -0700
In-Reply-To: <20220924071035.16027-1-yin31149@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007aab3a05e9674b8c@google.com>
Subject: Re: [syzbot] WARNING in wireless_send_event
From:   syzbot <syzbot+473754e5af963cf014cf@syzkaller.appspotmail.com>
To:     18801353760@163.com, davem@davemloft.net, edumazet@google.com,
        johannes@sipsolutions.net, keescook@chromium.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, yin31149@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+473754e5af963cf014cf@syzkaller.appspotmail.com

Tested on:

commit:         aaa11ce2 Add linux-next specific files for 20220923
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13b03250880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=186d1ff305f10294
dashboard link: https://syzkaller.appspot.com/bug?extid=473754e5af963cf014cf
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11b03250880000

Note: testing is done by a robot and is best-effort only.
