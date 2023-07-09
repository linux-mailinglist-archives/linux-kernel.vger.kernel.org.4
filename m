Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C5274C0CF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 06:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjGIEJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 00:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjGIEJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 00:09:37 -0400
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCB6E48
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 21:09:36 -0700 (PDT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-666ec28a20dso4166789b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 21:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688875775; x=1691467775;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R7q0J7G+yI5lmdgF+X7aufQLFQ3cYs8ipxCSvg9o7VM=;
        b=Cv+zn5SXNu6e+KkSdKYYmNCfzXr8JibL/A5B+in9+2vPYZSMcYxhXuPf5XHOvpY8L6
         4XUzpDaei/5j6LEN9xlAUS1YMGVaL3/y1JG2DWgYh/iHQJ7CIatNRB2LRZfYcqCz3TpX
         0WyxgIpxUdPv8QzrzyhrDnr789P6Cwz3u0QwCqNiffgBvyQQIwZ/SlXzayGkHSOg1vzK
         u4tYsXS/7OXqSn+dZJmhgmCqpw3HIf+N4immzDOCHRXYTsopxP2DjIjE84qTbbDvXGLn
         0E+ekfHVIF1ryLmSb2UcV3RI83Vq5iWZYAIaAAC7TptiP2QkRHQ3BViuh/7o7ueCOLF7
         yrhQ==
X-Gm-Message-State: ABy/qLZ2QsqZJNmgNowwk9Z0WFn7qe8nlfVp1mbZusS2lHNG7K+Uhhr1
        8r8f1Zbq/RBQ2iFI302ioRJx2O08dE1qpDY1c8ULeLZ/1joe
X-Google-Smtp-Source: APBJJlE7ScwMHQc7rQl3m/vhOqETjF/F63AB3cxj4/jZQIaXv/SjKsRxE6pYb/Cl0DHsdYhsfVgS5VlBlphx6XYqI8GqQo9hjrg9
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:2d9b:b0:678:e0b1:7f28 with SMTP id
 fb27-20020a056a002d9b00b00678e0b17f28mr12294027pfb.6.1688875775705; Sat, 08
 Jul 2023 21:09:35 -0700 (PDT)
Date:   Sat, 08 Jul 2023 21:09:35 -0700
In-Reply-To: <20230709011213.17890-1-astrajoan@yahoo.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae45de0600060878@google.com>
Subject: Re: [syzbot] [dri?] divide error in drm_mode_vrefresh
From:   syzbot <syzbot+622bba18029bcde672e1@syzkaller.appspotmail.com>
To:     airlied@gmail.com, astrajoan@yahoo.com, daniel@ffwll.ch,
        davem@davemloft.net, dri-devel@lists.freedesktop.org,
        dsahern@kernel.org, edumazet@google.com, ivan.orlov0322@gmail.com,
        jacob.e.keller@intel.com, jiri@nvidia.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
        skhan@linuxfoundation.org, syzkaller-bugs@googlegroups.com,
        tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+622bba18029bcde672e1@syzkaller.appspotmail.com

Tested on:

commit:         1c7873e3 mm: lock newly mapped VMA with corrected orde..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=101196d2a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f6b0c7ae2c9c303
dashboard link: https://syzkaller.appspot.com/bug?extid=622bba18029bcde672e1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10e44354a80000

Note: testing is done by a robot and is best-effort only.
