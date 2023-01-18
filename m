Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF824671D92
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjARNVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjARNUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:20:46 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A055C81017
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 04:45:30 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id n8-20020a6bf608000000b007048850aa92so8858832ioh.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 04:45:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V5gRBWvCrC4ivORDLYanYAKruxMNDrxF3nhXlCgZ6d4=;
        b=UXxLaxpIcW597EsPoG19Mfq7eQCmE7cXENa6xJT+Jos57U1f4D1dkQYDtL2aBUPV1Z
         IrVPYfK5FMilMet0LzR8Yn7Dw05E0iL62M3sUSKXsI8Jdw777gVe40N9Q8ATBBLj04Sn
         0RHrjN58r+zF7LPhp7E/VwgIFauZSiFNYCBbX/JyNtZunoy24+HB3CGGHD0MJZZQSj8Y
         A/49dCr4Rm78wzKdCyP/+JZkjFOEafs8dRAd7/pknNPXYASC8wW80KRnNnaHeoN4InNF
         UXHfwqtqDGZxtw8AGlXfPcn0FRaXziVBh294JkX/ZhXyW5yBiOOElfmQus67r1RQBSnc
         0djw==
X-Gm-Message-State: AFqh2kpVeLqHv7rw3F2j/iWeGGDVKMWMyHVZH3jaNUCsJ0yx6jTgsGKd
        KamkrXPjtM7c+FhPO8waQO884QizE7W+Ari1m7UGVSGfwVK2
X-Google-Smtp-Source: AMrXdXvVL691GTL7GLcjKS67887TwiKEHcWfhZ/5QhiOLGDZ6GpUCmi76ceqVWCaamLHt0l+5yy/Ku6ebLRN3lIzxLvTh09gafQy
MIME-Version: 1.0
X-Received: by 2002:a92:364f:0:b0:30d:a1d1:c165 with SMTP id
 d15-20020a92364f000000b0030da1d1c165mr756647ilf.263.1674045929712; Wed, 18
 Jan 2023 04:45:29 -0800 (PST)
Date:   Wed, 18 Jan 2023 04:45:29 -0800
In-Reply-To: <0000000000006c411605e2f127e5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa76ab05f2893036@google.com>
Subject: Re: kernel BUG in ext4_free_blocks (2)
From:   syzbot <syzbot+15cd994e273307bf5cfa@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, gregkh@linuxfoundation.org,
        joneslee@google.com, lczerner@redhat.com, lee@kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        nogikh@google.com, sashal@kernel.org, stable@vger.kernel.org,
        syzkaller-android-bugs@googlegroups.com, tadeusz.struk@linaro.org,
        tudor.ambarus@linaro.org, tytso@mit.edu
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
ext4: block range must be validated before use in ext4_mb_clear_bb()

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Android 5.10
Dashboard link: https://syzkaller.appspot.com/bug?extid=15cd994e273307bf5cfa

---
[1] I expect the commit to be present in:

1. android12-5.10-lts branch of
https://android.googlesource.com/kernel/common
