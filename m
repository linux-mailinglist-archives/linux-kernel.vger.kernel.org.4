Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552FB5B3B96
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbiIIPNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbiIIPNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:13:25 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63652144837;
        Fri,  9 Sep 2022 08:13:25 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id s14so2094628plr.4;
        Fri, 09 Sep 2022 08:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=/TVYg9gxnjxr72JuEtFu8ksh5BgzWE/f1gnQNq1u/+E=;
        b=othTGm4HyUSHazW+HD6FreCrKssyRVEa43unzkkehwPwhgnPeU8liZMNez/GrF7Zq5
         RrOSihwILv36NrNa+9yuY0EYhiJKT/KB9lCo5iAp9EI7K2baAzcrkgBz0JGOCHXdyCB9
         VenvkQ2aDH1/A8TXy3kzOQkayOExE+wMUMScMp9xjdojEqTDGtfVDoesmXCiU6ZSQ5pp
         wxoDiGkKwsV/vZIPE9FrZWhB1jbAaNLk2JuVbzahmNY8TpelbO6nySqxpdxAc1OMAl7A
         mxbr5wNDU6208OZNGDATArh5JTAo94L6e6g+t8qFy1n0KjKozSkdllUv7eFWCEEcvtTH
         W+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=/TVYg9gxnjxr72JuEtFu8ksh5BgzWE/f1gnQNq1u/+E=;
        b=ZYTFX6LA6ApazOAYxzrxVdfjVocLk4bh7Kig9/gpkFpRTyqN9O1o45zSMVpc/r3azj
         bdyP6w1QKFrMOc4YKb7AlbufBqFJb5Ch0KB3CxvOpPiUa/plG2UqXD5zT9hmyVNpPQBY
         eT1YDYoxPfCzOlPx567o3aiKHD1MACBw38V0+24/KjzibzgLXdZNuJMt3x8v8vGcBZYs
         uyBKeh70FEdESYw7TmkIxOqC9vJwPim5OEwhOqNMGMd2RXt+VsPvoZEjasxNEsR9kQfj
         S5yKTLm0etV6zMMSq2r7bMzpr4JdXKP84wSwfJJlVMiJd6METaIZMn9/oGGQvDh2qJOA
         wxSQ==
X-Gm-Message-State: ACgBeo03if/qiZuaKVxOL4l1qejPt0cCeDGsvAWdbJfkVN6VbTroZHe6
        +chXzG1UyDEcC8+gs6m8T6c=
X-Google-Smtp-Source: AA6agR504Khw69SnNgE4czqNaX/9Af7UvwnuEd8fuGMxBOCyNKhY6liUlwVW2AsuZ0PJPhHylLQ1Pg==
X-Received: by 2002:a17:902:f606:b0:172:6522:4bfc with SMTP id n6-20020a170902f60600b0017265224bfcmr14084911plg.133.1662736404835;
        Fri, 09 Sep 2022 08:13:24 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e7-20020a056a0000c700b0052e6d5ee183sm651962pfj.129.2022.09.09.08.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 08:13:24 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH V8 0/2] Add ums512 clocks and relative bindings file
Date:   Fri,  9 Sep 2022 23:12:34 +0800
Message-Id: <20220909151236.277671-1-gengcixi@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cixi Geng <cixi.geng1@unisoc.com>

This patchset is add the UMS512 clocks support

v2 changes:
  adjust description and add the "sprd,ums512-glbregs,syscon,simple-mfd"
  compatibles to fix match failed logs in the dt_binding_check.
  add the property license and copyright notice.

v3 changes:
  fix wrong indentation and hint: "maxItems" is not needed with an "items"
  list when use the latest dtschema.

v4 changes:
  move the syscon bindins from clk to glbreg yaml file by pickup 
  chunyan's patch for global registers bindings
  fix the comments from Krzysztof in v3 patchset
  add the Acked-by: Krzysztof in patch v4 3/4
  fix the  warning Prefer "GPL" over "GPL v2"

v5 changes:
  Add review tags.
  fix the comments in ums512-glbreg.yaml.

v6 changes:
  No more send the patch 1/4 and 3/4 in V5 for applied by Stephen
  change GPL to GPL v2 license
  fix the lack of space in some "{" and "}"
  add check error for sprd_clk_regmap_init.

v7 changes:
  Resend the patchset after the cross-tree patch merged
  use the absolute path for the mfd refs of patternProperties

v8 changes:
  add the const property for address-cells and size-cells.

Chunyan Zhang (1):
  dt-bindings: mfd: sprd: Add bindings for ums512 global registers

Cixi Geng (1):
  clk: sprd: Add clocks support for UMS512

 .../bindings/mfd/sprd,ums512-glbreg.yaml      |   71 +
 drivers/clk/sprd/Kconfig                      |    6 +
 drivers/clk/sprd/Makefile                     |    1 +
 drivers/clk/sprd/ums512-clk.c                 | 2202 +++++++++++++++++
 4 files changed, 2280 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
 create mode 100644 drivers/clk/sprd/ums512-clk.c

-- 
2.34.1

