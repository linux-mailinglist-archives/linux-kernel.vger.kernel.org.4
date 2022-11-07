Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE09861FE6D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 20:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbiKGTPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 14:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiKGTPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 14:15:40 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27FA27B12
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 11:15:38 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d10so11531781pfh.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 11:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dCHSGnCFJ0y/u8SQ+Xtk+pvjFKxhWsoTtgBkVZ7qxaM=;
        b=TwTXuGCgoe+Z65wLfGNAl2YpRz2wltTlH9WaarTkzyxcNuqjq7OP/xRtRRBMbAKp/r
         yBLXUgFsTL3cz7EnQAj/lTBse27z/05qQbXwve0LY0Qhyox4COYPH5+V5SLO/lBcFYK8
         BqbpdoK40GlI5FVGftaGRXyN3+w6eU8I99ZA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dCHSGnCFJ0y/u8SQ+Xtk+pvjFKxhWsoTtgBkVZ7qxaM=;
        b=vyGZUyfu/zHIzmCWrx0I4SReEB1OIZ4qvMgwikXRbI9UJjUz50FePuE0kXvxDkDYQt
         rjEj3gk2vgXEazdPbtkguj1LOaV+o/JBxkCUJVp93sqlctf0Ngj7SPDkdwyYu2fLzvmO
         HTpAKdR4BwhS8wjb+43RkEn01QXqE30mg9vlMu+vdCz/ZAwF7C7u/pp7d9dxF/GpEdyi
         xHM8V59LVmerubeu/rSQ1Q/Zi+aUSBZqPWS0CqYpzFW5zLBbOApJr8ubqEMlGY7egv85
         arbaCP4lyogHk9C7LG6msHL7TAG9xrwUOjOYja2u1RYyod90OrANPZIPvwiFl1Yev5pq
         Emdg==
X-Gm-Message-State: ACrzQf37vrdo8wr/MXF9hO7SLpj4s+Wvim6s1P64VxDEUYLfpl/u100v
        uHbF385ntyg6OSlbQiaFAIAmHQ==
X-Google-Smtp-Source: AMsMyM57yEmLDsxYkqy5WClNr4Ff1qFsZt/FJwLmrYrNwVcO744HMtZOn/erJGiCcLU+9G/pqnohcg==
X-Received: by 2002:a05:6a00:2285:b0:56d:5d42:3aa8 with SMTP id f5-20020a056a00228500b0056d5d423aa8mr44174929pfe.79.1667848538360;
        Mon, 07 Nov 2022 11:15:38 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:11a:201:4652:3752:b9b7:29f9])
        by smtp.gmail.com with ESMTPSA id r11-20020a170902c60b00b001830ed575c3sm5306627plr.117.2022.11.07.11.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 11:15:37 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>
Subject: [PATCH v2 0/2] Update fingerprint node on herobrine/trogdor
Date:   Mon,  7 Nov 2022 11:15:33 -0800
Message-Id: <20221107191535.624371-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series updates the binding for the Trogdor and Herobrine
boards' fingerprint node. Now that the binding has been accepted[1]
we're ready to merge this in the qcom tree.

Changes from v1 (https://lore.kernel.org/r/20220317010640.2498502-1-swboyd@chromium.org):
 * New patch for trogdor

Stephen Boyd (2):
  arm64: dts: qcom: Fully describe fingerprint node on Herobrine
  arm64: dts: qcom: Fully describe fingerprint node on Trogdor

 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  | 20 +++++++++++++++++--
 .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi |  5 ++++-
 2 files changed, 22 insertions(+), 3 deletions(-)

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Alexandru M Stan <amstan@chromium.org>

[1] https://lore.kernel.org/r/166718941539.790.4332712127794687523.git-patchwork-notify@kernel.org

base-commit: 95fade4016cbd57ee050ab226c8f0483af1753c4
-- 
https://chromeos.dev

