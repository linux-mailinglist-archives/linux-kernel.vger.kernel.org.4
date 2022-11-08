Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B181620737
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 04:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbiKHDEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 22:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbiKHDEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 22:04:41 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14222FFF5;
        Mon,  7 Nov 2022 19:04:26 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id fz10so8050922qtb.3;
        Mon, 07 Nov 2022 19:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Akr74WzhT+2lGDGVllEO7CxN1d/TLLqV1PqBhKW+nrU=;
        b=NtQ+1ScFO3NWmMxmi1u97F5s9xBhH7vsEnlCXbehYlz0LUqUeVgBMNNH/3yMzV8Rcu
         2S7dznvloo8aW5t0dMcPMjlawVYngBSdrk/2F/fACRROv9KBRs8xX7CSMEZ4tWepJtpO
         ud6RmZMHAIOegSKA9sX69pBcPSrOgRhQ37lPWdnGIDCYKtxv56YbPYsfjZQ56lqZERBr
         B93ydVsUNi9zhYxT9oi0pp6zokUPPQZqOcnLOl4nnr9KCabzIxW4/BC2k1BSraGwc8aE
         dp/KAHYnn+uy81kcOb/7HLStmupei6foE2U8Cl/eYHEYzJbxiYhsmZ55EX3qk+TbXXnP
         EIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Akr74WzhT+2lGDGVllEO7CxN1d/TLLqV1PqBhKW+nrU=;
        b=PtmT3FK2K5BlmY9rRiNfsYVP2Gi6OeDnWN9yflHM05FxyrauSPS6SavOqDv42awzEI
         wsbJjSokqCYuy4uwMDtMCj7vBwG+ldnAC62sZCHA3jTzE2r+vKI6gBhmKfIpZnpq4Uym
         DkQ+Z+TirwbRcS7wkglzwdRnoCduPsbTsNPon7fuM9fdVzC1oSo/i0jknvAg831TmbgE
         szWfYjU7S8ZMKhgQlyI3CXLBufTAfDQDQoqdj8uIRy0TLQsQjqmF26SUX/r/Ps8wTOon
         /93lvV0W3cGR87NtaB1ZI0o+E2HRTDxrHo5sGX7kk3vGavAGR/rhljGsWOvOwpb+v/Ft
         oaVQ==
X-Gm-Message-State: ANoB5pmavoVWEv5Lf2OzeNEu84/vguKZFFkG0egCUWtwq+xPfmT3IJQb
        Bm1g/74+bJ6fEa2FosTyp/Y=
X-Google-Smtp-Source: AA0mqf7q+d0UybB8NdLgYRNjIIR0O7Qz/iucr4SbgjTKapUpJyHQH63Z7L6u2CfRaqb6j9RfY60v5g==
X-Received: by 2002:a05:622a:14c8:b0:3a5:95dd:6aa0 with SMTP id u8-20020a05622a14c800b003a595dd6aa0mr4128166qtx.673.1667876666143;
        Mon, 07 Nov 2022 19:04:26 -0800 (PST)
Received: from localhost ([2607:fea8:a2e2:2d00::61cc])
        by smtp.gmail.com with ESMTPSA id l2-20020ac80782000000b00343057845f7sm7173103qth.20.2022.11.07.19.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 19:04:25 -0800 (PST)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v3 1/4] dt-bindings: arm: cpus: add qcom kryo 360 compatible
Date:   Mon,  7 Nov 2022 22:04:08 -0500
Message-Id: <20221108030411.59409-2-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221108030411.59409-1-mailingradian@gmail.com>
References: <20221108030411.59409-1-mailingradian@gmail.com>
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

The Snapdragon 670 uses CPUs named Kryo 360 silver and Kryo 360 gold.
Add the compatible string in the documentation.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 5c13b73e4d57..1247e9a975c9 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -178,6 +178,7 @@ properties:
       - qcom,kryo250
       - qcom,kryo260
       - qcom,kryo280
+      - qcom,kryo360
       - qcom,kryo385
       - qcom,kryo468
       - qcom,kryo485
-- 
2.38.1

