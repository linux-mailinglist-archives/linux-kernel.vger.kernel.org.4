Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB21E65D185
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 12:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbjADLep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 06:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbjADLek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 06:34:40 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79341B9EA
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 03:34:38 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id o10-20020a056e02102a00b003006328df7bso20968572ilj.17
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 03:34:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V5gRBWvCrC4ivORDLYanYAKruxMNDrxF3nhXlCgZ6d4=;
        b=owViCX3QTjBkqgnb95JPmSQ5Yso1qRPOUbdUy6+FAFZEoJTj67ZBaXIZi9VXMX+YcE
         RDqZbsjWyeYFyRlzqvk2tPqVnGva7TXXfqpNZIT0WQI78G7b0QSVtv0WwRJ/3MElPiqu
         417dwaF7bzHFukFDNS5zngRxFCLS5hCOouNf83ZX9DmISoUh9l9bdoiYBiGX1HC2PTa/
         TdQcdMfWSgzQUNLNLdFX19+WwcBDssNOL0Ry0v0PZIRPNB3tYq8cR4TLc0ZSmtYhv0SB
         xfCf1E9UcUbcx9KsIgeNgyoxq6uJ7QhZ+4HRQOJam8J+iEQNXihPlQap3/I9WVyEsRRP
         YRgg==
X-Gm-Message-State: AFqh2kplMlw6h0BfMS37l3WEB8AGOOO9TMkLTts64Yk08LxXw7Ss+BtC
        xgu+JIXOCfLh/1vTWydmams0or2bwjtamAxmKG8AWBAi3MwX
X-Google-Smtp-Source: AMrXdXtYnU0n+7Mz66+jF3YyEbOSXpsWchRQh4OWWMAkTgA+jN6H8D5b4L843NTdw6V/0AriGfmSejO1PiEbK7VCcfnaujakKtak
MIME-Version: 1.0
X-Received: by 2002:a02:c728:0:b0:399:6200:63dc with SMTP id
 h8-20020a02c728000000b00399620063dcmr4409365jao.194.1672832078148; Wed, 04
 Jan 2023 03:34:38 -0800 (PST)
Date:   Wed, 04 Jan 2023 03:34:38 -0800
In-Reply-To: <0000000000006c411605e2f127e5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c97b2a05f16e91c5@google.com>
Subject: Re: kernel BUG in ext4_free_blocks (2)
From:   syzbot <syzbot+15cd994e273307bf5cfa@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, gregkh@linuxfoundation.org,
        lczerner@redhat.com, lee@kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, nogikh@google.com, sashal@kernel.org,
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
