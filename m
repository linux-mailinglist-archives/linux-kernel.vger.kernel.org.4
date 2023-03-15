Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2EF6BB5C8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjCOOR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjCOORw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:17:52 -0400
Received: from mail-il1-x145.google.com (mail-il1-x145.google.com [IPv6:2607:f8b0:4864:20::145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFBD2D68
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:17:33 -0700 (PDT)
Received: by mail-il1-x145.google.com with SMTP id i7-20020a056e021b0700b0031dc4cdc47cso10088212ilv.23
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678889549;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D1rESnOQX+kv/muZBRxj4lLtimFZV7laY3UxsRMgR6k=;
        b=pKyQ6mCs+itwnLgpqr8ZatFVTIe8VZglVUnyGs743TUGSoKyXty1lG5NeLxJUJ6/9c
         JsqmNFEK0FuBlE4D/Ye8wzSxN3lKvC5rrZl/cCyF7AjViRJSijc6XbgTEdolnTnmPk3l
         kHW/D0hoEB7Xdr6hjE3lG0Ctj8Q42ELM8r0Os5uSHxD1bANAiVpfE7Ue9yiBu4Lv3/UV
         oXeXnOZi9ZZ1oB9pWP8A6iU4TArBaQfLqkTo+PoTwIsSt2H4OTlnjkxz1BPxtpRxo/K2
         JBbK4115DY2zAyAv0delzC80i3hDC3Dnh4BMAyigX5qWh+eJ71UfPlz51xwLMXLEEWx9
         LWLg==
X-Gm-Message-State: AO0yUKUvbgHG+xy0wJEhHY0ILjXDJsoG6pghDPpQe4hUsX3s4aqqiNxp
        7YFfwZfs7KtXJVq+dlmYVCd1AmZoI+11ZwMSBeC6S7vlG0oa
X-Google-Smtp-Source: AK7set8jQrT1g0l/9bnsj1jV2T6nfOxIVoUhSC18JC+M3Lw9b7FnOA/pp1BHblRcfSyawgGqQbEZs1YuIpRt5EAkPje7RlgwJqwx
MIME-Version: 1.0
X-Received: by 2002:a02:2acf:0:b0:401:d47f:e799 with SMTP id
 w198-20020a022acf000000b00401d47fe799mr5348051jaw.0.1678889549585; Wed, 15
 Mar 2023 07:12:29 -0700 (PDT)
Date:   Wed, 15 Mar 2023 07:12:29 -0700
In-Reply-To: <20230315134701.ojj2nzlbdbslheaz@fpc>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000386d3a05f6f0efc6@google.com>
Subject: Re: [syzbot] [wireless?] KMSAN: uninit-value in ath9k_hw_init
From:   syzbot <syzbot+df61b36319e045c00a08@syzkaller.appspotmail.com>
To:     glider@google.com, linux-kernel@vger.kernel.org,
        pchelkin@ispras.ru, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+df61b36319e045c00a08@syzkaller.appspotmail.com

Tested on:

commit:         34add094 kmsan: add test_stackdepot_roundtrip
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=14bfc58ac80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=76a9330669c37355
dashboard link: https://syzkaller.appspot.com/bug?extid=df61b36319e045c00a08
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1727a63ac80000

Note: testing is done by a robot and is best-effort only.
