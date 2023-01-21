Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37DD676393
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 05:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjAUEAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 23:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjAUEAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 23:00:25 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BFD73AF8;
        Fri, 20 Jan 2023 20:00:22 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id w2so5339976pfc.11;
        Fri, 20 Jan 2023 20:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11t9EWaoqoQjTzDSvKL7UQHCZsmzTEaq6eWvpzd3nXM=;
        b=oaiEPlxE7lBOS/lG2Z/v4sQg8axJqu6h6IJcgj0PSBCJWxCsXy8qwZg8X8NF//SFhB
         PHo9Xg2YnEviUei9c9FMs0XzUx0Sw2sSjAxxoeJL4huxhlbS8JTkvFHVIkGiPZKNpQvC
         XJCBJYsUMJ9oCAxzl0djX6pJeyZW+doG93hWZqyCK/XxPUzufBYNNon/bhZgMPVhcQuX
         0dZlbpQJJ23jchVqspTCk2W/m8moFPY/47LDgdio2aBygRVNbQwkko+dXyBAm2RHhDQg
         rsjKoorGICxh/euASSFAfFv9qSpp6mo/AExw8I/3ieMcOArXxN1D9yBXn2QRt4w4yRJg
         0vZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11t9EWaoqoQjTzDSvKL7UQHCZsmzTEaq6eWvpzd3nXM=;
        b=A71hUcCMtq1JZ/an5u4pluitg2VLri3jCE3gRkaxU9AQmKru8ZnHu5mZsEnooX0TG8
         HB/ixU6Z21DN814GslVca36RPFdiasxBkfX6DHjDUcJ60wSFWQqVpHCs2GpuPD0W6n8v
         3m1tv7ngTi1TloYIKFAL3eRhWTGUQRl2Guc3t0MHvqxjwaqy64XHAUVAPelxrnKiBMrC
         a1Ub0Qa1wKr/fwKOvRSj6kk8OnaSKCXJHete0IC3I5WlysVqRS69Y9/vi+lkAkh4UUft
         OSDEy7evxks/3LJXSF/21Lok00qdKJzdXGfB6UTEanAn4MZwHdQW7lE6zze9R7DXzKhC
         H3eA==
X-Gm-Message-State: AFqh2kquBKjV0zVs31iyU33AW1Y8iFH6JdmjDV11lir1Vo2uXkew9Whq
        3WI8/sR8+awluqhin76+0gk=
X-Google-Smtp-Source: AMrXdXsrqkAmLEGzR6E2szkgTf1lBPhFfkrlcBMDWPaiyOGt/tCPGcILHZAYRtzUVBJ5oy5li4rf6A==
X-Received: by 2002:a05:6a00:3020:b0:58d:92ff:8a2a with SMTP id ay32-20020a056a00302000b0058d92ff8a2amr16723145pfb.23.1674273622126;
        Fri, 20 Jan 2023 20:00:22 -0800 (PST)
Received: from debian.me (subs02-180-214-232-22.three.co.id. [180.214.232.22])
        by smtp.gmail.com with ESMTPSA id 4-20020a620404000000b00576ee69c130sm26638286pfe.4.2023.01.20.20.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 20:00:21 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id CE42B104FAD; Sat, 21 Jan 2023 11:00:17 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     CoreSight List <coresight@lists.linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        oe-kbuild-all@lists.linux.dev
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] Documentation: coresight: Extend title heading syntax in TPDM and TPDA documentation
Date:   Sat, 21 Jan 2023 11:00:13 +0700
Message-Id: <20230121040015.28139-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230121040015.28139-1-bagasdotme@gmail.com>
References: <202301210955.zYxDrLgv-lkp@intel.com>
 <20230121040015.28139-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2375; i=bagasdotme@gmail.com; h=from:subject; bh=/0rWs1kJBxyoM7wT0wIZqmdShtZzaJbSYX/tpNjmrlM=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMmnk/2enHu601lJzahB47pzerJmjP/0Z+tStk8wL5fwiauN 9JzfUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgImsd2RkWM99pydo9nap8nvKkzmNly kd/MSQt7aUu2rVk1NXvhex7WL4n1gQIWrQ8Es1eGa4S37mJrMjhxP/Hj/fL1xwws6l4up2ZgA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot reported htmldocs warnings:

Documentation/trace/coresight/coresight-tpda.rst:3: WARNING: Title overline too short.
Documentation/trace/coresight/coresight-tpdm.rst:3: WARNING: Title overline too short.

Extend title heading syntax (overline and underline) to match title text to
fix these warnings.

While at it, trim unneeded period in the title text.

Link: https://lore.kernel.org/linux-doc/202301210955.zYxDrLgv-lkp@intel.com/
Fixes: 758d638667d474 ("Documentation: trace: Add documentation for TPDM and TPDA")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/trace/coresight/coresight-tpda.rst | 6 +++---
 Documentation/trace/coresight/coresight-tpdm.rst | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/trace/coresight/coresight-tpda.rst b/Documentation/trace/coresight/coresight-tpda.rst
index 350dad4eda4721..a37f387ceaea13 100644
--- a/Documentation/trace/coresight/coresight-tpda.rst
+++ b/Documentation/trace/coresight/coresight-tpda.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-==============================
-The trace performance monitoring and diagnostics aggregator(TPDA).
-==============================
+=================================================================
+The trace performance monitoring and diagnostics aggregator(TPDA)
+=================================================================
 
     :Author:   Jinlong Mao <quic_jinlmao@quicinc.com>
     :Date:     January 2023
diff --git a/Documentation/trace/coresight/coresight-tpdm.rst b/Documentation/trace/coresight/coresight-tpdm.rst
index 4ba40b0db550da..6c6e95109072fa 100644
--- a/Documentation/trace/coresight/coresight-tpdm.rst
+++ b/Documentation/trace/coresight/coresight-tpdm.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-==============================
-Trace performance monitoring and diagnostics monitor(TPDM).
-==============================
+==========================================================
+Trace performance monitoring and diagnostics monitor(TPDM)
+==========================================================
 
     :Author:   Jinlong Mao <quic_jinlmao@quicinc.com>
     :Date:     January 2023
-- 
An old man doll... just what I always wanted! - Clara

