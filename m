Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064EE7392E0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 01:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjFUXKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 19:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjFUXKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 19:10:44 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EF71996;
        Wed, 21 Jun 2023 16:10:43 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-77faf29bdf1so114116739f.0;
        Wed, 21 Jun 2023 16:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687389043; x=1689981043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8jhBW4cq1G82lRhuphvSA0O78OczoAY/M/EXq/UCAFc=;
        b=POXrIRn6ZUxCTofTYbyKWy0jFnIWrLBLz8UaDJ9ydDoiIN8uFxlmocA/m375Cw6ACW
         yEuBZP3rkqrl7VZvac69K25smuAFyPiCN+Tq15onBbLr8DPTykdu9fzoxlkusNZrpbbI
         G7ywG3NSp39EdAUR76RVUDM/HTi6Brn9kUbh3JMsFxuAKe3wjP8nr55O9NYhWZ5g+/Kf
         OsHK+wI6WH4l1KJ5qZL8EAma8xs5pPtxtZqcyB2Dpjv7/JhbS7OSfHeh3a3JM4XtGEOz
         zHDkyeSDru6Qsr2lzhrB94O+wt5eyRbTYlu/iVb2S2fMRfy//QMXnnJWpH3syTnFbgPW
         ehtA==
X-Gm-Message-State: AC+VfDzv3BON/TBTAKaH0Zzk3xchG0hUNzafGV+9N3hKu2MKLCmJ9tXK
        CshJa8lAx2ripr/66o8arQ==
X-Google-Smtp-Source: ACHHUZ57x5pBJeZws/xTkeEyKFbWyzLbCNIsILFHDOxeI2LEqAmRC5EEtivUQe20MFBdYbUzt/TmOg==
X-Received: by 2002:a6b:6e18:0:b0:780:c873:87d0 with SMTP id d24-20020a6b6e18000000b00780c87387d0mr1173454ioh.10.1687389042852;
        Wed, 21 Jun 2023 16:10:42 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id u21-20020a5ec015000000b0077e2bf9ee78sm1686777iol.16.2023.06.21.16.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 16:10:42 -0700 (PDT)
Received: (nullmailer pid 3816831 invoked by uid 1000);
        Wed, 21 Jun 2023 23:10:40 -0000
From:   Rob Herring <robh@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] dt-bindings: net: altr,tse: Fix error in "compatible" conditional schema
Date:   Wed, 21 Jun 2023 17:10:12 -0600
Message-Id: <20230621231012.3816139-1-robh@kernel.org>
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

The conditional if/then schema has an error as the "enum" values have
"const" in them. Drop the "const".

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/altr,tse.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/altr,tse.yaml b/Documentation/devicetree/bindings/net/altr,tse.yaml
index 9d02af468906..f5d3b70af07a 100644
--- a/Documentation/devicetree/bindings/net/altr,tse.yaml
+++ b/Documentation/devicetree/bindings/net/altr,tse.yaml
@@ -72,8 +72,8 @@ allOf:
         compatible:
           contains:
             enum:
-              - const: altr,tse-1.0
-              - const: ALTR,tse-1.0
+              - altr,tse-1.0
+              - ALTR,tse-1.0
     then:
       properties:
         reg:
-- 
2.40.1

