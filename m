Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B626F3148
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 14:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbjEAM5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 08:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjEAM5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 08:57:20 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038C210D1
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 05:57:17 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2ab25e8a4a7so23512191fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 05:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682945835; x=1685537835;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5yj+EzAgsUG5Em1uJTZRhqMUdZlbskRY/arS004TCkM=;
        b=B9IWMG27JPGpZI8gUXQMEfsWPYFSYAm0fyRuGrnXSKLDFtKgBWLdfLp/lKvxPYpf0d
         N0LOgw9hLoceoy3ARo4dbCHy9OzED7sM31+UkHwZz2+g/YkX734roDvlz6YJuS/VQ0BE
         00/Mkq1loamZRWlhHOc73OPU6QsfcQ6oOJfNkJiGB28ijZxoZOZ5o6F2St3CzJjUJJxI
         P9W9+ZGBNvN0UPjI7dJuNJM8wwpDnrVrfpPpqL00v4hdnZIOzqYPlaNh/wIYYzJpZoYq
         6Al5LP0w9AzdlpDLD0/KbIzPyrQi3N9NAX3fEF9HgMUGmyBNiQ/orgbKcfSdzrIFizAx
         fKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682945835; x=1685537835;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5yj+EzAgsUG5Em1uJTZRhqMUdZlbskRY/arS004TCkM=;
        b=Fvnjxv93aXD8CuRS5KcMuXkRSLEYyeoc89lD/EMPsUSbi9YE6O1PLSdFUXthQQXPFL
         eqhSD4Sm/E4niG9azhygUHPvHsC1rWmlb8cWQZNxpGpRqQe/eBKr1va+6EaxOD8+OX2H
         n94wVHu1KZFGhVYNLd00rrpADa0ejb8EEdMeA+3/i1d/bHijnCbF0eu94qMIhzQob2SK
         Ts2gRvjtJP1FPiaBmr1zlbP/fYslv6UfKh6IZcV1rJQraOcKFF6ZxNTQDHIYkO/C5UYJ
         U/3zX0+lYMpd0i/aGF+4jgnQFjUmZWM8aoLMdilx2LZucbUqobgRBBJ84fmoieG8P0/6
         v9Ew==
X-Gm-Message-State: AC+VfDyjkau/tvTvhGT0N6FY2S6YHYoc76zkf4k0aUWEZg8NWaocuan7
        00rjCQnCxtzYzRpA9XPPUhAV5w==
X-Google-Smtp-Source: ACHHUZ7e+oXy+s9IC0V3lDiUd+O0BuhJQKzqPklAN2tzvGgzXmg8mGaSTJfk12/xokgMrQrsFOH0sQ==
X-Received: by 2002:a2e:7e0d:0:b0:2a7:f1e8:b08 with SMTP id z13-20020a2e7e0d000000b002a7f1e80b08mr3363092ljc.19.1682945835172;
        Mon, 01 May 2023 05:57:15 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id y6-20020a2e95c6000000b002a77ab1d73dsm58332ljh.96.2023.05.01.05.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 05:57:14 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/3] Mark RPMCC XO_A critical
Date:   Mon, 01 May 2023 14:57:10 +0200
Message-Id: <20230501-topic-rpmcc_xo_a-v1-0-93f18e47b607@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACa3T2QC/x2N0QqDMAwAf0XyvEDtEGS/MobENJsB15Z0DkH89
 4U93sFxBzQxlQa37gCTrzYt2aG/dMAL5ZegJmeIIV7DEHr8lKqMVt/M014mwsgkPPKYKA3g2Ux
 NcDbKvHiYt3V1WU2euv8/98d5/gCNeQIydwAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1682945834; l=959;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=lEfD0mmHrOC5fcfJkFA4Njozsjf+rOEhZPlsR22oTUc=;
 b=G2yoh6Mthv9u7eoX9sRud5gyKYDyxJhZOVaZnHOeWAecrdKPMJ5phO8OQM8Gf38dTdI9mKbGA+se
 yG5/KeSgBvBW5TFJ2RJ8C1iJrnm1FtF3ZQld6UZ/O2FOwIpGIWoC
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Arm part is supposed to hold an permanent, active-only vote on the XO
resource to prevent the RPM algorithms from deciding that its main clock
source should be cut off.

Guarantee this by marking XO_A critical.

These patches are extracted from a broader series at Stephen's request:

https://lore.kernel.org/linux-arm-msm/3040c836-4db8-7e7b-3ed4-6d71f0496cc5@linaro.org/

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (3):
      clk: qcom: smd-rpm_ Make __DEFINE_CLK_SMD_RPM_BRANCH_PREFIX accept flags
      clk: qcom: smd-rpm: Make DEFINE_CLK_SMD_RPM_BRANCH_A accept flags
      clk: qcom: smd-rpm: Make BI_TCXO_AO critical

 drivers/clk/qcom/clk-smd-rpm.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)
---
base-commit: 92e815cf07ed24ee1c51b122f24ffcf2964b4b13
change-id: 20230501-topic-rpmcc_xo_a-2caec8c8dad5

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

