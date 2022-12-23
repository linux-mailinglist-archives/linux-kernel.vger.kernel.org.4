Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00D9654C8D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 07:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiLWGuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 01:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLWGuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 01:50:18 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6DC1D675
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 22:50:18 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id s22-20020a6bdc16000000b006e2d7c78010so1600659ioc.21
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 22:50:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xx7mtNy24XegxlB0c6XSA52Z5pgoPFn7cD78McZJQm8=;
        b=yJM8JJTHg8IHtoWbA/IhgHolToMbF5FvzU+92URuVz6Psi/kh2i52mfTF/akwi1sRE
         2d5SajfqID+mbftkArQfjMLUMV2vIhV6YdjVgFjxA/jJ2ergyowrlmiLzACwL4dnqzzD
         b9DQFMaSEBxZVW9Vmngoglj+ss+tExZs7Aa5R2E/b3s+1fUEOpv76qudhEQDQxSk/ole
         GkKZgnyESc65gCaLmHPt3ferLdXwb//2KI58laA9T4Z98R5XDFW6Xbdy12S9Cp++EL/G
         7xcS9THHbYqb+1VCJvzF6V1rdGojxM1oBsGd7kxmNhEtTA1eYQGU4yc4Z5kDvJSk37Y+
         4OMg==
X-Gm-Message-State: AFqh2kqptK9wBn+VrJwTYUZTsISfs6GA9F7iWgm08fQ+Si6PhFrYzAEo
        emnPgQqYK+P7dCARE2bpkbgy/1e5usxLq5VQPzWrMW34nRGt
X-Google-Smtp-Source: AMrXdXuwaDyMuqBotyassnaOM+DnPbLD8heJ41BPn/tL9m3kKIXVUnSapLZX/4Uok9CLAN2opio8THAj8tl5o8AV5jBKOu142YeF
MIME-Version: 1.0
X-Received: by 2002:a5d:9f0f:0:b0:6e0:1738:5680 with SMTP id
 q15-20020a5d9f0f000000b006e017385680mr553627iot.109.1671778217385; Thu, 22
 Dec 2022 22:50:17 -0800 (PST)
Date:   Thu, 22 Dec 2022 22:50:17 -0800
In-Reply-To: <20221223060652.2000-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ca6b5d05f07932cc@google.com>
Subject: Re: [syzbot] BUG: stack guard page was hit in inet6_release
From:   syzbot <syzbot+04c21ed96d861dccc5cd@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+04c21ed96d861dccc5cd@syzkaller.appspotmail.com

Tested on:

commit:         8395ae05 Merge tag 'scsi-misc' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1714802f880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=935a84bda2af0616
dashboard link: https://syzkaller.appspot.com/bug?extid=04c21ed96d861dccc5cd
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1028681f880000

Note: testing is done by a robot and is best-effort only.
