Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8824B628AB0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237528AbiKNUpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbiKNUp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:45:27 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E88210A3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:45:27 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id l4-20020a056e021aa400b00300ad9535c8so10000365ilv.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:45:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UiNIXMC9PLeAhbtNxDuXY7NkP6nv73/Hn2iICKpHFto=;
        b=DLW60xfpM2MlpuKATb70tckpt9OhXNsEKThXTU580O32Jefnll8jDq8U7fIxPPHF8Y
         KxscuOyEdrU7FKo1VSo353Zx33inGuBu3E3VpkrcaOEYCsaoW6kluiWGKWbGst+DG8DW
         2K8qx3SWIuGDcvRRZCJhaBJS0UBPcuBsX3EQjcJzfSTgKf/F2rs3fYHbSrHBH6BZzFK0
         g5VXkbnYOcUS2T40ACqeP3DJmhyn3g4U8emtF5jDL9vNFp3f0yzUkg+otj4reZ+UdJrD
         FrRzH+7OgJRVg/Zxzs1GSyYSJN1c0wIVdDlJ0jhTir/wP2RVo7B47Z0fNOzzFwuZW0+q
         dbSg==
X-Gm-Message-State: ANoB5pmda/pHtOFIah3jo1KKKweWv5MK8hFnbsI5h6Crs8JQCEoB/PPx
        6Qyz5aTpGaYfR7Cv381DXU6xeM6IU1/MTxPGm+lhZtLUmljc
X-Google-Smtp-Source: AA0mqf5FHZ4zPQ7MyRu/TuWa+lI+C45pQvITg3EFD1bDOaKUEHiGNsIPr9HsAK4OS0fcKw9JTl01GW4w6NSOvOpK8brRXn+cL+5m
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:100c:b0:300:d5a7:4503 with SMTP id
 n12-20020a056e02100c00b00300d5a74503mr7305850ilj.294.1668458726643; Mon, 14
 Nov 2022 12:45:26 -0800 (PST)
Date:   Mon, 14 Nov 2022 12:45:26 -0800
In-Reply-To: <20221114131927.2159-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b95fa705ed7451ba@google.com>
Subject: Re: [syzbot] WARNING in anon_vma_name
From:   syzbot <syzbot+62ed954113bf02c79f74@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+62ed954113bf02c79f74@syzkaller.appspotmail.com

Tested on:

commit:         f8f60f32 Add linux-next specific files for 20221111
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=175b0e35880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85ba52c07cd97289
dashboard link: https://syzkaller.appspot.com/bug?extid=62ed954113bf02c79f74
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1751b9d1880000

Note: testing is done by a robot and is best-effort only.
