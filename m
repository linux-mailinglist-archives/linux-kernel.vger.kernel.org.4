Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15146A3965
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 04:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjB0DPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 22:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjB0DPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 22:15:22 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753F5B74D
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 19:15:21 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id bh26-20020a056602371a00b0074cd682126dso2203016iob.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 19:15:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A2+APwB2GzhFkrvpMTvqp+2rjjqslDHXMq8JUTR+K0Q=;
        b=CvG2I2fKb10cLaGtS7rKIKdbCOiOsBlT6eyfRXwC4Ddqyni7aATDOi9jccfjFMLCyU
         B2YQ5IC9VS+zeNa1iBrk3Alx8xdtriOh+eHZjCWKHOLJYoovjKEvtRyqeQTrnk3zVSzM
         I/toDCcFTa5fD9WC0pQS8q9xOI6G6059k+aLMs8E8BhnNn+T/1OV5O54aHB2SV2VXuA6
         LNwFnKyhmbv0iYqXuafQzl7JN7KB/pxowdBm4skZS8CnDgUdWIQQLSV4cFB2Qn4umFq6
         cbtdX+EDmB8Cfi20juemadMKQ2zsj/FWVVEKL7Xa3t5bH/3MKidakuDlMRJpCprYXlxL
         7uGQ==
X-Gm-Message-State: AO0yUKXaMj/Xm9ZAq53NIPRrtWE0/+miqp7BkeVmXKU0XSBhxvlcRDw+
        e2dkCFd8N/8MavorCNJrFvaEtfCeBkAGUnN98PlpG5wZk+QP
X-Google-Smtp-Source: AK7set9HZUDLaW3h7+7jAkTK1MosM05ryKdbqpCbz2sVoni9t+gVJdROmc0271ZfYLRFZbIAFHeiBshMWw+RLP61wIFAIcqEZX/d
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1148:b0:314:1fbc:27c9 with SMTP id
 o8-20020a056e02114800b003141fbc27c9mr7285163ill.2.1677467720826; Sun, 26 Feb
 2023 19:15:20 -0800 (PST)
Date:   Sun, 26 Feb 2023 19:15:20 -0800
In-Reply-To: <20230227024127.3574-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009f463305f5a5e394@google.com>
Subject: Re: [syzbot] [media?] WARNING in smsusb_term_device
From:   syzbot <syzbot+40ac6e73326e79ee8ecb@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+40ac6e73326e79ee8ecb@syzkaller.appspotmail.com

Tested on:

commit:         8232539f Add linux-next specific files for 20230225
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14fcfef8c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fe68735401a6111
dashboard link: https://syzkaller.appspot.com/bug?extid=40ac6e73326e79ee8ecb
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12d2c2b0c80000

Note: testing is done by a robot and is best-effort only.
