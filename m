Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305D6708001
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjERLof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjERLod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:44:33 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1366AA6
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 04:44:33 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-33832662ba5so25966775ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 04:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684410272; x=1687002272;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KQnN53fkTEytMmfw++/wxE9TfZaU0f5+dS+cduchN7M=;
        b=mGbEGTv/3KUKRHIO7n0iQ3BAiKHhctcNJ3Fg2YW98BPTgUsJ/xSf2wZ4uZI3Rbi6wX
         MxhWFh2U0cgCTuCQySA/uFcrO2LdlYWf8+hNusj50FKFdfDI5IX3LGBWUWzG9G+ecxVX
         o622YU4/7+3sSASmS8Noy/QqJ8RP+2fV9aqRN482LjI3XdUnOrkY7Yb2PDour4S3lQhV
         GA4UMrJ6xSo/evKRr9rSUT5ZoRu/eztxpo3hIdMbF1xAfiau1JZVP9p4KqY2QqpxdBQ7
         MQQhUTRYGS87+HGg4jPFBOp1rVQ7yRU/VX2to9DN5YLBHfFTP+gpKKNvU0Dt0qAqb40D
         RT5A==
X-Gm-Message-State: AC+VfDy8j7J6yt6ansNRm3BUGuUBK38yMLsFloK+cS1AXlFDKAEqe/Um
        JvM4DpGc2toHUsiLuLf30m6LFz1PpFYKv+XcSho3vGtkMV+7
X-Google-Smtp-Source: ACHHUZ6/TktaaGe51jokeqcOyYIPYi9vJMKwKKZPTYOAi1vPIIYcxSHpBaAhArmgNcu0WlbNy5YtqORrN2vFwJ7HR2NOG9A8EUwm
MIME-Version: 1.0
X-Received: by 2002:a92:d34a:0:b0:335:908b:8f9 with SMTP id
 a10-20020a92d34a000000b00335908b08f9mr3132277ilh.1.1684410272408; Thu, 18 May
 2023 04:44:32 -0700 (PDT)
Date:   Thu, 18 May 2023 04:44:32 -0700
In-Reply-To: <20230518112255.4516-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f16ab605fbf65309@google.com>
Subject: Re: [syzbot] [rdma?] INFO: trying to register non-static key in
 skb_dequeue (2)
From:   syzbot <syzbot+eba589d8f49c73d356da@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+eba589d8f49c73d356da@syzkaller.appspotmail.com

Tested on:

commit:         ab87603b net: wwan: t7xx: Ensure init is completed bef..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11bbc7d6280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eb92acf166a5d2cd
dashboard link: https://syzkaller.appspot.com/bug?extid=eba589d8f49c73d356da
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1146610e280000

Note: testing is done by a robot and is best-effort only.
