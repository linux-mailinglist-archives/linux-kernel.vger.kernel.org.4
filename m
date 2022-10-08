Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DCB5F84F3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 13:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiJHLPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 07:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiJHLP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 07:15:26 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC69740E33
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 04:15:24 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id l18-20020a056e02067200b002f6af976994so5625480ilt.16
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 04:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fVaL+aZWzivfpOiU0dZXdxkJSJjGpfDw5+EVyLzqpcs=;
        b=4aSoNR5da+EfjTryZr8NxPRha8Rn4X2MzPoJrfEMbLW9Ich71xC3LPyLQaAwUepEfr
         TcmDK3wyd6Dw0IjbQ0IWBXeluCsp9DUjhtXvQl7UW8U1w3eaVsyGY3awanIGLeGgLZTd
         8duy4SQ77pODyPvudlcE1ahknD7T7Ffk5Qz2O6J1rBQNjlEmUKmZShjxHdZWTFFEpVQz
         5Ib61BQNf4ruwKiRTK5uYkIAPov1drvRApIE0kpcnaC/cjclxVjYafy7MkWmmM2BBqWm
         nFXDjjuHyPQE8Y84cV+kJuEkkPwCzMpFxvCHb7qzSHqkQgO0l9K/0iC3FzhfwaqOIKeW
         Shug==
X-Gm-Message-State: ACrzQf3PMpw9GX+HvPZ05H/8C7Rj1GN2prhiOORDaiBpl6yYaleZZARw
        jlV+Uw6ECwkVKY4lc1MgS5kAd9OcUp+1byNX8o+VC/Mqc5rr
X-Google-Smtp-Source: AMsMyM5nf4R4TbJCrbM9nU0nsafe8IeY2XAp5fFs5XUArq9iTFWM6QlLIdpXPQZufIChFL9PZl6xpPcD+t0xYllgvniMO2g/R4R9
MIME-Version: 1.0
X-Received: by 2002:a05:6638:349f:b0:363:95e0:ea52 with SMTP id
 t31-20020a056638349f00b0036395e0ea52mr3040718jal.157.1665227724028; Sat, 08
 Oct 2022 04:15:24 -0700 (PDT)
Date:   Sat, 08 Oct 2022 04:15:24 -0700
In-Reply-To: <20221008055133.jqreizhg5k23umgp@wittgenstein>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f6073905ea840a2a@google.com>
Subject: Re: [syzbot] general protection fault in kernfs_get_inode
From:   syzbot <syzbot+534ee3d24c37c411f37f@syzkaller.appspotmail.com>
To:     brauner@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tj@kernel.org
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

failed to checkout kernel repo git@gitlab.com:brauner/linux.git/kernel.cgroup_may_write.fix: failed to run ["git" "fetch" "--force" "81e322358ba96b4e95306c1d79b01e0c61095de5" "kernel.cgroup_may_write.fix"]: exit status 128
Host key verification failed.
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.



Tested on:

commit:         [unknown 
git tree:       git@gitlab.com:brauner/linux.git kernel.cgroup_may_write.fix
dashboard link: https://syzkaller.appspot.com/bug?extid=534ee3d24c37c411f37f
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13ae1c42880000

