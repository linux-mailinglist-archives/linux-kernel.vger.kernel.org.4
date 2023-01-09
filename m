Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773BD662F5E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbjAISl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236645AbjAISkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:40:43 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57132218
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 10:40:19 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id b77-20020a6bb250000000b006e4ec8b2364so5446314iof.20
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 10:40:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vdozkht3DNskI0+rKd1YxGtR1GDDOg/Q1E8DUSg+rBs=;
        b=wZWOE0q36twEHVYrxrrn9lvuDJJa1OX0i4HNk3Ayf9UE0u7B7vzsMH3WYXPvLzgWdt
         T9RzfKseclPze4rCadSi6HdGg4f/WjTy5kZBQBiTVFHC4ibV+cJBE9DFNKFHSPLQPG7P
         ku+uvX9MeObig/5MSJZQRuofB+0ilMSqJZYsHLTMQQ0kljKClKZOVUEo6Zjku/v3Bar5
         LWn1ckpfM1HhIX5yWausEE1gK+CjyAjFVxNMa96hPoUECrdGSSVWskPL88dK8KymrrKE
         SONRt0eK2u/D6Edf4Y1obmnGCwhuZpXPZfjFJNJ2bmlCRj9cmkuB5W061l1gjeTga/fm
         ZMjg==
X-Gm-Message-State: AFqh2kp42AkRwHx15Ub+vdffrFrga2tWEgNnmGjFTqLcFBn6UFZ0wpvS
        XHD+zYzTDupnt1oD8q65ce58B9LU4r23fqQk4wVjXwhjoAbn
X-Google-Smtp-Source: AMrXdXt7Be4Hz9M5A+G9mfuyePIMJEOaigQw+rzHzModFUXa6OvX+N+Xndq1/IUECbf1mo6wYEYin+Nr3miqQbpAY8V+Qi8Vjx1b
MIME-Version: 1.0
X-Received: by 2002:a92:a007:0:b0:30c:1ec6:23d0 with SMTP id
 e7-20020a92a007000000b0030c1ec623d0mr4343045ili.134.1673289618727; Mon, 09
 Jan 2023 10:40:18 -0800 (PST)
Date:   Mon, 09 Jan 2023 10:40:18 -0800
In-Reply-To: <3b08247b-a645-db6a-aa20-ba77766730bc@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000054ace405f1d919f3@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in io_worker_get
From:   syzbot <syzbot+55cc59267340fad29512@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+55cc59267340fad29512@syzkaller.appspotmail.com

Tested on:

commit:         a4b98579 Merge branch 'io_uring-6.2' into syztest
git tree:       git://git.kernel.dk/linux.git syztest
console output: https://syzkaller.appspot.com/x/log.txt?x=165136a4480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=defbee0450ed9648
dashboard link: https://syzkaller.appspot.com/bug?extid=55cc59267340fad29512
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
