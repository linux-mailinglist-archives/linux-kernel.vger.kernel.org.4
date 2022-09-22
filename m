Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3675E5FCA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbiIVKXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiIVKXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:23:16 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED3BD8260;
        Thu, 22 Sep 2022 03:23:14 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id rt12so6834407pjb.1;
        Thu, 22 Sep 2022 03:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=TCc/gOvTHOL2F7Ue8s9kl1byTSwmPAIbmIyaPtaEwiM=;
        b=B63v5JfB2QpdVWKDCWbpGo28vPsDyQjPhOsEs429tsqG1h1JNK9/V4CLJ+4J6pcVj+
         L0d3olMJR710z7PyunmYSGm6Vdco277lqWjsUQy0r/NFoiWVcwjw/Lnmm3Igrs8if7bB
         f2d1i3OEq7InLzoqWyiQ/4tpaFN0xLHLfzj+vp8+2Dy0y5nGF/zvkkvCfui7RV1ieWkJ
         XOeG9sxgsC6udAs66Yw571KtvYb5auxwi9ZoUSbLAg08s52fUfnHg7/bmNAnwFMQYg7t
         vYtB/y+8qG7M0NWwxEswIFVow8TJ6nI+azcBSrtpTcNkfCd7RR9WKzukhLdaHYKT5mJF
         JjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=TCc/gOvTHOL2F7Ue8s9kl1byTSwmPAIbmIyaPtaEwiM=;
        b=FM8uV/xhcDcWcAQwHHPeWByVkHOMqBaDXyivYPq4H35QlOU/AcASEHZoCAey38I+ov
         UlgvkAkJtsd4wbhf7gdAH3RWTwxScOS4qlxnphrWYZhB0jU9F6gMIyTXMAo1n9IU+9Ha
         MDf57od4vbKsDpGZ+icNQYd2uqTytjEWLEZEKNcU+uQgOS9l3PkA5XnjV4CDdPDV1PnH
         IBbcan+gDhrx75v+jKb+tIXvzmjQWT4WJQgsE0UVPcbjGSAWT3a16y9IC6MjIvMKZxVz
         eoRMNe3DtwwILqnxipqwYn2tiVi+REKGoyAhu394U9A4GQa9W07AKTIptSPXPTi32wM4
         pdFg==
X-Gm-Message-State: ACrzQf3eF3MPJr73y//Ktl4IWGU0blHfSGUDjD0wMsSbzD0yqVjneF1C
        fI2p7Ltwf/A6XeCM4gM3l+cHKQVu60g=
X-Google-Smtp-Source: AMsMyM4kfuZosAAZxMcsajDHXKIGopFg2NGyv/VoRgOD6U8/wnIhttZNebZzdCaNRTsetUK6HBoJyw==
X-Received: by 2002:a17:90b:388c:b0:202:a29d:6e6f with SMTP id mu12-20020a17090b388c00b00202a29d6e6fmr2950086pjb.231.1663842193394;
        Thu, 22 Sep 2022 03:23:13 -0700 (PDT)
Received: from localhost.localdomain ([103.104.171.43])
        by smtp.gmail.com with ESMTPSA id v16-20020a63f210000000b0042a713dd68csm3422050pgh.53.2022.09.22.03.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 03:23:12 -0700 (PDT)
From:   Yunlong Jia <ecs.beijing2022@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Yunlong Jia <yunlong.jia@ecs.com.tw>,
        Henry Sun <henrysun@google.com>,
        Bob Moragues <moragues@chromium.org>,
        Yunlong Jia <ecs.beijing2022@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH v4 3/4] dt-bindings: input: touchscreen: elants_i2c: Add  eth3915n touchscreen chip
Date:   Thu, 22 Sep 2022 10:21:19 +0000
Message-Id: <20220922101813.v4.3.Ic4e8f03868f88b8027a81bc3d414bae68978e6b7@changeid>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220922101813.v4.1.I3aa360986c0e7377ea5e96c116f014ff1ab8c968@changeid>
References: <20220922101813.v4.1.I3aa360986c0e7377ea5e96c116f014ff1ab8c968@changeid>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an elan touch screen chip eth3915n.

Signed-off-by: Yunlong Jia <ecs.beijing2022@gmail.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>

---

(no changes since v1)

 .../devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml b/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml
index a9b53c2e6f0ab..d28625372f5ac 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/elan,elants_i2c.yaml
@@ -17,6 +17,7 @@ properties:
     enum:
       - elan,ektf3624
       - elan,ekth3500
+      - elan,ekth3915
 
   reg:
     maxItems: 1
-- 
2.17.1

