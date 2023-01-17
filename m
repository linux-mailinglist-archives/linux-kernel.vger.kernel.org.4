Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4928466DD1A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 13:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbjAQMCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 07:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236132AbjAQMCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 07:02:33 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC1636085;
        Tue, 17 Jan 2023 04:02:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 65629CE0E83;
        Tue, 17 Jan 2023 12:02:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CCDC433EF;
        Tue, 17 Jan 2023 12:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673956948;
        bh=CKlIXRz91IRPYHZiS5PjXrbKb/M2dV/YQZOMxzLWTGs=;
        h=From:To:Cc:Subject:Date:From;
        b=O0D55epM/2aYLDIbeYyeXzSyuGB7zbusuYm5LZ1xX7A5Thg98J7IsbaZdjI8RSNax
         0rya5Ir2VK9eVNDRkmdrCW6O71cyr4ILsr0+4kgp4N5WN1V8IAk1cusg8Ekg6gpx6s
         5CylZfuAk9Df0rmw0lHaAnlNzyutheB8th+TvMd5vWy7iYpq4kAVqSlEsvyyNv3+1P
         e+kO6WTm9fqSAbwvyod500zVRNHyrf5SgU/k1inE+PI9bgzIftFw/tRdkOfR6I+0++
         wl+ob1gafEl6NMSVPSyJrLrQAxZiQbR/mJU/Tx3LQzYdLoN7W9EwP73SL1WF8nWf1X
         HZk6JFHUy1u+A==
From:   rfoss@kernel.org
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Foss <rfoss@kernel.org>
Subject: [PATCH v1 0/3] SM8350 Display DTS
Date:   Tue, 17 Jan 2023 13:02:20 +0100
Message-Id: <20230117120223.1055225-1-rfoss@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Foss <rfoss@kernel.org>

This series was split out of v4 of the SM8350 DSI series[1],
and now only contains the DTS changes related Display on SM8350.


[1] https://lore.kernel.org/all/20221230153554.105856-1-robert.foss@linaro.org/

Robert Foss (3):
  arm64: dts: qcom: sm8350: Add display system nodes
  arm64: dts: qcom: sm8350-hdk: Enable display & dsi nodes
  arm64: dts: qcom: sm8350-hdk: Enable lt9611uxc dsi-hdmi bridge

 arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 127 ++++++++++
 arch/arm64/boot/dts/qcom/sm8350.dtsi    | 297 +++++++++++++++++++++++-
 2 files changed, 420 insertions(+), 4 deletions(-)

-- 
2.34.1

