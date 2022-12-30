Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051A26595DA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 08:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbiL3Hni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 02:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234586AbiL3Hmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 02:42:42 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F05B193CC
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 23:42:28 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id fm16-20020a05600c0c1000b003d96fb976efso12640421wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 23:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9glgiQ3X2mnRDXJb2Alh33CJzpO6VrfmT4rZI5QbMWI=;
        b=V7xWuH0yhNJRVRnKaXTGhP5HxhPjee9z6CmeRwOOrjS2KTlWp0i7gSeadQS5ICVjIP
         W8NSWKURx9pdG4EXZNzz0CoZ1ScMOGzKjpQOO9lOGRQKo/2bAxo/R3Cdczr2KjdfOL0F
         66HwtWqwtio24F2o8s+yao+G/Py4kIC1VhSU2gSoEmQX9WQ2YpS66zcc9KAt19MTt56n
         5I57Gb9f5hgN78Vf5aTrgQ80Zv1lyPch5vuqJRLkZ1DtaHXxoPd+tk21eh/CYzr2p7N2
         noXFQaU1DX1TjDhRLutjv2hF981+NFl+xKRXdB6kHiERTQzsVMVB6GRbPYQewhUIp5kP
         is4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9glgiQ3X2mnRDXJb2Alh33CJzpO6VrfmT4rZI5QbMWI=;
        b=B5QG6mZDPVgu6JPCWi8648Y31fj64jvYikCmMqGDsTDXeTFD3NlgvhzJFKizPKmgqr
         0u5LvJMOu/Hm/On6cAX0izAwiP7TBzxPN5kXw2l40POia4qmbwarWcfgcVfBjlXRQpSB
         CnpdrlRBSrtC7X+gIwJPb1Vj7WJIK9B9WDr/9ys7ziJKmBrxdLrC444XHPrdI8c/uzaz
         0AojbCpyolPouKx4WTu/2E44hD3+7V0urG1WKfW3D2r1W+n1COY5wf8s3XH3HUCCljcV
         U5qpoMl8Ur2VUiRmeous+7O9qe7Q00izxkVlM654pNHviiZIk3awgARCGqVoCo0EekcQ
         x4Jg==
X-Gm-Message-State: AFqh2kq//j1bEjvPNbKDLSOkkq11Ii0cFYFZG7owji0pm3/quYaTEBg0
        94j47FRoYIwLlvHfdG2GGQgNYw==
X-Google-Smtp-Source: AMrXdXuMAYlJIN6G0YpFZf+H7rBVfxrHu1N1igoDRNnDZETh62z/olsIXbGLCPP1+zIdfUmwIjXT2A==
X-Received: by 2002:a05:600c:1d89:b0:3d3:58cb:f6a6 with SMTP id p9-20020a05600c1d8900b003d358cbf6a6mr21699299wms.41.1672386146864;
        Thu, 29 Dec 2022 23:42:26 -0800 (PST)
Received: from [192.168.0.28] (2a02-8388-6582-fe80-0000-0000-0000-0007.cable.dynamic.v6.surfer.at. [2a02:8388:6582:fe80::7])
        by smtp.gmail.com with ESMTPSA id a6-20020adfed06000000b0028e8693bb75sm1887655wro.63.2022.12.29.23.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 23:42:26 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v2 0/3] Fix some issues in QCOM UFS bindings
Date:   Fri, 30 Dec 2022 08:42:05 +0100
Message-Id: <20221209-dt-binding-ufs-v2-0-dc7a04699579@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE2WrmMC/3WNTQrCMBCFr1KydiQZ1FpX3kNcpM2kGagTSdqCl
 N7dwb2r9wPfe5upVJiquTWbKbRy5Swa8NCYIXkZCThoNmgRHdoOwgw9S2AZYYkVMLTxcmq7NkY0
 CvW+EvTFy5AUk2WatExc51w+v5PVqTz+7q0OLFzD2WK05NTco+fyTlnoOOSXee77/gUEwQp+tQA
 AAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <me@iskren.info>
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.11.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patches depend on the following patch adding SM6115:
* https://lore.kernel.org/linux-arm-msm/20221030094258.486428-2-iskren.chernev@gmail.com/

The only remaining validation issues I see in the UFS bindings are solved with
the following patches, but this series doesn't depend on them:
* https://lore.kernel.org/linux-arm-msm/20221228124331.258416-1-krzysztof.kozlowski@linaro.org/
* https://lore.kernel.org/linux-arm-msm/20221205100837.29212-2-johan+linaro@kernel.org/

To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Alim Akhtar <alim.akhtar@samsung.com>
To: Avri Altman <avri.altman@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Iskren Chernev <me@iskren.info>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: ~postmarketos/upstreaming@lists.sr.ht
Cc: phone-devel@vger.kernel.org
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v2:
- Add new patch adding reg-names to sm6115 & rebase series on top of sm6115
  addition
- Fix binding example after sm8450 move, split this patch from original patch
  since it became too big
- Move reg-names definition to top-level
- Link to v1: https://lore.kernel.org/r/20221209-dt-binding-ufs-v1-0-8d502f0e18d5@fairphone.com

---
Luca Weiss (3):
      arm64: dts: qcom: sm6115: Add missing reg-names property for UFS
      dt-bindings: ufs: qcom: Add reg-names property for ICE
      dt-bindings: ufs: qcom: Fix sm8450 bindings

 .../devicetree/bindings/ufs/qcom,ufs.yaml          | 35 ++++++++++++++++++----
 arch/arm64/boot/dts/qcom/sm6115.dtsi               |  1 +
 2 files changed, 31 insertions(+), 5 deletions(-)
---
base-commit: 98d95cb05f231dd0f155f912ec7823475b112f6e
change-id: 20221209-dt-binding-ufs-2d7f64797ff2

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>
