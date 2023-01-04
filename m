Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11BD65D2A8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 13:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbjADM3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 07:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234961AbjADM3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 07:29:22 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9F21A234
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 04:29:21 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id m5-20020a6b7f45000000b006fc1dded1b9so2434699ioq.18
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 04:29:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fcj5zEd7cDAScfww7SklL50hfxt3eAMIbzbrLQpIjB0=;
        b=wzmG06/L8oezVUKbe2Cg1UtA2qmFzMuwkfoU0L+cD1JQaiOqFEQ3HBY7HZQFvdWRIY
         1Cl31Ad2rXap3aFULiRmr4qCswszPaxkS6D6dP4s+hTEKqwqyrJen4rPES/lXjUB8+Mu
         KQOTvTnb5TAm9iUJAJIs/XFQjJbV54VEWJlfkr8baU2OW8DhsA6MBFfNTzPm71QCmll7
         GHpxPsofxPPORH0dr0iVPLfIYK8YTsAzpUyFowxfJ5TKxgk+BT/9ueWys8FYZ0HHkpiX
         aQVrdkDx0SmSbx3gHhrC+qWW9zpiaCQmfyN/wOVpJgL7dnR1MNKOovbF5slIjgMYW/RQ
         ZhCw==
X-Gm-Message-State: AFqh2kr7TkBH4B3G5ybmHWBocIJfAnNxRkM+dqfA6ugEFgouxMCTI222
        qrD3Kzxk8elzjk66b1LCAp1+pqbimhHhWQGBMSSduoP3q4AA
X-Google-Smtp-Source: AMrXdXuhsnSVKqSljPe3fO4qiiin9BhckSoK2ZR89pMASmqSjccpISB3AQeo2AXERvs5Zi7JvTsEm7eVkEgU7fZMw3wi7s+7AWjc
MIME-Version: 1.0
X-Received: by 2002:a92:190b:0:b0:303:1869:3a84 with SMTP id
 11-20020a92190b000000b0030318693a84mr4719532ilz.37.1672835360726; Wed, 04 Jan
 2023 04:29:20 -0800 (PST)
Date:   Wed, 04 Jan 2023 04:29:20 -0800
In-Reply-To: <20230104120235.4230-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000071a65905f16f55d0@google.com>
Subject: Re: [syzbot] possible deadlock in rds_message_put
From:   syzbot <syzbot+f9db6ff27b9bfdcfeca0@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+f9db6ff27b9bfdcfeca0@syzkaller.appspotmail.com

Tested on:

commit:         c183e6c3 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12ca7750480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8ca07260bb631fb4
dashboard link: https://syzkaller.appspot.com/bug?extid=f9db6ff27b9bfdcfeca0
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14e25424480000

Note: testing is done by a robot and is best-effort only.
