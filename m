Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5087365C2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 10:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjFTIJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 04:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjFTIJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 04:09:22 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECD7C7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 01:09:19 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7775dd6c7e1so418075539f.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 01:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687248558; x=1689840558;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kPOmXK+JJS4XSvlfMU0a0e+c0GK1JCtS0fKF/mMBn1s=;
        b=TDH0l0/isttkXv6K436z7gXyFHWdgacwjWoUnsFiA6iPPMY+Zhae8LL01aclYhbOfA
         hZIR9FO7ewyaNJrsnFsEmhHpnATvNFD7+8Ncdub7Qtc6Kz64uT/oj/r4ciFNaOHE7SkG
         2UthUsZhbaukJAsT2cnJLRC3GfmgYyvPsPYd89dNy5azLBRyUT1NJiPkExc/xdFz9v3F
         qCY6CZLV4wDHHoHXZWRsGQcTX+lqfsoHZfGZ+cAsertfVyTUqt8POWIeLZztP/5QruEB
         2vys/bNgvjhhI8r9ucouRJVH7xeDtqOjSRXzjz0wPQFtqOKRglI1siR8+6EHnekfpqHr
         ZYxQ==
X-Gm-Message-State: AC+VfDzdej2fyxAzlOTlTkA0Ckp1HVyTOKwgpbS+489HOtu2b+RFQYPv
        hQjwTFLYfl+lzBhnGfaSmiLDf+ltkYL+Tbuoqa2X+jDBWvfT
X-Google-Smtp-Source: ACHHUZ47imoHu3Jlv7gSHJneCOAcUD5Sx26XyRsq93AybmIdKnUTNEssmEu5sY2CCI52QcBpBYoNLifZf2DdT28IgIIcEVk/2WfB
MIME-Version: 1.0
X-Received: by 2002:a5d:9e58:0:b0:766:6741:8856 with SMTP id
 i24-20020a5d9e58000000b0076667418856mr3886774ioi.4.1687248558828; Tue, 20 Jun
 2023 01:09:18 -0700 (PDT)
Date:   Tue, 20 Jun 2023 01:09:18 -0700
In-Reply-To: <1221049.1687246988@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ff364905fe8b2a25@google.com>
Subject: Re: [syzbot] [crypto?] general protection fault in shash_ahash_update
From:   syzbot <syzbot+88f4b1e6cf88da11f5cd@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dhowells@redhat.com,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+88f4b1e6cf88da11f5cd@syzkaller.appspotmail.com

Tested on:

commit:         49310624 Merge branch 'ipv6-random-cleanup-for-extensi..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=141473e3280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4a7d74e6a7c3211
dashboard link: https://syzkaller.appspot.com/bug?extid=88f4b1e6cf88da11f5cd
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13365e5b280000

Note: testing is done by a robot and is best-effort only.
