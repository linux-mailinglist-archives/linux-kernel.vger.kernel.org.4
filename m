Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB246AAAD0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 16:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjCDPjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 10:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjCDPj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 10:39:29 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FAABBBC
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 07:39:28 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id t11so7326017lfr.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 07:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677944366;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9paeHp+07qtpfuYo/tQXtDjNkaBqslOTssto+pQozeo=;
        b=CuS1rbmeyF9jWQnBlPitLbL8VaTcKqsbyS/ObvHmoHemsLv0X/4deI63Z1MFKXQzS1
         zsbP3yW8kroFZIlmyHOgY+80/zHheHwJ/My0IRM2RfDGQwp9hItbWJPH6FUSn+1Nn98w
         48HbpiT6DY/7QUEXZiAybJD+F7XHukJFXtjrDlG0JrDXRdDFkkJdnNgIKh4iSgri3iI4
         x7FWPEy8HN8721gkkFqxCzm5m/45q1imdyYU40q/BJBAZCJLToXPouzfY8pa5xCywN8V
         Ct4GO+NXd9anikiKiym5lZbKBNciHEmTYJ9A2DTlY67X7otmp5fXExuctd6ivaVExEca
         Y7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677944366;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9paeHp+07qtpfuYo/tQXtDjNkaBqslOTssto+pQozeo=;
        b=xRF3JWpFc2+73vMT8ljrQ+c3e2sbPv/EAma1Kml3wXPydd6wp9AHLWjDbNOaZxbZnp
         cl96JZcCVbSHQePnpz4nlbL9So9KQSlZJGB9YP4eu6znIwrH+TJOuITIWK376DQOD0/d
         LQRhOGGQrB/EK2xB/PTW77SM7X6CoPGvdm3UBcTKU8xhp4RpOT58sHiIHbB+L0KCGROT
         6b+SJeOJmhFAwsI1+KE/mBcg43Hj218pZtu/WJpZFish8XTYTAf54EcBzbjAwPKgGpJx
         knVhoKsM8Xaa061LAcaAFYPHth0n/r3ZSBXyFm3M1mc3msQi4kjPvMdFgAzgxKJV8rCK
         3s0g==
X-Gm-Message-State: AO0yUKW6EDK+r1KCvm0+4Rafrglcpy6gRe1SMIePwaQvwCtmxkJszIQd
        6QI1aQKLX9L2hsmsQp18A2+ujA==
X-Google-Smtp-Source: AK7set8sr+Xp7qat1I3ccKEdugetU6vb3agdy2j/9e6AYxb0X0dCgZeKcsTs2TLXKv+nuhC48oCRDg==
X-Received: by 2002:a19:c208:0:b0:4bc:af5:b8d9 with SMTP id l8-20020a19c208000000b004bc0af5b8d9mr1289964lfc.6.1677944366490;
        Sat, 04 Mar 2023 07:39:26 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id f14-20020ac2532e000000b004ab52b0bcf9sm855065lfh.207.2023.03.04.07.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 07:39:26 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/3] Fix BWMONv4 for <SDM845
Date:   Sat, 04 Mar 2023 16:39:18 +0100
Message-Id: <20230304-topic-ddr_bwmon-v1-0-e563837dc7d1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACZmA2QC/x2NWwrCQAwAr1LybWDdbQW9iojsI9pAzZZs1ULp3
 Q1+zsAwGzRSpgaXbgOlDzeuYnA8dJDHKE9CLsbgnQ8uuB6XOnPGUvSevq8qeHJn530uA4UBrEq
 xESaNkkfr5D1NJmelB6//zfW27z/tl1ykdgAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677944365; l=2383;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=fwdbbzi8OngqlWoVwF8HJxscMkiKpnd+ydCW2XQ3Bb4=;
 b=Ywxdv2lXbMrvAoH/8qjB+lGNe2qfxuooyV4dR+6Bkp7KO0Z4YC+d4Z9Zo9CnPA3P1/RwlT8SZIaK
 NrrcInHwB+MTJP1zEJSgXYwsJlfJtRwfX4xe9PmC3fa4uVXmJHRn
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BWMONv4 (the one used for DDR scaling on all SoCs from msm8998 to sm8550)
features two register regions: "monitor" and "global" with the first one
containing registers specific to the throughput monitor itself and the
second one containing some sort of a head switch.

The register layout on all BWMON versions an implementations up to that
looked like this:

|..........[GLOBAL].........[MONITOR]........|

however with SDM845 somebody thought it would be a good idea to turn it
into this:

|................[GLOBAL]....................|
|....................[MONITOR]...............|

Sadly, the existing upstream driver was architected with SDM845 in mind,
which means it doesn't support the global registers being somewhere else
than near the beginning of the monitor space. This series tries to address
that in the hopefully least painful way. Tested on msm8998 (the count unit
seems to be wrong, should probably be 1MiB and not 64 KiB but the point is
that this series makes it work at all, as without it the headswitch is
never turned on) and SM6375 (with the "combined" layout introduced in
SDM845). Equally sadly, everybody uses the qcom,msm8998-bwmon compatible
(which frankly should have been just qcom,bwmon-v4) that never actually
worked on MSM8998 , which prevents us from handling it in a simpler way..

While at it, an unused struct member is removed.

One suboptimal feature of this patchset is that it introduces an "invalid
resource" print from within devres. This could be solved with an
introduction of devm_ioremap_resource_optional or by dropping devres
functions in place of manual handling, which also doesn't sound great..
I'll leave it up to the reviewers to decide.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (3):
      dt-bindings: interconnect: qcom,msm8998-bwmon: Add global registers
      soc: qcom: icc-bwmon: Handle global registers correctly
      soc: qcom: icc-bwmon: Remove unused struct member

 .../bindings/interconnect/qcom,msm8998-bwmon.yaml  |  28 ++++-
 drivers/soc/qcom/icc-bwmon.c                       | 137 ++++++++++++++++++---
 2 files changed, 142 insertions(+), 23 deletions(-)
---
base-commit: 1acf39ef8f1425cd105f630dc2c7c1d8fff27ed1
change-id: 20230304-topic-ddr_bwmon-609022cd5e35

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

