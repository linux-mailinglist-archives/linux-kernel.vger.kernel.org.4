Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D236D803F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238410AbjDEPBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjDEPBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:01:46 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3B04C31
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 08:01:42 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id j11so46989956lfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 08:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680706900;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=InCAPoKb7nXqVzt45DrhtDsezJaeGfAT3p2E+j2WBiQ=;
        b=a04wPNLyVNBH0DDZmfY14/ypEXwgCxdYLy6h73WscSpl9iN1YZ7Pnoh7dT97r9tj8B
         HzxuhESN6U8bwe6UqFdOCF9ty8NNRyJ0ddhl6VllJTxq7Sf/BKKC2VztWlgPgFuCsQQA
         toY9fSHT9fiFTQwLekA7QcWk4WIbVKUZih8Qm2LRWopmXWdNFPqwhGjDcRPgIzXQ1Lzl
         IoTsRk5mP9p9AETRHWyre1FD1PAWy352wed15V+STbcsQJK0Qgs4/2RguwitzRX/B1Kc
         GKgKaZt8tklpRIhCoDX4X8VaeaE1Hl5jE7GVwQxzyngRSZQMRpMPGMDfYolx4RXkLgac
         LQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680706900;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=InCAPoKb7nXqVzt45DrhtDsezJaeGfAT3p2E+j2WBiQ=;
        b=GgLpMU64Bsl0bXvLxhUnG4k6RXbObfgchTZNFp6R3XuN/ntqqgM5r9nB0E4nIzL8vj
         gxKBocVg/GjB14Hb1UPBv7RyHn83kPsss6A4Xrm+2MdL541cbwac4cm/QSmB4hPsVF1s
         5o/vvKwsv4YTmUrJASXRI/sTiD9adTWy9nrK6lOb6lMS7U6bEDoZVsrwCDdp59TrrssM
         HmYtEZiQfHsBqNDfIWx/gPLkLxYsesxHpru9PWLTnNrtjO+odL4AjTBdhIqQxu8Q2Ok7
         QwC0EPEfdCrEDIa9nFk7aeQgMKJ4rRW+o+QisK3aE8mXRDAS/BM3OiN3aBG8/cfgG2IP
         B8Zw==
X-Gm-Message-State: AAQBX9c7b2dftwIaH2rWT7S43ph+7eC19sFzaCWdjYQOuvCxWA4/IdES
        Mj6zoCAdhULTTFqLo9k1vxNOnQ==
X-Google-Smtp-Source: AKy350ZnUnp+ndTfSd3cBb7U2tFRydWFJHUuvzlhA0x8eAdms8NerYv4BtqzyEp7Fbln7MKkIhEzFA==
X-Received: by 2002:ac2:596b:0:b0:4e9:609c:e901 with SMTP id h11-20020ac2596b000000b004e9609ce901mr1629436lfp.21.1680706900447;
        Wed, 05 Apr 2023 08:01:40 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id 16-20020ac25690000000b004e84896253asm2833994lfr.251.2023.04.05.08.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 08:01:39 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/2] Introduce RPM Master stats
Date:   Wed, 05 Apr 2023 17:01:34 +0200
Message-Id: <20230405-topic-master_stats-v1-0-1b1fa2739953@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE6NLWQC/x2NQQqDQAwAvyI5N7Cu9mC/UkrJrrEG7CrJthTEv
 zd4nIFhdjBWYYNbs4PyV0zW4tBeGsgzlRejjM4QQ+xCH65Y100yvskq69MqVcNEMbQ00DR0I3i
 YyBiTUsmzp+WzLC435Ul+5+n+OI4/aRZrdXkAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680706899; l=1192;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=14q4AT8u/IwWpTVamu6McL0Que9EQK9+tnHVqVGCza4=;
 b=V9FO4W9wrnVv7FQTMDwPWeUJn+ZMGby6qW6rhJdnqp9sVBnwJwJ8yMERt2zOd3n04sT5txwnQoMc
 DnMorEupDnl3teN0hfy+QII6hDx0rfQAAk4Xg5/V21YqLb03mmss
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RPM MSG ram includes per-subsystem low-power mode entry/exit/
residence/etc. statistics which are very useful for trying to debug
what I'd call "SoC insomnia", or IOW the plaftorm refusing to drop
the voltage rails to a minimum and gate the non-critical clocks.

This series adds a very short and simple driver to query that data
and expose it through debugfs.

The base used for writing this driver is:
https://github.com/sonyxperiadev/kernel/blob/aosp/LA.UM.9.14.r1/drivers/soc/qcom/rpm_master_stat.c

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      dt-bindings: soc: qcom: Add RPM Master stats
      soc: qcom: Introduce RPM master stats driver

 .../bindings/soc/qcom/rpm-master-stats.yaml        |  53 +++++++
 drivers/soc/qcom/Kconfig                           |  11 ++
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/rpm_master_stats.c                | 160 +++++++++++++++++++++
 4 files changed, 225 insertions(+)
---
base-commit: 8417c8f5007bf4567ccffda850a3157c7d905f67
change-id: 20230405-topic-master_stats-ba201a9af93d

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

