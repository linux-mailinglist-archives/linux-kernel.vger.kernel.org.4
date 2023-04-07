Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432AC6DAD73
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240805AbjDGN2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjDGN2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 09:28:35 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDC986A6
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 06:28:34 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id a11so43564832lji.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 06:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680874112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TQBrT693IMyw8NXc3/LuFzvk7FqmU/zQ20PRIEg0JBA=;
        b=BhAuGFkm7Z0Dk0sWW58yFSVdvbmwo3bezMeeCVSDvB0MGnNQGYS21BcCvQU/+hL6Jq
         UhRW2wiMHrBww3yim/pjJiTmifunGLJiVl1MiOyA8s61wX0kKSXPgu/aTAFxIOOYk+Pf
         8XOXQa5+kOGs7uCUa2cCaM8s9HhqAhc6OcgA3AC9zYxcvxaPT2c6GatMO6xDZWKs8kQY
         nSDPvIRheNugYDQLwUbt2OANwgRus7KTt7wmpGjeguHXp92/6+CGHOjz4dUp0+0RBOUq
         QNkzwnlHNWpJF38KTmQbaYJUE1fASrBuNjeEdGfcAFCZZQNr7JbdDG/KFOCszRAea92H
         jupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680874112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TQBrT693IMyw8NXc3/LuFzvk7FqmU/zQ20PRIEg0JBA=;
        b=Qddxdb1koS00RzdWo3ywRxVHwF7IUgQDfzewsDf1gfQJ8b2YLWlMp7iBMPjR9Q3dwz
         lqNhRADXahSx1v85zOu2tMYoAzBuxf6JEHa1Eca2AW0rUgIdYy0ZEnXQLbPs1AAqobmg
         zRD6od2XkrNN1aCX5QSp+3bF8zsWjgY8ulOp493lVS/kuVAgSXNn+QgjdcVbB4E/GFTm
         8C3uub52gTWqm+daxf8XudCP65YYysBlFTS/dx59O1B2UpCGT6X7rEFJNxbql8VHSOvY
         X6iq04Hw/2U/Tj2FZMreaq/GkK2msar3rpS87tdlSKbp9orcECaE+3efMvoC/krITB8i
         6rVw==
X-Gm-Message-State: AAQBX9fiunLm3oz5/PHpI57ysIg6jjIZwNw++gQUX/7NyeN6Czgy3T6h
        Hrs09aC8SIfe8gBy3Mign9J1WQ==
X-Google-Smtp-Source: AKy350YmuhzUBxWUp60ovcUDsPlJFsBLyczP0oGDo4ISjPF+jYKyyt5nWKv+Dmxe0wdKjdJvsar7dg==
X-Received: by 2002:a2e:8001:0:b0:2a6:2444:9892 with SMTP id j1-20020a2e8001000000b002a624449892mr668944ljg.25.1680874112332;
        Fri, 07 Apr 2023 06:28:32 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id h2-20020a2e3a02000000b002a618eb72b1sm811031lja.98.2023.04.07.06.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 06:28:31 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/6] Couple of bindings / dt fixes
Date:   Fri, 07 Apr 2023 15:28:30 +0200
Message-Id: <20230407-topic-msm_dtb-v1-0-6efb4196f51f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH4aMGQC/x2NWwqDQAwAryL5biBNX7ZXkVKya1oDuspGpSDev
 Us/Z2CYDVyzqcOj2iDram5jKnA8VBA7SR9FawsDE5/oTDecx8kiDj682jkg1cy1XFkud4LSBHH
 FkCXFrlRp6fsip6xv+/4nzXPff6id8El0AAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680874110; l=1182;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=9ZXqfxOQy7I2vZ6V/C5/H9u0lqdYqI+mn97VyDj4Pf4=;
 b=7g+tFK1DIvw8PBgY5f/XwdyP6/5uKgfC6fcEf6XcQ1SDfP+/cDy/PnluuI/fa3zPlWlcXL0B0zR9
 qZFl+EXLBc9Ov11e6TfAyDILL6AbIDlGhUQUuw0SVi1rAGfVLGdT
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Couple of trivial fixes to make dtbs_check happy (happier).

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (6):
      dt-bindings: media: qcom,sdm845-venus-v2: Allow interconnect properties
      dt-bindings: remoteproc: qcom: adsp: Allow firmware-name
      dt-bindings: usb: dwc3: Allow dma-ranges
      arm64: dts: qcom: sc7280: Fix up the gic node
      arm64: dts: qcom: pm8916: Fix pm8941-misc node name
      arm64: dts: qcom: sdm845-oneplus: Fix speaker GPIO node

 .../devicetree/bindings/media/qcom,sdm845-venus-v2.yaml    |  8 ++++++++
 .../devicetree/bindings/remoteproc/qcom,adsp.yaml          |  4 ++++
 Documentation/devicetree/bindings/usb/qcom,dwc3.yaml       |  2 ++
 arch/arm64/boot/dts/qcom/pm8916.dtsi                       |  2 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi                       | 14 +++++++-------
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi        | 12 +++++-------
 6 files changed, 27 insertions(+), 15 deletions(-)
---
base-commit: e134c93f788fb93fd6a3ec3af9af850a2048c7e6
change-id: 20230407-topic-msm_dtb-08228a62a590

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

