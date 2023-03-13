Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8B26B74BA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 11:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjCMKxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 06:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjCMKxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:53:37 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C7D166FB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 03:53:22 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id q8-20020a92ca48000000b00320ed437f04so6225745ilo.19
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 03:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678704802;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iQxKRV7imlZOJAklU2wsxQPzEHvU8j8IFJWbZVN/75A=;
        b=DCIvstezAV8qSle2O0uwtWvB/AHhp63l0ekYBfI3YN2BbHaqRG6InqKzNNY8DbTZXT
         MzKAIDk7K3zejtlkWKxEmAiRS+O6XlBxRJTH5Qt/sU50evab91cklP5uV5Dz/NSCB9pd
         0atM4hyeCtNoQlHuvICVckuJ1WTRNHgCSsZtDjHaWLqtbB1UQhPcJyTzZiIyFoMN8X5r
         8T28jTcDm84iJXXLt1meoW5+/jOyD66DB92swVgoZka3uplkp48AkTydD6nX05hl58yO
         KcbNRN48tgd0i6cb3z/SC5bdVDNhPGMcx2XwTMz3cGYa2vWvaaiNtG1KHI6kDWnhOwdn
         TTng==
X-Gm-Message-State: AO0yUKUIc3LIRspQERE14FsoLm2BpvBDkkKx5B64/MoFYX5U6ORJ+zFE
        TxC1SBbaBWehk/2r64ADWiCH2EUbOqqkEiEi0kJ4AjBd+0GE
X-Google-Smtp-Source: AK7set+3Ma7khExIX6P+jF0AO9dwyHv0k3SsF4v9DPPFsx8owxXodphsOpZ9T5Ow0l50Qa7lTt+GHZdXJyPyH/ZwHYLSz9fyfFC6
MIME-Version: 1.0
X-Received: by 2002:a6b:dc1a:0:b0:74c:a82e:eed1 with SMTP id
 s26-20020a6bdc1a000000b0074ca82eeed1mr5212910ioc.0.1678704802225; Mon, 13 Mar
 2023 03:53:22 -0700 (PDT)
Date:   Mon, 13 Mar 2023 03:53:22 -0700
In-Reply-To: <20230313102807.wdd22btl5smkkcse@fpc>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006b695005f6c5ebcb@google.com>
Subject: Re: [syzbot] [wireless?] KMSAN: uninit-value in ath9k_wmi_ctrl_rx
From:   syzbot <syzbot+f2cb6e0ffdb961921e4d@syzkaller.appspotmail.com>
To:     glider@google.com, linux-kernel@vger.kernel.org,
        pchelkin@ispras.ru, syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+f2cb6e0ffdb961921e4d@syzkaller.appspotmail.com

Tested on:

commit:         e6189313 kmsan: add test_stackdepot_roundtrip
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=152829b2c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ef8f90a9dd9b8eae
dashboard link: https://syzkaller.appspot.com/bug?extid=f2cb6e0ffdb961921e4d
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14f7a2dac80000

Note: testing is done by a robot and is best-effort only.
