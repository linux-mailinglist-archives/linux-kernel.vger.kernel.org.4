Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6005E64D761
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 08:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiLOHkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 02:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiLOHkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 02:40:37 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A512CE38
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 23:40:27 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id b24-20020a056602219800b006e2bf9902cbso5236224iob.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 23:40:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=beK/RyAk6JMkokDhacR9sWsAak3KfcE5cJn8YM9YfXo=;
        b=GhKovFpleML+7ohekDp4tte2fnkoZqqOoNkIVKLMW1u/QrF2Dc1PVuczq+il+geFcA
         AjautJ1vuSLUQd1Wj33ACxEOkYfHA5br0PgXU04Z22zdP53+C3PPJMcMFcQm3QYCnDWO
         MrDv53buhnSp06WtXmKtOIRky7R/Sc25EVCCV/e5HEeCDPbOgkG2hHAMzvLQNoEe6sy+
         J2e7BzZhRGNtvuVDiQrPnbNLy/3bB9L4EQRfM0D//7khghlNSZXruQUVIW6+pzRbipzA
         9LHPNawKdp5a6rgdXUMHtVOfUZZZI7xpPvfyFFnMlXv4h16Z+MmTNwN4bzVx0aKEoPJo
         YS/g==
X-Gm-Message-State: ANoB5pkdGFMBI6rfINSgUqvog5lH+DELGgNOUbgEDFEXNHzg3nEsWxVX
        1ruKzfTHfLCdSlDE1i6u/DSuRBgKqQuTB9hB9TerFZI1ntCj
X-Google-Smtp-Source: AA0mqf5rjfC/qHzBvbu7vKT0UKU/G6DITpJJBSIEAgiV6RtdAfbCITH1DkIU9vyJGn1MMqwemKr6tiKHOU5jYJpBwRmrXrdiIwT2
MIME-Version: 1.0
X-Received: by 2002:a92:d185:0:b0:303:898e:3cf7 with SMTP id
 z5-20020a92d185000000b00303898e3cf7mr4300613ilz.136.1671090027173; Wed, 14
 Dec 2022 23:40:27 -0800 (PST)
Date:   Wed, 14 Dec 2022 23:40:27 -0800
In-Reply-To: <000000000000f2b07b05d5dc87cc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000075205005efd8f711@google.com>
Subject: Re: [syzbot] general protection fault in fscache_free_cookie
From:   syzbot <syzbot+5b129e8586277719bab3@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, dvyukov@google.com,
        linux-cachefs-bounces@redhat.com, linux-cachefs-owner@redhat.com,
        linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        mudongliangabcd@gmail.com, nogikh@google.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is marked as fixed by commit:
fscache: fix GPF in fscache_free_cookie
But I can't find it in any tested tree for more than 90 days.
Is it a correct commit? Please update it by replying:
#syz fix: exact-commit-title
Until then the bug is still considered open and
new crashes with the same signature are ignored.
