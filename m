Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947C4652E06
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 09:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbiLUIgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 03:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiLUIgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 03:36:20 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7181900A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 00:36:20 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id b77-20020a6bb250000000b006e4ec8b2364so6621752iof.20
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 00:36:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dDQ+iN7ILHO/J3wN3ERCX305u4LCb1Q+cpshSFioZ8k=;
        b=UphbRvJcc66w8M4fEffmSc/KEa0wzhovw4brvnpbAfOORWdHQieHnOxOtb+2OntTCY
         FBgJ49dz+gWXoAZUE/AtwukMni1ICakGLkBmosLZ3FC32QTGXJkrvIAlvj3yhD3i+EfU
         EedEc/Qefe4z/uCEHpF7mIj/pN5T5eCTV0MVUPjPnkOjzUjQIuSAXPCwgFcqVJS1Vknc
         uavxc+JW4KOsWH4CRVEq0HbdpP7tOpgCmWF/JGtyKSlCcRwjLXXlX+5gKpHiDsrbubNq
         3lLvEKnQYu7yPX+K9j50zM093mlCBsKTjgO7WGdLNtMI8grhVX10tvPPIqi7zGq0Nyu3
         ypWg==
X-Gm-Message-State: AFqh2ko3VNX8kC0d3Ok9He6V2OpGdA8v2LNYD6t136XaV+EIveFJw/cl
        OGo8syqzllWZv4YhsstfaJ5uPrwWxOhTvlHg4d37WAFZReRi
X-Google-Smtp-Source: AMrXdXticohJ13ErsbJ6kMB6pCCk7Ek7Y+kL83Y7IW4FWp6ABn9Jab7moiYyZ7Om8LLyGvTMRO2mN1q/t5ekvYPrkKttAG7KzKmA
MIME-Version: 1.0
X-Received: by 2002:a5d:81d9:0:b0:6df:bcf7:d86 with SMTP id
 t25-20020a5d81d9000000b006dfbcf70d86mr98261iol.188.1671611779508; Wed, 21 Dec
 2022 00:36:19 -0800 (PST)
Date:   Wed, 21 Dec 2022 00:36:19 -0800
In-Reply-To: <20221221063432.1612-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000051f1af05f05272c1@google.com>
Subject: Re: [syzbot] WARNING in io_cqring_overflow_flush
From:   syzbot <syzbot+cf6ea1d6bb30a4ce10b2@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+cf6ea1d6bb30a4ce10b2@syzkaller.appspotmail.com

Tested on:

commit:         b6bb9676 Merge tag 'm68knommu-for-v6.2' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1583ffbf880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8ca07260bb631fb4
dashboard link: https://syzkaller.appspot.com/bug?extid=cf6ea1d6bb30a4ce10b2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1418e6bb880000

Note: testing is done by a robot and is best-effort only.
