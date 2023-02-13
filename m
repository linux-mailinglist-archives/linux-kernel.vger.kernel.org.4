Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E436694B61
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjBMPil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjBMPic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:38:32 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2727D193CE;
        Mon, 13 Feb 2023 07:38:29 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id rp23so32844755ejb.7;
        Mon, 13 Feb 2023 07:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q86xsnFvfvmah1G0eGQOi1KV205lT5RC6i71PTaiGzo=;
        b=YNfKzAtIz72gcYaG7XV4PSq2NEXvrAgcCMjnPsI91+HELi7EmCHFa3h4v/3A9zLFQn
         eiH1eheI31WtpJif3x+2OOK8Xz4DoEkCcRuLK59lss1ztdCoMu8sFoOHteG1OD6KSrbL
         Ev8MEuIShNtQosDwH5de/OQhc61gNDKH73GvL/OKOWXAORkRh/yTwQGIKVUjJhYeMUYn
         DqYHQ1dZewnMIWm3Kbr8D2rRW1OUeE8IEB2dQtF0EkHYPu+q10gnQBajelD4xPxvZA1p
         kAXt7QQv6YugLjFyGT9tpF7eClkhCylEdqWoohIOa1EZ3SG724LY168OA+5zHKy/KARI
         c4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q86xsnFvfvmah1G0eGQOi1KV205lT5RC6i71PTaiGzo=;
        b=6gzt9f4T9VHF6uRQDdmWmS8eZB0K+3s00llDeXqU3JYqm5PnlqfDBXQ9aUqv5qlFJS
         TatVV2g/3kQ5SYbv5xUC8R9cM6n1NLVkcgQ3N6QNl/725eX5uz3RAHP8Hkjbz74f7s3s
         v7HSeck2it53OG0YrQicWmZXxU6CBGuf5qLpCWRPOc0ua3TlA4PlRiNNnxSQIaU7eKgt
         R1pDlWgJzFBWN8l4KzYmOL9i1qT5/8BS+EdhMxuKR+jT0FET21xsQoapUono5SQPMVN8
         YZFIdtJAFrPgswVmVko59sS5QhmoHet2ZhcnRCKz8/KmFSRpTJ950+dd0dbK/dVcthlf
         ylag==
X-Gm-Message-State: AO0yUKVPXKn2JWxXwMC1b/OH8RVEvaJHLAafz380Zjl7r+B9iLCuYecI
        idOd6uEcAVNsrHcmfcdWTQo=
X-Google-Smtp-Source: AK7set9rpu4uOTlLBDoMG+BkveHrcsEYP70PEWPeRWFby5VyriFa/6JKgxhk4Nenhc+awLxNZsP00A==
X-Received: by 2002:a17:906:6a1b:b0:8af:b63:b4bf with SMTP id qw27-20020a1709066a1b00b008af0b63b4bfmr23256890ejc.27.1676302707637;
        Mon, 13 Feb 2023 07:38:27 -0800 (PST)
Received: from localhost.localdomain (83.24.145.108.ipv4.supernova.orange.pl. [83.24.145.108])
        by smtp.gmail.com with ESMTPSA id gf17-20020a170906e21100b008b12614ee06sm115901ejb.161.2023.02.13.07.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 07:38:27 -0800 (PST)
From:   Maya Matuszczyk <maccraft123mc@gmail.com>
To:     heiko@sntech.de, Jagan Teki <jagan@amarulasolutions.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-rockchip@lists.infradead.org,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: display: panel: sitronix,st7701: Add Elida KD50T048A Panel
Date:   Mon, 13 Feb 2023 16:38:13 +0100
Message-Id: <20230213153816.213526-2-maccraft123mc@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213153816.213526-1-maccraft123mc@gmail.com>
References: <20230213153816.213526-1-maccraft123mc@gmail.com>
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

Add compatible for 854x480 Elida KD50T048A panel, found in Odroid Go Super
and Odroid Go Ultra

Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
---
 .../devicetree/bindings/display/panel/sitronix,st7701.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
index 34d5e20c6cb3..83d30eadf7d9 100644
--- a/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
+++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
@@ -28,6 +28,7 @@ properties:
     items:
       - enum:
           - densitron,dmt028vghmcmi-1a
+          - elida,kd50t048a
           - techstar,ts8550b
       - const: sitronix,st7701
 
-- 
2.39.1

