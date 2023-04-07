Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7AD6DAD7C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240821AbjDGN2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjDGN2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 09:28:37 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AAA8A52
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 06:28:35 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id a11so43564931lji.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 06:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680874114;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OgDPlYdeyBN5Ce+XKNF10sW0zXkUfnHdpMsUaHXHsmA=;
        b=wirQaUgP7v7X9GkaF1EOA3FI0ORRUf7xGwFC1cy6YoAraBNvAlvmvGjhnAJDkkJB2r
         uEpoM7BlqdARZP4E6zm0ElxaniNBG8TUOQgyBgLlH9oyG/GkUot7bkSOhfKu4kg2PIfW
         MC/5dtto7NIM9pfMMlFuPz37CEFYSdwQi4MWsMHhDai9CdJ4wbZXgD4m9nC9QOAF+c9F
         6bhwD9YSE2tyQ1lvJ1G0g9OulLfzd1vGicOsdEoFI62iMU8FefVZFML8E17BgTaSlW0k
         ZslYXcOhRvkKdwkSB1k4ifDjqKiYZDatJGNaX/tUDAeFB6uPmSo617/LKO8eZ/wQ8C1L
         E9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680874114;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OgDPlYdeyBN5Ce+XKNF10sW0zXkUfnHdpMsUaHXHsmA=;
        b=oKfbpu0at4QnueVXQRiGd4N0Kt/IB9bT+tkmr/9VR3ZcFSZKBZqsk4LYbbyxveFSB6
         vMBaoYTv8ikTq3a429OdY6lpNynqGctQbvs7IIssrslaAPUUf56Rw4H5YekJ83RBRIWO
         XFPXJEfDEAim/i8tE8g22CT+N4yU3ZO+K25fMUUNWiDFI343bL3aL14RRVygXYB189Lu
         5jYZwNqLl1ZmP4fZ8xBAf+xkCmIlmHwlBFc93JP4t02/T/SOHhDnhArIzBBS5UwElnXI
         pm/Yhn29lGEurLVklsE6fHuArcjU5Uojs2vYnuTDJ7HnS+EEzLIg1T/yTfsAEBY+Ed/w
         I32Q==
X-Gm-Message-State: AAQBX9fd5t1s7vkcbLw283ONEUV4LBW/h0pY0j9oVJXY5nPDeQZn18Gu
        FN0GpilB82nCWrwFqb9UQtXZGQ==
X-Google-Smtp-Source: AKy350bNk4BbC2iWXByZtDbKjEm7psxi4oI5hkztB0J+/AmIB7wZjpS7vBo0MXMRy4vW3Ihhy0bUag==
X-Received: by 2002:a2e:a232:0:b0:295:9517:b98f with SMTP id i18-20020a2ea232000000b002959517b98fmr520908ljm.15.1680874113953;
        Fri, 07 Apr 2023 06:28:33 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id h2-20020a2e3a02000000b002a618eb72b1sm811031lja.98.2023.04.07.06.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 06:28:33 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 07 Apr 2023 15:28:31 +0200
Subject: [PATCH 1/6] dt-bindings: media: qcom,sdm845-venus-v2: Allow
 interconnect properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230407-topic-msm_dtb-v1-1-6efb4196f51f@linaro.org>
References: <20230407-topic-msm_dtb-v1-0-6efb4196f51f@linaro.org>
In-Reply-To: <20230407-topic-msm_dtb-v1-0-6efb4196f51f@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680874110; l=861;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=x0byFv9Tpffmv4tOybuaTsG0ZSBjTbBYI411ExiSp0g=;
 b=EC0ulUC65d17dKo7Frq3qvRwtteTFJ96VnOc/0CNt8p2Q4VjwS1FYzNm0SXw46wcRgHOjaIbmIgv
 Kj4//+sjBJiJGMl+QYDIACI6Jj3QJUxsi1yT/0yTAj8lHjuSa1KO
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

Allow the interconnect properties, which have been in use for ages.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml b/Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml
index d5f80976f4cf..6228fd2b3246 100644
--- a/Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml
@@ -48,6 +48,14 @@ properties:
   iommus:
     maxItems: 2
 
+  interconnects:
+    maxItems: 2
+
+  interconnect-names:
+    items:
+      - const: video-mem
+      - const: cpu-cfg
+
   operating-points-v2: true
   opp-table:
     type: object

-- 
2.40.0

