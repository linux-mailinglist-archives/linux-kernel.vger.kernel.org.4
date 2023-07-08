Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FDE74BB91
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 05:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjGHD3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 23:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHD3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 23:29:44 -0400
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD1C1FEB
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 20:29:42 -0700 (PDT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-262e2cb725eso4092834a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 20:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688786982; x=1691378982;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oRmmo91KtXwV3Q9E2QoZFWtlhYWtVfAkm5QWKDBRMJY=;
        b=j7zTvLYwTucJnL02KwutsIifkuLUnfWNqxZ3VFJU8kRtj4hP4bEcNHjNbzdhx0wThY
         jBBiaXTMnHNaKcsEiVLIg81cDULXzm6hEtS8gvkBzbuO7x8ilzgNYaQQqvgcuqqp1W1S
         S3IHmNAGme/Emn6dltsYylsak3oZBvKKwSuLrpYLiUjTvI/51nh4NVJGmnFpA0wqzjs5
         lir3p/14uD3j8WSfIU7tiDGMeTOdziy/FcWFCy1BQiubFIPOAfRB5LJyPtp8nmn5XniU
         g6Jzs2dTUxy10hVzXmrDXbLiZgNyKomVbcYi4jXpB89IirSxH1qJY7o6A9kIWo3cI3hO
         ZG+Q==
X-Gm-Message-State: ABy/qLaKtFaMt1MD++lMz/NnRuXk0MZpGcl4CPVEIIu1K5kW+QVd6vo8
        19YDdDrNt2f6/TulTGhlXonobJSWKRgi2BxgBnYx00SWNh6f
X-Google-Smtp-Source: APBJJlFo2k6cY956YcKwaHFEyisbNOeGwA1amFSdHp1k54MCXYbu3JtdJhd0DzRllYkOkG5A2Gkbs6deM6FjZPVOcPdtXfzHXp3o
MIME-Version: 1.0
X-Received: by 2002:a17:90a:d241:b0:262:d507:b813 with SMTP id
 o1-20020a17090ad24100b00262d507b813mr5612043pjw.2.1688786982042; Fri, 07 Jul
 2023 20:29:42 -0700 (PDT)
Date:   Fri, 07 Jul 2023 20:29:41 -0700
In-Reply-To: <20230708025457.1362-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002a835605fff15c69@google.com>
Subject: Re: [syzbot] [nfc?] UBSAN: shift-out-of-bounds in nci_activate_target
From:   syzbot <syzbot+0839b78e119aae1fec78@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+0839b78e119aae1fec78@syzkaller.appspotmail.com

Tested on:

commit:         a4524835 Merge tag 's390-6.5-2' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1406e26ca80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7df0cabaf5becfdc
dashboard link: https://syzkaller.appspot.com/bug?extid=0839b78e119aae1fec78
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13f3fad2a80000

Note: testing is done by a robot and is best-effort only.
