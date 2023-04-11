Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F126DD494
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 09:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjDKHpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 03:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjDKHpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 03:45:17 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CF1EA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 00:45:16 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id r14-20020a5e950e000000b0074cc9aba965so4981140ioj.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 00:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681199116; x=1683791116;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HbWUqpJCIyP7ZGmwXjgwzNf+FuN/IBe6NUV2pu6zltU=;
        b=ccbksPxVgnzSwoxk63difBlakyNYVU4d8m0ypqzyfoer3QXNmZkR3nL70+JZ5Xhp97
         60dQw2XwFyUsqbk1Hmc1iz0bXIZOvQUjk11jTmoPFpVOv/TrlBzIpVKp2+hsVvqgIokg
         xpon8g/sBAZcelsLR4z+bHioQHOOownQjyutmtR9Y5/uhBW5xZoxlRdN3454gmem4SBj
         CEoTTun1519s2CaZV99qzsJXYXshR4D3vuXRSGqEZVsudMCgrV6tr73J80qP7TKQJ6++
         8SgnosIzQ8btPSgOPQYrHr2UlHb2g2YtvoRdwRufFZkwFTazjWWy1WDUFNBVnjscOF9+
         9aFw==
X-Gm-Message-State: AAQBX9cBnjy8gIjX8PkvqBeW4qZ1AEkx1CmsFnY9psvNEZTZ+5SnU2pS
        H1FjpPsonffK+LtBv1rfODpW7Y7K1+RaGfK9XhKzJmuvRKoC
X-Google-Smtp-Source: AKy350bNSCu/PcC8QGr7jRhj27QLgX2g6a+toIV9soxEZ/khEnqLSN2ViGI6A5tkAgSHqE25xe6PU8JKkiJto2MR5IWbSWqMPuOH
MIME-Version: 1.0
X-Received: by 2002:a02:858c:0:b0:3a7:e46e:ab64 with SMTP id
 d12-20020a02858c000000b003a7e46eab64mr5005293jai.1.1681199115991; Tue, 11 Apr
 2023 00:45:15 -0700 (PDT)
Date:   Tue, 11 Apr 2023 00:45:15 -0700
In-Reply-To: <d6caf172-7eb6-e664-88c7-581bd0559bb0@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001b02a505f90aac8d@google.com>
Subject: Re: [syzbot] [erofs?] WARNING in rmqueue
From:   syzbot <syzbot+aafb3f37cfeb6534c4ac@syzkaller.appspotmail.com>
To:     hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        xiang@kernel.org
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

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git//dev-next: failed to run ["git" "fetch" "--force" "2dd127424840ba106193cac6a90d288b6cc7557c" "dev-next"]: exit status 128
fatal: couldn't find remote ref dev-next



Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git/ dev-next
dashboard link: https://syzkaller.appspot.com/bug?extid=aafb3f37cfeb6534c4ac
compiler:       

Note: no patches were applied.
