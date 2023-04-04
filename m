Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146E56D6A7A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbjDDRYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236089AbjDDRXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:23:33 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AB94EE2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:23:01 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id eg48so133482692edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swqW9Ca9H56TFND+javZmACJz25+KcaCrTqA9gONh10=;
        b=m33jvcLmJSZ/5wrs36eE5pgAEQqL0Exs2cHsfCdEva7xp2/g51588owtwuWYjp730Q
         nAwNjWKDCPW+kQZfkbjndbUj7q4R3Hwou/EXyOtTZUA7HTJQ69tUcOo7eSt5czJervzn
         IVuMGM28Ml5XthYIZGKuxKsGLOhr29OL3TDIXqRTgJGN48p6goZYXrc3bNubeWsVfxz1
         F8GUCD/wBu5YNG1pNIP0QRbXyJW2z0VepbgZZKnluo6YQlk7WGWKDJQHKH7fmIHKA4+A
         P40HZLfpp9l1yneuFNl+MQ+WM5toBAGoCwD9VHTjJzM1DgGkodIdFOacY5MXQ+nr0nTf
         3JdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=swqW9Ca9H56TFND+javZmACJz25+KcaCrTqA9gONh10=;
        b=ewTAhjl/5CxXlQCBtLdu1jteLBIiOqqBA1gHao6+rh9PBO9FlVpkVhQL4IvG1tLOH1
         Ft7cM/wcbUavT4izm1BwURJ4OWqXeufQYT+M7mVMRda2kQo9MP7ZX+2mC9NFBqXJTfRL
         5AUTRZ8Hb+wQHwokpBiu6BIU+cq2PjRGUW/17McGlxchNvf27ZNz5Vkf2x0LpthcmVZu
         QLAaSF4ssASw3noRNh8WHKYgEzPcWNG4rig9r4k25qUV87U46FGcWgozlXdf207fQNgx
         UPyGiMmrDV5vGGkXRn7XFecQp2CpFhUrvh7SQn/mm9RUwIXZR4ovgkDJX+V6kLtrlPja
         k+Ag==
X-Gm-Message-State: AAQBX9dCXgyF9OML2sTlMMqO2vkC7jhBQ6xL3JCQFI5FnEXPwe5Jjzql
        fZSK5b6KqujQIAf89PstE8hS2g==
X-Google-Smtp-Source: AKy350aFBwLu7hTxlDG8KC+HzY11W/sU9e+YM3f1QLTF9NPbo20z10zcjr9qCD8HRBxF3rFxu/dRbA==
X-Received: by 2002:a17:906:8450:b0:948:c047:467d with SMTP id e16-20020a170906845000b00948c047467dmr310931ejy.23.1680628976356;
        Tue, 04 Apr 2023 10:22:56 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:22:55 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 24/40] MAINTAINERS: Add myself as ONIE tlv NVMEM layout maintainer
Date:   Tue,  4 Apr 2023 18:21:32 +0100
Message-Id: <20230404172148.82422-25-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

Following the introduction of the bindings for this NVMEM parser and the
layout driver, add myself as maintainer.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a7763063ffa3..de05ac9b58ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15547,6 +15547,12 @@ L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	drivers/hwmon/oxp-sensors.c
 
+ONIE TLV NVMEM LAYOUT DRIVER
+M:	Miquel Raynal <miquel.raynal@bootlin.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
+F:	drivers/nvmem/layouts/onie-tlv.c
+
 ONION OMEGA2+ BOARD
 M:	Harvey Hunt <harveyhuntnexus@gmail.com>
 L:	linux-mips@vger.kernel.org
-- 
2.25.1

