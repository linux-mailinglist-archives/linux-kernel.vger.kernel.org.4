Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84D268A8D4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 08:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbjBDHpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 02:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbjBDHpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 02:45:11 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9315C367C2;
        Fri,  3 Feb 2023 23:45:09 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id bt17so3369001wrb.8;
        Fri, 03 Feb 2023 23:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hifGEzLokKSpU+8Oo9+RkSr2w2NcYjrTW3lQhdBhGew=;
        b=a3HvtRYwEPCEMaXL7/KwAQQbh/aDW5gkuIFWbmeLP9TdwsJFM6TmURKZwr/rWOIamd
         AME1UttDpaBaSNgB5dY1rxM8FFeIxZDNsm80zcJtnXY/hXtitUOGJ7Nv+QXCS1FfLl70
         y/NOjVNdtAr0Oe4VvqwujpHueUviSSYBLeNhZo1P+1FBfX+D3siNhf2C8pFeoPy/8XgQ
         tqYdz9Ub8Pai1KjXUzdMHhLeJ9KL+fePNDkH1KWQbbzQu7nqQB8Lfx2MWIGXg5894963
         LV8P7xwyOqZWyfWmnHAgwu1vLnDPiwJTG6tvlgSuTIFVqfzs8sVJSqcN94vsD11VLw9i
         Uh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hifGEzLokKSpU+8Oo9+RkSr2w2NcYjrTW3lQhdBhGew=;
        b=6WxEJIjK835tP4YlfTHgDA/9EmPjARX3qLaNZoHdiaApyx/2+n3UoFa2H64zH2Mx3V
         0858/fkH4+wFT347DFGLfaPI2Aoh6gI7WvPns5CI8WMtrBrNTB66qFz3myoTtG489er1
         MPwVvmOcjXn90J8fsIzMaOKLPSL6namNjL+IvqzB7Lo4nmnFPy4r/G7/ATH9ZGVtny7p
         GpT/w6xwYFxKWoHqF6fqGCDMWfzWmGBBOZTjrfBjF23LpXtvH5VZ9yz7zpMLra4xpB3N
         tLJyFYBwWAxWiOEOQ5Z7GTqdZRVxFb78uW99WBEgoq4Ma/JtDrR2PaPGkO8rQaBCnrrY
         zsiA==
X-Gm-Message-State: AO0yUKXPNNHm1YWyh68ulKh23vi0jZ1y7m3ZS6stYKs6Gs3ddqLIhu30
        hZ4D/rwcO3OzWb5Y7PLR5Sw=
X-Google-Smtp-Source: AK7set/tNcwdHjcw4AI11EU/eRIIuPDwIZVvdtI4IC3ZqxcJ2B+U0nrLmAVTGgJuCrQcDedS5q7OHw==
X-Received: by 2002:adf:f482:0:b0:2c3:e142:5fcb with SMTP id l2-20020adff482000000b002c3e1425fcbmr305146wro.14.1675496708046;
        Fri, 03 Feb 2023 23:45:08 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d50c2000000b00267bcb1bbe5sm3735814wrt.56.2023.02.03.23.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 23:45:07 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: media: rc: add rc-beelink-mxiii
Date:   Sat,  4 Feb 2023 07:45:00 +0000
Message-Id: <20230204074501.3421910-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230204074501.3421910-1-christianshewitt@gmail.com>
References: <20230204074501.3421910-1-christianshewitt@gmail.com>
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

Add a binding for the rc-beelink-mxiii remote keymap

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/media/rc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/rc.yaml b/Documentation/devicetree/bindings/media/rc.yaml
index e7d2ae5a7eb9..deeda4bb8dae 100644
--- a/Documentation/devicetree/bindings/media/rc.yaml
+++ b/Documentation/devicetree/bindings/media/rc.yaml
@@ -39,6 +39,7 @@ properties:
       - rc-avertv-303
       - rc-azurewave-ad-tu700
       - rc-beelink-gs1
+      - rc-beelink-mxiii
       - rc-behold
       - rc-behold-columbus
       - rc-budget-ci-old
-- 
2.34.1

