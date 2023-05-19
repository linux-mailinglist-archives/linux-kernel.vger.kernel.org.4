Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B10709995
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 16:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjESOZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 10:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjESOZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 10:25:34 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785E7137;
        Fri, 19 May 2023 07:25:33 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f41dceb9d4so32157035e9.1;
        Fri, 19 May 2023 07:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684506332; x=1687098332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xvLZ2++fQnm+JjIhOF2F8t+cx4hl9h36DRJ3AK+mRck=;
        b=JFVXiWQSmYDU74DDMckE8I1eFbRQZT+cw8e9Lik5jkhHW38xmrHrxIUZjgOixa67dO
         t1HNBo517Z7vdPY0YOBOy0QiLPhBPYjzJdZymvkigS+KhrinR2C6tjJlqcRY18imZ+F8
         uH9j/QOS+uXhW0W77aTFTjFz5I8bN9wsdEBfPdV0sDMqFB20iCMvpZrpVefe1ScwC/Xj
         gE1KMeGi3FgsMCnX7F1JbS2EC0jqDis4EK4FcussUuTFvErnSYY6MLgz/iMeWQLS8LCY
         3Rnl4Eom/33W401g2Lc101fCvNRCF5TeAoPbqCmaHLO++JCEnNxlolEOMzgXV4quxGTR
         6B+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684506332; x=1687098332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xvLZ2++fQnm+JjIhOF2F8t+cx4hl9h36DRJ3AK+mRck=;
        b=IBZi2IdGSvz6OPiuNgZV9PdkSFXMtxETibVgBMmjxalt4oVv8d7137Fo568QRwaZmV
         ol3mIWeoOkyfoFGxydX/skyeN91PoJwiEEPHhZ1FaIfwH8Gh1Oc5dZUk4wVlja95pa1C
         euif8YjZBMLhlb6KuLsrww8XOOAHIgijZutm6S/MlKNo5JKisSIyyP/DVs5sjtYnisMP
         HR+rtUCGxcrfbu2my8RGn4p+pTcwL3sOpgbjraaDWBrhEAEqWOlnMM40fLUnqxJ668zN
         oorDwpb8il2B70ar8XZc/BDOAKfhkaOu7S53Ua9QKiwDPaEOHzHemzrKBUGaBCuv19bj
         vW2w==
X-Gm-Message-State: AC+VfDyvI0ItrxpaOKkroFOWh41HEvAtIFcIQUkz+TSCQa5UmPBpWrs4
        9ieBnAPHi2paZh4rcQsYvLE=
X-Google-Smtp-Source: ACHHUZ7NWkSGxn/SlGxO8yV6Ikgtyfk9MEXgniVzcGq6Q9SyrHjOpFO3NiuhF4V62VzWRsdG7lyoVg==
X-Received: by 2002:a7b:c7c3:0:b0:3f4:2174:b28a with SMTP id z3-20020a7bc7c3000000b003f42174b28amr1441643wmk.15.1684506331605;
        Fri, 19 May 2023 07:25:31 -0700 (PDT)
Received: from fedora.. ([95.168.116.22])
        by smtp.gmail.com with ESMTPSA id h12-20020a5d4fcc000000b003062b2c5255sm5451748wrw.40.2023.05.19.07.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 07:25:31 -0700 (PDT)
From:   Paulo Pavacic <pavacic.p@gmail.com>
To:     neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Paulo Pavacic <pavacic.p@gmail.com>
Subject: [PATCH 0/2] drm/panel: add fannal c3004 panel
Date:   Fri, 19 May 2023 16:24:54 +0200
Message-Id: <20230519142456.2588145-1-pavacic.p@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fannal C3004 is a 2 lane MIPI DSI 480x800 panel which requires initialization with DSI DCS commands. After some commands delay is required.

In previous discussions for device tree [1] [2] and device driver [3] were named mipi-dsi-bringup.

[1] https://patchwork.ozlabs.org/project/devicetree-bindings/patch/CAO9szn3t-giVipb5oH_3mzQZbnXbDqqz0WEg8uAmo-1W2uKzFg@mail.gmail.com/
[2] https://patchwork.ozlabs.org/project/devicetree-bindings/patch/CAO9szn18KsR0c+U8EEY1=xnmsKMxy6SEArMUic0z=aYJDVwWCQ@mail.gmail.com/
[3] https://lists.freedesktop.org/archives/dri-devel/2023-May/404775.html    

Paulo Pavacic (2):
  dt-bindings: display: panel: add fannal,c3004
  drm/panel-fannal-c3004: Add fannal c3004 DSI panel

 .../bindings/display/panel/fannal,c3004.yaml  |  75 ++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   7 +
 drivers/gpu/drm/panel/Kconfig                 |  11 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-fannal-c3004.c    | 405 ++++++++++++++++++
 6 files changed, 501 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/fannal,c3004.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-fannal-c3004.c

-- 
2.40.1

