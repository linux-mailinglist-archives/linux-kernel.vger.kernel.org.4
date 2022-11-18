Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2964D62FA52
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 17:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241531AbiKRQbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 11:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241904AbiKRQbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 11:31:45 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB0393713;
        Fri, 18 Nov 2022 08:31:44 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id s17so978784ilp.1;
        Fri, 18 Nov 2022 08:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FP1bUQo+iwkHiXqXdQVRu9FY7LrCRwnTYHQ0qebweZ8=;
        b=ZgwYNd9F/SaIHfKswk1vi8zPLD3WN1fWCfyHf5F50m884FRLNr8CHNij7vRPBxkEZT
         USRku8Z4c+EfvVmqus3fg36oHRh0KkQ+fD+usNaT75kD4rPXz3YiTJTL3nOUvUMQO1zJ
         mpsjEUHmT2T2zdT453Hy4AvmHwG9SKajpELfY10v/BhcTLhvpsc9JTOqjstc/buOJX8p
         nhyWyFTUDtFkS7hADWgr5cpOlyQI3AQ6OyRF9RApU983kyBLW5EazieoqmlgAY3jsMCa
         Eiipr27S0+p9+zMN5t/CY2ab1daUYTJaUfFMgeOKghV5cQqHa6Z49o8JK50TWHQmClbW
         4a4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FP1bUQo+iwkHiXqXdQVRu9FY7LrCRwnTYHQ0qebweZ8=;
        b=7o6lsZ1ZWav3nvMvhX4bfQnniA4SMRqEI4ggDJBXLv6+GWeIDvH9kWAk59J77N63PV
         XN31dch7Y9R0R3Yx6+7xjwKMaevZHbz3Zzx/XGwtURmtKkDCnuGJ9XIkrE9EshpT3kKN
         Jj54FtOdbOZVLyv6H3cK3XYE9858Wnt8AC9uxD/T9nWgq5sXSKty6ibLuPkvbQZe5Thr
         /+mwGNPx1GXlBx2FwWCUgVWV0vaSBbPS6Cvd7rmd8f6KhPJULpvGR6bXxlYsd6aWzAzT
         exO4hsXLLH8JSyrmdbxadPSnmq77NZGXaV+9qH5eRKGw/79Gl0XGzNWVP6a1qrUrl+sf
         9Dhg==
X-Gm-Message-State: ANoB5pkLwy6Pslp9kEuY+r9vYwuTEpSV6qH6j1++aXT2loLt998BiImL
        UwFtKklXUActIW1V3ZSu7Oc=
X-Google-Smtp-Source: AA0mqf5uGM/qoxxHmxsD4otzFwgVvp+9Wf+BqmxKS/eXECF0mS2RUVaq9nCkQXkxTspGAjcdw74+jQ==
X-Received: by 2002:a05:6e02:1210:b0:2f9:aecd:6397 with SMTP id a16-20020a056e02121000b002f9aecd6397mr3695890ilq.100.1668789103458;
        Fri, 18 Nov 2022 08:31:43 -0800 (PST)
Received: from hestia.gfnd.rcn-ee.org (208-107-176-7-dynamic.midco.net. [208.107.176.7])
        by smtp.gmail.com with ESMTPSA id f2-20020a02a102000000b00372412edbc2sm1311128jag.116.2022.11.18.08.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 08:31:42 -0800 (PST)
From:   Robert Nelson <robertcnelson@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Nelson <robertcnelson@gmail.com>,
        Rob Herring <robh@kernel.org>, Nishanth Menon <nm@ti.com>,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <drew@beagleboard.org>
Subject: [PATCH v6 1/2] dt-bindings: arm: ti: Add bindings for BeagleBone AI-64
Date:   Fri, 18 Nov 2022 10:31:38 -0600
Message-Id: <20221118163139.3592054-1-robertcnelson@gmail.com>
X-Mailer: git-send-email 2.30.2
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

This board is based on the ti,j721e

https://beagleboard.org/ai-64
https://git.beagleboard.org/beagleboard/beaglebone-ai-64

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
CC: Nishanth Menon <nm@ti.com>
CC: Jason Kridner <jkridner@beagleboard.org>
CC: Drew Fustini <drew@beagleboard.org>
---
Changes since v5:
 - no changes
Changes since v4:
 - no changes
Changes since v3:
 - added Acked-by from Rob Herring
Changes since v2:
 - rebased on next after k3.yaml alphabetical sort
Changes since v1:
 - added documenation links
 - add board in alphabetical order
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 28b8232e1c5b..09e6845ff243 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -61,6 +61,7 @@ properties:
           - const: ti,j721e
           - items:
               - enum:
+                  - beagle,j721e-beagleboneai64
                   - ti,j721e-evm
                   - ti,j721e-sk
               - const: ti,j721e
-- 
2.30.2

