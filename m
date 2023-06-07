Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8737263C6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbjFGPLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239458AbjFGPLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:11:35 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32521720;
        Wed,  7 Jun 2023 08:11:33 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-977c8423dccso148608266b.1;
        Wed, 07 Jun 2023 08:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686150692; x=1688742692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fVGis/rTcZr0vzPZaXtByS8SSJioRsVHgE4mgu1eoWM=;
        b=spq/RM/dNbFQuTXPY2sPsA/aibgvpksiop/LevkGp/FWybfXYU2k1nvoislNHdCw4W
         wSdAHMDyz7EVjlm5OErhFBu/dybUozjzN00xXwhbrlyTeI3ZGzVRouvB+1WPEhkgF1Vr
         OWiMFSwBv7N9IYdwU68QAeNgcda30cfuy66UiZHx3wEdmhLkMxBEJvTwU/ya6ncO1GmR
         kqBqn0R+2HvlH6bGbBM4ndaFrTW1ak7eREiK0UFRUGJD4v+9+s/+isgtov/wT1+lxYmq
         gW6ijZbyd8Zi49JyJ0tWW+sQsPWXoV8vlQjN2w8aaaEHVLsozhlbet2K752E6fDC3Xof
         87Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686150692; x=1688742692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fVGis/rTcZr0vzPZaXtByS8SSJioRsVHgE4mgu1eoWM=;
        b=UiyirWoMNWqUwwxzM1eDe+Sn8dsVecBCp4d3vBmbWxudE4DO/YJRdiPkd+lIpitgrg
         IqCMObyDewQTXSsDN45NyyVDUnQC2V7IQr+PErkpXskMrjvArQtATxA0w6jezHlDEaae
         Q4yW8jtrVmsUR1GikLoiVf73Ha9Q5FYkzqZmudUo22PI5dGFpwbbCOtgJWfglovKH0Kx
         9T8Q+/psesS4SSUg817oMA8GbL+r96epFa+4emTuivSO6CPJ0HOiwr9jhSyyXR6nbV0K
         KAUygtZBS8/Q8W6CwgbgKLTORPqoVheFU3JACntPmlI/wbm7pMXeFQsgHttO34RTD9PB
         Ziyw==
X-Gm-Message-State: AC+VfDxGipULk9gXQ7vMvLEZ8z110DB+UuWv4XoF9jDZ7juhVBYT8DuN
        GF6PGlqcVa9wesLu7EMY5Oo=
X-Google-Smtp-Source: ACHHUZ7b7bz7T9J2KeyxrecP+EhKZCCXFFupI1T8bkMfAEqF3RD87rlXw9HCzXySDal0y7jqrODRrQ==
X-Received: by 2002:a17:906:5d07:b0:96a:2210:7dd8 with SMTP id g7-20020a1709065d0700b0096a22107dd8mr5206553ejt.38.1686150691954;
        Wed, 07 Jun 2023 08:11:31 -0700 (PDT)
Received: from fedora.. ([46.188.160.176])
        by smtp.gmail.com with ESMTPSA id m19-20020a170906235300b00967a18df1easm7006222eja.117.2023.06.07.08.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:11:31 -0700 (PDT)
From:   Paulo Pavacic <pavacic.p@gmail.com>
To:     neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Paulo Pavacic <pavacic.p@gmail.com>
Subject: [PATCH v4 0/3] drm/panel: add fannal c3004 panel
Date:   Wed,  7 Jun 2023 17:11:24 +0200
Message-Id: <20230607151127.1542024-1-pavacic.p@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Fannal C3004 is a 2 lane MIPI DSI 480x800 panel which requires initialization with DSI DCS
commands. After few initialization commands delay is required.

Paulo Pavacic (3):
  dt-bindings: add fannal vendor prefix
  dt-bindings: display: panel: add fannal,c3004
  drm/panel-fannal-c3004: Add fannal c3004 DSI panel

 .../bindings/display/panel/fannal,c3004.yaml  |  78 +++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/panel/Kconfig                 |  11 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-fannal-c3004.c    | 314 ++++++++++++++++++
 6 files changed, 412 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/fannal,c3004.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-fannal-c3004.c

-- 
2.40.1

