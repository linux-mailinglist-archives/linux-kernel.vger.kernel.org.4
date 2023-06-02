Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7869C71F78E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 03:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjFBBNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 21:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjFBBNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:13:46 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21195180
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 18:13:45 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-565bdae581eso16317357b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 18:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1685668424; x=1688260424;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4nydeH8fGmYfEq//3RT6MGqc1Z4XWdWvcyC0fJTwhtM=;
        b=JFBun+Pik8MgDtLxGed2bleSGjQCew45jQglAUHqtG3l9V53YpgjD3ZokHdpg2u95+
         nR3woVnNJRgAcLxwgbda8dkLv7dMAMIbAlzoqLQJUEsKtUYBApsyTpqbc7P042Sygxxd
         h7m4VmiGKxlLVAj7GLE9wuDHP+uMeFHB8rslF/yhflnSNcewswQICHjPdlKOn/CzSLi0
         avgCmxnCuYQslsl6cyl+JmCfP2xp9u5BWKAuUdpiMomu6oGeT0n594nYyRhKfCj0ifuw
         1UyLccigYVvCOx7oT453wNtRcR5Rgw1d1JSSharO0tegFGxPuP4VBIk6ifiO5wKy7r1+
         T8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685668424; x=1688260424;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4nydeH8fGmYfEq//3RT6MGqc1Z4XWdWvcyC0fJTwhtM=;
        b=fhhH/UPQpgFfp7QXw6k8j7ndBkBKWYWStY9wiMDCLIT5gLM2dPmelYmlJXfmaH7URs
         dJHnxPwtZ1e2a+k7ATb1RVjLgjiRzs9wAMxKvKQtJIar7CG/hLJT02QVLEpX1w8d7544
         T0ak66TL1gOjK/+v2+moKR6MebrepbbUPPCZxHJUsVkT4NZ1FKasBudG8z5Bpiex209s
         U7KqYt5vn6qIXpiB3Q20/P29ayf9t2uthOmG75HpV6yiy7YukDsANW9hVs1IrCiM/wwe
         ToKRWr7qmXd8NKrJEmIluwuebsGTpfC6Djy2NQ2kaot+fTQBqEI6BMRw3EeRAlAYRcUK
         U/RA==
X-Gm-Message-State: AC+VfDyKna9YE2FaTMpcsH4DVoGU4pTm80sxiHz09HAJruLjPunaHXyC
        UxMRNVompusE032On+ZA3nr7MvQSZ/or3q6NC9/a
X-Google-Smtp-Source: ACHHUZ7orX0SaNZQ72ZLc51WkA3Dy6WwNhQoWx2L0nYgKXT4snf9ah6BwBrapuvf/G9Xsr9zVyKYPNl1JmUAZdSPl3g=
X-Received: by 2002:a0d:e801:0:b0:561:e8d7:ac6b with SMTP id
 r1-20020a0de801000000b00561e8d7ac6bmr10789383ywe.49.1685668424300; Thu, 01
 Jun 2023 18:13:44 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 1 Jun 2023 21:13:33 -0400
Message-ID: <CAHC9VhQPMmWZwS-S9FQpU5rETcizcDPK0Nm1mwXeWpykUdDLFw@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v6.4 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A small SELinux Makefile fix to resolve a problem seen when building
the kernel with older versions of make.  The fix is pretty trivial and
effectively reverts a patch that was merged during the last merge
window.  As usual, the commit description has more information.

Thanks,
-Paul
--
The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

 Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

 https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20230601

for you to fetch changes up to 42c4e97e06a839b07d834f640a10911ad84ec8b3:

 selinux: don't use make's grouped targets feature yet
   (2023-06-01 13:56:13 -0400)

----------------------------------------------------------------
selinux/stable-6.4 PR 20230601

----------------------------------------------------------------
Paul Moore (1):
     selinux: don't use make's grouped targets feature yet

security/selinux/Makefile | 6 +++++-
1 file changed, 5 insertions(+), 1 deletion(-)

-- 
paul-moore.com
