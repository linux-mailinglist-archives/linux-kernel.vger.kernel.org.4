Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFEB749FE1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 16:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbjGFOwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 10:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbjGFOwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:52:43 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337181BFB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 07:52:38 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fbb281eec6so1131257e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 07:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688655156; x=1691247156;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hjKVN+qn87MKvJd5TV+xQ0Hc6xEBPPpptclCGYnHRhs=;
        b=iIKURdUGe6y2LGlUOSiN0rseMpWnDj94pegnIpTR1Jwdu4p9YYR0Y9BC43lsdUKOzd
         lJT+s8KqzQrjSRZmHIVzzb7bcBbFvLnLCEORgwBUY9hYIpvBIK5Ib0SlPHDY9lVCa2xp
         6c8Q1uDQDjlxliSYFByw1keBUEgeW6FEdwqtbbKIWjYWW7qWwlSAN/WMc7VwG9NtA1WD
         sz6tS1jDX4iu7AnzdoYs85KWmXHm2gtXgRq2Q1Cg763XqKv9DQlqowYXDFM3DPYd2W4F
         OXK8nygLTsdVGsy2dJEl3NNzMcUv+A4qPVnqtFr4JzXEKY/OvT6d0fVaTnh6dabI7y3T
         4dYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688655156; x=1691247156;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hjKVN+qn87MKvJd5TV+xQ0Hc6xEBPPpptclCGYnHRhs=;
        b=QTYyle+hu0cH+30zrGKe6Kb7XZ1L8k0pi1PJBCg01cX9ILDhzj2KyBhDtpb1s5xIr2
         8Xa1H8OGgRNANhHzcFBb+3Fpuyr3UAH5HxQ48e+oi3XRcjSppozC6ptFzPvaVuEnnNfr
         mld3hkJ3JIfCraTkPOu0XCJP69SUcb6IQ18MVsWtvaEFgaE4+SZZ2oe8epjl3OzF8edW
         so2oMyt6R3PQ3/ApXMuufN4Rsy6oHhMyfOSDqV21DSlUj+udscZsSpUuSWuAdS9TfOpZ
         527KlyKtEcDfr8kgdoc1aMjg78/rHQIzqsfGt7r9Ujfm+MpOeoi+UqKZHNAUCjF+3b7Y
         KuzQ==
X-Gm-Message-State: ABy/qLZigxLoA4ftsdybOfPNVaHBHG9jnrC1JIHjBfQZfZCYaSf+ZalU
        N3ggk1qpMQ69hhEAgi8be01TBQ==
X-Google-Smtp-Source: APBJJlEtM+SQS9ACMNP2wd/3TsmIiImBPH4L/Z3o8U3aqHQbQfADXlt9zMtIMGwB9fTBmTPDMQMMAA==
X-Received: by 2002:a05:6512:2005:b0:4f8:71cc:2b6e with SMTP id a5-20020a056512200500b004f871cc2b6emr1561923lfb.33.1688655156431;
        Thu, 06 Jul 2023 07:52:36 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id k15-20020a7bc40f000000b003fbaf9abf2fsm5371070wmi.23.2023.07.06.07.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 07:52:35 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 0/3] dt-bindings: second batch of dt-schema conversions
 for Amlogic Meson bindings
