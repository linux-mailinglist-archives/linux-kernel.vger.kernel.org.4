Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DB7732675
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 07:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbjFPFB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 01:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbjFPFBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 01:01:24 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9870326A9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 22:01:22 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-77d825fd3bcso26334139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 22:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686891682; x=1689483682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eGnwxdo2DEMIi7tpDl/sj1NsuPf/fjo1eZwFLbHh/oc=;
        b=Sm8ByQ0C03TQn5m5rGLOGVVI9ZtQNJsMAxkSp1Wty+c/492581vJRBClQejiHWQXme
         /UqwBZjwJeRwyUMy73B6AHrj0OYUqv3AKweee6grT6Eww972Gju8lnUsqL/cvwUv9foB
         H8OPr4/qwKXwm+fPigIa0xdOM+31g2i+UY9Z/LF1VqjVnH5/9TMDrULWjGtHkqieh9P4
         9n0PlRAsySc5eMsp0ig0mvVpCTV2dM8MggbTGoUY/Wbt26MOfKVihJlbNIikmz+Zyx2e
         lXE30FO2dLCejwedvMRpsxSmV5s3zFC5VNOhQODCCc6InjShXnJtXGOwDUYC9chCJkTJ
         BcUQ==
X-Gm-Message-State: AC+VfDzp85L2m0MBH0T3+ydHWg4lukrbe1XCtijnaxF8HoCm5IxGAORw
        tYeci2bH/wv5u5qnwOzfbCbhsHGbBao2uFDELb2i9kqqvAvr
X-Google-Smtp-Source: ACHHUZ6chEzs+H370XGbzmOcYS60hX1wyOhuKQHSGSvTc8wzvYQfpRdk/s8FYqZChd2H1Q8CFppxMqo46ogMdIqov/rMlSBJIyS+
MIME-Version: 1.0
X-Received: by 2002:a02:3319:0:b0:423:141e:f20b with SMTP id
 c25-20020a023319000000b00423141ef20bmr303599jae.2.1686891681994; Thu, 15 Jun
 2023 22:01:21 -0700 (PDT)
Date:   Thu, 15 Jun 2023 22:01:21 -0700
In-Reply-To: <415439.1686877276@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007adf2d05fe38132a@google.com>
Subject: Re: [syzbot] [crypto?] general protection fault in shash_async_final
From:   syzbot <syzbot+13a08c0bf4d212766c3c@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dhowells@redhat.com,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+13a08c0bf4d212766c3c@syzkaller.appspotmail.com

Tested on:

commit:         97c5209b leds: trigger: netdev: uninitialized variable..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=159c4d9b280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=526f919910d4a671
dashboard link: https://syzkaller.appspot.com/bug?extid=13a08c0bf4d212766c3c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16962727280000

Note: testing is done by a robot and is best-effort only.
