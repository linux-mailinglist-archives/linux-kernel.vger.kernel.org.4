Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76096A7A37
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 04:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjCBDzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 22:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCBDzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 22:55:33 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625602DE46
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 19:55:29 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id b4-20020a92c844000000b00317983ace21so2125072ilq.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 19:55:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00xfrrClzURlGRUuK1OunWq/lrQQId5kjwoGp/zS80k=;
        b=IKo2dcAi8I+lo/2q0I3ejUDEiRdNMwe/DIEMe0UHLwP3guWVit6Kos1cm/kSShZ+vr
         boKogLTyi/usj2tBsORA/KuKRWWFvo3lLF1j/f8dHNxBTds+UefFrV4q9DAM3Yjjl8p9
         fvmFeE0WZwgxMCaNPbu/zroeaURuMWE0iLt5lrgX/SWtpjT/wgq+xHqCLfdqSILzuaiC
         YG5K16JSG1GONMEkzW39I2zrOetghjyQbbI2HpzVje3gQJt7imYaP+RIyucLv0G5cgJU
         nEfTsyIGhyawndZnL3Ms3V2V6IbIxvq6p7JfMr4xSDVY2gwjLqWxsEBvZfUmdkG0hTU3
         GYAg==
X-Gm-Message-State: AO0yUKU+duJFVIqcnVhmBfbO+1KQnd4jytNX4JbZR+AcxobU+Pqe3vjz
        uQpgMHtOkQxpN/zpm9nd1CYrfvRT3VRPSmLCVWlAchIbr0gZ
X-Google-Smtp-Source: AK7set/Ivxu+6VBFeZdxqtudeToANn2v+72BNTzgsUdh0pYZsufFqBp+QYVhk6lvWww5TRW2zAiqQgcmWUrh/Lzuzt9luWsOT9A1
MIME-Version: 1.0
X-Received: by 2002:a92:6d05:0:b0:315:8de2:2163 with SMTP id
 i5-20020a926d05000000b003158de22163mr4021695ilc.5.1677729328748; Wed, 01 Mar
 2023 19:55:28 -0800 (PST)
Date:   Wed, 01 Mar 2023 19:55:28 -0800
In-Reply-To: <20230302032608.2457-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ab607205f5e2ccea@google.com>
Subject: Re: [syzbot] [mm?] INFO: task hung in write_cache_pages (2)
From:   syzbot <syzbot+0adf31ecbba886ab504f@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+0adf31ecbba886ab504f@syzkaller.appspotmail.com

Tested on:

commit:         489fa31e Merge branch 'work.misc' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=127939f8c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbfa7a73c540248d
dashboard link: https://syzkaller.appspot.com/bug?extid=0adf31ecbba886ab504f
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13c7e422c80000

Note: testing is done by a robot and is best-effort only.
