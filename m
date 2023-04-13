Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAEF6E0B12
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjDMKKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjDMKJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:09:59 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F6093FA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 03:09:48 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id z26so14363488ljq.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 03:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681380587; x=1683972587;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ff/HJj5Bp66DbVLI+nypfoRfFF1jrHWVoqmFfRJlC2I=;
        b=ICOg9tn8uB8MYJaCPLZtvj5NLO3g75xdfrT7pTbQlihxuXxHR2UTFYfivUJSSjqtty
         crS6scMY8FiKrKLMQS781ozN1Z9tuecQvcSN3pRra2t/9M1lWWUZ6iweQD7SxgRw5eiE
         I0dH+jq+1olkX4jhu7F8oPep6jS393wo1EG2uv/VUHcpEAR/NCXEjgIE6kAdcmgb22Vi
         ie8JyJieOHJckE4ijQC6C0Nh67S2uTA2uTkGGSCsguoX+lJDET5nVb91FNE1Bh8exRfB
         i9SaOUr66n/jVVgYpHD7fUL9gMe8q7e6h//trCZO2XwyC7OOpW6Y3Lz0YKya29Isf0pV
         p1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681380587; x=1683972587;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ff/HJj5Bp66DbVLI+nypfoRfFF1jrHWVoqmFfRJlC2I=;
        b=Gj9DIAdQYAoZXeV4p1iy54/e0Mat4Sos2nrnbp9rfiQE38qHHwvgjs38y1gbmAiIY7
         SvTSIhmivApyDGMLuN5q2E3c/REzdt+nMksnnWPEYSHy9vPP9WWOAk/Z/RRXwjsRIJds
         SJ/CB3lBKkOySThGySstWhmKIyNzwKhV4MDwqFs8LWhSNiA3K+gHHVWKveUSzWBootPN
         XIiLvyD82L4EGWcJhBx/KoZnoNST6kKZ/AlAM05ueFn4BgyK6vM4vUJ7z4ic1Kfic0y4
         TbpoMPVCgK9EGvrwXulNycyUDu31YXZSqXGFSuuUQh5Eugh5O73Kfu07/YzZ5OYesLv9
         qLtQ==
X-Gm-Message-State: AAQBX9edPEaSbaSne2L9cdbpFT7MXx6bIWCIG8D2lzZesTeAViQbE5do
        4BPfm2Mqs4OSjXGBDzFtX8vVyA==
X-Google-Smtp-Source: AKy350aU21tbuXy959wLVaRqTEyTpLkUrrRHgfrmsF1nmQcAIslHo/zCIPA7yRlzZh0TWIsygQA5Pw==
X-Received: by 2002:a2e:808f:0:b0:2a7:7e8d:986f with SMTP id i15-20020a2e808f000000b002a77e8d986fmr790128ljg.51.1681380587235;
        Thu, 13 Apr 2023 03:09:47 -0700 (PDT)
Received: from [192.168.1.101] (abyl123.neoplus.adsl.tpnet.pl. [83.9.31.123])
        by smtp.gmail.com with ESMTPSA id t20-20020a2e9d14000000b002a2e931fc48sm200482lji.140.2023.04.13.03.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 03:09:46 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 0/5] Lenovo Tab P11 panel
Date:   Thu, 13 Apr 2023 12:09:34 +0200
Message-Id: <20230412-topic-lenovopanel-v2-0-055c3649788e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN7UN2QC/32NQQ6CMBAAv0J6ds3SghpP/sNwKGWBTZqWbLHRE
 P5u5QEeZ5LJbCqRMCV1rzYllDlxDAX0qVJutmEi4KGw0qgNNrWGNS7swFOIOS42kAccjMX2SsZ
 po0rX20TQiw1uLmV4eV/kIjTy+xg9u8IzpzXK5/jm+mf/LXINCIi9boexudx08/AcrMRzlEl1+
 75/AQS+zkzIAAAA
To:     Jianhua Lu <lujianhua000@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681380585; l=1131;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=6PmzWn6dAXfVvXwy6DSd1z7BrTFh80L9gsPMzLfKnmY=;
 b=8Ocdd2+e91ythzoVKk4uu8GgAXpfJPmCdwjyOPTS8WMlp7zgOw3C7dqwyR/73k/dDVkSzN+5uxog
 2ED203s2C5Kx0np5ThLRF2T+77c0mGmhNBgvW1BkDD4rgNuQFxz4
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 -> v2:
- Remove dsi_info (unused for single DSI) [5/5]
- Add backlight.scale [3/5]
- pick up tags

v1: https://lore.kernel.org/r/20230412-topic-lenovopanel-v1-0-00b25df46824@linaro.org

Continuation of:
https://lore.kernel.org/lkml/20230217-topic-lenovo-panel-v2-0-2e2c64729330@linaro.org/

I rolled back the versioning, as this has been remade from scratch.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (5):
      dt-bindings: display: panel: nt36523: Allow 'port' instead of 'ports'
      dt-bindings: display: panel: nt36523: Add Lenovo J606F panel
      drm/panel: nt36523: Add DCS backlight support
      drm/panel: nt36523: Get orientation from OF
      drm/panel: nt36523: Add Lenovo J606F panel

 .../bindings/display/panel/novatek,nt36523.yaml    |  31 +-
 drivers/gpu/drm/panel/panel-novatek-nt36523.c      | 569 ++++++++++++++++++++-
 2 files changed, 590 insertions(+), 10 deletions(-)
---
base-commit: 7d8214bba44c1aa6a75921a09a691945d26a8d43
change-id: 20230412-topic-lenovopanel-0d3a057e3c23

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

