Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BF673B74F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 14:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjFWMdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 08:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjFWMc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 08:32:59 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A121683
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 05:32:58 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fa7cd95dacso6288765e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 05:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687523577; x=1690115577;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3nioVLaBlmpUmAJOY/G29NwVsUk826AqisUa8G22+3E=;
        b=ekPXno6XspMm889bu/+d0e+13NvrGvILCP9a4IA3MYLR+C1KDGPFjvx5DMtJFjwSlM
         RR+DVUtPO/hEvmkuz09fLP2a1aL2vUmB8CBHq3I6gXMktJiozuBiBPAOYvVMPkg8/NkC
         zp2FkWQZxujCMjWU+sZj3JzA8Sft69Nnk8kl+wR27GX9VY6ZahRKypHfQsam18LFXM3t
         V9jrAZNug2GeT+wTPjup8VW3cRc+mVdEYWN23sAZ3D5WxeOSyVMCSplosaEc1USchsUU
         uSvQUWTYAd0F3LYzUbwP7Kpc7PzRMBS0WaXjEqcUni1nAhOsyuk10IP4Fp0cUmrOX7ek
         Eogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687523577; x=1690115577;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3nioVLaBlmpUmAJOY/G29NwVsUk826AqisUa8G22+3E=;
        b=HIJ842CY8fuVHfWVf++oDZzOW2i0/WLySTyX1xHgDr2q8SdZay2GNgKeKCzGEtxNrj
         g/EMYFaDFOSPeQ48RoATAl6m8pCONhJ+gk88Xar4q2F8OxPeQm+adV2dCYvJIDeHqqvn
         bX5jj+hdUtBtyB34Ure7GhPT8Lq07y0+4SuOxeRgErleW5JeSDdARCNpD0S3BTxVkKEa
         plck4yP75P3sC1hxG/kSTGpQ6uNFcZYJvKtOI+ABvZnY0dRIW9PhnH2hd8/XWRSlTzwy
         pxFIF+mRZKLvX1ClLS12ly+QrmvQWioX34UNYPhcqNPmX5XPHEm57IaDUtnKG+zNft4n
         eBOg==
X-Gm-Message-State: AC+VfDxysXS0ndm/WQlKat3DXsCjFWJLD10N0Myl7r22q2azTXecgUCJ
        km0bpqkXrQrl3IeLj4a/WnTJlg==
X-Google-Smtp-Source: ACHHUZ4Zw4foLCPx7ofG1ffKiCC6zFfB3Lk8C//VZfUT2SyK9JctQKgOA0us5B+yLQJv5lAN/j0oRg==
X-Received: by 2002:a1c:4b12:0:b0:3fa:7875:35f0 with SMTP id y18-20020a1c4b12000000b003fa787535f0mr2584392wma.39.1687523577057;
        Fri, 23 Jun 2023 05:32:57 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id t24-20020a1c7718000000b003f91e32b1ebsm2228105wmi.17.2023.06.23.05.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 05:32:56 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/3] dt-bindings: display: msm: document the SM8[345]50
 displayport MDSS subnode
Date:   Fri, 23 Jun 2023 14:32:52 +0200
Message-Id: <20230621-topic-sm8x50-upstream-mdss-bindings-dp-subnode-v2-0-733ed383f6b6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPSQlWQC/52OSw6DMAwFr4Kyrisg5aOueo+KRUwMWIIExYCoE
 HdvyhG6nFm8N4cSCkyinsmhAm0s7F2E/JaodjCuJ2AbWeVprtMyz2DxM7cgU70XKayzLIHMBJM
 VAWRn2fUCdgZZ0XlL8OhIlxV2RYuk4igaIcBgXDvEWbeOY5RzoI73q+LdRB5YFh8+V9SW/ezf/
 1sGKdTY6bpEXWnC18jOBH/3oVfNeZ5fjX3aRwIBAAA=
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Robert Foss <rfoss@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1479;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=EBIjcCxyg5V/PvWq7nOKGJCN4FMlGSX8kOFs3sv4mBw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBklZD2Fk5SGjv9uNP5erhI9WFOG3oimSfHcp5eD5p4
 pWEm6N2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJWQ9gAKCRB33NvayMhJ0cwUEA
 CeJSeV2sCo7oNl4rkT3AJ/aIPaZ4dvPGAO3S8fVdBwtvpONLu/CX/6d6ss56iavBVde4NfIA3BaoP4
 MG6Rkh1wGIdcRHwUNgcXoWTOg++hu5/5CjBOm865tWSGM5nNHKlxhXocIPke49574cYe0Tx9z2jicX
 1a9J4dB20ejBiwPAv/51DovMh4BYY//k3TBp76QUJo/q2bJK2eTebVL1dZxz6SMs108wIE8PSya54Q
 KPpkss/2DBgZj7SLsxhg1dSY6XIWg7ez4hTT8iRw/jNfk5uaLakqamNBXrg+hLJQYnENYikN4Cxm4X
 2AIX55QuhZ2aaXxwDIRz6iefBTkmJZEA5c5db8V5Q1J908xtdCFqEruaRZeqSnRWLmh/ictVuiiGIS
 mEUWCWT6l9VDwEhayOqqxQJUzKf0ruSFzJjfturbUDxf3zsGQYQMcSojt+wvGsLhe1MVDzJLMMtkUL
 m0JfCR7tOTAyLkAghp+GhVw/LixEDeawKdNDzy3fzrfNE3YUi6izd3GQ68AuyKWqtjX2CsGd7sE2lr
 nhlKx6IrFYzVLcCw7Kt4nb4OLA99LbQceXhLslFlX6l5Rldm1mZ6usbGgzeDCA+CfPmAt6snrAR8De
 bp3AhG62NLACEdCgxe864l/TxdDmKGNhpvv2DKEnB+aUkKdBxPc8/c80NmyA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the displayport subnode to fix the bindings check error:

arch/arm64/boot/dts/qcom/sm8550-mtp.dtb: display-subsystem@ae00000: Unevaluated properties are not allowed ('displayport-controller@ae90000' was unexpected)   
        From schema: Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml                                                                 

And same for SM8350 and SM8450.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Removed duplicate "document" in commit messages
- Added review trailers
- Link to v1: https://lore.kernel.org/r/20230621-topic-sm8x50-upstream-mdss-bindings-dp-subnode-v1-0-8bf386b373eb@linaro.org

---
Neil Armstrong (3):
      dt-bindings: display: msm: sm8350-mdss: document displayport controller subnode
      dt-bindings: display: msm: sm8450-mdss: document displayport controller subnode
      dt-bindings: display: msm: sm8550-mdss: document displayport controller subnode

 .../devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml         | 6 ++++++
 .../devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml         | 8 ++++++++
 .../devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml         | 8 ++++++++
 3 files changed, 22 insertions(+)
---
base-commit: 15e71592dbae49a674429c618a10401d7f992ac3
change-id: 20230621-topic-sm8x50-upstream-mdss-bindings-dp-subnode-4fe367bf5cbe

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

