Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A8D5FA687
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJJUq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJJUq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:46:57 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B2472EF7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 13:46:55 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id i7-20020a17090a65c700b0020ad9666a86so14111795pjs.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 13:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K6vWhNkXYIMcCDi2L3E2bfLP3W7gblcGN9nVooZSDqI=;
        b=P4SlCefcjq2GAAR5BVF6kBdMyLJhLLzKg9RG0K1CA2ksWzV8hrUORHa2feV6Mzaz7S
         EWi5VKGdMyvmHfaA8rR3kfVAPcVEOHE+q7WcBM8pVENuht4DriW7s5v/VaRNPuW0NXHT
         eu7qvZ9owvp+YEEisvyhIQAtjc+1fSA/1mrvAt6/KFo/wNBdoTng+94PS+KwUu/S6KvF
         Pky+LbRFjwQ7Fo39neY2VTlAGDvbR2YRTjddgtQrQRjpDHhNT1i1XaLrukUXKxz5Ui1Q
         DRKd1/q3IRvkXvTzIMhC0M73FHOf11iCo2YrCfF7HtC84OMjFWYMurwlW5Hx6jcnnIYr
         vKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K6vWhNkXYIMcCDi2L3E2bfLP3W7gblcGN9nVooZSDqI=;
        b=Oc+QGqbwrQJm+rVAiHh6xbVdgdbagVi9xb/jUuh+truU2HI69YQm+IX85nTvwszl9i
         +dlgL1/Zat2t3fjWqsJx8cV9FSZ3FrfCmYKLEwTaqGVCHcxTXEemUyvBn1c5rcnDN+nX
         gxkY+Q00ljpDqZ5Tr3V4QqB2WfmK+AggYWj08K4qN7yMrrmVb/5Juc7pFFnOY5suQR8G
         Cx2LUyP3wQbA78ElqbSVONjGUnCosWU248m1MWu/Udzty7+7EsE6J/9MMApZVEV+vBJV
         Nl8S013fikaXAZtL0apmt9S6aJA32PCpOpcCBhOApYULicNEfN/MtmA/wXkjvzE3tUAv
         A+ng==
X-Gm-Message-State: ACrzQf0qDiZ8XiWfZ2SFdXVaBdBPiOUuWc8t76pnbpcYXQnrUAPSToN8
        J/Q+ca/lPbhuz6Rs8HnHLSU=
X-Google-Smtp-Source: AMsMyM5J0Ppa2C71JmfxiUOyjXtemeQogMkvzi8wJvUIwaI/kdIg0ttKPBT22X99Y/+6U2M8nIW4oQ==
X-Received: by 2002:a17:90b:4c46:b0:203:7c2a:defe with SMTP id np6-20020a17090b4c4600b002037c2adefemr33752109pjb.40.1665434814748;
        Mon, 10 Oct 2022 13:46:54 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:f802:67c2:7f9a:bf3c])
        by smtp.gmail.com with ESMTPSA id w21-20020a634755000000b0045751ef6423sm6578085pgk.87.2022.10.10.13.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 13:46:54 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 0/2] xtensa updates for v6.1
Date:   Mon, 10 Oct 2022 13:46:30 -0700
Message-Id: <20221010204630.2383703-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following updates for the xtensa architecture.

The following changes since commit 80e78fcce86de0288793a0ef0f6acf37656ee4cf:

  Linux 6.0-rc5 (2022-09-11 16:22:01 -0400)

are available in the Git repository at:

  https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20221010

for you to fetch changes up to e3ddb8bbe0f8cc994748c81e17acc58fda6f8abe:

  xtensa: add FDPIC and static PIE support for noMMU (2022-09-13 18:28:00 -0700)

----------------------------------------------------------------
Xtensa updates for v6.1

- add support for FDPIC and static PIE executable formats for noMMU

----------------------------------------------------------------
Max Filippov (2):
      xtensa: clean up ELF_PLAT_INIT macro
      xtensa: add FDPIC and static PIE support for noMMU

 arch/xtensa/include/asm/elf.h         | 24 ++++++++++++++++++++----
 arch/xtensa/include/asm/processor.h   |  3 +++
 arch/xtensa/include/uapi/asm/ptrace.h |  4 ++++
 fs/Kconfig.binfmt                     |  2 +-
 4 files changed, 28 insertions(+), 5 deletions(-)

-- 
Thanks.
-- Max
