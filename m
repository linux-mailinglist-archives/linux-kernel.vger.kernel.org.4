Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B8E6C8A4A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 03:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbjCYCqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 22:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjCYCqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 22:46:40 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD7F1514A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 19:46:39 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso3348881pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 19:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679712399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FsdVQp4WpBtkmg9p3gV+BN8yPUL2KVe2K+u+tVikQvc=;
        b=UX1rxJ0PXz3zf2c58svwhK5paSZbNoObBWd4JF/GmxH7t7xn/NSCmn+okhYpt2gNRE
         IE+VWUEePZJ/d4Letz7sVIBoancul2YBPJ2ypW4UhZ3qoM3WbejJRg39HickhPpGOPMB
         SdI3BeEjH1q79QCS8rW6ZfIrwULCf0QlF/a4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679712399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FsdVQp4WpBtkmg9p3gV+BN8yPUL2KVe2K+u+tVikQvc=;
        b=7kiRyVbAlEEHLdPr8VZCEDLb5jOAae+fn7JjBATN37AAVpNEa/7FrxPVwsjwd8ghQp
         eTX4jpOfSBqs5HzxZklHzKqDVP4zGac1ZxaltOw7o6q8K2TEsMb4XQQ9l+I3ikHuWT/M
         MRklpMXO0xHs0Sut95Xw0xykA3bTEm+71zpSWUf/ib6CPtGbB2WEJJvmq+FgQD9Mczzf
         rgxshpv7664FsQHl7GO+WGubXpN2hC3Vhu0PA2YK/8dYDT8w+MpVNZB0UxwTzCTZmQfP
         KkidyRaBJmKSRCuGq6o01QHlT9PzraZN/F611hHEPUvZz7RlP5di6PBn8DpGqM557gKw
         cG2Q==
X-Gm-Message-State: AAQBX9dIcafaJAJ44pNeRIc8iTaqFGHE/8CMqYgZV+wScI1wfISNeKfr
        yW9lTfitRtokMCAvxCScW+MsKKFKjVqt0223eyHqzg==
X-Google-Smtp-Source: AKy350YOeYqK21CIdUsyUTx827J7MaCXU3vKIUsL4kiQmKkjsp+rzw64Zlpya6PE/5YmaolNEGV//w==
X-Received: by 2002:a17:90a:18e:b0:237:24eb:99d8 with SMTP id 14-20020a17090a018e00b0023724eb99d8mr5228100pjc.19.1679712399130;
        Fri, 24 Mar 2023 19:46:39 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:6179:9cb5:be4d:f76b])
        by smtp.gmail.com with ESMTPSA id hv19-20020a17090ae41300b0023b4d33bedbsm3675840pjb.21.2023.03.24.19.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:46:38 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 0/2] zsmalloc: minor documentation updates
Date:   Sat, 25 Mar 2023 11:46:29 +0900
Message-Id: <20230325024631.2817153-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	Two minor patches that bring zsmalloc documentation up to date.

Sergey Senozhatsky (2):
  zsmalloc: document new fullness grouping
  zsmalloc: document freeable stats

 Documentation/mm/zsmalloc.rst | 135 +++++++++++++++++++---------------
 1 file changed, 76 insertions(+), 59 deletions(-)

-- 
2.40.0.348.gf938b09366-goog

