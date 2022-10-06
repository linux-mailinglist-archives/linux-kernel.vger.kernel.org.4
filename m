Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA665F63C6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbiJFJn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiJFJn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:43:26 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38122844E3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 02:43:23 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id i4-20020a056e02152400b002fa876e95b3so1129035ilu.17
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 02:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L72TxMqn957lCY1q6MQNwCwEIeO2DumpQTLfXHJDx2U=;
        b=K4Hz4Cf9nh3ryIME1C1G2evgypOBP+2itGW1Vpmu8dpxTXCVcVwg2Sibdl4xTxwD3W
         cWAoCM0CH1PQKtXxGvOkeODAfJjxoigWlje5tMabXqK2+pwtADllvJ3ymOBiuAWRLeOE
         tkcK0WVtMlmc2e8onBRNFKviGJuyySxFDqkKvvICeaNqIdClN6JxD+dKUiVA2j4vom0U
         DxneJR6cQjoxN7bYrtDnCILjnZ/MClBxKzyrQV2k041Y9yQPNlNP3q19McHbB2d9L6++
         hPtacfzmMXmq/uAdrCVLG3XXLMQhrFPmgba5RXxhzRBBTIKWAEq7gaqXYWEkXZOaAtuT
         nTSA==
X-Gm-Message-State: ACrzQf3sWETBEvtNYyKHO8jPyOm8ZAtCSjeQdpmUSGsybCADx57dOrc2
        CD9b4ZeVg2Go10JOlHrtcDzxGdMzSXWGXJisQkgBuJ/1hv+T
X-Google-Smtp-Source: AMsMyM7EC0ZZu26V+PPR2QQv2e5WsIu0BMXIfrMQJ90KByy98aZxmoJRS7LVjWfnbLh4Ipd50tWWQ6rRGlkxWKP3U9lx4oCwhVyG
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d51:b0:35a:5808:41ff with SMTP id
 d17-20020a0566380d5100b0035a580841ffmr1972552jak.45.1665049402278; Thu, 06
 Oct 2022 02:43:22 -0700 (PDT)
Date:   Thu, 06 Oct 2022 02:43:22 -0700
In-Reply-To: <2217443.iZASKD2KPV@mypc>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000280f3e05ea5a868a@google.com>
Subject: Re: [syzbot] memory leak in __get_metapage
From:   syzbot <syzbot+389b82b29093b3e2640a@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, fmdefrancesco@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/6.0: failed to run ["git" "fetch" "--force" "f569e972c8e9057ee9c286220c83a480ebf30cc5" "6.0"]: exit status 128
fatal: couldn't find remote ref 6.0



Tested on:

commit:         [unknown 
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 6.0
dashboard link: https://syzkaller.appspot.com/bug?extid=389b82b29093b3e2640a
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1634a658880000

