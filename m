Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41E16A8FA5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 04:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjCCDE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 22:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjCCDE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 22:04:26 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F70136DF
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 19:03:50 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id w10-20020a056e021c8a00b003174d233ebfso728924ill.18
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 19:03:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=isli2AKH+kwLN02L4pT/nJCswlz+AKRmYnIoioB/Uns=;
        b=dW3kApqkvdPCLMvr6RgxJZWjrQgU2KNUiIZbRvztN4hGKfRcb7l+tkMKkFNEQA0bYf
         o69jZN3ghjkpk6sLOPM2QTwz53o3MkRH7NJ8BRgYKf6Km6HNjxDTccIf29vOUI+VvOfR
         HwH8DzQCO8nRphD5eBmPkUhpqyqIjxB1NykpPBNKgTRgsVv5z3Gi8Z88Db5VxZZW4M/m
         xb0Z2zgWnXitdUhC5Amm+fKjt7jHEbzdQ8Y7SxuDOhFn8Vnhg4YytB2hIq0T5oXNb+91
         wTTnKGjIJhekr6njUKi7oWdf3UeJh1EGk+tDKlnVeXfYyR8VhXGrk98dzXBSQnfsI/40
         7upQ==
X-Gm-Message-State: AO0yUKX9cY9L5Yz+u4MKGndVJuNBlo33eMLEZ3sprbSYT29y65vUx45i
        Oyt+fAp4PfCeCTFtc8/msqk8PWbEVfuCSq4prwa9Tf1O2IuF
X-Google-Smtp-Source: AK7set/igu8Bor2XtivVr9jM8HFtmhoQ4GQ0SaU584K4FSab8jjk0wwXNDU/HPeESkqBRzfe6Wb8KyzYdjvCasaIebcctmwUNxe9
MIME-Version: 1.0
X-Received: by 2002:a6b:6a11:0:b0:745:68ef:e410 with SMTP id
 x17-20020a6b6a11000000b0074568efe410mr101478iog.0.1677812606638; Thu, 02 Mar
 2023 19:03:26 -0800 (PST)
Date:   Thu, 02 Mar 2023 19:03:26 -0800
In-Reply-To: <20230303023229.2635-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006b200305f5f63039@google.com>
Subject: Re: [syzbot] [block?] WARNING in blkdev_put (2)
From:   syzbot <syzbot+2bcc0d79e548c4f62a59@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+2bcc0d79e548c4f62a59@syzkaller.appspotmail.com

Tested on:

commit:         2eb29d59 Merge tag 'drm-next-2023-03-03-1' of git://an..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=10467122c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cab35c936731a347
dashboard link: https://syzkaller.appspot.com/bug?extid=2bcc0d79e548c4f62a59
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10d3ef60c80000

Note: testing is done by a robot and is best-effort only.