Date:   Thu, 06 Jul 2023 16:52:31 +0200
Message-Id: <20230706-b4-amlogic-bindings-convert-take2-v3-0-f63de6f12dcc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC/VpmQC/5XOzW7CMBAE4FdBPrPI3iRqzYn3QD34Z52smtrIT
 i0QyrvX5FJxg+PM4Zu5i0KZqYjj7i4yVS6cYgvdfifcZOJIwL5lgRI7iVKD7cH8zGlkB5aj5zg
 WcClWygss5psQCJ0Jn6Sc6oJojjWFwGYT3dSk+DvPrbxkCnzdhs9fLU9clpRv24+qHu07k1WBB
 NcH0rLXnoI+zRxNToeUR/HgK/6TH3J4hcRGIlrSavDedfaJXNf1DyKUKgg7AQAA
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2081;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=xjG+GmuWItSzseeK1S3e1RFM6/Z0jgtrI6vT+WCtMks=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkptUxWi65D8O4Rp/SDdWDxNVQg6GKFdRLKvm8wUwF
 1LIMWEqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZKbVMQAKCRB33NvayMhJ0fcpD/
 9WfIjdolhyWc6mZWsiqjWMDZ2ZWmOBGokQ+ySrS+06ZtW+8ElljYCNU1IH4wTn867/HlcHmYp5Ljpl
 Sl7CZ/K72TN+cPjvHBJVstsVgHpAiWzzMSYrJgHUkf6f8nEyPbJh1+sjP9vBLAnX9/EQMVM7lCUZDB
 eR2nPtwN3AXkuCGH9tu8/Ij8YLvB2KmFXSu0GaUA+jIrbRpCqGA00VTyRhUEsctjKGhe8TmBoT+h/g
 tNmIZXUqOQXhGdjR5/yYkDcjqJG/phW4a0taNr5fnbIusmxTAVQloVxdSBGIRM/yvTtqm9LoICVF7p
 7PVth0sQL46OOHFh03WpE2GHQKulJt+/1jGIjzTpQKkfhrol2WytYx+0OIbDpzPXXphKFa6AFOXUDx
 gUH/cRHkDjV+ueP+HmI5v3+WejJ/EKb7hdJKozBRXmCGz5hHEa/4xm8ZEQpYD+5PqDAZ5l+AQedcnX
 2d2TNFiT+NModAkP5Th9vxYBFQbqdoxLDC+UhkqTwYBBobQh6ib1D1nr/1LkoF+g62QlMXN0lFDXbX
 6ZrHn0pKukh789SMnyuR8vKwbeNK+TotbG85dydsYZFKbdfZ65xBf3RZY6CHAEJPI2gYbNxZwc2ZAA
 HRjJNbEpc0ynjP9hNNG7V2zUwGOTRlpfSCnOA1KE6p6a1qpkSCUG0lUzolFg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Batch conversion of the following bindings:
- amlogic,gxbb-clkc.txt
- amlogic,gxbb-aoclkc.txt

And in addition document the System Control registers top node.

DT fixups will be posted once those conversion are fully reviewed.

With this serie, the in-review and applied bindings documentation, the
the following arm64 compatible are yet to be documented in dt-schema:
 ['amlogic,axg-audio-clkc']
 ['amlogic,g12a-audio-clkc']
 ['amlogic,sm1-audio-clkc']
 ['amlogic,g12a-tohdmitx']
 ['amlogic,sm1-tohdmitx', 'amlogic,g12a-tohdmitx']
 ['everest,es7154']
 ['everest,es7241']
 ['ti,tas5707']
 ['linux,spdif-dir']

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v3:
- Added review tags
- Switched to maxItems in allOf:if and moved clk-names items to main properties
- Link to v2: https://lore.kernel.org/r/20230705-b4-amlogic-bindings-convert-take2-v2-0-22be915ddc3b@linaro.org

Changes in v2:
- rebased on next-20230705
- dropped applied patches
- dropped example in clk bindings
- fixed clk bindings
- fixed sysctrl bindings and moved patch to the end
- Link to v1: https://lore.kernel.org/r/20230209-b4-amlogic-bindings-convert-take2-v1-0-c4fe9049def9@linaro.org

---
Neil Armstrong (3):
      dt-bindings: clock: amlogic: convert amlogic,gxbb-clkc.txt to dt-schema
      dt-bindings: clock: amlogic: convert amlogic,gxbb-aoclkc.txt to dt-schema
      dt-bindings: soc: amlogic: document System Control registers

 .../bindings/clock/amlogic,gxbb-aoclkc.txt         |  64 ---------
 .../bindings/clock/amlogic,gxbb-aoclkc.yaml        |  85 +++++++++++
 .../bindings/clock/amlogic,gxbb-clkc.txt           |  53 -------
 .../bindings/clock/amlogic,gxbb-clkc.yaml          |  37 +++++
 .../soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml  | 160 +++++++++++++++++++++
 5 files changed, 282 insertions(+), 117 deletions(-)
---
base-commit: e1f6a8eaf1c271a0158114a03e3605f4fba059ad
change-id: 20230209-b4-amlogic-bindings-convert-take2-e2caf8e1c13f

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

