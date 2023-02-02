Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C827768759F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 06:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjBBFxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 00:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjBBFx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 00:53:26 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5CF46171
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 21:53:18 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id b16-20020a92ce10000000b003125834f6a5so647510ilo.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 21:53:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F5X3PEWTVkHnwFAbIlbT7YNh0EaczW0sbZvQk9H2knQ=;
        b=VmnZ8/pY8ce3Xnan5BMQ7ki5vAbSfgujD3LOMUa8sZc2Eu5n5+LbYkW+hE75K+ZFRx
         ojnMQKQrTtTZllG664ETj5MRCPMThMH16/T6QgUu4itLU7x80vvL0g10ekhHWVE2Hjkb
         iVzzWCqjVh4DIURz4c60eNNyh0Nf8SzKaUrYe6Vsh8brTVBr76ZXUstejEKcLvcyTCFG
         KGBIh593FT8fLQfvVApHfMR2qme0K023BD0GZ+OmgWVLWmddyqcaPVfjZzmi+jZzpFXj
         0Ikmpbj2NZE+kMyjpXBUJ/KgOkC7CBhl3AMmvrEhjv02IpLPz1lwmC6E+NeICWT/+leY
         5mYw==
X-Gm-Message-State: AO0yUKX4EofdNuUs1SKrATz4kavZi9ylOS35d8IUUjfuUKZN0h63dp9Q
        FeyfzF0e1JaNJSYOjPqpAOqlCt92skVD3DMcNbz3hhjwOC8L
X-Google-Smtp-Source: AK7set+DnsN7U0QwpHa+DKS5CVGCdrgz4brE1tjyuO4LuGYCXUuSDVFGZD5wJ0PIXY3Wec5knp91LLHnHmzUryPg08kHGor3VuJh
MIME-Version: 1.0
X-Received: by 2002:a02:6645:0:b0:3b3:32b:e595 with SMTP id
 l5-20020a026645000000b003b3032be595mr1251643jaf.3.1675317198269; Wed, 01 Feb
 2023 21:53:18 -0800 (PST)
Date:   Wed, 01 Feb 2023 21:53:18 -0800
In-Reply-To: <20230201233913.650-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007d356005f3b12efa@google.com>
Subject: Re: [syzbot] general protection fault in skb_dequeue (3)
From:   syzbot <syzbot+a440341a59e3b7142895@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+a440341a59e3b7142895@syzkaller.appspotmail.com

Tested on:

commit:         9f266cca Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=10ae0ac3480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=723d250bd16cf869
dashboard link: https://syzkaller.appspot.com/bug?extid=a440341a59e3b7142895
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=126ad755480000

Note: testing is done by a robot and is best-effort only.
