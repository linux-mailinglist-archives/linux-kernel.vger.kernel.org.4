Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B18374B971
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 00:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjGGWRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 18:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjGGWRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 18:17:39 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8387A2117;
        Fri,  7 Jul 2023 15:17:37 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-78362f574c9so88471439f.3;
        Fri, 07 Jul 2023 15:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688768257; x=1691360257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VbcO12KcuCZy6mIXJQxBwZ8MhvfUPsQU9+tPXTNckJU=;
        b=D6xlbvcNkYavVRFid47w72LBvCAPCmPDCttROQ3cxnSc6Z8XR93dMRFpFus+zhHVKy
         tuaUymJuDgNqHlwdY8PP6BMqe2Fth2ojMjEzimGme2myhFBFr6bnkcCz4mxjFTe8GVmt
         KwnYmolRfUAuve9zXZ2d0MHFCbj9nvHy1+YZ42z9SQlf1Dmiqc4j6fYJiFKCcsEPavES
         ot31d7m2FE4m/8n3C9hmRYSdEXMHikfJ8o1iMy4axUkSrgOM+Ix5vHm5ZiO/feM1Jke3
         2+lDORUZbBhpTRRCO+cArqlPgRol7DDdfIEK39SyIK8+qHIY1sRLloleNymjdzuO/J1f
         k15g==
X-Gm-Message-State: ABy/qLZmolzBmpMCKwqii71n4QaHERy75BK7R7plEXTPfySaKq3gl7qO
        OrmxRU7GpCEDJvPJSGXLXA==
X-Google-Smtp-Source: APBJJlFO+EngP3AgSBdVkctaKn6OK6ew2bMWVk+3PoD7xbagCXQdFDfFEahreMSZGD6t8VCzb0Oc6g==
X-Received: by 2002:a5e:dd0c:0:b0:786:ea57:22e2 with SMTP id t12-20020a5edd0c000000b00786ea5722e2mr2706201iop.20.1688768256760;
        Fri, 07 Jul 2023 15:17:36 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id u25-20020a02aa99000000b0042b4e2fc546sm1542025jai.140.2023.07.07.15.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 15:17:35 -0700 (PDT)
Received: (nullmailer pid 1071485 invoked by uid 1000);
        Fri, 07 Jul 2023 22:17:34 -0000
From:   Rob Herring <robh@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: audio-graph-card2: Drop incomplete example
Date:   Fri,  7 Jul 2023 16:17:25 -0600
Message-Id: <20230707221725.1071292-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The example in audio-graph-card2 binding is incomplete, uses
undocumented compatibles strings, and doesn't follow typical .dts
formatting. Rather than try to fix with what would probably be a lengthy
example, just drop the example.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/sound/audio-graph-card2.yaml     | 20 +------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-card2.yaml b/Documentation/devicetree/bindings/sound/audio-graph-card2.yaml
index 3de7b36829da..d3ce4de449d5 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-card2.yaml
+++ b/Documentation/devicetree/bindings/sound/audio-graph-card2.yaml
@@ -39,22 +39,4 @@ required:
 
 additionalProperties: false
 
-examples:
-  - |
-    sound {
-        compatible = "audio-graph-card2";
-
-        links = <&cpu_port>;
-    };
-
-    cpu {
-        compatible = "cpu-driver";
-
-        cpu_port: port { cpu_ep: endpoint { remote-endpoint = <&codec_ep>; }; };
-    };
-
-    codec {
-        compatible = "codec-driver";
-
-        port { codec_ep: endpoint { remote-endpoint = <&cpu_ep>; }; };
-    };
+...
-- 
2.40.1

