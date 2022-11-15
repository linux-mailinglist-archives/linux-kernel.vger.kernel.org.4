Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8B962927F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 08:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbiKOHfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 02:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiKOHfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 02:35:31 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57246A193
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 23:35:27 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id bp26-20020a056820199a00b0049f4e8f2d95so1171148oob.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 23:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QfPcLCxz1TiNWDHSlAnE2r5KbmpQPBxQAuqWGU9WFyM=;
        b=j4NIo48j0ZYB18FvLybTFpyOdAxeEMoCIiDws9AzWcs1PWHdNwvPl/kQX+fqCq7fP0
         FhvfMwQw156AHdXGEebmNu8AByizWYwSTVrXb6H/uBpuC99gE2hrxrTT5FaupWOX7r/5
         6GXPkQKJirZcg4+9lWjMiss57lrK3P6JwR+FYwyJLQ7atild2FOT9iNXmTCq5YbeS/Uq
         pxoJNhMHL+JZkTFKb9aYllVht+XuTunNG8Zx1nclb8UFvkMuZOEI79df1lpW3ntuRG+h
         mXp7Ipr6Crt1c39/doBUwMeGcS3rPGrngRNElNzlkNYLvCQUPAqqJJWUG18NmmnA/Air
         GEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QfPcLCxz1TiNWDHSlAnE2r5KbmpQPBxQAuqWGU9WFyM=;
        b=5ba8njMnlKd7Lmj1XnzdtfVf6BKoNEovrcqIY7tRuP+DKDx2A6eEFNDVTswVFd4N/O
         IscrY1VqtrCYlbdZtgJIL4aMc/+uFXGLDGeldSFxDTzwSjsL49XI9Ff/Df4e2GEakoW9
         Is8CmgGMy+SXhlsQSy5sXFYwpQvdkZM7kaUR/coN6hYF2VF4iB+qaZFEVlZJBQuGcGP5
         lvV1SRhCLtdemNH6RJ+nLBU2R32MiOQMc8eTZ+j+ZA43bUwrIhHkWrQMjdhu6FVDqmLI
         5gdDj8QrcnJAWGPaMACjL0PIwDDb2GuvgN9HMtJATYEpUzQtlA8dA+WCVQ2s9Jy1WUez
         WNrA==
X-Gm-Message-State: ANoB5pnofY2PwuvZv7zF1OSnuw+OJ8jlUkpLGicXYg0U/TOBGqWu0LcO
        if1/eYtclji6a4cWgzwmihc70UUxAFORRKRk/Bt3YpSMsc+Zcg==
X-Google-Smtp-Source: AA0mqf7BBYSv/7BHzqHv5j7TCXasOrCoNRQAluEQ5aAbbGeMLuh4XzwBWG4lUJuMg179dpx84jPSXysxj7hfS904ufc=
X-Received: by 2002:a4a:ab83:0:b0:49e:9f04:2010 with SMTP id
 m3-20020a4aab83000000b0049e9f042010mr6885137oon.48.1668497726244; Mon, 14 Nov
 2022 23:35:26 -0800 (PST)
MIME-Version: 1.0
References: <0000000000001dba0805d2a5bf87@google.com>
In-Reply-To: <0000000000001dba0805d2a5bf87@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 15 Nov 2022 08:35:15 +0100
Message-ID: <CACT4Y+Z-Mi-F8V_stvFvPdzyfnmcYwLp986gyQ=Z0amvsC4_fA@mail.gmail.com>
Subject: Re: [syzbot] upstream test error: BUG: program execution failed:
 executor NUM: failed to write control pipe: write |NUM: broken pipe
To:     syzbot <syzbot+7d6f6855aee30f8bb7a5@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Dec 2021 at 18:23, syzbot
<syzbot+7d6f6855aee30f8bb7a5@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    79a72162048e Merge tag 'xfs-5.16-fixes-2' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=167ed58db00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5c733c28c0192584
> dashboard link: https://syzkaller.appspot.com/bug?extid=7d6f6855aee30f8bb7a5
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+7d6f6855aee30f8bb7a5@syzkaller.appspotmail.com

This was fixed in syzkaller.

#syz invalid

> executing program
> executing program
> executing program
> executing program
> executing program
> 2021/12/05 06:23:57 BUG: program execution failed: executor 0: failed to write control pipe: write |1: broken pipe
> SYZFAIL: wrong response packet
>  (errno 16: Device or resource busy)
> loop exited with status 67
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
