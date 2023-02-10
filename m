Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5938F691905
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 08:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjBJHQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 02:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjBJHQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 02:16:22 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89265B749
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 23:16:20 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id i124-20020a6b3b82000000b0073440a80b1aso2974041ioa.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 23:16:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C45lykeHtOW+MQxyP7Hi9638WK2NqXd/3gtP4eYkUbM=;
        b=B4u+21w28YJLfYEDY6Yz6O0g/Jg/NjUT3/U0SaPHLm8N2Nl8+0PitVNOK5f7fPh39y
         SwuJ+i8ZlFHTl31mdCBDm56f4g3NR/HBzxw1Oxyxdrb+hJv8znKR3gyuVsvvpsvOjgjs
         vOiu8O3kgiF/5uodI/mFQ60uMVsiGSHHWnkWvzDjdy1JTuR4Onkcfxr9o+SdPss2cJwb
         EyCq+ASci3T5YMvjZSQwr7iLAX4HbfbJUVtihTcIbPQ8CfBYy1kf72FaTyb+FOt0TC72
         vNRTp/mqKT/YsaGXM52KOAbqYy5J8yVOTl0dPyKigi50LvihmrfT/gcZKcaLXGLGRQ76
         +zWQ==
X-Gm-Message-State: AO0yUKWMCJvU1CfGyKH/aMg3I+o1zLtNv2GBhL/771D6CqqQV2YtCnAH
        eoZCRkQcj5hFTruUHrdOTrGGP0k0T/VrcNXEjYckaLSFV5IW
X-Google-Smtp-Source: AK7set/Q7PBInp2lCzKm/66DRS5PIqfMGbqcjgb+4+7XiBQKt34AwlXpQuWBCjstFFgdeOMB3X9jXt0Ft4jqzhKdnRDfAjiVwcHU
MIME-Version: 1.0
X-Received: by 2002:a92:7a03:0:b0:314:8c8:de5d with SMTP id
 v3-20020a927a03000000b0031408c8de5dmr2612981ilc.47.1676013380303; Thu, 09 Feb
 2023 23:16:20 -0800 (PST)
Date:   Thu, 09 Feb 2023 23:16:20 -0800
In-Reply-To: <20230210065053.2385-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002c049605f4534631@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in ext4_file_write_iter (6)
From:   syzbot <syzbot+b9564ba6e8e00694511b@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+b9564ba6e8e00694511b@syzkaller.appspotmail.com

Tested on:

commit:         4fafd969 Add linux-next specific files for 20230203
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11ee1b83480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d2fba7d42502ca4
dashboard link: https://syzkaller.appspot.com/bug?extid=b9564ba6e8e00694511b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=117f7c0b480000

Note: testing is done by a robot and is best-effort only.
