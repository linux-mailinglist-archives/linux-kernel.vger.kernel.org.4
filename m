Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDEA6E29DD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 20:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjDNSNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 14:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDNSNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 14:13:15 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0589005;
        Fri, 14 Apr 2023 11:13:14 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id hg12so4632703pjb.2;
        Fri, 14 Apr 2023 11:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681495993; x=1684087993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i64S1Gb6i6BXvs6qSii52zJ3ScYuWSR5RAeuO5Zmt1E=;
        b=svfYttqfWSSUok6CpHujVXjjJvDgSsKJQ3NOi5dXibBi3pfs8SRbGvDnQwdLRSuGSw
         Z3uG2oGsPlA6qQH+j+vfsQm+ggEK/rfgGByiDyqMKhspdtsPls2XqkM8//O4CrryA4cS
         tMn+wVf/tF8+hii0o/qvUgNb3Gotp7vJx3T6JtWABlS98Zt8KLfQiI7J032xpCoXe9rv
         KOyoJ7cG7T6FivwbX12+UAMuq/GcaFEI4u47QyE+MY7wP3moelorBBempP2iCw3Dx+/e
         jd9Dl2r0vDJTdwo0fWhdXBjCVp/mbAUO7su8CscejVqfm776z8aF4BqkaciuaYLTdDtB
         gl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681495993; x=1684087993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i64S1Gb6i6BXvs6qSii52zJ3ScYuWSR5RAeuO5Zmt1E=;
        b=hMDwOg8FoYCNnBQfYZ2I7xGAFpmsoZ6ZLFB8+s71c2uanj6VAedXc8D++DGOIx9f0n
         c1YktRouJ0v4JWwocsCOzkH1VBevREmldrKBvSDmowJH+dm/Kbyq37xNMsuy/W0ALtmO
         RT/piYqa9VlUI4I13TWg79zMM0K9+oHRFDPGo9XiNH8woiqYziJ1Re8P/5JygYQiU/pv
         Zp7+5fMjYlGdJCcjKGRLaoW+31xPdw5jKQ9BbHE79RpR4+P1zc8daWfGIuB5gNCXnQnO
         /DPAQYMWw0CFJg+p9KCECthqNpfN/DiQ63ZT7yrgMq8dHqznvxEfrTPCY+dJap/lzGDK
         XDXg==
X-Gm-Message-State: AAQBX9csje5WUeJcYVBJWeZZ4cgCKPJ2JV/7LvNaF8Y73tg7nKLCX358
        t0ksopDODUp0gdDxWPKTveP5PlTbv9jeX/VpXZ0=
X-Google-Smtp-Source: AKy350YU1CIR3iw6zpttN9gepz/ix/4ajKULqxnkjM9T/mEG6FVjNP/Uq5emblEduY1pRimowtbF3A==
X-Received: by 2002:a17:903:2290:b0:1a2:afdd:8476 with SMTP id b16-20020a170903229000b001a2afdd8476mr4116249plh.2.1681495993419;
        Fri, 14 Apr 2023 11:13:13 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.200])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902820b00b0019a593e45f1sm3309371pln.261.2023.04.14.11.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 11:13:13 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] clk: Add basic register clock controller
Date:   Sat, 15 Apr 2023 02:12:58 +0800
Message-Id: <20230414181302.986271-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
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

These clocks were provided in `include/linux/clk-provider.h`, but lacks DT
bindings. Add a clock controller to avoid operation conflict on same
register.

*** BLURB HERE ***

David Yang (2):
  dt-bindings: clock: Add reg-clock-controller
  clk: Add basic register clock controller

 .../bindings/clock/reg-clock-controller.yaml  | 245 +++++++
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-reg.c                         | 638 ++++++++++++++++++
 3 files changed, 884 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/reg-clock-controller.yaml
 create mode 100644 drivers/clk/clk-reg.c


base-commit: 7a934f4bd7d6f9da84c8812da3ba42ee10f5778e
-- 
2.39.2

