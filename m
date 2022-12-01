Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EDC63F555
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 17:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbiLAQef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 11:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbiLAQed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:34:33 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C659A9E86
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 08:34:32 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id o8-20020a056e0214c800b00303300b5cbdso2461036ilk.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 08:34:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UKNN3axs1y811QkhsVcYtMf113asLOYvCITq8yCsIOI=;
        b=eBQB9/XD7Pq3umahdDEMgfXUoWb+h5uPYuoz6hl2S8sJIDbeKBEUkJdcnz3KCxmHga
         6HtPSko7sjLYh/JyS1UiLeuxqVg265PVv+IL9R+cJFqWgub0bHj2eFjI+i7CUJn5adrh
         oP4odMdD1hDrl1SbLs0vcbwzJgGnbBWAZbjWh8Mm+5lIOt5fZDG2Hzca5zDM+WAWW5JT
         Pf6rdKLttqfAF8Jl1Cr+OnReNtTdJ8a+/llqp9wNfpameO8uo1twJ67jk9Q762wVOOc1
         7s9R9DvhSMh8cfMsb/ekKIRa4X9Mv9i/Y7+sFEGtvw/GmSEko2oSlKRfdUlDDEEaA0Fp
         /MkA==
X-Gm-Message-State: ANoB5pkVLW28tz15H1VGlCcoRgCRGfktJKIUa+Rpp9f4qoFPITuuJaM2
        53vDFDffrrKR1PaJ1ne4EroJQGvwRXMALMZ6snATm9bIV5uh
X-Google-Smtp-Source: AA0mqf4QsSf1RfaffekqeYnhim3TQSpIXqCXD7AhIKoXzfukEk/NduogwSXw23qNdA3B36SI0rQ3mzU6CxJ96hdkg4dHKHsaUPFE
MIME-Version: 1.0
X-Received: by 2002:a92:cbcd:0:b0:302:a682:4867 with SMTP id
 s13-20020a92cbcd000000b00302a6824867mr28386527ilq.214.1669912471753; Thu, 01
 Dec 2022 08:34:31 -0800 (PST)
Date:   Thu, 01 Dec 2022 08:34:31 -0800
In-Reply-To: <0000000000006c411605e2f127e5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000af5eb905eec6cb85@google.com>
Subject: Re: kernel BUG in ext4_free_blocks (2)
From:   syzbot <syzbot+15cd994e273307bf5cfa@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, gregkh@linuxfoundation.org,
        lczerner@redhat.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, sashal@kernel.org,
        stable@vger.kernel.org, syzkaller-android-bugs@googlegroups.com,
        tadeusz.struk@linaro.org, tytso@mit.edu
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
But I can't find it in any tested tree for more than 90 days.
Is it a correct commit? Please update it by replying:
#syz fix: exact-commit-title
Until then the bug is still considered open and
new crashes with the same signature are ignored.
