Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226E75ED8AD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbiI1JQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbiI1JQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:16:06 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6DD357D7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 02:15:29 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id h17-20020a056e021d9100b002f81bc83425so7981480ila.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 02:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=beK/RyAk6JMkokDhacR9sWsAak3KfcE5cJn8YM9YfXo=;
        b=jd8fzRDumobSQ5ZQ+FSjEGlaspmIIPnjtVyN7GHvqcvmXhksQio8Rg1+nhcbffd0iE
         8JAY4MlBf9o1jch4gfvBDeYblCVXEM1WGeU6D+R7n5HctcH+zqVx22SrhBVHQpkWs+KH
         QaYNO+NoLFCca5risX91wKQ6n05YIqwB9jhElFA7CheG04goT+E0Eab1FA/qbIEOnvKX
         b6qRubsac3bCXxVJ2/Pb6O5w3IqnSRw5GjnGW72opUhYSvikVwlRN6MeYB+wfgq3lIJI
         FfQa5XA7tunDzYJvuY0VQJjUZqV7XfE/OL8WnEXFRgO9KxqVZ4vi+oLRHZ5+2HpvXVEF
         NUIQ==
X-Gm-Message-State: ACrzQf1UA3XL3wTCU6gVVRRk9Ufb5ADp36i6mrRa0vXH0OoBTzADxgGW
        Oo1TGmqYn68Fy0WcqV4ZdcPvZ4ExAjaobSN7C1LsKoEVSVkp
X-Google-Smtp-Source: AMsMyM6BIiupKnvoAFOsnwm0XJAWBDCHCGcAp1YvPH/VWKpWZj/AjdMc8eNeAEV12usUyE8/g0EF6bCHNMAtpYRqmrNcQRRPx2su
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1074:b0:2f6:15d9:4719 with SMTP id
 q20-20020a056e02107400b002f615d94719mr14583204ilj.123.1664356527089; Wed, 28
 Sep 2022 02:15:27 -0700 (PDT)
Date:   Wed, 28 Sep 2022 02:15:27 -0700
In-Reply-To: <000000000000f2b07b05d5dc87cc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000093aefb05e9b93343@google.com>
Subject: Re: [syzbot] general protection fault in fscache_free_cookie
From:   syzbot <syzbot+5b129e8586277719bab3@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, linux-cachefs-bounces@redhat.com,
        linux-cachefs-owner@redhat.com, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org, mudongliangabcd@gmail.com,
        nogikh@google.com, syzkaller-bugs@googlegroups.com
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
