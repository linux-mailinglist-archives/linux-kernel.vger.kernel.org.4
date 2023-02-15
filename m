Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46D5697C1E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 13:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjBOMpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 07:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjBOMpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 07:45:52 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E9C311CD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 04:45:51 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id q3-20020a056e02096300b003157134a9fbso736674ilt.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 04:45:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V5gRBWvCrC4ivORDLYanYAKruxMNDrxF3nhXlCgZ6d4=;
        b=US0DePTcWCe2Ug9Jf6jkcYQIj9Rm2YSce3NDhEgQ/OuU5THFHr/t/ne8XLOTziodfV
         XqtzCWUZvmzHcS+a5C3yTYqGlmrspIuaQ4weXPEvdP/sdlNtUqGwd4O51KDfqSLTjDsq
         FVgn5RL9qQM2bT81Xd0k6DNUWct/8+VV2tvzEJF7cxA81VzX2Ldunc4H7nc3dujKzSmo
         8A0Y0TNpc5BCqqP3kXpvupIwQq8+J8gfHmGYm1Bhip1Oha920oHu1/vO6OKzev2XIVQB
         JzVyPDv22jBBJ0NEmbyl5Rf0JoN4XISK+0HwbLNkoEphMoMF9Zo4LVE0nfh7Phsz5oWE
         vvPw==
X-Gm-Message-State: AO0yUKVmHqvMGM4LjLCYjE27BrgyWDRGn3xVoUURLxaJsIYhlTYE7CJP
        q28LJRGSb6omA73GITQwqGEtd8H7OqM0zOtEItWqAU8h7POF
X-Google-Smtp-Source: AK7set9TjvisiTIRVmOM6kk7oWlt9QxFsyDansPcekDaE9vTb1o4Jz8iKYvVdAHKEnBGb6wJBTvmELx9OL90n9hUVjrG8BHZYbwh
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3e0f:b0:3c4:a4d1:cc49 with SMTP id
 co15-20020a0566383e0f00b003c4a4d1cc49mr886208jab.3.1676465151294; Wed, 15 Feb
 2023 04:45:51 -0800 (PST)
Date:   Wed, 15 Feb 2023 04:45:51 -0800
In-Reply-To: <0000000000006c411605e2f127e5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d245a705f4bc75b4@google.com>
Subject: Re: [Android 5.10] kernel BUG in ext4_free_blocks (2)
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
