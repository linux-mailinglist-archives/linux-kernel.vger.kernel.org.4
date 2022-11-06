Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA4461DFDE
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 02:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiKFBLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 21:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiKFBLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 21:11:52 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE2FB7D0
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 18:11:50 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so11463156pjc.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 18:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r9sXGVgxlgucjcB491+VVt6fi0bJrGLCKS3sBo3gKhU=;
        b=JykyOAMSIMcEcsBRsaS37YRp6g+2b5Vc7stDMREvIjXCs6QeCyd/HYGL9OXf7/mNvX
         THJ+4uu1JemfnvOUgXNrRDuks/CIBPV3M/jxG+zZaMOL82W6P/TV8rA2nFb99QgVzAfL
         3FZQvHm6uVM7VOqWKqbURNLr8ZjkoxpMKnmyTaHcYmiPboPHdRtpB+gYo/CxSP97ufQW
         0+cooDENmqsENiVQiiRb7NCJkBvplfotc89Onc4sqzO3CMcH754enPNDvVmFGQWCHcJs
         j+AYIDSgbXCO2duhwKLGPDccLZpjPUl3+MI2GFels6rulyu5ybK9qsW2tjc46NzKQKPt
         gQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r9sXGVgxlgucjcB491+VVt6fi0bJrGLCKS3sBo3gKhU=;
        b=Uhp/01paSdU0I5U9YI9yMG7/JISq5PZ93JLAJvfITWQoKUpN1xYj8ZzEJQ3Veg214L
         Thy0TaHFpqN159+oKfu3RvUrN9q0TksQyHoNxSnerlOzt8MvXWATeX3nb8TbtETE7nj6
         34aO6J90SDjTmd4sm45Uumd98+mjzYxv+DUmFABMfBMp3DZbWFLdb3orJiiqDGZj6Hbj
         aniIKAxNWSQ+RRaHfVieV4haj72ATwtB/PJWyB/yElvNnu1a4/FJO5JOng43HsCvenGI
         AmFHhIK+9hOVLSQjF9sYQa0rFH9gVcBC498AFnWKGcmHsHn3rfnBrry9Cp+bQbWvQupn
         CYkA==
X-Gm-Message-State: ACrzQf23+WxiJGdx/ppAUvzJbIszSrer2g+XKgvVLX34zWX1lehEkuHI
        SWFNEkkQhgw3irNPfYOqTDUJgl9XAAFFjH6Q
X-Google-Smtp-Source: AMsMyM7B34fDzvbojkDxXNhYI3UCM8uvz5tOnH3xmqPyoBcsVOtRs4pNsoLF4eT+lS/QjYQFucEcrA==
X-Received: by 2002:a17:90b:3013:b0:213:ab5f:d388 with SMTP id hg19-20020a17090b301300b00213ab5fd388mr42359103pjb.66.1667697110084;
        Sat, 05 Nov 2022 18:11:50 -0700 (PDT)
Received: from jacob-Ubuntu (126.224.215.218.sta.wbroadband.net.au. [218.215.224.126])
        by smtp.gmail.com with ESMTPSA id c18-20020a63ea12000000b00462255f5aeasm1812343pgi.40.2022.11.05.18.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 18:11:49 -0700 (PDT)
From:   Jacob Bai <jacob.bai.au@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Jacob Bai <jacob.bai.au@gmail.com>
Subject: [PATCH v2 0/3] staging: rtl8192e: trivial code cleanup patches
Date:   Sun,  6 Nov 2022 12:11:42 +1100
Message-Id: <cover.1667694826.git.jacob.bai.au@gmail.com>
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

Rename few variables and source files to make it align with other
rtlwifi drivers.
The patches are required to be applied in sequence.

Changes in v2:
	1. Patch 2: modify r8192E_firmware.c to include table.h instead of
r8192E_hwimg.h.

Jacob Bai (3):
  staging: rtl8192e: rename tables in r8192e_hwimg.c
  staging: rtl8192e: rename r8192E_hwimg.c/h to table.c/h
  staging: rtl8192e: remove unnecesscary macro defines

 drivers/staging/rtl8192e/rtl8192e/Makefile    |  2 +-
 .../rtl8192e/rtl8192e/r8192E_firmware.c       |  2 +-
 .../staging/rtl8192e/rtl8192e/r8192E_hwimg.h  | 33 ------------
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 54 +++++++++----------
 .../staging/rtl8192e/rtl8192e/r8192E_phy.h    | 20 -------
 .../rtl8192e/{r8192E_hwimg.c => table.c}      | 20 +++----
 drivers/staging/rtl8192e/rtl8192e/table.h     | 33 ++++++++++++
 7 files changed, 72 insertions(+), 92 deletions(-)
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8192E_hwimg.h
 rename drivers/staging/rtl8192e/rtl8192e/{r8192E_hwimg.c => table.c} (95%)
 create mode 100644 drivers/staging/rtl8192e/rtl8192e/table.h

-- 
2.34.1

