Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E06174F0A1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjGKNrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjGKNr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:47:27 -0400
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C74210C0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:47:26 -0700 (PDT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-563641a966aso4847509eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689083245; x=1691675245;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rShxroulwemaQ3xw/CWRpWc1+VARI1i/SlzABuWAXw0=;
        b=Y0qnOPcqgtvm5e585uLihLm5NcNW3LexqR9bH1y2nDKGlGVAd6tviCPdYgR7fIrw/A
         ZMRF91XaL/amdNTFYXk1+gQTevAMOTNph9k5JfNDUCtrqyb8GwizNgHMdBx3wVDiFYlo
         M4pMoc58R+WqNd+D8eB2X9iVOBwIpoB3fb86LbDuB9hvBmQ5HErSmL/YKKQd4W/fPRn/
         E2hXOPmAyJn6NrEclEN34uBNicD3c75NDf6wHZGnEq2RQEcBqebqbQSalBlfk/wi+RLx
         m64l4G4N/p0tgS0SyJSSVWum3D07JnUnYrLVMjwbE+BKESHhC41tkrnEri06H8/fo+HW
         7d2A==
X-Gm-Message-State: ABy/qLar2r5+JB7qOvywcC0ZaQIZRooKh5OK1EYGsjTbsry4vVwaJqZq
        BOEVKRfO4F/AJcPcrdAb1rgrqSpBMhCZZ4RkKAg6e6rmPiDH
X-Google-Smtp-Source: APBJJlEWmMPR7SEq04BNMqLaU6K74VXt8QFzC9KgoyW+hKd/KLKbdlPU/abCa/VAvhhlE7W/SXU4bnbM+V0vTjv0pPdq+rhGIvs4
MIME-Version: 1.0
X-Received: by 2002:aca:e156:0:b0:3a1:ee4f:77ce with SMTP id
 y83-20020acae156000000b003a1ee4f77cemr1639419oig.1.1689083245669; Tue, 11 Jul
 2023 06:47:25 -0700 (PDT)
Date:   Tue, 11 Jul 2023 06:47:25 -0700
In-Reply-To: <20230711131958.334-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dab44a06003656ef@google.com>
Subject: Re: [syzbot] [can?] possible deadlock in j1939_sk_errqueue (2)
From:   syzbot <syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com

Tested on:

commit:         e40939bb Merge branch 'for-next/core' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12a24702a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c84f463eb74eab24
dashboard link: https://syzkaller.appspot.com/bug?extid=1591462f226d9cbf0564
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1772e474a80000

Note: testing is done by a robot and is best-effort only.
