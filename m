Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D0A6275F0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 07:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbiKNGb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 01:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbiKNGbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 01:31:24 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFA710B4D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 22:31:23 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id g4-20020a92cda4000000b00301ff06da14so8751700ild.11
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 22:31:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHAjE8v+rR+q2eHvXyL5uTVpywlN8Yt7SBPnOf5Yuzo=;
        b=WesJttYiqBORki2PUGLqlrWnKNd8vRErV5Ikv+FMe7dQ21pkqbWwlc+qZHiSJee5kW
         UzQCErod1C2YW0ZR3eHoHim7YCm+NKFwjTUNOv/H2JRGI105uscWPDDg/O66uppHIwX5
         TPQ+Zmy3oDaCSi7pEzUfgZHdQJMZyZ0wXUvcR5v2gSeuguCkFuTU31qvQCb+VXtxjsEi
         OqGofg4Rfz+VF7wmR24CKgqUJs0IrFLWEq+hxTJBhtFNsnpgJTNXRKVrwaiuky/1K3QH
         WjTxlj8XxQcdtAv+WMMqSVgmFIKRNvMQq+9gr9+B6e+7gPu/o4c9tq+qX86xBVoIrWmt
         Topw==
X-Gm-Message-State: ANoB5pmJQ32RNtl0925dKHwDnVroLMLwibkmHEUmPRGD5zApC3MPsle7
        qzSTVneT6BF/+tzO9gWK52OMEoO4wJfA7nhntrsLwugTEHtw
X-Google-Smtp-Source: AA0mqf6mYjyOyR+atf9LMbatWp4IokzvSWPNvyupAo65dWEFooILqw81wzrjbCxHvwBCz1vu+05j48pHWVVwSvIcgXANLMLH1Gyx
MIME-Version: 1.0
X-Received: by 2002:a92:cec3:0:b0:300:ef0e:9388 with SMTP id
 z3-20020a92cec3000000b00300ef0e9388mr5744392ilq.262.1668407482431; Sun, 13
 Nov 2022 22:31:22 -0800 (PST)
Date:   Sun, 13 Nov 2022 22:31:22 -0800
In-Reply-To: <20221114031540.2006-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000054c08f05ed686345@google.com>
Subject: Re: [syzbot] possible deadlock in vfs_fileattr_set
From:   syzbot <syzbot+abe01a74653f00aabe3e@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+abe01a74653f00aabe3e@syzkaller.appspotmail.com

Tested on:

commit:         f8f60f32 Add linux-next specific files for 20221111
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14a95a11880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85ba52c07cd97289
dashboard link: https://syzkaller.appspot.com/bug?extid=abe01a74653f00aabe3e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12d16985880000

Note: testing is done by a robot and is best-effort only.
