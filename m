Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BC463EA66
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 08:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiLAHjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 02:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiLAHja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 02:39:30 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FB14A077
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 23:39:29 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id g4-20020a92cda4000000b00301ff06da14so1191131ild.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 23:39:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=beK/RyAk6JMkokDhacR9sWsAak3KfcE5cJn8YM9YfXo=;
        b=cyxvlmj3hboM6cGOz1NUMxDomt4f8XvhnBvfE4jdHJCxaxmiJt2ISnTw4QO73c0Xh0
         l7SDebSKUITZnhgA6prbiyyQFN1JM+2nSVmXIR6DLl2TiAAQuHMEdHxz7IC5jxKyQ5Ri
         eMcnKc8gnM092JoLtmaDQ4aWCkFFcf8j67JRQOXKwUpzK8fDWhNam8N3YmKRTFJBPkie
         3mLt8JvSPacUjx3vY3zvFastTK/m4kaGUAj8paq3EcS6G6QwpnmUvOoARhsDCbH8FvZO
         gyHkfFJGrVazyxd9ol2qYeYFwTjsrn07r13qdtB70LnjUh3XKLdQ+YZlbKdTdn023SXH
         3qoQ==
X-Gm-Message-State: ANoB5pltlgg9iW7gwq4z+bIGA73otGJba8t3323XbQYBQ0bEKjG8CN5Z
        FlzYw7fmaFK7qeb6gxryHQNhTukPSNg7gnAt8oqsQMwvM/Tn
X-Google-Smtp-Source: AA0mqf6TEaExiCBLiN5lVFzq28y5UfbzPncz6y1OGUlTmIHBsnAh0zShpCzvPqMreHnr3BXx3Z1gWLA7DwNgRAc2gYCUA/2hoiy3
MIME-Version: 1.0
X-Received: by 2002:a92:da48:0:b0:302:ebf5:a7ae with SMTP id
 p8-20020a92da48000000b00302ebf5a7aemr17788055ilq.34.1669880369263; Wed, 30
 Nov 2022 23:39:29 -0800 (PST)
Date:   Wed, 30 Nov 2022 23:39:29 -0800
In-Reply-To: <000000000000f2b07b05d5dc87cc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003a3d8905eebf52af@google.com>
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
