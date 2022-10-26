Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6940560DF1F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 13:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbiJZLC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 07:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbiJZLCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 07:02:24 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2B6B56DB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:02:23 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so1185990wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b0Xtwax/hQw5d4kEBGpw81Qb64TNz4VlkoBE9EnSw6Q=;
        b=H1JTRzh/+cqFTGYsUz3J4xpK2fL5tdimFZxJxHzXZgBXDlv9mUjzoxacA2Mx8gzWx3
         AWieO3BfftliDuDOti4BQUrtVr2YKSYvSjf6+CKzsyHNvSOM2VBXqHetY4d497lHmnRk
         y/1p687MiGW2FvFZ/96hpR7MOB/PZQwYLJfG5WkCc7mclkv832tQBTWLqAaN0mi+3+Jl
         eDvw0YjefHRtN/8+MmPGeE5klnBcBfH7W8F0kPapxvWehbDm5KmwR/u0iLrw3sUCqy21
         yFGbcK/KwhGaWEau+vKjAhhFkvZIBWzHqy8z4xXmrL9+GQITsNaX2XJjh+0MheK4+yLb
         qRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b0Xtwax/hQw5d4kEBGpw81Qb64TNz4VlkoBE9EnSw6Q=;
        b=E947ToA0jYTBwf99WwKSrnw71ppKGgDBgmYebfTPFmxz9SRqPXA1uQituGOwE76TX8
         fkU0C7fmjg1St5WZHJyjDPUr+jwA66ZHr2+Tgs0fMHUOa+cuslbjvu97AF+92iDT0d+R
         3ja+LLp98RzSEsHe0nbgUKJ/KmVaJiXOw/xNdscAxhpHztkCiW2H32IoiFMr7oKb3LvM
         b6wJuA3xJSP2JtVy06u+kPpf0TjuEAICzr3jlcvuOc1P3o91ILFsxRzICY8HTl9NiEW/
         wnl/44/FznNXEOb0/srNQrWXSqVv7T4AAqGO+1Ju38N53Eh3KR+/U3ahZxFz/GmrTrDW
         Ux9g==
X-Gm-Message-State: ACrzQf1Cffm9PwRgNhzFdbZgI/oujiZ+pvTghnOiwxTnN4ZSlFNXC0Q4
        1+wDkRZ+42icUpYMcOOuP5dCxg==
X-Google-Smtp-Source: AMsMyM4XDDQL21MzqtmKiCE7tMg6rgbbNYjeN8Myv8+4yCqDeA5g3zB9saxlZn0oY2W2pdUfsFOPZg==
X-Received: by 2002:a05:600c:3384:b0:3c6:f25a:96e9 with SMTP id o4-20020a05600c338400b003c6f25a96e9mr2039053wmp.112.1666782141702;
        Wed, 26 Oct 2022 04:02:21 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id z7-20020a5d44c7000000b0023672104c24sm5237415wrr.74.2022.10.26.04.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 04:02:20 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: [PATCH 0/6] soundwire: qcom: fixes and support for v1.7
Date:   Wed, 26 Oct 2022 12:02:04 +0100
Message-Id: <20221026110210.6575-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset has 2 fixes around fifo handling adds support
for v1.7.0 controller found in SM8450 SoCs. Also a patch to
make reset optional for v1.6 as this is not required for sc8280xp.

Thanks,
Srini

Srinivas Kandagatla (6):
  soundwire: qcom: reinit broadcast completion
  soundwire: qcom: check for outanding writes before doing a read
  soundwire: qcom: remove unused SWRM_SPECIAL_CMD_ID
  soundwire: qcom: make reset optional for v1.6 controller
  dt-bindings: soundwire: qcom: add v1.7.0 support
  soundwire: qcom: add support for v1.7 Soundwire Controller

 .../bindings/soundwire/qcom,sdw.txt           |  1 +
 drivers/soundwire/qcom.c                      | 34 ++++++++++++++++---
 2 files changed, 30 insertions(+), 5 deletions(-)

-- 
2.21.0

