Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F406670C49
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjAQW72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjAQW6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:58:53 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD8F22029;
        Tue, 17 Jan 2023 14:38:53 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id a3so10247473ilp.6;
        Tue, 17 Jan 2023 14:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jU12ccyuLWQKpoa2iSEenE8dXXcbDsaHalxsJ2WThL8=;
        b=poFjKZmOJ7uryR3fumGWtdkKfQo76yahi9f1/P0ldguR1raajeovaTcN9YeXVCIi4T
         ZXGV7IMS3mF6zOEnp8jGagZKVvZPQKNjkcY49m48iXKIJPIDIFhrkc+VN+9U2dmo79v7
         HD4f6EtC7VX+1X1ITDn1oJDfXI8trJhSzs9neVmPxHuwQFP37WrUwf13mQuHtJRt1T0G
         HP+F03gluoHs4g+/qH/kbCW0jrVckQP/N+n55FOcEC0DvsY3QtmbMGg5njb7hN+hVJ6d
         hUAkGzXNKNHJ6C9V4BbNiDk0WA4Fau7PrjUH0dabXw+ldC6pmupU3EYJVqnBuYs1eKnL
         evPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jU12ccyuLWQKpoa2iSEenE8dXXcbDsaHalxsJ2WThL8=;
        b=IbjyIfRAzlHPvGdnyD97ePie3JdzpM9mbUi4O6ELFOv5ERFFPR9chplLiV13Lwcv0U
         tYgMzi4xCMM6LQNRnXNSb3MFVh02ru9kbPEVfmpMH7aP1iil3IgFS7C7Z1VBsfeOGQ9b
         YxTG4+drKsKUloxC+/jTfdUG/DUg3T7zVFZ3SBbRStNCa6Gf2vKjsI4ys8AhDsKLGRdd
         RNUyTqUMjTZm8t+onAIAN/SZhSsra0rOdkGbJOAfD36uJGv8YBI7OUNhSisbjqPb3BHb
         J7Ert9HqoNOvsM3s28BmVGzobjzzZvhTSyxbnZU0+49/75uPr6FdEafLEWkVJUXXxs7Q
         oG8g==
X-Gm-Message-State: AFqh2kqh90+laCxboZ60+uPvF8pTX9wZOHdy4GlZXt1KoQOgc1l0tfXQ
        SJcwU4ydiYr89MF7Wxp7zo4=
X-Google-Smtp-Source: AMrXdXvXNQcElhppNfe3JjOr48lukCBRDrEbC1qJEa0Blx6Nn3W9t48KTCNHIJW+G5Vhvmni88Cwtg==
X-Received: by 2002:a92:b05:0:b0:30e:e070:cae9 with SMTP id b5-20020a920b05000000b0030ee070cae9mr3984061ilf.28.1673995132908;
        Tue, 17 Jan 2023 14:38:52 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id a14-20020a027a0e000000b0038a5370658bsm9827122jac.6.2023.01.17.14.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 14:38:52 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 1/2] dt-bindings: arm: Add Beacon EmbeddedWorks i.MX8M Plus kit
Date:   Tue, 17 Jan 2023 16:38:44 -0600
Message-Id: <20230117223846.465016-1-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT compatible string for a Beacon EmbeddedWorks development
kit based on the i.MX8M Plus from NXP.

Signed-off-by: Adam Ford <aford173@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 3ba354578e8f..67449bc30bc9 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -932,6 +932,7 @@ properties:
       - description: i.MX8MP based Boards
         items:
           - enum:
+              - beacon,imx8mp-beacon-kit  # i.MX8MP Beacon Development Kit
               - fsl,imx8mp-evk            # i.MX8MP EVK Board
               - gateworks,imx8mp-gw74xx   # i.MX8MP Gateworks Board
               - polyhex,imx8mp-debix      # Polyhex Debix boards
-- 
2.34.1

