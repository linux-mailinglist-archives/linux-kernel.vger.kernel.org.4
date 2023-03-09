Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212E96B2CB9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 19:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjCISNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 13:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjCISNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 13:13:37 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ED55553F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 10:13:30 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id s1-20020a6bd301000000b0073e7646594aso1251331iob.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 10:13:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678385609;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eRq3TMJJZHy95+Bnu1oE5VxJ/AJwds9+h0Qo4sc5MT8=;
        b=vQO0hhU9afFpAGZyE4wmD/VbBPr/arPBdIFz+qTYKIDK+NtBFB8mhNxzqrYvzM22dk
         xvc7sJRmMBGZVTmPnTJj7N9by2gm3VgblAYUeF542M8LYQNh9XeQK7tgWM4Gbt6mTnx4
         Gmxkw0nt9ZrkCxY4LcWczvLQoH3q3tkdaVSI2zlX8ExgauMbTxamzi0apzcrbQsvlt2A
         n12kp9NkEWUrPJI+RhiyWfzW/kVl6vNQEu3cuwJvZ4IVx6K8FkAW2jbqolRF21ECTPbd
         gI6f22JTOXtvH9n23iD4tdO3ZtWwbLUlYP5N08jzYFOTkp0bT1eJyBZr/ZKVpuwRgO0I
         1D7Q==
X-Gm-Message-State: AO0yUKV8VkvezQBZLTIW75qVd1kooQEYqdRb2JuH5F0Tv6LsF6W/TBnI
        J6gMJtBqjAwAlCSJKl3EEobSRe/zI33suah6FPIr7Ofw8nnm
X-Google-Smtp-Source: AK7set/dw+lBFz3VuekguS1j6XrbI8OFHItFn11I7RCeq74vSHR2atkqy55CSQaU2RexX6vC3Nv/T4g09iEyOdu+45bOcLLDXeSz
MIME-Version: 1.0
X-Received: by 2002:a02:85a1:0:b0:3a9:5ec2:ef41 with SMTP id
 d30-20020a0285a1000000b003a95ec2ef41mr10941296jai.3.1678385609080; Thu, 09
 Mar 2023 10:13:29 -0800 (PST)
Date:   Thu, 09 Mar 2023 10:13:29 -0800
In-Reply-To: <0000000000008fb52f05eb515c2d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000068c2505f67b9a8d@google.com>
Subject: Re: [syzbot] WARNING: fbcon: Driver 'vkmclient_loop: send disconnect:
 Broken pipe
From:   syzbot <syzbot+8e67d6db6ac1d1b297f7@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jiri@nvidia.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit ed539ba614a079ea696b92beef1eafec66f831a4
Author: Jakub Kicinski <kuba@kernel.org>
Date:   Fri Jan 6 06:33:57 2023 +0000

    devlink: always check if the devlink instance is registered

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13f213eac80000
start commit:   55be6084c8e0 Merge tag 'timers-core-2022-10-05' of git://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c29b6436e994d72e
dashboard link: https://syzkaller.appspot.com/bug?extid=8e67d6db6ac1d1b297f7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172e57a4880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: devlink: always check if the devlink instance is registered

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
