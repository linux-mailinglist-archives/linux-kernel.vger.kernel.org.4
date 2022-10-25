Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1E660D303
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbiJYSH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbiJYSHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:07:19 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430C3D2F3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 11:07:06 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id p3so10698653pld.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 11:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UaHvsuBeqGUDHNJwrHZu7I7KXYW+zqfgTqUGn6DC/xo=;
        b=BrZrLWVB5VSJpkzOeZqV2YWZUWJDEwqbeQ1Nve9BZ4AAyOSYp43pwQEn1bBPMP1PUV
         xFiQdrcQEowdrnFBqYSxGvy8VpMmBzyE2atFCIS/8/rs65U/DPt7ezxoUwSB7kqZU/LH
         rZ4F/tlv0HbrYah5/V8rNIThPb6tiWOQcfTEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UaHvsuBeqGUDHNJwrHZu7I7KXYW+zqfgTqUGn6DC/xo=;
        b=AdjdWR06uN0h94SDhQVIhODdGKlvTnffoIvpXv2+UD6ZL9nZm7u16ttWMNd9k3zvhD
         u2sUI2M1L41M65e6CLnINsiiCnxOJqfkiqYqstpfmczQHCTv1I7RDHQLWdHEe+zko+QH
         QKBlyyuPmMdoGxmEYaW/7gQSbXxRSePMKtsJie60nNuWI9IIA+6oRJDl4qijdjS1Eufr
         7je7sQwAuavSC5AppuVdicwL5mCQMyHIo3+2EG0XMTk8it9DWGBYav9wQc4NpTZd9/EZ
         PUliAqCW4l0MUYT1/+BFxpc9FV2tfc8PRBlp+1k1SgY1swnRkJD7r47sKanbQTNKWutY
         3aXA==
X-Gm-Message-State: ACrzQf14TAllygOhs1YFKr6xS0p2sK3kOdnsDypVcU7u5SuMOg9l8fZb
        I3uKAB84VaJodQ6L1TgpIIgZTg==
X-Google-Smtp-Source: AMsMyM6KD70FiLQ2NY7/KT4ZdCgreGIg8amZ286q1tYd4ft48X6ah9dtxyQ5N7DjKGkH08gBYBnE6w==
X-Received: by 2002:a17:902:d483:b0:182:cb98:26e8 with SMTP id c3-20020a170902d48300b00182cb9826e8mr39797221plg.73.1666721225601;
        Tue, 25 Oct 2022 11:07:05 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:11a:201:97a:f22a:beab:58])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902654800b001788ccecbf5sm1493786pln.31.2022.10.25.11.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 11:07:05 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] arm64: dts: qcom: Remove fingerprint node from herobrine-r1
Date:   Tue, 25 Oct 2022 11:07:03 -0700
Message-Id: <20221025180703.1806234-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that only a few people have the fingerprint sensor hooked
up on their board. Leaving this enabled is slowing down boot for
everyone else because the driver slowly fails to probe while trying to
communicate with a sensor that isn't there. Remove the node to speed up
boot, developers with the board can manually enable it themselves.

Reported-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
index c1a671968725..8d07401d852d 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
@@ -47,10 +47,6 @@ &pp1200_wf_cam {
 
 /* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
 
-&ap_spi_fp {
-	status = "okay";
-};
-
 /*
  * Although the trackpad is really part of the herobrine baseboard, we'll
  * put the actual definition in the board device tree since different boards

base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
-- 
https://chromeos.dev

