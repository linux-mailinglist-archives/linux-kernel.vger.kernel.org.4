Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D33735FC1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 00:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjFSWJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 18:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjFSWJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 18:09:38 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62815187
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 15:09:37 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-77a1d6d2f7fso389917339f.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 15:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687212576; x=1689804576;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=18wIF3rKinLoRpSkehNKDsiNhig12DTTerhF0r5bB/A=;
        b=EDThN/imkFlPjVKzte0U48m5GMseEAeNwl59/HMKNnN1KaqksaR2iZtmrjry9F/JgL
         Ou9hBikvhPpa5KivQhNQdA7liRNlzlVjNfebC052KIK3UV+ZZHs7i8GD5NaXJY/cHbS8
         7Omt1ciO4a1oy4BP1RDc3Di/UMScwOU6qRvut/GRjkc+ZLzEZGi4Bu0/w0cD2zgL7+BB
         nCUqmePLAqZVoteTywGGDsr5iDH4zEUkU+n2D4gaHq8p18DzM4uyAJZjAyvlMX7bOLWK
         7bdzQpLCaYaLE5s6vyCv5YTOMV1BA8qPgMGoV2MXXlhtc7HHNBMi8Kyq7oOkrpXQGFaf
         cLlg==
X-Gm-Message-State: AC+VfDxPfHpEVBw/qTn9g7VSZ86HXO2Ny5jimk7ZwK1VQ/rmKMutUgvg
        yHXcusmTqmxJItJ6X1R4Vnng1+nnFe+5opoZEgCjqKsUV7WN
X-Google-Smtp-Source: ACHHUZ47JiJ7D6zbVcTND2HYnJ/ijfBs9OfkopT5ILSUxZMfqmcxVgGVigX37KA31taxlGmZ9fCoz0oSgn1EnM5BowFoIAwwT2yh
MIME-Version: 1.0
X-Received: by 2002:a02:93a7:0:b0:426:29a2:9d24 with SMTP id
 z36-20020a0293a7000000b0042629a29d24mr3087319jah.2.1687212576774; Mon, 19 Jun
 2023 15:09:36 -0700 (PDT)
Date:   Mon, 19 Jun 2023 15:09:36 -0700
In-Reply-To: <1167416.1687211141@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ca4ee05fe82cae7@google.com>
Subject: Re: [syzbot] [crypto?] general protection fault in shash_ahash_update
From:   syzbot <syzbot+88f4b1e6cf88da11f5cd@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dhowells@redhat.com,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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
console output: https://syzkaller.appspot.com/x/log.txt?x=178ba75b280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4a7d74e6a7c3211
dashboard link: https://syzkaller.appspot.com/bug?extid=88f4b1e6cf88da11f5cd
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11352c83280000

Note: testing is done by a robot and is best-effort only.
