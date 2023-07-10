Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8590D74DEEF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 22:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjGJUOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 16:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjGJUOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:14:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72030BB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:14:29 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689020067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=8dqQcHsAWD3KRo9IBBeMBUGtHwdAS4lMEwTXDFFdOx0=;
        b=NPew7pv8a5wWZ4z5+LgQH9Kj3o4vU08gnjlk7WMQy2JkiCcfRmtuLhwvVpgxurkxZQkPsU
        Y9UAfO/G9VSHevvxs3Nq8W8i36fgWefftZCzPUZ38yF2SZyyhCqb5r9h56Gcsfse7w7tHA
        8gw4i6tBXOZfAnCglbwc0n3n+2QswHNx19dhmcHSVKa9m0jMSZfP+ZOtVxkoFUuD0IVxV8
        yHHq55fHw+iESFKWycY9g4D67XcVJ2/ymkEdl3M/5QvePfe/PmMQIHcAWxBH3q1vbYrHWp
        tRTc2pnZO0wa5JoLuUhev8qU+X4EXRLOK9Bj6wGCJIJoOZUpslRS92Su6R9hwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689020067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=8dqQcHsAWD3KRo9IBBeMBUGtHwdAS4lMEwTXDFFdOx0=;
        b=QADcnZPn70qE2G+n4ePqRbQeKZU+YZ9LAkc6u+H4HNUDFS1Hiv2Ak69ds3y5AKz6zIITEx
        0SjElV27MrcB4FDQ==
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Fangrui Song <maskray@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: 6.5-rc1: powerpc-linux-gnu/bin/ld: warning: discarding dynamic
 section .rela.opd
Date:   Mon, 10 Jul 2023 22:20:24 +0206
Message-ID: <871qhf1q3j.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It seems an old warning [0] has reappeared with 6.5-rc1 for my ppc64:

/usr/powerpc-linux-gnu/bin/ld: warning: discarding dynamic section .rela.opd

The machine boots and appears to be happy.

Some info about the target:

$ uname -a
Linux g5power 6.5.0-rc1 #1 SMP Mon Jul 10 21:52:33 CEST 2023 ppc64 GNU/Linux

Some info about the cross toolchain on the build machine:

$ /usr/powerpc-linux-gnu/bin/ld --version
GNU ld (GNU Binutils for Debian) 2.31.1

$ powerpc-linux-gnu-gcc --version
powerpc-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0

I am happy to test any patches or send any additional information.

John Ogness

[0] https://lore.kernel.org/all/CAKwvOdkyGQztQ9YgDOw2+DpcnoNXwbsOstNhDOLc6HP_Kopv-Q@mail.gmail.com/
