Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A965F6542DA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235527AbiLVOY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiLVOYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:24:55 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57DD286F0;
        Thu, 22 Dec 2022 06:24:54 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id tz12so5237290ejc.9;
        Thu, 22 Dec 2022 06:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HdAXRp18Yhl+PSUnXtbvxR+DNOmBhpNB7mLZxnFGxfA=;
        b=Ak5UOvazOKQI4voJRBbw/aBCbllxV6iZfxLX5kvr7a5k5+402RTMNX9ttsPTN8xVOn
         jT6T0+rXU62S82MDgMd+aQlPOOz/nfCu0pq1ZLDkC8fIZcYV/qrF/bpFwM8yAWQ0x7EQ
         q9HcoG9P5F+9jZje1fi5sgQoaWHo7hmbgbgOJE7cM//3AeuvYbrpdL0Sl9FsN+43sM41
         8MexiDyS2m+RHro68c2blvLTjRBbFlnQ4ynqfyt4QdPsL54m7KwwZe765Cl5pAO+TBLQ
         kh0a1doC6s6qxvb+rN0CUV2+qE2y3WmNyNet3Vn2IghdsPmFXjRJdFOalNe3uBpXFpbA
         /VTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HdAXRp18Yhl+PSUnXtbvxR+DNOmBhpNB7mLZxnFGxfA=;
        b=UJDgSurvDHvuC3vqPLj5mf3XHbKX1zQy87tGMuG0aRrfYYMPVyO63as/RpTHaadKD0
         Fhyz9YEh6amrT97TtlKUDaUvHFS1g28771sZt9bm9c0dMP/oE7GeyzrdKYfysbR4s1lP
         h7uMV3cwLUur/teXpSdJhFnIdcHOYD/6fNdERLEfJ223p97jq/e9mY0ajYL7unzL9Mg2
         s8+6Oc48nB622g3jKC53JBZWnd813Use+V8r1qjueS4liRECiA3zbkfZW/rHbHvW7rHU
         QbwY7CubnUK4/ye7mJpac4XujJpqBX1mC6t9kXiFCDlUacUGTgFbKFqtu3tMt1JDMFKt
         HV7g==
X-Gm-Message-State: AFqh2kpftqdfVistrTIxPKH+rYlLAIn46ABzZ6K3K8VCdTsyxMVWS0Vr
        2UYWheAhxKRW+FaZrvnLklc=
X-Google-Smtp-Source: AMrXdXt45+koOLdg7WkWVuXyCH9JMIXYsbmfdjeRv0hUdjOfPc/eqO1XzGfCc9tGBAYRQkxdVQZgQA==
X-Received: by 2002:a17:907:1b0b:b0:7c1:6344:84a with SMTP id mp11-20020a1709071b0b00b007c16344084amr7096364ejc.5.1671719093335;
        Thu, 22 Dec 2022 06:24:53 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w14-20020a17090649ce00b00835dababb9fsm283580ejv.214.2022.12.22.06.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 06:24:53 -0800 (PST)
Message-ID: <1c3b18ad-350f-e862-de98-a775e11e132c@gmail.com>
Date:   Thu, 22 Dec 2022 15:24:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v6 03/17] dt-bindings: display: dsi-controller: move
 clock-master property
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        airlied@gmail.com, daniel@ffwll.ch, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, philippe.cornu@foss.st.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org,
        linus.walleij@linaro.org, inki.dae@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com,
        alim.akhtar@samsung.com, linux-samsung-soc@vger.kernel.org
References: <67771143-fd83-383d-41b2-68e8707134e8@gmail.com>
Content-Language: en-US
In-Reply-To: <67771143-fd83-383d-41b2-68e8707134e8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock-master property is used for the controller and not in the panel,
so move it there.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../bindings/display/dsi-controller.yaml       | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/dsi-controller.yaml b/Documentation/devicetree/bindings/display/dsi-controller.yaml
index ca21671f6..67ce10307 100644
--- a/Documentation/devicetree/bindings/display/dsi-controller.yaml
+++ b/Documentation/devicetree/bindings/display/dsi-controller.yaml
@@ -30,6 +30,15 @@ properties:
   $nodename:
     pattern: "^dsi(@.*)?$"

+  clock-master:
+    type: boolean
+    description:
+      Should be enabled if the host is being used in conjunction with
+      another DSI host to drive the same peripheral. Hardware supporting
+      such a configuration generally requires the data on both the busses
+      to be driven by the same clock. Only the DSI host instance
+      controlling this clock should contain this property.
+
   "#address-cells":
     const: 1

@@ -52,15 +61,6 @@ patternProperties:
           case the reg property can take multiple entries, one for each virtual
           channel that the peripheral responds to.

-      clock-master:
-        type: boolean
-        description:
-          Should be enabled if the host is being used in conjunction with
-          another DSI host to drive the same peripheral. Hardware supporting
-          such a configuration generally requires the data on both the busses
-          to be driven by the same clock. Only the DSI host instance
-          controlling this clock should contain this property.
-
       enforce-video-mode:
         type: boolean
         description:
--
2.20.1

