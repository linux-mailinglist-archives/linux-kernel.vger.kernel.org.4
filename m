Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648756EA047
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 01:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjDTXxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 19:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjDTXxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 19:53:17 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E0D6A42
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 16:53:12 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-54fa9e1b562so2273467b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 16:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1682034791; x=1684626791;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KHHZZuHbwLiJ7NY+Ob+HDRHHPDzvLMpAxuYAdsUfBAQ=;
        b=epryOW3J8Xyc4q4qhmbSDG34MQ4prFFY//qNwXIck4/ujK7skA2/p2D5NymsnJ7F+U
         TqH+NG1p+Zv2HLy0d/ZobEyfs/4iIlChuu+Gbk2sckmJUuLQiHqgidja5lg61XnDaYEB
         cfd1bXj2lFv9Y6cA7gytwNdmS1c8/Y9hThGdSeV7Q7nBt63IgzzizwJClKIrW5V23+LR
         dO1V3oocKPX82iw4EeUAIifWIy7AIRcXcWVJ84qKSmnakOLKpqYjzQspdZ2U9X7pC8x+
         Pqio+JENC6noc5QKunnAYttRiExvJu+O3A6h6vsV1XKaBSWq5hpihfJclMnF0+wqz2jD
         7YXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682034791; x=1684626791;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KHHZZuHbwLiJ7NY+Ob+HDRHHPDzvLMpAxuYAdsUfBAQ=;
        b=kJXef3Ss89rJ+9wMD/Xb8KzS2rTWybF4bnooRwx0IvZpM56QPIhgBl+0yxxqez+omK
         TVrfjwfxS4ylyC+E6EuaDg/O80uBVqaw4c+9HmI69F/icxaRYAMUD52OwZ2qahim1Go6
         J8iBOsDXS+R3fkZyc7hjTJJfEDkNLq/p9ACgswHF+YNMo/4HWUZ2Ujk5s+HoUfTfntWB
         R1fTOXHYhtXXJq3KhfGUIZQcHxXe1iLX/bbMg5pulymBb0McTPS0MeXlkbancLCbJyYi
         QoGYcs58vkHYMebarMBWf97qZ6VrTr0uMS632ON8gvim0Wed07w/ou7bRa2mhLGHR75Y
         k55g==
X-Gm-Message-State: AAQBX9cQSauBEdXo1iZfQB9ri+GqCDH+5Khy/lpe6sNsCYd5vnGY5KdX
        gv8nglas/uqfFkUw7pg2rJGcwu67HbBJOm8P2hZ9ztIpn4gJiQA=
X-Google-Smtp-Source: AKy350ZhNdgyZvx7qtxLr4jn/78Wdk0Sn/X/4jXl8wsfCs5XgsZ2t1s+arzp6nhURgUpvNBAtAecCheHZJtx2qXZ8hs=
X-Received: by 2002:a81:678a:0:b0:54f:9cd0:990 with SMTP id
 b132-20020a81678a000000b0054f9cd00990mr483394ywc.18.1682034791479; Thu, 20
 Apr 2023 16:53:11 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 20 Apr 2023 19:53:00 -0400
Message-ID: <CAHC9VhQmV7=+eP0Rh6f+grz6=wigoHKuX5zZuMYVazsV8HVaVw@mail.gmail.com>
Subject: [GIT PULL] LSM patches for v6.4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Due to some personal logistics challenges over the next few days I'm
sending the LSM pull request for Linux v6.4 a bit early.  Here is a
quick summary of the changes:

* Move the LSM hook comment blocks into security/security.c
For many years the LSM hook comment blocks were located in a very odd
place, include/linux/lsm_hooks.h, where they lived on their own,
disconnected from both the function prototypes and definitions.  In
keeping with current kernel conventions, this PR moves all of these
comment blocks to the top of the function definitions, transforming
them into the kdoc format in the process.  This should make it much
easier to maintain these comments, which are the main source of LSM
hook documentation.  For the most part the comment contents were left
as-is, although some glaring errors were corrected.  Expect additional
edits in the future as we slowly update and correct the comment
blocks.  This is the bulk of the PR's diffstat.

* Introduce LSM_ORDER_LAST
Similar to how LSM_ORDER_FIRST is used to specify LSMs which should be
ordered before "normal" LSMs, the LSM_ORDER_LAST is used to specify
LSMs which should be ordered after "normal" LSMs.  This is one of the
prerequisites for transitioning IMA/EVM to a proper LSM.

* Remove the security_old_inode_init_security() hook
The security_old_inode_init_security() LSM hook only allows for a
single xattr which is problematic both for LSM stacking and the
IMA/EVM-as-a-LSM effort.  This PR finishes the conversion over to the
security_inode_init_security() hook and removes the single-xattr LSM
hook.

* Fix a reiserfs problem with security xattrs
During the security_old_inode_init_security() removal work it became
clear that reiserfs wasn't handling security xattrs properly so we
fixed it.

Please merge, thanks.

--
paul-moore.com
