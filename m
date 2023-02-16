Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCFC698EF9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjBPIs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBPIsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:48:25 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E3538E86
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:48:24 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id 9-20020a056e0220c900b0030f1b0dfa9dso922832ilq.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:48:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8CEGlLT8TzfwV/TNrI7gfJp9hsTS01KyPUT9B23o3II=;
        b=j7fqe2iVjWs2Tmex2GHBVG2SpwhZ1gE/bgseBhX/mvaoaLPAwOiq9xWk0+TtzgoOWs
         Z1dnnzEhO9GqDgQU5/66/7lX8vjMFvLQ8yNV6FFAcCQahj0FXp2xyg997lPy052PzdWC
         3i4zpYXxlFmKXSj+JAX8iWh2s1ElbvU/KM08O4hlqhhAPZqHVLg6zlTQkROS9xNg0QEb
         wCSreczFoXvn+oSbO8WO65alTXZya4ybZ77DkAYPD3gwE02lUuGxFeExfKUboTKS/fk4
         xpQgnsycSV3yvrpFpE85X6AbwKZ0WAGx4tCXjsyuRnF+T68uSjt3jYJKZ8hQBpssauD9
         5lQw==
X-Gm-Message-State: AO0yUKXOzSTsXxbbeqKa8pWCneQqpVTzqwTzt2MPy2eor+p7qebjPrM+
        MHeP3CH8kR3y3iTiH+GMfCF/EkO7R+5P9/UkqiGxPMvIFDet
X-Google-Smtp-Source: AK7set/5+rKKQqL3Ky/3iJfI5HOf9LgMftP2zbEa5grbipfj6Y9Zpph8L9swDZwiQhPILqAcrmwyJd3SnjwDJX2/k6tmRXI4J7Lq
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ec:b0:315:3277:f05c with SMTP id
 q12-20020a056e0220ec00b003153277f05cmr655148ilv.0.1676537303358; Thu, 16 Feb
 2023 00:48:23 -0800 (PST)
Date:   Thu, 16 Feb 2023 00:48:23 -0800
In-Reply-To: <2277739.ElGaqSPkdT@suse>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006b656405f4cd42ee@google.com>
Subject: Re: [syzbot] WARNING in usb_tx_block/usb_submit_urb
From:   syzbot <syzbot+355c68b459d1d96c4d06@syzkaller.appspotmail.com>
To:     fmdefrancesco@gmail.com, hdanton@sina.com,
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

Reported-and-tested-by: syzbot+355c68b459d1d96c4d06@syzkaller.appspotmail.com

Tested on:

commit:         f87b5646 dt-bindings: usb: amlogic,meson-g12a-usb-ctrl..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
console output: https://syzkaller.appspot.com/x/log.txt?x=160ab7d0c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d59dd45f9349215
dashboard link: https://syzkaller.appspot.com/bug?extid=355c68b459d1d96c4d06
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16fe1f10c80000

Note: testing is done by a robot and is best-effort only.
