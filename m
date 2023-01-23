Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D29677546
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 07:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjAWGzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 01:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjAWGzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 01:55:12 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC628196AE;
        Sun, 22 Jan 2023 22:55:10 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso4019761wmb.0;
        Sun, 22 Jan 2023 22:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DJ7pZzP7l4POQysOuFD6RXLwFmeQ64kf4EXzL/9/vCM=;
        b=SZB5f+BslCr+6rnD0bGuhWHfYC/po5PbklRCKScbGHMO0v/+I0mDslXhXkgAcZmBnH
         72IEMHTBkvjUwP93/p28l8dU0+rVyWttiSgV5PpcNryp+ZTeaLSONqb5ZlBKP79CwMeg
         5ZS+6HdQEJyGFviao39g0tKfGHu5gz5yrD23BvA/VaxZCl05v0d/efDW9xjrfSGioF/j
         dOErQb/eVijdT0UGYROqjN7uwaAAYjnfXYkmX+dbCzei+x8MDEubZi2vqyb4HqTcLWW0
         galk8SpP/h/Ofb/i7stpeFlE1NGhVhBfRe0z5lStBk6ntYjKZ4OEYG5lxYO5nVbLRauf
         uTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJ7pZzP7l4POQysOuFD6RXLwFmeQ64kf4EXzL/9/vCM=;
        b=zH6XI2gdichbndsckJsYshG3jCQuBaxj51648BxvFRTfe5r8hMZewca0hsablFmWf6
         i46+Su6pGuTwZl+J9uvddvMvPuKo0quOekrgjN3kMh/EepJpSq5+zMI62Cvww1I6KJ0H
         yqDWNj2HxFNrumWLgPwJf/5x4ebMCBmvRzESpFv6l2Ttxm779vLaOPSBetC7JOyZVnUg
         znrkiSuS9yggWFfhGtXs4iZAkfnxI/kkxBFpEIZPcpe2IMwghZZvqjrpJychfo59cBcL
         6/FdhgsLtdYOXkbscrUm/idTHwRUBy7x8Z4F848G3lkyU1QfuLZzOzHog8cBcyTskY7x
         PH9w==
X-Gm-Message-State: AFqh2krifXPXd9UcMiafozHGjf8lrMn65SI7zvI4uN6QrGpzY14PpUXk
        ald6Cc96Og7q5r4uMhj1ILU=
X-Google-Smtp-Source: AMrXdXsRjRl9GgZhb5JHClnfyLweMYqjELAUA0MevSUcuGPjcWZEwb2kQp0JOjfWeEDMV8jXZ95J8w==
X-Received: by 2002:a7b:c4d0:0:b0:3d1:f6b3:2ce3 with SMTP id g16-20020a7bc4d0000000b003d1f6b32ce3mr23724781wmk.35.1674456909143;
        Sun, 22 Jan 2023 22:55:09 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id az22-20020adfe196000000b002bddaea7a0bsm25948365wrb.57.2023.01.22.22.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 22:55:08 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 0/3] arm64: dts: meson: add WiFi to P212 and cleanup VIM1
Date:   Mon, 23 Jan 2023 06:55:01 +0000
Message-Id: <20230123065504.2669769-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small series adds WiFi support to the P212 dtsi then removes the
corresponding node from the VIM1 dts (as it's now inherited). Also
move the pwm_ef node in the dtsi to alpha-sort correctly.

Christian Hewitt (3):
  arm64: dts: meson: add Broadcom WiFi to P212 dtsi
  arm64: dts: meson: move pwm_ef node in P212 dtsi
  arm64: dts: meson: remove WiFi/BT nodes from Khadas VIM1

 .../amlogic/meson-gxl-s905x-khadas-vim.dts    | 15 -------------
 .../dts/amlogic/meson-gxl-s905x-p212.dtsi     | 21 ++++++++++++-------
 2 files changed, 13 insertions(+), 23 deletions(-)

-- 
2.34.1

