Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B28623FF4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiKJKfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiKJKfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:35:16 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AFA663E8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 02:35:16 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id o13so1398749pgu.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 02:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=w3Q7nb8mm+ugLVzloAAiV50ng5cZIeUMUq76G09WJLk=;
        b=q5m/uzQtlXopPz22JGqRLCwTsoFo8Onjnu3D8x85brI1dVXfJsXtDYK8FnBr75mQc3
         tq0msAAXAMtBqzgy33CAnpGWi1dO//tm54+YrpebUcBmrze2hM0T3DGUVJbdE2LtGkQ9
         01JszW80SllVVTycHMhWUmCa3aDpJZ2ol22jDNm2j5M1BNYlvb6Kd4LC9mrH8bm1OG6d
         rkgSgjB4W7ec7aVd3KbV5BO8FtBfIcnjbO3XEHEYbXnfVRFUMHHTqRohXMxs84r87a9d
         FTTGBKheccvC4LZ5We+cmxAUB8pXN5aq6yLy2ZLfeAQw+IqhUD9khzxI+EoMuyBkE/l9
         Lpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w3Q7nb8mm+ugLVzloAAiV50ng5cZIeUMUq76G09WJLk=;
        b=EdNx60uqnDY9Y7xEJov8UPsp0b+CWtWMf7B5tajZKhlA3eKuLW5MItQT9/djovJ/Ja
         sIfFCo4Xw++sP1PxpS3ePHTvx5pgL2q1s0SdE62qX2gkbgLOtOj5zTUPA2Jo6/cqIKsC
         dEb3sPS2hgv0/76i+SLcan6RbrFV1Z6E3Gj5TQVTFV3BtsVBzv3RZcZY/xzwmuyql2/z
         AzJLEqcMU302BHpKwLeww8bDdVKj4I6sZIJ347ftRAASbV8ePY1PA54hvETO8ZmPqHd7
         9Ns1qY/abjOPEv3rAK19eXRpo/f5wFvueg0jemUmKdguwq/Y0nPhhnlI0g2r1aPacbiT
         p1yQ==
X-Gm-Message-State: ACrzQf1zqig+8G//r0BE9pTuK7dXUwmsdQwPhvGxL+lGQKHySLU2rN6w
        iz6DWPwBzOqdK8JRi6J0LBmIGsHVJFF7EQ==
X-Google-Smtp-Source: AMsMyM4YYNLLV7RC23uv9W6O2WIX45qsDfRsqeNXK/q1WMby+UvLYqkFLYzjPQJ39G8w3Amr42d+aA==
X-Received: by 2002:a05:6a00:4c0e:b0:56b:a80f:38d4 with SMTP id ea14-20020a056a004c0e00b0056ba80f38d4mr2344226pfb.12.1668076515331;
        Thu, 10 Nov 2022 02:35:15 -0800 (PST)
Received: from jacob-Ubuntu (126.224.215.218.sta.wbroadband.net.au. [218.215.224.126])
        by smtp.gmail.com with ESMTPSA id j16-20020a17090a589000b00210c84b8ae5sm2776227pji.35.2022.11.10.02.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 02:35:14 -0800 (PST)
From:   Jacob Bai <jacob.bai.au@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] staging: rtl8192e: trivial code cleanup patches
Date:   Thu, 10 Nov 2022 21:35:09 +1100
Message-Id: <cover.1668075486.git.jacob.bai.au@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove macro defines and rename few variables to make it align with other
rtlwifi drivers.
The patches are required to be applied in sequence.

Changes in v5:
	1. Removed original Patch 2, which is renaming file r8192E_firmware.c
to table.c, as it's not required at this stage. Feedback from
gregkh@linuxfoundation.org.
	2. Put more details on the description of Patches.
	3. Put more details on the changelogs.

Changes in v4:
	1. Missing patch set vision number in the v3

Changes in v3:
	1. Patch 3: use ARRAY_SIZE() to initialize variables to replace 
macro defines. Feedback from joe@perches.com

Changes in v2:
	1. Patch 2: modify r8192E_firmware.c to include table.h instead of
r8192E_hwimg.h.

Jacob Bai (2):
  staging: rtl8192e: rename tables in r8192e_hwimg.c
  staging: rtl8192e: replace macro defines with variables

 .../staging/rtl8192e/rtl8192e/r8192E_hwimg.c  | 31 ++++++++++------
 .../staging/rtl8192e/rtl8192e/r8192E_hwimg.h  | 36 +++++++++----------
 .../staging/rtl8192e/rtl8192e/r8192E_phy.h    | 20 -----------
 3 files changed, 38 insertions(+), 49 deletions(-)

-- 
2.34.1

