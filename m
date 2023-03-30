Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7654D6D0A91
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbjC3QAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbjC3QAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:00:35 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFF0D31F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:00:30 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id i7-20020a056e021b0700b0031dc4cdc47cso12751033ilv.23
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680192030; x=1682784030;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AFd4Vv+1QlOQI+H4u8kgcpRfOkpOstzxf4ODCKTbTXE=;
        b=NZhxnUvSgMw14980I0fAnS+/to/0pjsUr0HAD0QgWhnqWOqZb06Rqj62+VcpX08/X2
         x6CCjkqnd6GR3jaCtpP+VGCI6EJ6aEZVSVEeGhFROkT+ErvWdsu6s4spRyS5zxgviT85
         7F85jtCRMnsi/eQYfJzl/rMy0oZqlBuvAyzgefgI+tF06VU9r8FH3tfJw/g9p3axmvb/
         vKAMY1gSwLF5KgUF5BJNmS4EDZyD0IYp1VcuMtgWVZHsflcGy0jp/yuAZisO+1/2Sa96
         HL7yxjn9Xb9ekk1RSkgAwk5lDmr0OYbfn6eCed2eZab5HO82Nhs3hPyzVrjOUsrelw15
         zq1g==
X-Gm-Message-State: AO0yUKX7e+iZ7FZrWClgp2vlfUy+2FLRFwZq7BOr8JsGBrIvZVRFV6HU
        2TdhMETbftxdYPSzI/YLJBbVLp8JwOVRRQygU1+NKAOMucK9iWE=
X-Google-Smtp-Source: AK7set9zMzME+5Sql6iouCqcaECY6f0i9FUvslzaxRbKCppicvh8rUlxD9aczW/rP3CUtus4FG9SA2BzVGZ9p0ffb/ym+1BylAkN
MIME-Version: 1.0
X-Received: by 2002:a5d:9446:0:b0:753:2ab8:aff7 with SMTP id
 x6-20020a5d9446000000b007532ab8aff7mr8414673ior.1.1680192030243; Thu, 30 Mar
 2023 09:00:30 -0700 (PDT)
Date:   Thu, 30 Mar 2023 09:00:30 -0700
In-Reply-To: <b799fc68-8840-43e7-85f5-27e1e6457a44@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001e03d605f8203164@google.com>
Subject: Re: [syzbot] [usb?] WARNING in sisusb_send_bulk_msg/usb_submit_urb
From:   syzbot <syzbot+23be03b56c5259385d79@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com,
        thomas@winischhofer.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+23be03b56c5259385d79@syzkaller.appspotmail.com

Tested on:

commit:         c9c3395d Linux 6.2
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ v6.2
console output: https://syzkaller.appspot.com/x/log.txt?x=16fe503ec80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b64e70ff2a55d53
dashboard link: https://syzkaller.appspot.com/bug?extid=23be03b56c5259385d79
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10b3a60dc80000

Note: testing is done by a robot and is best-effort only.
