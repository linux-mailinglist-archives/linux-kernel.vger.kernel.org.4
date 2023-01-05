Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03FD65E879
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 10:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjAEJ65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 04:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbjAEJ6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 04:58:34 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019F754716;
        Thu,  5 Jan 2023 01:58:33 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id t15so26708621wro.9;
        Thu, 05 Jan 2023 01:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjqUfn0/m8oEBwXENgNWLccsjZuSA06a38MdlKkOCzg=;
        b=RNomMt6X37Ose1dLmxPosXH2n19rdxAfhmfqzB1kkUfIhtu0JioUtBOjLtZnn7cSa1
         AVh90rPGFcB+OVV2IMFhWBAks75ClFCbpU6SdQC1GsoYPf6OZgBU83h0i4pkPbomB1/o
         ygkZufdOjR2jZvCN2EuSlaxeZX9/jaXccbWQPkeHz5Gl86yWM2/LbY+0Ja3XX6hTTAuQ
         KzjSV49D4vI0+i0/FA6skHVUDCeAUD69RQ2TgUpmwk43f49sjTB/k7fQDtA6yNXXRKvQ
         99m/mZVHJS7TDEInIQ+DylaG13tv2ywiALzWhDtvZMNKV/OBjA7I30FngzPwGT95ld9g
         6iqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjqUfn0/m8oEBwXENgNWLccsjZuSA06a38MdlKkOCzg=;
        b=daDkRb1LndJsKsufB6Mzk0y0NGlRiNBZ0wC9fJaT29ZiAPcs1t/+QE9DT5bPS3SAUF
         VmdXRnUK0dVF8cT98BHBcyqYcICGfAJFlIccpwOORsfwcsInFbL6j8QbVhgy3JdrwboP
         cVO9oR8t/j3nnpH0YhkBuhDhmBPTLpYQb0HpBOKvL0HgX7JAmFyS6IFeqi4wwPnu5dmN
         aQ4+BPEcevGEBcFZnkFgxCDvlwjQXfYZSteopPXCJSTPpXMRmzvO5YmUWO7eJ+COHhCM
         lLQvOLFUxy2/X0vLovcQbLf8pqF9fG6EYJPpWDru8nuJt77gUIKwMbA7v5epFktG49x3
         xGOg==
X-Gm-Message-State: AFqh2kqaEcYUncadHngsFTcFFCXosqiO/oqV2apzdDf6VPYY9lvO6C6+
        4Eh2MoDpF9NkHOqzB3ic5kk=
X-Google-Smtp-Source: AMrXdXuNDtxxU4WfSFIDWIy4r1BJYpPNNpxEGLmZ2haReFRE2hLHCM5685utkQSkIoYc2JjNY6jmAg==
X-Received: by 2002:a5d:4e83:0:b0:29f:b589:158d with SMTP id e3-20020a5d4e83000000b0029fb589158dmr5136938wru.48.1672912711309;
        Thu, 05 Jan 2023 01:58:31 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id e11-20020adf9bcb000000b00242442c8ebdsm36759541wrc.111.2023.01.05.01.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 01:58:30 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2][next] dt-bindings: nvmem: Fix spelling mistake "platforn" -> "platform"
Date:   Thu,  5 Jan 2023 09:58:28 +0000
Message-Id: <20230105095828.2951-2-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230105095828.2951-1-colin.i.king@gmail.com>
References: <20230105095828.2951-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in platforn-name. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 .../devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
index 5a0e7671aa3f..714a6538cc7c 100644
--- a/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
@@ -61,7 +61,7 @@ properties:
     type: object
     additionalProperties: false
 
-  platforn-name:
+  platform-name:
     type: object
     additionalProperties: false
 
-- 
2.30.2

