Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1B373324F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjFPNhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjFPNhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:37:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A232330C1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 06:37:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bc505a8dd60so658015276.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 06:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686922665; x=1689514665;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ph3G9nr5fRPxWStwGOYNsQfSUF/EQcmUq1B+Gjqo/J4=;
        b=dvNong4qKBffFX3umW/2OU9ULUPomFHHUVMjOEHWASQkhl+S76KN4mhSzoCjStc6RP
         3oh4x3RaDcyhdQhWv5wWTh+XvHy6BpWg2SpdZDS/g14cVjpJ9NE/vNeojgkuBMRFIXB5
         N5uSgX1iVxTnqKFzy/EFOucJKwsaxSznyu6IC04Qu/SwdQj8G+phNyK3yvJ3b4pFraGZ
         D6VA2/KNQCFG2YJTQ6dhfMvH8kxkQd5V0Q7qBvHkle9kDru/RgccknPIRRuZEoXb7dMq
         +dd9okZYE6hMqDh2dz6SvAR5cLDchngZauyZhxO5m9knd18RfP8vfQ5am0aHQgmeY9oV
         7CKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686922665; x=1689514665;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ph3G9nr5fRPxWStwGOYNsQfSUF/EQcmUq1B+Gjqo/J4=;
        b=d3W3KrrfYeymhzYCaKJswnO+WG0iTD6gDr4k/YlaE4go0u0njJJ2EvskeGdAmm+3oW
         PZ+3X8FKYf99AgffUFCECaaOgckKkKJ5KyKK//QGNXBJqnC/xyi5q4w3yzN31vE7ukG0
         LUWjLaB1Y/FgZiNz2yIyMIEDXtZs1Waq8reZHKZT50ENPPQePvpdxeE5HReGnuVfDacC
         6K2eREYPCVRoHl32XyuS5bDnJKU624cIS/rF4PNnfti+PgUQ8EBuycRwEaHQQJ5YHP3/
         OvNxEUngW+4+LGlEm4E5rftsq0zETa7eDWJ349/5SR7C1I+LUgmhrJ/riuMelmaSNB71
         SmZA==
X-Gm-Message-State: AC+VfDzIUBFYFOoc9q9+XV3BGyyP/iZMvUBXTMY2b8sV7B6W0z5lJ2qy
        0I2YJcs+sWCQK135nbImP+Tb2FtC4MlAEFfieQ6qkuVTPvoo02lnZlvBKgtoMTEYyCdP7xk7Cm6
        70qT28LC7T2q+3J/ANAta953J4FMCYkXAopzRFL5BahMkqXSY2U+2yRsyk0uZri2SzdFHU2UwaJ
        6qhVWM
X-Google-Smtp-Source: ACHHUZ5o8FfhMm0+FPcd9HHSnOfQP5UxFp92HFFP/hCG366Fdh5kXLnQgxoGpDrC6pC7hqL77yG2Qa2SmcFga7Q6
X-Received: from jordy-spec.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:f2f])
 (user=jordyzomer job=sendgmr) by 2002:a25:516:0:b0:bcf:7f0b:e1d0 with SMTP id
 22-20020a250516000000b00bcf7f0be1d0mr232476ybf.0.1686922664785; Fri, 16 Jun
 2023 06:37:44 -0700 (PDT)
Date:   Fri, 16 Jun 2023 13:37:34 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230616133735.351479-1-jordyzomer@google.com>
Subject: [PATCH 0/1] nospec: Add documentation for array_index_nospec
From:   Jordy Zomer <jordyzomer@google.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, jordyzomer@google.com, dave.hansen@linux.intel.com,
        daniel@iogearbox.net, tglx@linutronix.de, rdunlap@infradead.org,
        pawan.kumar.gupta@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

array_index_nospec() should only be used if the upper boundary is a built
time constant. Otherwise the boundary could be speculated on as well.
While it might be more difficult to control two loads, it doesn't rule
out the problem. Adding this to the documentation so people won't mis-use
it instead of barrier_nospec().

Jordy Zomer (1):
  nospec: Add documentation for array_index_nospec

 Documentation/staging/speculation.rst | 5 +++++
 include/linux/nospec.h                | 5 +++++
 2 files changed, 10 insertions(+)

-- 
2.41.0.162.gfafddb0af9-goog

