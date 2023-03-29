Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477896CEFB1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjC2Qp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjC2Qpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:45:54 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A1661A7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:45:39 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so16741958pjl.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680108339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NSTv8w+x28I1WDmCVWEDRLYoLR2cDzb0186a8FLurx4=;
        b=dSYxlNDK1NqRNMYGUGkpA95ddaseQfjn/gnK7uqCGJhIU6mlUVPbLmBJtS/qMTaVXu
         A6/7VWPhL289CK6nQarYHj4OQRtxFxDP3vYDNY4c4hDT19XuIssgi6QXs96N8ttqGH3E
         RH/XGVNcdQI/i1Y3o0kvVoZg+5A3tkZB+Ip9b9whNxbe2IH5AqMlffY6XpT4pDiSBI8k
         sWEvMLEC/by4qdkqJngWQOJrNENWHP1q5GQkKko6H3cYlvAqYfcXeSZk92N8yiPFMCbr
         9ZuXvDGHEaZD7THihNYeWS0UT3LTg5KiyoBP05pXKKl4L8GIMFKKaotylq/NvWJU0ukD
         +bCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680108339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NSTv8w+x28I1WDmCVWEDRLYoLR2cDzb0186a8FLurx4=;
        b=yKFDyt9qu78zB7IV92vfwTL45mmLWC1jMMMJxDolIS4s5iAPzb2LJ4YMbvAjQc52i6
         fhzVR+rPyQlFPUddELoIxqgOYQIUlpXS9hhbN2L6VFylW6qmBxEq0ig9Xrg640YCArKU
         hV9GYXVrGGE7EMVzUO9tf3S/Ay1SmScnHNPfBYQMF321lQl+wEQZqrwRLBdLDuHF45z7
         /YgHVrGr8fZhJ2y897huqsKs4yksgy1fD0s3/pW3bjp1hCfnPuTxADupyCFCsNWsdpnK
         hN+k3ezZ/FyTihvWyvc5E59TrDlIn6lTflnX21/GAfXR6n1Oe/xQJBWO33GwXvo7ln4G
         30eA==
X-Gm-Message-State: AAQBX9f/QK3aC9nYbQUwnEjLTnouvhgxMcoOgGYXap3SvZuujhpQHQeV
        T6nGG3+yZz1aKDI9broR81RWRx6NndY=
X-Google-Smtp-Source: AKy350bJhWWQPp9q3ay511eks1a81Ls879IR4XBP/I2D54VE1a+dEj/euERRcS0YD+Jq6QOSmJ7cNw==
X-Received: by 2002:a17:90b:4a50:b0:240:59e8:6dad with SMTP id lb16-20020a17090b4a5000b0024059e86dadmr17592292pjb.25.1680108339132;
        Wed, 29 Mar 2023 09:45:39 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:c3f5:d0ba:53b0:fcda])
        by smtp.gmail.com with ESMTPSA id ca14-20020a17090af30e00b002353082958csm1647395pjb.10.2023.03.29.09.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 09:45:38 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 0/2] Xtensa fixes for v6.3
Date:   Wed, 29 Mar 2023 09:45:27 -0700
Message-Id: <20230329164527.2996022-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following fixes for the Xtensa architecture.

The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20230327

for you to fetch changes up to e313de5b5b04176f28384b45ebebd552c0c7dae3:

  MAINTAINERS: xtensa: drop linux-xtensa@linux-xtensa.org mailing list (2023-03-24 05:30:56 -0700)

----------------------------------------------------------------
Xtensa fixes for v6.3:

- fix KASAN report in show_stack
- drop linux-xtensa mailing list from the MAINTAINERS file

----------------------------------------------------------------
Max Filippov (2):
      xtensa: fix KASAN report for show_stack
      MAINTAINERS: xtensa: drop linux-xtensa@linux-xtensa.org mailing list

 MAINTAINERS                |  2 --
 arch/xtensa/kernel/traps.c | 16 ++++++++++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

-- 
Thanks.
-- Max
